module edithabit

imports src/theme

ajax template ajaxInputColor(self: Placeholder, color: ref Color){
	action setColor(c: Color){
		color := c;
		replace( self );
	}
	
	<div class="dropdown dropdown-end">
	  <label tabindex="0" style="background:~color.value;" all attributes>elements</label>
	  <div tabindex="0" class="dropdown-content card card-compact w-64 p-2 shadow bg-neutral text-neutral-content !rounded-lg">
	    <div class="card-body">
	      <h3 class="card-title">"Pick a color"</h3>
	      <div class="grid gap-4 grid-cols-[repeat(auto-fill,_minmax(1.5rem,_1fr))]">
	      	for(c: Color){
	      		if(!c.premium || principal.isPremium){
	      			btn[type="button", class="w-6 h-6 !rounded", style="background:~c.value;", onclick := setColor(c)]{}
	      		} else {
	      			<div class="w-6 h-6 !rounded grid place-items-center" style="background:~c.value;">
	      				iLock(16)
	      			</div>	
	      		}
	      	}
	      </div>
	    </div>
	  </div>
	</div>
}

template inputColor(c: ref Color){
	placeholder ph { ajaxInputColor(ph, c)[all attributes]{ elements } }
}

ajax template ajaxEditHabit(h: Habit, mId: String, self: Placeholder, update: [Placeholder]){
	action update(){
		h.user := principal;
		h.save();
		replace(self);
		updatePlaceholders(update);
	}
	
	action delete(){
		h.user.habits.remove(h);
		principal.save();
		h.delete();
		replace(self);
		updatePlaceholders(update);
	}
	
	form[class="contents"]{
		<div class="form-control">
          	<label class="label">
            	<span class="label-text">"Name"</span>
          	</label>
          	<div class="input-group">
	          	inputajax(h.name)[class="input input-bordered flex-1"] {}
	          	inputColor(h.color)[class="grid w-12 h-12 pointer !rounded-l-none !rounded-r"]{}
	        </div>
	        validate(!h.name.isNullOrEmpty(), "Required")
        </div>
        
        <div class="form-control">
          	<label class="label">
            	<span class="label-text">"Description"</span>
          	</label>
          	inputajax(h.description)[class="textarea textarea-bordered"] {}
        </div>
        
        submit delete()[id:="delete_~id",ajax,class="hidden"]{}
		
		modalActions{
			modalToggle(mId)[class="btn"]{ 
				"Cancel"
			}
			modalToggle(mId)[class="btn btn-error", onclick="if(confirm('Are you sure?')){triggerSubmit('delete_~id');};"]{
				"Delete"
			}
			modalToggle(mId){ 
				submit update()[class="btn btn-primary"]{"Save"}
			}
		}
	}
}

template editHabit(h: Habit, update: [Placeholder]){
	modalToggle(id)[all attributes]{ elements }
	modal(id, "Edit Habit")[class="overflow-y-visible"]{
		placeholder ph {
			ajaxEditHabit(h, id, ph, update)
		}
	}
}

access control rules
	rule ajaxtemplate ajaxInputColor(self: Placeholder, color: ref Color){ loggedIn() }
	rule ajaxtemplate ajaxEditHabit(h: Habit, mId: String, self: Placeholder, update: [Placeholder]){ loggedIn() && h.user == principal}
