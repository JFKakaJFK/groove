module habit

imports src/entities
imports src/utils

// helper entity for streaks
entity Day {
	date: Date
	habit: Habit
	completed: Bool (default = false)
	completion: Completion (default = null)
	// used to show different svgs
	before: Bool (default = false)
	after: Bool (default = false)

	function toggle(){
		if(completed){
			completed := false;
			habit.completions.remove(completion);
			completion.delete();
			habit.save();
			completion := null;
		} else {
			var c := Completion{ habit := habit, date := date };
			habit.completions.add(c);
			c.save(); habit.save();
			completion := c;
			completed := true;
		}
	}
}

entity Habit {
	name: String (searchable)
	// this would make sense in a production setting, but for testing it is more convenient to take
	// the first completion as start (no completionrates > 100%)
	//start: Date (searchable, default = today(), not null)
	description: Text (searchable, default = "")
	color: Color (not null, default = randomColor(), allowed = from Color as c where c.premium = false or ~principal.isPremium() = true)
	user: User (not null) // default = principal, // crashes if i want to init some habits as there is no principal...
	// maybe having ranges instead of single days is more performant, but I don't want to redo it...
	completions <> {Completion} (inverse = habit, default = Set<Completion>())
	// the current streak could be kept track of as derived property-ish
	// but modifications to the longest streak would need a re-scan of all completions anyway
	// so to keep things "simple" this is a linear pass collecting max, current and avg streak lengths
	// cached 
	function streakInfo(): StreakInfo {
		var current: DateRange := null;
		var totalStreaks: Int := 0;
		var totalStreakLength : Int := 0;
		var longestStreak :Int := 0;
		var start : Date := today();
		
		for(c: Completion in completions order by c.date asc){
			if(c.date.before(start)){ start := c.date; }
			// stat keeping for last streak
			if (current != null && current.end.addDays(1).before(c.date)){
				totalStreakLength := totalStreakLength + current.length;
				totalStreaks := totalStreaks + 1;
				if (current.length > longestStreak){
					longestStreak := current.length;
				}
				current := null;
			}
			if (current == null){ // new streak
				current := DateRange{ start := c.date, end := c.date};
			} else { // not new and not broken
				current := DateRange{ start := current.start, end := c.date};
			}
		}
		if (current != null){
			totalStreakLength := totalStreakLength + current.length;
			totalStreaks := totalStreaks + 1;
			if (current.length > longestStreak){
				longestStreak := current.length;
			}
		}
		
		var currentStreak : Int := 0;
		// if today was not yet completed, but yesterday was, then the streak is still active
		if (current != null && current.end.addDays(2).after(today())){
			currentStreak := current.length;
		}
		
		var avg: Float := 0.0;
		if(totalStreaks > 0){
			avg := totalStreakLength.floatValue() / totalStreaks.floatValue();
		}
		
		return StreakInfo {
			longest := longestStreak,
			avg := avg,
			current := currentStreak,
			completionRate := (1000.0 * (totalStreakLength.floatValue() / daysBetween(start, today()).floatValue())).round().floatValue() / 10.0
		};
	}

	// This feels stupidly inefficient but works (I think)
	function completionRange(range: DateRange): [Day] {
		var days : [Day] := List<Day>();
		var completionsInRange : [Completion] := from Completion as c where c.habit = ~this and c.date >= ~range.start and c.date <= ~range.end order by c.date asc;
		var idx : Int := 0;
		for(date : Date in range.dates()){
			var d:= Day{ date := date, habit := this };
			// check if completed
			if (idx < completionsInRange.length){
				var cur := completionsInRange.get(idx);
				if(cur.date == d.date){
					d.completed := true;
					d.completion := cur;
					if(idx + 1 < completionsInRange.length){
						d.after := cur.date.addDays(2).after(completionsInRange.get(idx+1).date);
					}
					if(idx > 0){
						d.before := completionsInRange.get(idx-1).date.addDays(2).after(cur.date);
					}
					idx := idx + 1;
				}
			}
			
			days.add(d);
		}
		return days;
	}
}

