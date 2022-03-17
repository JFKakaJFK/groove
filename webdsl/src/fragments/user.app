module user

imports src/entities

// TODO template for user overview, w/ editable roles (self contained)

template userFragment(u: User){
  <div class="stats shadow">
    <div class="stat">
      <div class="stat-title">output(u.name)</div>
      <div class="stat-desc"> // badges
        if(u.isAdmin){
          <span class="badge badge-primary uppercase">"admin"</span>
        }
        if(u.isPremium){
          <span class="badge uppercase">"premium"</span>
        }
      </div>
    </div>

    <div class="stat">
      <div class="stat-title">"# Habits"</div>
      <div class="stat-value">output(u.habitInfo().count)</div>
      <div class="stat-desc">"Done ~u.habitInfo().totalCompletions times"</div>
    </div>

    <div class="stat">
      <div class="stat-title">"Active streak"</div>
      <div class="stat-value">"~u.habitInfo().longestActiveStreak"</div>
      <div class="stat-desc">"Longest streak is ~u.habitInfo().longestStreak"</div>
    </div>
  </div>
}