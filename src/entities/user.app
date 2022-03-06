module user

imports src/entities

entity User {
	name: String (searchable)
	email: Email (id, not null, searchable, validate(isUniqueUser(this), "email address not available"))
	password: Secret (not null)
	passwordResetToken: Token
	
	verified: Bool (default = false)
	verificationToken: Token
	newsletter: Bool (default = false)
	
	roles: {Role} (default = Set<Role>())
	habits: {Habit} (inverse = user, default = Set<Habit>())
	
	cached function isPremium() : Bool {
		return PREMIUM in roles;
	}
	cached function isAdmin() : Bool {
		return ADMIN in roles;
	}

	cached function habitInfo() : HabitInfo {
		var longestStreak : Int := 0;
		var longestActiveStreak: Int := 0;
		var info : StreakInfo := null;
		var totalCompletions : Int := 0;
		for(h: Habit in habits){
			totalCompletions := totalCompletions + h.completions.length;
			info := h.streakInfo();
			if(info.longest > longestStreak){
				longestStreak := info.longest;
			}
			if(info.current > longestActiveStreak){
				longestActiveStreak := info.current;
			}
		}

		return HabitInfo {
			count := habits.length,
			totalCompletions := totalCompletions,
			longestStreak := longestStreak,
			longestActiveStreak := longestActiveStreak
		};
	}
}