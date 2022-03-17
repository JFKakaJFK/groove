module admin

imports src/fragments
imports src/views

ajax template adminView(){
  ensureRoute("/admin")
  setTitle("Manage | Groove")
  setNavbarTitle("Manage")

  placeholder ph {
    searchUsers(ph, "", 0)
  }
}

access control rules
  rule ajaxtemplate adminView(){ loggedIn() && principal.isAdmin }