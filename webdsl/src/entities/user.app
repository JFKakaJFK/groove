module user

imports src/entities

entity User {
	name: String (not null, validate(!name.isNullOrEmpty(), "Required"))
	email: Email (id, not null, iderror = "Address not available", idemptyerror = "Required")
	password: Secret (not null)
	passwordResetToken: Token
	
	verified: Bool (default = false)
	verificationToken: Token
	newsletter: Bool (default = false)
	
	roles: {Role} (default = Set<Role>())
	habits: {Habit} (inverse = user, default = Set<Habit>())

	isPremium : Bool := PREMIUM in roles
	isAdmin : Bool := ADMIN in roles
	
	search mapping {
		name;
		email;
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