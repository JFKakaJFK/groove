module completion

imports src/theme
imports src/entities

template completionHelper(day: Day, size: Int){
  if(!day.completed){
    iCompletionSingle(size)[class="text-neutral"]
  } else if (!day.before && !day.after){ // single completion
    iCompletionSingle(size)[style="color:~day.habit.color.value;"]
  } else if(!day.before){ // start of streak
    iCompletionStart(size)[style="color:~day.habit.color.value;"]
  } else if(!day.after){ // end of streak
    iCompletionEnd(size)[style="color:~day.habit.color.value;"]
  } else { // in streak
    iCompletionMid(size)[style="color:~day.habit.color.value;"]
  }
}

template completion(day: Day, update: TemplateElements){ completion(day, 24, update)[all attributes] }
template completion(day: Day, size: Int, update: TemplateElements){
	action toggle(d: Day){
		d.toggle();
		rendertemplate( update() );
	}
	
	if(day.date.after(today())){
    iCompletionSingle(size)[class="text-neutral-focus"]
  } else if(day.habit.user == principal) {
    form[class="contents"]{
      submit toggle(day)[ajax]{
        completionHelper(day, size)
      }
    }
  } else {
    completionHelper(day, size)
  }
}