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

override template templateSuccess( messages: [String] ){
  <div id="~id" data-theme="dracula" class="z-[9999] fixed right-4 bottom-4 grid gap-4 mx-auto w-full max-w-sm">
    <script type="text/javascript">
			setTimeout(() => {
				const e = document.getElementById('~id');
				e.animate([{opacity: 1},{opacity: 0}], 500).onfinish = () => e.remove();
			}, 4000)
		</script>
		for( msg in messages ){
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
  </div>
}

// didn't work that well w/ ajax
override template messages(){ }


// <!-- TODO if time -->
// have another global div, use mutationobserver to see if there are new notifications
// then copy them over in the other div to show, thus avoiding deleting messages early by template replacement
ajax template notifications(){
  request var list: [String] := List<String>()
  render{
    list.addAll( getDispatchServlet().getIncomingSuccessMessages() );
    list.addAll( getDispatchServlet().getOutgoingSuccessMessages() ); //in case there are new messages created within this request
    if(!getPage().isRedirected()){ getDispatchServlet().clearSuccessMessages(); }    
  }
	<script type="text/javascript">
		function hideAlert(e){
			const a = e.closest('.alert');
			a.animate([{opacity: 1},{opacity: 0}], 500).onfinish = () => a.remove();
		}
	</script>
  if( list.length > 0 ){
    templateSuccess( list )
  }
}

access control rules
	rule ajaxtemplate notifications(){ true }