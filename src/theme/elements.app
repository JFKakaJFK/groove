module elements

imports src/theme

htmlwrapper {
  button button[type="button"]
}

override attributes inputString{ class = "input input-bordered" }

template card(){ card({}, { })[all attributes]{elements} }
template card(title: String){ card({ <h2>title </h2> }, {})[all attributes]{elements} }
template card(title: TemplateElements){ card(title, {})[all attributes]{elements} }
// template card(title: String, actions: TemplateElements){card({ <h2>title </h2> }, actions)[all attributes]{elements} }
template card(title: TemplateElements, actions: TemplateElements){
  div[class="card w-full max-w-5xl bg-base-300 shadow-xl", all attributes]{
    div[class="card-body"]{
      div[class="card-title"]{
        title
      }
      
      elements

      div[class="card-actions justify-end mt-4"]{
        actions
      }
    }
  }
}

// a modal
template modalToggle(mId: String){
	<label for="~mId" class="modal-button" all attributes>
		elements
	</label>
}

template modall(mId: String, title: String, actions: TemplateElements){
  <input type="checkbox" id="~mId" class="modal-toggle" />
	<div class="modal">
	  <div class="modal-box" all attributes>
  		if(!title.isNullOrEmpty()){
  			<h3 class="font-bold text-lg mb-4">output(title)</h3>
  		}

	  	elements

      <div class="modal-action">
        actions
      </div>
	  </div>
	</div>
}

template modalActions(){
	<div class="modal-action" all attributes>
		elements
	</div>
}

template modal(mId: String){ modal(mId, "")[all attributes]{ elements } }
template modal(mId: String, title: String){
	<input type="checkbox" id="~mId" class="modal-toggle" />
	<div class="modal">
	  <div class="modal-box overflow-y-visible" all attributes>
  		if(title.length() > 0){
  			<h3 class="font-bold text-lg mb-4">output(title)</h3>
  		}
	  	elements
	  </div>
	</div>
}