module messages

imports src/theme

override template errorTemplateInput( messages: [String] ){
	elements
	for( msg in messages ){
	  <span class="label label-text-alt text-error">output(msg)</span>
	}
}

override template errorTemplateForm( messages: [String] ){
  elements
	for( msg in messages ){
	  <span class="err-form label label-text-alt text-error">output(msg)</span>
	}
}

override template errorTemplateAction( messages: [String] ){
  elements
	for( msg in messages ){
	  <span class="err-action label label-text-alt text-error">output(msg)</span>
	}
}

// didn't work that well w/ ajax
override template messages(){ }

template notifications(){
	request var list: [String] := List<String>()
	init {
		list.addAll( getDispatchServlet().getIncomingSuccessMessages() );
		list.addAll( getDispatchServlet().getOutgoingSuccessMessages() ); //in case there are new messages created within this request
		if(!getPage().isRedirected()){ getDispatchServlet().clearSuccessMessages(); }    
	}
	// make sure the hide function is in scope for the alerts
	<script type="text/javascript">
		function hideAlert(e){
			const a = e.closest('.alert');
			a.animate([{opacity: 1},{opacity: 0}], 500).onfinish = () => a.remove();
		}
	</script>
	<div id=G.notificationsId class="z-[9999] fixed right-4 bottom-4 grid gap-4 mx-auto w-full max-w-sm subpixel-antialiased" data-theme="dracula">
		for( msg in list){
			notificationSuccess(msg)
		}
	</div>
	<script type="text/javascript">
		(function(){
			// no need to wait for DOMContentLoaded as the div is already present
			// have an mutationobserver listening to changes on the wrapper div
			// annoying way of finding the div as interpolation is ambiguous per definition...
			const scripts = document.getElementsByTagName("script");
			const target = scripts[scripts.length - 1].previousElementSibling;
			//console.log(target)
			const config = { childList: true, attributes: false, subtree: false };
			function listener(mutations, observer){
				for(const mutation of mutations){
					//if (mutation.type === 'childList'){ console.log(mutation, 'child list mut'); }
					// remove newly added nodes after some time
					mutation.addedNodes.forEach(e => {
						setTimeout(() => {
							e.animate([{opacity: 1},{opacity: 0}], 500).onfinish = () => e.remove();
						}, 4000)
					});
				}
			}
			const observer = new MutationObserver(listener);
			observer.observe(target, config);
		})();
	</script>
}

// if only called in the function, this leads to java.lang.RuntimeException: template lookup failed for name: notificationSuccessString
template notificationSuccess(msg: String){
	<div class="flex flex-row justify-between items-center alert shadow-lg alert-success">
		<div>
			iSuccess(24)[class="flex-shrink-0"]
			<span>output(msg)</span>
		</div>
		<button class="m-0" onclick="hideAlert(this)">
			iX(24)
		</button>
	</div>
}

// allows at least some backwards compatibility with the built-in notifications
function showNotifications(){
	// get messages
	var list: [String] := List<String>();
	list.addAll( getDispatchServlet().getIncomingSuccessMessages() );
	list.addAll( getDispatchServlet().getOutgoingSuccessMessages() ); //in case there are new messages created within this request
	getDispatchServlet().clearSuccessMessages();
	// prerender
	var prerendered : String := "";
	for( msg in list){
		prerendered := prerendered + rendertemplate(notificationSuccess(msg));
	}
	// attach and show
	runscript("document.getElementById('~G.notificationsId').innerHTML += '~prerendered';");
}
function notify(msg: String){
	message(msg);
	showNotifications();
}