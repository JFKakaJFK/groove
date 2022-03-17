module settings

imports src/views

ajax template settingsView(){
  ensureRoute("/settings")
  setTitle("Settings | Groove")
  setNavbarTitle("Settings")

  "Settings"
}

access control rules
  rule ajaxtemplate settingsView(){ loggedIn() }