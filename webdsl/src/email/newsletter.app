module newsletter

imports src/email/template

email newsletterEmail(u: User, subject: String, content: WikiText){
	to(u.email)
	from("noreply@groove.app")
	subject(subject)
	
	emailTemplate(u){
		output(content)
	}
}

function unsubscribeFromNewsletter(u: User): Bool {
	if (u != null && u.newsletter){
		u.newsletter := false;
		u.save();
	}
	return true;
}

page unsubscribe(u: User){
	var t := unsubscribeFromNewsletter(u)
	if (t){}// no warnigns
	
	styled[class="grid place-items-center"] {
		<div class="card w-96 bg-base-300 shadow-xl">
		  <div class="card-body">
		    <h2 class="card-title">"Newsletter"</h2>
        <div class="alert shadow-lg alert-info">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="stroke-current flex-shrink-0 w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            <span>"You are now unsubscribed from the newsletter."</span>
          </div>
        </div>
        <div class="justify-end card-actions">
		      navigate root()[class="btn btn-primary"]{"Home"}
		    </div>
		  </div>
		</div>
	}
}

access control rules
	rule page unsubscribe(u: User){ true }