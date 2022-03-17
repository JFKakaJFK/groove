module views

imports src/theme
imports src/auth
imports src/utils

imports src/views/index
imports src/views/habits
imports src/views/login
imports src/views/signup
imports src/views/settings
imports src/views/admin

// First I had used WebDSL in the way it feels intended w/ multiple pages
// and navigates etc.
//
// But then I thought hey it's 2022 and SSR SPAs are the hype right now
// This means that extra effort to split pages into ajax template fragments and
// to navigate using placeholder replacing instead of links is needed.
// (Most SPA frameworks also make sure that the pages can have different routes,
// as in going from / to /habits would not refresh the page but replace the window.location (i think)
// and there is a page /habits generated to allow entering from all valid entry points.
// Making an actual page with differnt entrypoints is not done here since there is
// no easy meta programming (automatically generating templates) going on.)
// Scratch that comment I actually made something in this direction
//
// Anyways, for most pages the footer and navbar stay constant, so I made 2 top level placeholders
// one for the page content and one for the stuff in the navbar that sometimes gets changed.

// Note that passing navbarId/rootId to every component is annoying (for React it often is called prop drilling I think)
// therefore I made a global entity in the src/util module for just that.

// adds to the browser history
function pushRoute(path: String){
  runscript("window.history.pushState({}, '', `${contextpath}~path`)");
}

template ensureRoute(path: String){
  <script type="text/javascript">window.history.replaceState({}, '', `${contextpath}~path`);</script>
}

// e.g. when changing login state, these things need to be updated
function updatePage(){
  replace( G.navbarId, nav() );
  replace( G.navbarLogoId, logo() );
  replace( G.footerLogoId, logo() );
}

// from here on out there is, surprisingly - BOILERPLATE CODE
template toIndex(){
  action a(){
    replace(G.rootId, rootView());
    pushRoute("/");
  }

  if( loggedIn() ){
    toHabits()[all attributes]{ elements }
  } else {
    button[onclick := a(), all attributes]{ elements }
  }
}

// sometimes, e.g. when going from logged in to logged out, the url needs to be refreshed
ajax template logo(){
  toIndex()[all attributes]{
    image("/images/logo.png")[class="object-contain object-center max-h-8"]
  }
}

page root(){
  layout(){ rootView() }
  <script>console.warn('root')</script>
}

template toLogin(){
  action a(){
    replace(G.rootId, loginView());
    pushRoute("/login");
  }

  button[onclick := a(), all attributes]{ elements }
}

override page login(){
  layout(){ loginView() }
  <script>console.warn('login')</script>
}

template toSignup(){
  action a(){
    replace(G.rootId, signupView());
    pushRoute("/signup");
  }

  button[onclick := a(), all attributes]{ elements }
}

page signup(){
  layout(){ signupView() }
  <script>console.warn('signup')</script>
}

template toHabits(){
  action a(){
    replace(G.rootId, habitsView());
    pushRoute("/habits");
  }

  button[onclick := a(), all attributes]{ elements }
}

page habits(){
  layout(){ habitsView() }
  <script>console.warn('habits')</script>
}

template toSettings(){
  action a(){
    replace(G.rootId, settingsView());
    pushRoute("/settings");
  }

  button[onclick := a(), all attributes]{ elements }
}

page settings(){
  layout(){ settingsView() }
  <script>console.warn('sett')</script>
}

template toAdmin(){
  action a(){
    replace(G.rootId, adminView());
    pushRoute("/admin");
  }

  button[onclick := a(), all attributes]{ elements }
}

page admin(){
  layout(){ adminView() }
  <script>console.warn('admin')</script>
}

page search(query : String) {
  var newQuery : String := query;
  action doSearch() {
    return search(newQuery);
  }

  title { "Search" }
  form {
    input(newQuery)
    submit("Search", doSearch())
  }
  for(m : Habit in searchHabit(query, 50)) {
    output(m)
    output(m.name)
  }
}

access control rules
  rule page search(q: String){ true }
  rule ajaxtemplate logo(){ true }
  rule page root(){ true }
  rule page login(){ true }
  rule page signup(){ true }
  rule page habits(){ loggedIn() }
  rule page settings(){ loggedIn() }
  rule page admin(){ loggedIn() && principal.isAdmin }