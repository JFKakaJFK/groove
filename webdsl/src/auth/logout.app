module logout

imports src/auth
imports src/utils
imports src/views

override template logout {
  action logout(){
    securityContext.principal := null;
    notify("Logout successful");
    updatePage();
    replace( G.rootId, rootView() );
    pushRoute("/");
  }
  
  button[onclick := logout(), all attributes]{ elements }
}