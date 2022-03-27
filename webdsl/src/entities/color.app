module color

entity Color {
	value: String (id, not null)
	premium: Bool (default = false, not null)
}

// premium features lol
var red:     Color := Color{ value := "#ef4444" }
var orange:  Color := Color{ value := "#f97316" }
var amber:   Color := Color{ value := "#f59e0b", premium := true }
var yellow:  Color := Color{ value := "#facc15" }
var lime:    Color := Color{ value := "#84cc16", premium := true }
var green:   Color := Color{ value := "#22c55e" }
var emerald: Color := Color{ value := "#10b981", premium := true }
var teal:    Color := Color{ value := "#14b8a6" }
var cyan:    Color := Color{ value := "#06b6d4", premium := true }
var sky:     Color := Color{ value := "#0ea5e9" }
var blue:    Color := Color{ value := "#3b82f6", premium := true }
var indigo:  Color := Color{ value := "#6366f1" }
var violet:  Color := Color{ value := "#8b5cf6", premium := true }
var purple:  Color := Color{ value := "#a855f7", premium := true }
var fuchsia: Color := Color{ value := "#d946ef", premium := true }
var pink:    Color := Color{ value := "#ec4899", premium := true }
var rose:    Color := Color{ value := "#f43f5e", premium := true }

function allowedColors(): [Color] {
  if ( !loggedIn() ) {
    return List<Color>();
  } else if( principal.isPremium ){
    return from Color;
  } else {
    return from Color as c where c.premium = false;
  }
}

function randomColor(): Color {
	var colors : [Color] := from Color as c where c.premium = false;
	return colors.random();
}

template input( c: ref Color ){
  var req := getRequestParameter ( id )

  request var errors: [String] := null // keeps value even if validation fails

  if( errors != null && errors.length > 0 ){
    errorTemplateInput( errors ){
      inputColorInternal( c, id )[ all attributes ]  // use same id so the inputs are updated in both cases
      validate{ getPage().enterLabelContext( id ); }
      elements
      validate{ getPage().leaveLabelContext(); }
    }
  }
  else{
    inputColorInternal( c, id )[ all attributes ]
    validate{ getPage().enterLabelContext( id ); }
    elements
    validate{ getPage().leaveLabelContext(); }
  }
  validate{
    if ( req != null ){
      var picked := findColor(req);
      log(req); log(picked);
      if( picked == null ) {
        errors := [ "Not a valid color." ];
      } else if ( picked.premium && (!loggedIn() || !principal.isPremium) ){
        errors := [ "This color is not allowed" ];
      }
    }
    if(errors == null){
      errors := c.getValidationErrors();
      errors.addAll( getPage().getValidationErrorsByName( id ) ); //nested validate elements
    }
    errors := handleValidationErrors( errors );
  }
}

template inputColorInternal( c: ref Color, rname: String){
  // input is not nullable as that makes little sense for the use cases
  var req: String := getRequestParameter( rname )

  // hidden input, value to be set is c.id of selected color using js, req does databind
  <input id=id type="hidden" name=rname value=c.value />
	
	<div class="dropdown dropdown-end">
	  <label tabindex="0" id="l~id" style="background:~c.value;" class="grid w-12 h-12 pointer" all attributes>elements</label>
	  <div tabindex="0" class="dropdown-content card card-compact w-64 p-2 shadow bg-neutral text-neutral-content !rounded-lg">
	    <div class="card-body">
	      <h3 class="card-title">"Pick a color"</h3>
	      <div class="grid gap-4 grid-cols-[repeat(auto-fill,_minmax(1.5rem,_1fr))]">
	      	for(col: Color){
	      		if(!col.premium || principal.isPremium){
              <button
                type="button" 
                class="w-6 h-6 !rounded grid place-items-center"
                style="background:~col.value;"
                onclick="document.getElementById('~id').value = '~col.value';document.getElementById('l~id').style.background = '~col.value';"
              ></button>
	      		} else {
	      			<div class="w-6 h-6 !rounded grid place-items-center" style="background:~col.value;">
	      				iLock(16)
	      			</div>	
	      		}
	      	}
	      </div>
	    </div>
	  </div>
	</div>

  databind{
    if( req != null ){
      // protect against tampering
      var picked := findColor(req);
      if ( picked != null && c != picked ){
        c := picked;
      }
    }
  }
}