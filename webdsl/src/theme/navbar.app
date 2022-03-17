module navbar

imports src/theme
imports src/utils
imports src/views
imports src/auth

// this is page/"View" specific and I don't see the point of updating this with
// a replace call if it can just be inlined
template setTitle(title: String){
  <script type="text/javascript">document.title = '~title';</script>
  // postProcess("document.title = '~title';")
}

template setNavbarTitle(title: String){
  // apparently this JS parses ambiguously... and I want the interpolation/FieldAccess so here we go
  rawoutput("<script type=\"text/javascript\">document.getElementById('~G.navbarTitleId').textContent = '~title';</script>")
  // postProcess("document.getElementById('~G.navbarTitleId').textContent = '~title';")
}

ajax template nav(){
  if(loggedIn()){
    <div class="dropdown dropdown-end">
      <label tabindex="0" class="btn btn-ghost btn-circle ">
        iMenu(20)
      </label>
      <ul tabindex="0" class="mt-3 shadow menu menu-compact dropdown-content bg-base-300 rounded-box w-52">
            <li>
              toHabits{ "Habits" }
            </li>
            <div class="my-1 py-0 px-3 gap-0 h-min divider"></div>
            <li>
              toSettings{ "Settings" }
            </li>
            if(!principal.isPremium){
              <div class="my-1 py-0 px-3 gap-0 h-min divider"></div>
              <li> // <!-- TODO -->
                <span class="bg-gradient-to-r from-secondary to-primary hover:bg-clip-text hover:text-transparent">
                  "Get Premium"
                </span>
              </li>
            } else {
              // TODO potential premium features
            }
            if(principal.isAdmin){
              <div class="my-1 py-0 px-3 gap-0 h-min divider"></div>
              <li>
                toAdmin{ "Manage" }
              </li>
            }
            <div class="my-1 py-0 px-3 gap-0 h-min divider"></div>
            <li>
              logout{ "Log out" }
            </li>
          </ul>
    </div>
  } else {
    <div class="flex items-center gap-2">
      toLogin[class="btn btn-ghost"]{ "Sign in" }
      toSignup[class="btn btn-outline btn-secondary"]{ "Sign up" }
    </div>
  }
}

template navbar(){
  <div class="navbar bg-base-300">
		<div class="navbar-start">
      placeholder "~G.navbarLogoId" { logo() }
		</div>

    <div>
      <h2 id="~G.navbarTitleId" class="text-xl"></h2>
    </div>

    <div class="navbar-end">
      placeholder "~G.navbarId" { nav() }
    </div>
  </div>
}

access control rules
  rule ajaxtemplate nav(){ true }