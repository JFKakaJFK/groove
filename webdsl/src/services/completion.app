module completion

imports src/services/utils
imports src/entities

// get all completions (but different format than entities...)
service completionsService(){
  var res := Response();
  if( isPOST() ){
    if( loggedIn() ){
      var req := JSONObject(readRequestBody());

      var habitId : String := expectString(req, res, "id");
      var start : Date := expectDate(req, res, "start");
      var end : Date := expectDate(req, res, "end");

      if ( isOk(res) && !start.after(end)){ // can be same day 
        var habit : Habit := loadHabit(habitId.parseUUID());
        if ( habit != null && habit.user == principal ){
          var arr := JSONArray();
          for(d in habit.completionRange(DateRange{ start := start, end := end })){
            arr.put(d.json());
          }
          return Ok(res, arr);
        } else {
          return Err(res, 404, "Habit \"~habitId\" not found");
        }
      } else {
        return res;
      }
      
    } else {
      return Err(res, 401, "Not authenticated");
    }
  } else {
    return Err(res, "Invalid request");
  }
}

service completionService(){
  var res := Response();
  if( isPOST() ){
    if ( loggedIn() ){
      var req := JSONObject(readRequestBody());
      
      var habitId : String := expectString(req, res, "habit");
      var completionId : String := expectString(req, res, "id");
      var date : Date := expectDate(req, res, "date");
      var completed : Bool := expectBool(req, res, "completed");

      if ( isOk(res)){
        // TODO error if invalid which is not handled
        var habit : Habit := loadHabit(habitId.parseUUID());
        if ( habit != null && habit.user == principal ){
          // completion id not necessarily accurate and plain lookup would need date/habit verification anyway
          var candidates : [Completion] := from Completion as c where c.habit = ~habit and c.date = ~date limit 1;

          if ( completed && candidates.length == 0 ){ // make sure completion for day exists
            habit.completions.add(Completion{ habit := habit, date := date});
          } else if( !completed && candidates.length > 0 ) { // delete if exists
            habit.completions.remove(candidates[0]);
          }

          habit.save();
          
          if ( isOk(res, habit.validateSave()) ){
            var c := JSONObject();
            c.put("id", completionId);
            c.put("date", date.format("yyyy-MM-dd"));
            c.put("completed", completed);
            return Ok(res, c);
          } else {
            return res;
          }
        } else {
          return Err(res, 404, "Habit \"~habitId\" not found");
        }
      } else {
        return res;
      }
    } else {
      return Err(res, 401, "Not authenticated");
    }
  } else {
    return Err(res, "Invalid request");
  }
}

access control rules
  rule page completionsService(){ true }
  rule page completionService(){ true }
