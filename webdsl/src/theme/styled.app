module styled

imports src/utils

template empty(){}


template notificationsWrapper(){
	// make sure the template is references somewhere outside of a function to avoid the template not found bug
	empty { notificationSuccess("") }
	// make sure the hide function is in scope for the alerts
	<script type="text/javascript">
		function hideAlert(e){
			const a = e.closest('.alert');
			a.animate([{opacity: 1},{opacity: 0}], 500).onfinish = () => a.remove();
		}
	</script>
	<div id=G.notificationsId class="z-[9999] fixed right-4 bottom-4 grid gap-4 mx-auto w-full max-w-sm subpixel-antialiased" data-theme="dracula"></div>
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

// only called in the function, leading to java.lang.RuntimeException: template lookup failed for name: notificationSuccessString
// so i use a trick to get a reference in the template...
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

function notify_old(msg: String){
	message(msg);
	replace(G.notificationsId, notifications());
}

template styled(){
  includeCSS("./theme.css")

  <div id="__styled" class="min-h-screen w-full subpixel-antialiased" data-theme="dracula" all attributes>
    elements
  </div>

	notificationsWrapper()
	//placeholder "~G.notificationsId" { notifications() }

  <script type="text/javascript">
		// helper for using JS events to trigger WebDSL submits
		function triggerSubmit(id){ document.getElementById(id)?.click(); }
    // yes, I artificially show the loading indicator longer 
		// than potentially necessary to prevent the UI from looking too "jumpy"
		function delay(duration){ return new Promise((resolve,_) => setTimeout(resolve, duration)); }
		let minDuration = null;
		function startLoading(elem) {
		  elem.classList.add("loading");
		  elem.disabled = true;
		  minDuration = delay(150);// ms
		}
		function stopLoading(elem, _) {
			function clear(){
				elem.classList.remove("loading");
				elem.disabled = false;
		  		minDuration = null;
			}
		  	if(minDuration === null){ clear(); }
		  	else { minDuration.then(clear); }
		}
    // css tabs code
    document.addEventListener('DOMContentLoaded', () => {
			function styleTab(tab, active, activeClass){
				if (active){
					tab.e.classList.add('tab-active');
					tab.c.classList.remove('hidden');
					if(activeClass){
						tab.e.classList.add(activeClass);
						tab.c.classList.add(activeClass);
					}
				} else {
					tab.c.classList.add('hidden');
					tab.e.classList.remove('tab-active');
					if(activeClass){
						tab.e.classList.remove(activeClass);
						tab.c.classList.remove(activeClass);
					}
				}
			}
			document.querySelectorAll('.tabs').forEach(t => {
				const activeClass = t.getAttribute('data-active') || null;
				const tabs = Array.from(t.querySelectorAll('.tab'))
					.map(t => ({e: t, id:t.getAttribute('data-id'), c: document.getElementById(t.getAttribute('data-id'))}));
				tabs.forEach(tab => {
					// init
					styleTab(tab, tab.e.classList.contains('tab-active'), activeClass);
					// handle click events
					tab.e.onclick = () => {
						tabs.forEach(t => styleTab(t, t.id === tab.id), activeClass);
					}
				})
			})
		});
  </script>
}