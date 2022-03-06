module index

imports src/auth
imports src/theme
imports src/views

ajax template rootView(){
  if(loggedIn()){
    habitsView()
  } else {
    ensureRoute("/")
    setTitle("Groove")
    setNavbarTitle("")
    <div class="hero min-h-screen bg-base-200">
      <div class="hero-content text-center">
        <div class="max-w-md">
          <h1 class="text-5xl font-bold">"Get in the groove!"</h1>
          <p class="py-6">"Form new habits and unlock your potential. Groove keeps you on track to your goals."</p>
          toSignup()[class="btn btn-primary"]{ "Get started" }
        </div>
      </div>
    </div>
  }
}

access control rules
  rule ajaxtemplate rootView(){ true }