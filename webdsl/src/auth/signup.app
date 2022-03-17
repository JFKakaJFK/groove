module signup

imports src/theme
imports src/views

ajax template signupA(){
	var name := ""
	var email : Email := ""
	var password : Secret := ""
	var repeatPassword : Secret := ""
	var newsletter := false
	
	card("Sign up")[class="!max-w-md"]{
		form[class="contents"] {			
			<div class="form-control">
				<label class="label">
					<span class="label-text">"Name"</span>
				</label>
				input(name)[class="input input-bordered"] {
					validate(name.trim().length() > 0, "Required")
				}
			</div>
			<div class="form-control">
				<label class="label">
					<span class="label-text">"Email"</span>
				</label>
				inputajax(email)[class="input input-bordered"] {
					validate(isUniqueUserId(email), "Address already in use")
				}
			</div>
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
			
			<div class="form-control items-end">
				<label class="label">
					<span class="label-text-alt">"Subscribe to the newsletter"</span>
					input(newsletter)[class="ml-2"]//checkbox 
				</label>
			</div>
			
			//captcha() TODO
			<div class="form-control">
				submit signup()[class="btn btn-primary", ajax] { "Sign up" }
			</div>
		}

		<div class="flex justify-center items-center label-text-alt">
			<span>
				"Already have an account? "
				toLogin()[class="link link-secondary"]{ "Sign in" }
				"."
			</span>
		</div>
	}
	
	action signup() {
		var u := User {
			name := name
			email := email
			password := password.digest()
			verified := false
			newsletter := newsletter
		};
		u.save();
		securityContext.principal := u;
		// TODO sendVerificationEmail(u);
		// TODO welcome email
		message("Welcome! You signed up successfully.");
	  updatePage();
    replace( G.rootId, rootView() ); 
	}
}

access control rules
  rule ajaxtemplate signupA(){ true }