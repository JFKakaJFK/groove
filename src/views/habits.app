module habits

imports src/views
imports src/fragments

ajax template habitsView(){
  ensureRoute("/habits")
  setTitle("Habits | Groove")
  setNavbarTitle("Habits")

  habitsoverview(principal)
}

access control rules
  rule ajaxtemplate habitsView(){ loggedIn() }