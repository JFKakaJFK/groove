module admin

imports src/fragments
imports src/views

ajax template adminView(){
  ensureRoute("/admin")
  setTitle("Manage | Groove")
  setNavbarTitle("Manage")

  <div>
    placeholder search {
      searchUsers(search, "\"*\"", 0)
    }
  </div>

  <div>
    for(u: User){
      userFragment(u)
    }
  </div>
}

access control rules
  rule ajaxtemplate adminView(){ loggedIn() && principal.isAdmin() }