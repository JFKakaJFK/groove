module icons

template iAward(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<circle cx="12" cy="8" r="7"></circle>
		<polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
	</svg>
}

template iTrash(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<polyline points="3 6 5 6 21 6"></polyline>
		<path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
		<line x1="10" y1="11" x2="10" y2="17"></line>
		<line x1="14" y1="11" x2="14" y2="17"></line>
	</svg>
}

template iSearch(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<circle cx="11" cy="11" r="8"></circle>
		<line x1="21" y1="21" x2="16.65" y2="16.65"></line>
	</svg>
}

template iRefresh(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<polyline points="23 4 23 10 17 10"></polyline>
		<polyline points="1 20 1 14 7 14"></polyline>
		<path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
	</svg>
}

template iEdit(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path>
	</svg>
}

template iSuccess(size: Int){
  <svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" stroke="currentColor" fill="none" viewBox="0 0 24 24" all attributes>
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
  </svg>
}

template iX(size: Int){
  <svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" fill="none" viewBox="0 0 24 24" stroke="currentColor" all attributes>
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
  </svg>
}

template iLock(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
		<path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
	</svg>
}

template iMenu(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" fill="none" viewBox="0 0 24 24" stroke="currentColor" all attributes>
		<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7" />
	</svg>
}

template iAdd(size: Int){
	<svg xmlns="http://www.w3.org/2000/svg" width="~size" height="~size" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" all attributes>
		<line x1="12" y1="5" x2="12" y2="19"></line>
		<line x1="5" y1="12" x2="19" y2="12"></line>
	</svg>
}

template iCompletionSingle(size: Int){
	<svg width="~size" height="~size" viewBox="0 0 32 32" fill="currentColor" xmlns="http://www.w3.org/2000/svg" all attributes>
		<path d="M28 16C28 22.6274 22.6274 28 16 28C9.37258 28 4 22.6274 4 16C4 9.37258 9.37258 4 16 4C22.6274 4 28 9.37258 28 16Z" />
	</svg>
}

template iCompletionStart(size: Int){
	<svg width="~size" height="~size" viewBox="0 0 32 32" fill="currentColor" xmlns="http://www.w3.org/2000/svg" all attributes>
		<path d="M7 24C9.55328 26.8765 13 28 16 28C19 28 22 27 25 24C28 21 30 20 32 20V12C30 12 28 11 25 8C22 5 19 4 16 4C13 4 9.55328 5.12352 7 8C4.785 10.4954 4 14 4 16C4 18 4.785 21.5046 7 24Z" />
	</svg>
}

template iCompletionMid(size: Int){
	<svg width="~size" height="~size" viewBox="0 0 32 32" fill="currentColor" xmlns="http://www.w3.org/2000/svg" all attributes>
		<path d="M25 8C22 5 19 4 16 4C13 4 10 5 7 8C4 11 2 12 0 12V20C2 20 4 21 7 24C10 27 13 28 16 28C19 28 22 27 25 24C28 21 30 20 32 20V12C30 12 28 11 25 8Z" />
	</svg>
}

template iCompletionEnd(size: Int){
	<svg width="~size" height="~size" viewBox="0 0 32 32" fill="currentColor" xmlns="http://www.w3.org/2000/svg" all attributes>
		<path d="M25 8C22.4467 5.12352 19 4 16 4C13 4 10 5 7 8C4 11 2 12 0 12V20C2 20 4 21 7 24C10 27 13 28 16 28C19 28 22.4467 26.8765 25 24C27.215 21.5046 28 18 28 16C28 14 27.215 10.4954 25 8Z" />
	</svg>
}