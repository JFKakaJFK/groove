module login

imports src/theme
imports src/views

ajax template signin(){
	var email : Email := ""
  var password : Secret := ""
  var rememberMe := false
  
  <div class="card w-full max-w-sm shadow-2xl flex-shrink-0 bg-base-100" all attributes>
    form[class="card-body"] {
      <h2 class="card-title">"Sign in"</h2>

      <div class="form-control">
        <label class="label">
            <span class="label-text">"Email"</span>
          </label>
          input(email)[class="input input-bordered"]
      </div>

      <div class="form-control">
          <label class="label">
            <span class="label-text">"Password"</span>
          </label>
          input(password)[class="input input-bordered"]
          <div class="flex justify-between">
            <label class="label">// TODO forgot password
              // TODO navigate requestPasswordReset()[class="label-text-alt link link-secondary link-hover"]{ "Forgot password?" }
            </label>
            <label class="label">
              <span class="label-text-alt">"Remember me"</span>
              input(rememberMe)[class="ml-2"]//checkbox
            </label>
          </div>
      </div>
      
      <div class="form-control mt-6">
          submit login()[class="btn btn-primary", ajax] { "Sign In" }
      </div>
      
      <div class="flex justify-center items-center label-text-alt">
            <span>
              "Need an account? "
              toSignup[class="link link-secondary"]{ "Create an account" }
              "."
            </span>
      </div>
    }
  </div>

  action login(){
    getSessionManager().stayLoggedIn := rememberMe;
    validate(authenticate(email, password), "The login credentials are not valid.");
    // message("You are now logged in.");
    notify("Login successful");
    // refresh();
    updatePage();
    replace( G.rootId, rootView() ); 
  }
}

access control rules
  rule ajaxtemplate signin(){ true }