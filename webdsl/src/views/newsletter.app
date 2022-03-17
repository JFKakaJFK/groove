module newsletter

imports src/theme
imports src/views
imports src/email

ajax template ajaxPreview(content: WikiText){
	var src : String := rendertemplate( 
		emailTemplate(principal){
			output(content.replace("@user", principal.name))
		} 
	)
	<iframe srcdoc="<html>~src</html>" class="w-full min-h-max" all attributes></iframe>
}

template newsletterInfo(){
  <div class="dropdown">
    <label tabindex="0" class="btn btn-circle btn-ghost btn-xs text-info">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="w-4 h-4 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
    </label>
    <div tabindex="0" class="shadow card compact dropdown-content bg-base-100 rounded-box w-64">
      <div class="card-body">
        <h2 class="card-title">"Tip"</h2> 
        <p>"The sequence "<code>"@user"</code>" will be replaced with the user's name."</p>
      </div>
    </div>
  </div>
}

// The admin can send custom newsletter emails here 
// (for the sake of simplicity, there are no drafts, staging, past newsletters, templates, scheduled sending, ...)
ajax template newsletterView(){
  ensureRoute("/newsletter")
  setTitle("Newsletter | Groove")
  setNavbarTitle("Newsletter")

  var subject : String := ""
	var content : WikiText := ""
	
	action updatePreview(){
    // weirdly complains if replace( preview ); is used instead
		replace(preview, ajaxPreview(content));
	}
	
	action send(){
		//log(subject); log(content);
		var recipients : [User] := from User as u where u.newsletter = true;
		for(u: User in  recipients){
			email newsletterEmail(u, 
				subject.replace("@user", u.name), 
				content.replace("@user", u.name)
			);
		}
		notify("Newsletter sent to ~recipients.length users");
		replace(G.rootId, adminView());
	}

  toAdmin[class="hidden", id=id]{}

  card({ <h2>"Send Newsletter"</h2>}, {
    button[class="btn", onclick="if(confirm('Are you sure?')){triggerSubmit('~id');}"]{ "Back" }
    button[class="btn btn-primary", onclick="triggerSubmit('f~id');"]{ "Send" }
  }){
    form[class="flex flex-wrap gap-4"]{
      <div class="flex-1">
        <div class="form-control">
          <label class="label">
            <span class="label-text">
              "Subject"
              newsletterInfo
            </span>
          </label>
          input(subject)[class="input input-bordered"]
        </div>

        <div class="form-control">
          <label class="label">
            <span class="label-text">
              "Content"
              newsletterInfo
            </span>
          </label>
          input(content)[class="textarea textarea-bordered", onkeyup := updatePreview()]
        </div>
      </div>

      <div class="form-control flex-1">
        <label class="label">
          <span class="label-text">"Preview"</span>
        </label>
        <div class="border mockup-window bg-base-300">
          <div class="flex justify-center px-4 py-16 bg-base-200 overflow-y-auto">
            placeholder preview { 
              ajaxPreview(content)
            } 
          </div>
        </div>
      </div>

      submit send()[class="hidden", id="f~id"]{}
    }
  }
}

access control rules
  rule ajaxtemplate ajaxPreview(content: WikiText){ loggedIn() && principal.isAdmin }
  rule ajaxtemplate newsletterView(){ loggedIn() && principal.isAdmin }