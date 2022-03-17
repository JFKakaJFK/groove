module reset-password

imports src/email/template
imports src/entities
imports src/theme

email passwordResetEmail(u: User){
	to(u.email)
	from("noreply@groove.app")
	subject("Reset your password")
	
	emailTemplate(u){
		<h2>"Hi ~u.name,"</h2>
		<p>"you can reset your password with this link:"</p>
		<p style="text-align: center;">
			navigate(resetPassword(u.email as String, u.passwordResetToken.id.toString())){"Reset password"}
		</p>
	}
}

function sendPasswordResetEmail(email: Email){
	var u : User := findUser(email);
	if (u != null){
		u.passwordResetToken := Token{};
		u.save();
		email passwordResetEmail(u);
	}
	// give no info about the email actually being in the system
	notify("Reset link sent to your email address");
}

// given a token, verify this user or return an error message (null = success)
function canResetPassword(u: User, t: Token) : String {
	if (u.passwordResetToken != t || now().after(t.expiresAt)) { return "Verification token invalid"; }
	return null;
}

page requestPasswordReset(){
	var email : Email := ""
	
	action requestReset(){
		sendPasswordResetEmail(email);
		refresh();
	}
	
	styled[class="grid place-items-center"] {
		card("Forgot your password?")[class="max-w-lg"]{
			form[class="contents"]{
        <div class="form-control">
          <label class="label">
              <span class="label-text">"Enter your email"</span>
            </label>
            input(email)[class="input input-bordered"]
        </div>
        
        <div class="justify-end card-actions mt-6">
          navigate login()[class="btn"]{"Back"}
          submit requestReset()[class="btn btn-outline btn-secondary", ajax] { "Request reset" }
        </div>
			}
		}
	}
}

// page resetPassword(u: User, t: Token){ // doesn't work for null values per default
page resetPassword(uid: String, tid: String){
  var u : User := null;
  var t : Token := null;
  var error := "Invalid page arguments"
  init {
    if(!uid.isNullOrEmpty() && !tid.isNullOrEmpty()){
      u := findUser(uid);
      t := loadToken(tid.parseUUID());
    }
    if(u != null && t != null){
      error := canResetPassword(u, t);
    }
  }

  var password : Secret := ""
	var repeatPassword : Secret := ""
	
	action resetPassword() {
		u.password := password.digest();
		u.passwordResetToken := null;
		// log this user in (if the verification is to be trusted then this is fine)
		securityContext.principal := u;
		u.save();
		message("Password reset successful");
	  return root();
	}
	
	styled[class="grid place-items-center"] {
		<div class="card w-full max-w-sm shadow-2xl bg-base-300">
		  	form[class="card-body"] {
		  		<h2 class="card-title">"Reset your password"</h2>
		  		
		  		if (error == null){
		  			<div class="form-control">
              <label class="label">
                <span class="label-text">"Password"</span>
              </label>
              inputajax(password)[type="password", class="input input-bordered"] {
                validate(password.length() >= 8, "Password needs to be at least 8 characters")
                validate(/[a-z]/.find(password), "Password must contain a lower-case character")
                validate(/[A-Z]/.find(password), "Password must contain an upper-case character")
                validate(/[0-9]/.find(password), "Password must contain a digit")
              }
            </div>
            <div class="form-control">
              <label class="label">
                <span class="label-text">"Repeat Password"</span>
              </label>
              inputajax(repeatPassword)[type="password", class="input input-bordered"] {
                validate(repeatPassword == password, "Passwords must match")
              }
            </div>
            
            <div class="form-control mt-6">
                submit resetPassword()[class="btn btn-primary"] { "Reset password" }
            </div>
	  			} else {
            <div class="alert shadow-lg alert-error">
              <div>
                <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current flex-shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                <span>output(error)</span>
              </div>
            </div>
            
            <div class="justify-end card-actions mt-6">
              navigate root()[class="btn btn-primary"]{"Home"}
            </div>
          }
		  	}
	  	</div>
  	}
}

access control rules
  rule page requestPasswordReset(){ true }
  rule page resetPassword(u: String, t: String){ true }