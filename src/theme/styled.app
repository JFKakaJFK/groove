module styled

imports src/utils

function notify(msg: String){
	message(msg);
	replace(G.notificationsId, notifications());
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

	placeholder "~G.notificationsId" { notifications() }

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