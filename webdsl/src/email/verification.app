module verification

imports src/email/template
imports src/entities
imports src/theme

email verificationEmail(u: User){
	to(u.email)
	from("noreply@groove.app")
	subject("Verify your email")
	
	emailTemplate(u){
		<h2>"Hi ~u.name,"</h2>
		<p>"please verify your email with this link:"</p>
		<p style="text-align: center;">
			navigate(verify(u.email as String, u.verificationToken.id.toString())){"Verify"}
		</p>
	}	
}

function sendVerificationEmail(u: User){
	u.verificationToken := Token{};
	u.save();
	email verificationEmail(u);
	notify("Verification email sent successfully");
}

// given a token, verify this user or return an error message (null = success)
function verifyUser(u: User, t: Token) : String {
	if (u.verified){ return "Already verified"; }
	if (u.verificationToken != t || now().after(t.expiresAt)) { return "Verification token invalid"; }
	u.verified := true;
	u.verificationToken := null;
	u.save();
	// log this user in (if the verification is to be trusted then this is fine)
	securityContext.principal := u;
	return null;
}

// page verify(u: User, t: Token){ // doesn't work for null values per default
page verify(uid: String, tid: String){
  var error := "Invalid page arguments"
  init {
    var u : User := null;
    var t : Token := null;
    if(!uid.isNullOrEmpty() && !tid.isNullOrEmpty()){
      u := findUser(uid);
      t := loadToken(tid.parseUUID());
    }
    if(u != null && t != null){
      error := verifyUser(u, t);
    }
  }

	styled[class="grid place-items-center"] {
    card({
      <h2>"Verify your email"</h2>
    }, {
      navigate root()[class="btn btn-primary"]{"Home"}
    }){
      if(error != null){
        <div class="alert shadow-lg alert-error">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current flex-shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
            <span>output(error)</span>
          </div>
        </div>
      } else {
        <div class="alert shadow-lg alert-success">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current flex-shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
            <span>"Email successfully verified"</span>
          </div>
        </div>
      }
    }
	}
}

access control rules
  rule page verify(u: String, t: String){ true }