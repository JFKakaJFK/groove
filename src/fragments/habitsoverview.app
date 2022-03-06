module habitsoverview

imports src/entities
imports src/theme

imports src/fragments/completion

session rangeSelection {
  start: Date (default = (today().addDays(-14) as Date))
  end: Date (default = today())
}

ajax template ajaxhabitsoverview(parent: Placeholder, u: User){
  var range : DateRange := DateRange{ start := rangeSelection.start, end := rangeSelection.end }

  action update(){
    replace(parent, ajaxhabitsoverview(parent, u));
  }

  <div>
    form[class="contents"]{
      <div class="form-control">
        <label class="label">
          <span class="label-text">"Date range"</span>
        </label>
        <label class="input-group">
          input( rangeSelection.start, now().addYears( -1 ), now())[class="input input-bordered"]{}
          input( rangeSelection.end, now().addYears( -1 ), now())[class="input input-bordered"]{}
          submit update()[ajax, class="btn"]{ "Update" }
        </label>
        validate(rangeSelection.start.before(rangeSelection.end), "Start must be before end")
      </div>
    }
  </div>

  action toggle(day: Day){
    day.toggle();
    replace(parent, ajaxhabitsoverview(parent, u));
  }

  var size: Int := 24

  for(h: Habit in u.habits){
    <div>
      <div>
        <span>output(h.name)</span>
        <span>output(h.description)</span>
      </div>

      <div class="grid grid-flow-col auto-cols-min place-content-center overflow-x-auto">
        for(day : Day in h.completionRange(range)){
          if(day.date.after(today())){
            iCompletionSingle(size)[class="text-neutral-focus"]
          } else if(u == principal) {
            form[class="contents"]{
              submit toggle(day)[ajax]{
                completionHelper(day, size)
              }
            }
          } else {
            completionHelper(day, size)
          }
        }
      </div>
    </div>
  }
}

template habitsoverview(u: User){
  placeholder ph {
    ajaxhabitsoverview(ph, u)
  }
}

access control rules
  rule ajaxtemplate ajaxhabitsoverview(parent: Placeholder, u: User){ loggedIn() && (u == principal || principal.isAdmin()) }