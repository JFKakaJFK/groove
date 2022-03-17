module settings

imports src/views
imports src/email

// I decided to just do (almost) a full page refresh here
function updateSettingPage(){
  replace(G.rootId, settingsView());
}

template updateUserMeta(){
  // extra var used to see if email changes or not
  var newEmail : String := principal.email

  action updateUser(){
		var u : User := principal;
		if (u.email != newEmail){
			u.email := newEmail;
			u.verified := false;
			sendVerificationEmail(u);
		}
		u.save();
		notify("Changes saved successfully");
		updateSettingPage();
	}

  card({
    <h2>"Details"</h2>
  }, {
    button[class="btn btn-outline btn-secondary", onclick="triggerSubmit('~id');"]{ "Save changes"}
  }){
    form[class="contents"]{
      <div class="form-control">
        <label class="label">
          <span class="label-text">"Name"</span>
        </label>
        inputajax(principal.name)[class="input input-bordered"]
      </div>
      <div class="form-control">
        <label class="label">
            <span class="label-text">"Email"</span>
          </label>
          inputajax(newEmail)[class="input input-bordered"]
          //validate(newEmail == principal.email || isUniqueUserId(newEmail), "Address already in use")
      </div>

      submit updateUser()[class="hidden", id=id]{}
    }
  }
}

template updatePassword(){
  var password : Secret := ""
	var repeatPassword : Secret := ""

  action updateUser(){
		var u : User := principal;
		u.password := password.digest();
		u.save();
		notify("Password reset successful");
		updateSettingPage();
	}

  card({
    <h2>"Update password"</h2>
  }, {
    button[class="btn btn-outline btn-secondary", onclick="triggerSubmit('~id');"]{ "Save changes"}
  }){
    form[class="contents"]{
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
      
      submit updateUser()[class="hidden", id=id]{}
    }
  }
}

template updateNotificationPrefs(){
	
	action updateNotificationPreferences(){
		notify("Changes saved successfully");
	  updateSettingPage();
	}
	
	action sendVerifyEmail(){
		sendVerificationEmail(principal);
	}

  card({
    <h2>"Notifications"</h2>
  }, {
    button[class="btn btn-outline btn-secondary", onclick="triggerSubmit('~id');"]{ "Save changes"}
  }){
    if (!principal.verified){
      <div class="form-control">
        <div class="flex-row alert shadow-lg alert-warning">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current flex-shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" /></svg>
            <span>"Your email is not verified!"</span>
          </div>
          <div class="flex-none">
            button[class="btn btn-accent", onclick := sendVerifyEmail()]{"Verify"}
          </div>
        </div>
      </div>
    }
    form[class="contents"]{
      <div class="form-control">
        <label class="label flex">
          <span class="label-text">"Subscribe to the newsletter"</span>
          input(principal.newsletter)[class="flex-none"]
        </label>
      </div>
      
      submit updateNotificationPreferences()[class="hidden", id=id]{}
    }
  }
}

ajax template settingsView(){
  ensureRoute("/settings")
  setTitle("Settings | Groove")
  setNavbarTitle("Settings")

  <div class="grid w-full max-w-lg gap-4">
    updateUserMeta
    updatePassword
    updateNotificationPrefs
  </div>
}

access control rules
  rule ajaxtemplate settingsView(){ loggedIn() }