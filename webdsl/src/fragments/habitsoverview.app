module habitsoverview

imports src/entities
imports src/theme

imports src/fragments/completion

session rangeSelection {
  range: DateRange (default = DateRange{ start := (today().addDays(-14) as Date), end := today() })
}

// be prepared for a lot (and I mean A LOT) of placeholder passing (React calls this prop drilling I think)
// One workaround would be passing down an entity with all the placeholder ids as strings but that would not be
// more generic and static string ids are not ideal either...

// the habit overview has a date range selection to see a custom range of habit completions,
// lists each habit and allows adding habits.
// the completions of each habit can be changed as well as the habit itself can be edited
// if we only want to update what we need to, thats a lot of ajax templates (which need to know about each other)

ajax template addHabitModal(mId: String, self: Placeholder, parent: Placeholder){
  var name : String := ""
  var description : Text := ""
  request var color : Color := null
  init {
    if(color == null){
      color := randomColor();
    }
  }
  
  action save(){
    var h: Habit := Habit{
			user := principal,
			name := name,
			description := description,
			color := color
		};
    principal.habits.add(h);
    principal.save();
    notify("Habit added successfully");
    replace( parent, ajaxhabitsoverview(parent, principal) );
    replace( self, addHabitModal(mId, self, parent));
    runscript("document.getElementById('~mId').checked = false;");
  }

  form[class="contents"]{
    <div class="form-control">
      <label class="label">
        <span class="label-text">"Name"</span>
      </label>
      <div class="input-group">
        inputajax(name)[class="input input-bordered flex-1"] {}
        input(color)[class="!rounded-l-none !rounded-r"]{}
      </div>
      validate(!name.isNullOrEmpty(), "Required")
      validate((from Habit as h where h.name = ~name and h.user = ~principal limit 1).length == 0, "You already have a habit with this name")
    </div>
    
    <div class="form-control">
      <label class="label">
        <span class="label-text">"Description"</span>
      </label>
      input(description)[class="textarea textarea-bordered"] {}
    </div>

    submit save()[ajax, class="hidden", id := "s~id"]{}
  
    modalToggle(mId)[class="hidden", id := "t~id"]{}

    modalActions{
      modalToggle(mId)[class="btn"]{ "Back" }
      //modalToggle(mId)[class="btn btn-primary", onclick="triggerSubmit('s~id')"]{ "Save Habit" }
      submit save()[ajax, class="btn btn-primary"]{ "Save Habit" }
    }
  }
}

ajax template editHabitModal(mId: String, self: Placeholder, update: Placeholder, overview: Placeholder, h: Habit){
  action update(){
    notify("Changes saved successfully");
    replace( self, editHabitModal(mId, self, update, overview, h) );
    replace( update, ajaxSingleHabitOverview(overview, update, h, mId, self) );
    runscript("document.getElementById('~mId').checked = false;");
  }

  action delete(){
    h.user.habits.remove(h);
		principal.save();
		notify("Changes saved successfully");
    // deletion needs to do a "full" update
    replace( overview, ajaxhabitsoverview(overview, principal) );
  }

  form[class="contents"]{
    <div class="form-control">
      <label class="label">
        <span class="label-text">"Name"</span>
      </label>
      <div class="input-group">
        inputajax(h.name)[class="input input-bordered flex-1"] {}
        input(h.color)[class="!rounded-l-none !rounded-r"]{}
      </div>
      validate(!h.name.isNullOrEmpty(), "Required")
      // we need to allow each name at least once or it won't work to save a habit ever again...
      validate((from Habit as h where h.name = ~h.name and h.user = ~principal limit 2).length <= 1, "You already have a habit with this name")
    </div>
    
    <div class="form-control">
      <label class="label">
        <span class="label-text">"Description"</span>
      </label>
      input(h.description)[class="textarea textarea-bordered"] {}
    </div>

    submit update()[ajax, class="hidden", id="u~id"]{}
  }

  modalToggle(mId)[class="invisible", id := "d~id", onclick := delete()]{ }

  modalToggle(mId)[class="hidden", id := "t~id"]{}

  modalActions(){
    modalToggle(mId)[class="btn"]{ "Back" }
    button[class="btn btn-error", onclick="if(confirm('Are you sure?')){triggerSubmit('d~id');}"]{"Delete"}
    //modalToggle(mId)[class="btn btn-primary", onclick="triggerSubmit('u~id');"]{ "Update" }
    //submit update()[ajax, class="btn btn-primary"]{ "Update" }
    button[class="btn btn-primary", onclick="triggerSubmit('u~id');"]{"Update"}
  }
}

ajax template ajaxSingleHabitOverview(parent: Placeholder, self: Placeholder, h: Habit, mId: String, editPh: Placeholder){
  action toggle(day: Day){
    day.toggle();
    replace(self, ajaxSingleHabitOverview(parent, self, h, mId, editPh));
  }

  action updateEditModal(){
    replace( editPh, editHabitModal(mId, editPh, self, parent, h) );
  }

  var size: Int := 32
  var streakInfo : StreakInfo := h.streakInfo()

  <th class="sticky left-0 max-w-[120px] whitespace-normal">
    <h4>output(h.name)</h4>
    <p class="text-sm font-light">output(h.description)</p>
  </th>
  for(day : Day in h.completionRange(rangeSelection.range)){
    <td class="!p-0">
      if(day.date.after(today())){
        iCompletionSingle(size)[class="text-neutral-focus"]
      } else if(h.user == principal) {
        form[class="contents"]{
          submit toggle(day)[ajax]{
            completionHelper(day, size)
          }
        }
      } else {
        completionHelper(day, size)
      }
    </td>
  }
  <td class="text-center">output(streakInfo.current)</td>
  <td class="text-center">output(streakInfo.completionRate)"%"</td>
  if(h.user == principal){
    <td>
      modalToggle(mId)[class="sticky right-0 btn btn-circle", onclick := updateEditModal()]{ iEdit(24) }
    </td>
  }
}

ajax template ajaxhabitsoverview(self: Placeholder, u: User){
  action update(){
    replace(self, ajaxhabitsoverview(self, u));
  }

  action reset(){
    rangeSelection.range := DateRange{ start := (today().addDays(-14) as Date), end := today() };
    replace(self, ajaxhabitsoverview(self, u));
  }

  action initAddModal(){
    replace(addPh, addHabitModal("a~id", addPh, self));
  }

  card({ // card header
    <div class="w-full flex flex-row items-center justify-end">
      form[class="contents"]{
        <div class="form-control">
          <label class="label">
            <span class="label-text">"Date range"</span>
          </label>
          <label class="input-group">
            input( rangeSelection.range.start, now().addMonths( -3 ), rangeSelection.range.end.addDays(-1))[class="input input-bordered !rounded-l-lg", onchange="triggerSubmit('d~id')"]{}
            input( rangeSelection.range.end, rangeSelection.range.start.addDays(1), now())[class="input input-bordered", onchange="triggerSubmit('d~id')"]{}
            submit reset()[ajax, class="btn", title="Reset Selection"]{ iRefresh(24) }
          </label>
          validate(rangeSelection.range.start.before(rangeSelection.range.end), "Start must be before end")
          submit update()[ajax, class="invisible", id := "d~id"]{ }
        </div>
      }
    </div>
  }, { // card actions
    modalToggle("a~id")[class="btn btn-circle", onclick:=initAddModal()]{ iAdd(32) }
  }){ // card body
    if(u.habits.length > 0){
      <div class="mt-4 rounded-2xl !overflow-x-auto bg-base-100 w-full scrollbar-thin scrollbar-thumb-gray-600 hover:scrollbar-thumb-gray-500 scrollbar-track-gray-800 scrollbar-thumb-rounded-full scrollbar-track-rounded-full">
        <table class="table w-full">
          <!-- head -->
          <thead>
            <tr>
              <th class="!rounded-none">
                "Habits"
              </th>
              for(d: Date in rangeSelection.range.dates()){
                <th class="relative !p-0 text-sm leading-none w-8">
                  if(!d.before(today())){
                    <div class="absolute z-10 -rotate-[75deg] bottom-2 p-1 bg-primary rounded-xl">
                      <span>output(d.format("dd EEE"))</span>
                    </div>
                  } else {
                    <div class="absolute z-10 -rotate-[75deg] bottom-2 p-1">
                      <span>output(d.format("dd EEE"))</span>
                    </div>
                  }
                </th>
              }
              <th class="text-center">
                "current"<br/>"streak"
              </th>
              <th class="text-center">
                "completion"<br/>"rate"
              </th>
              if(u == principal){
                <th></th>
              }
            </tr>
          </thead>
          <tbody>
            for(h: Habit in u.habits){
              placeholder <tr> habitPh {
                ajaxSingleHabitOverview(self, habitPh, h, id, editPh)
              }
            }
          </tbody>
        </table>
      </div>

      modal(id, "Edit"){
        placeholder editPh {}
      }
    } else {
      <div class="grid place-items-center h-48">
        <p>"No habits yet, create one first"</p>
      </div>
    }
    modal("a~id", "Create new Habit"){
      placeholder addPh {
        addHabitModal("a~id", addPh, self)
      }
    }
  }
}

template habitsoverview(u: User){
  placeholder ph {
    ajaxhabitsoverview(ph, u)
  }
}

access control rules
  rule ajaxtemplate addHabitModal(mId: String, self: Placeholder, parent: Placeholder){ loggedIn() }
  rule ajaxtemplate editHabitModal(mId: String, self: Placeholder, update: Placeholder, overview: Placeholder, h: Habit){ loggedIn() && (h.user == principal) }
  rule ajaxtemplate ajaxSingleHabitOverview(parent: Placeholder, self: Placeholder, h: Habit, mId: String, editPh: Placeholder){ loggedIn() && (h.user == principal || principal.isAdmin()) }
  rule ajaxtemplate ajaxhabitsoverview(parent: Placeholder, u: User){ loggedIn() && (u == principal || principal.isAdmin()) }