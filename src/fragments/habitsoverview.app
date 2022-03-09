module habitsoverview

imports src/entities
imports src/theme

imports src/fragments/completion

session rangeSelection {
  range: DateRange (default = DateRange{ start := (today().addDays(-14) as Date), end := today() })
}

// TODO style, edit
template singleHabitOverview(parent: Placeholder, h: Habit){
  action toggle(day: Day){
    day.toggle();
    replace(parent, ajaxhabitsoverview(parent, h.user));
  }

  var size: Int := 32
  var streakInfo : StreakInfo := h.streakInfo()

  <tr>
    <th class="sticky left-0">
      <span>output(h.name)</span>
      <span>output(h.description)</span>
    </th>
    for(day : Day in h.completionRange(rangeSelection.range)){
      <td class="!p-0">
        // almost seems like it would work, but doesn't
        // completion(day, { render{ replace(parent, ajaxhabitsoverview(parent, h.user)); } })
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
    <td>output(streakInfo.current)</td>
    <td>output(streakInfo.completionRate)"%"</td>
    <td>
      button[class="sticky right-0 btn btn-circle"]{ "E" }
    </td>
  </tr>
}

ajax template editModal(mId: String, self: Placeholder, update: Placeholder, h: Habit){
  action update(){
    h.save();
    notify("Changes saved successfully");
    replace( self, editModal(mId, self, update, h) );
    replace( update, ajaxSingleHabitOverview(update, h, mId, self) );
  }

  form[class="contents"]{
    "Edit ~h.name"
  }

  modalActions(){
    modalToggle(mId)[class="btn"]{ "Back" }
    modalToggle(mId)[class="btn btn-primary", onclick := update()]{ "Update" }
  }
}

ajax template ajaxSingleHabitOverview(parent: Placeholder, h: Habit, mId: String, mph: Placeholder){
  action toggle(day: Day){
    day.toggle();
    replace(parent, ajaxSingleHabitOverview(parent, h, mId, mph));
  }

  action updateEditModal(){
    replace( mph, editModal(mId, mph, parent, h) );
  }

  var size: Int := 32
  var streakInfo : StreakInfo := h.streakInfo()

  <th class="sticky left-0">
    <span>output(h.name)</span>
    <span>output(h.description)</span>
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
  <td>output(streakInfo.current)</td>
  <td>output(streakInfo.completionRate)"%"</td>
  if(h.user == principal){
    <td>
      modalToggle(mId)[class="sticky right-0 btn btn-circle", onclick := updateEditModal()]{ "E" }
    </td>
  }
}

ajax template ajaxhabitsoverview(parent: Placeholder, u: User){
  action update(){
    replace(parent, ajaxhabitsoverview(parent, u));
  }

  action reset(){
    rangeSelection.range := DateRange{ start := (today().addDays(-14) as Date), end := today() };
    replace(parent, ajaxhabitsoverview(parent, u));
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
    // TODO new habit FAB
    button[class="btn btn-circle"] { iAdd(32) }
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
              <th>
                "current streak"
              </th>
              <th>
                "completion rate"
              </th>
              if(u == principal){
                <th></th>
              }
            </tr>
          </thead>
          <tbody>
            for(h: Habit in u.habits){
              placeholder <tr> ph {
                ajaxSingleHabitOverview(ph, h, id, mph)
                //singleHabitOverview(parent, h)
              }
            }
          </tbody>
        </table>
      </div>

      modal(id, "Edit"){
        placeholder mph {
          
        }
      }
      // TODO have edit modal // toggle onclick sets habit target => one modal enough?! 
    } else {
      <div class="grid place-items-center h-48">
        <p>"No habits yet, create one first"</p>
      </div>
    }
  }
}

template habitsoverview(u: User){
  placeholder ph {
    ajaxhabitsoverview(ph, u)
  }
}

access control rules
  rule ajaxtemplate editModal(mId: String, self: Placeholder, update: Placeholder, h: Habit){ loggedIn() && (h.user == principal) }
  rule ajaxtemplate ajaxSingleHabitOverview(parent: Placeholder, h: Habit, mId: String, mph: Placeholder){ loggedIn() && (h.user == principal || principal.isAdmin()) }
  rule ajaxtemplate ajaxhabitsoverview(parent: Placeholder, u: User){ loggedIn() && (u == principal || principal.isAdmin()) }