module login

imports src/auth
imports src/views

ajax template loginView(){
  if(loggedIn()){
    habitsView()
  } else {
    ensureRoute("/login")
    setTitle("Log in | Groove")
    setNavbarTitle("")
    <div class="hero min-h-screen">
      <div class="hero-content flex-col lg:flex-row-reverse">
        <div class="text-center lg:text-left">
          <h1 class="text-5xl font-bold">"Login now!"</h1>
          <p class="py-6">
            "Provident cupiditate voluptatem et in."
          </p>
        </div>
        signin()
      </div>
    </div>
  }
}

access control rules
  rule ajaxtemplate loginView(){ true }


