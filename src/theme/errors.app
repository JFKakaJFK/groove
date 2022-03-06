module errors

imports src/theme

template errorPage(err: Int, msg: String) {
	title{ "~err | Groove" }
	styled[class="grid place-items-center"] {
 		<div class="flex flex-col justify-center items-center gap-4">
 			<div class="flex w-full items-center text-7xl font-bold leading-normal">
			  <div class="text-primary">output(err)</div>
			  <div class="divider divider-horizontal"></div>
			  <div class="flex-1">output(msg)</div>
			</div>
 			<div>
 				navigate root()[class="btn btn-primary"]{ "Go back Home" }
 			</div>
 		</div>
  	}
}

override page accessDenied() {
	errorPage(403, "Access Denied")
}

override page pagenotfound() {
	errorPage(404, "Page not found")
}
