module signup

imports src/auth
imports src/views

ajax template signupView(){
  if(loggedIn()){
    habitsView()
  } else {
    ensureRoute("/signup")
    setTitle("Sign up | Groove")
    setNavbarTitle("")
    <div class="hero min-h-screen bg-base-200">
      <div class="hero-content flex-col lg:flex-row-reverse">
        <div class="text-center lg:text-left">
          <h1 class="text-5xl font-bold">"Sign up now!"</h1>
          <p class="py-6">
            "Provident cupiditate voluptatem et in."
          </p>
        </div>
        signupA()
      </div>
    </div>
  }
}

access control rules
  rule ajaxtemplate signupView(){ true }


