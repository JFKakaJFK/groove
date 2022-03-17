module searchusers

imports src/entities

imports src/fragments/user

ajax template searchUsers(target: Placeholder, prevQuery: String, prevPage: Int){
  var query : String := prevQuery
  var page : Int := prevPage
  var results: [User] := searchUser(query, 25, 25 * page)
  var hasPrev : Bool := page > 0
  var hasNext : Bool := results.length >= 25

  action prev(){
    if(hasPrev){
      replace(target, searchUsers(target, query, page-1));
    }
  }

  action next(){
    if(hasNext){
      replace(target, searchUsers(target, query, page+1));
    }
  }

  action searchUsers(){
    replace(target, searchUsers(target, query, page));
  }

  <div> // TODO card
    <div>
      <div> // heading row
        form[class="contents"]{
          input(query)[class="input input-bordered", placeholder="Search Users"]
          submit searchUsers()[ajax]{"search btn"}
        }
      </div>

      <div> // all users of query
        <div>"No Users matching that query"</div>// TODO display only if parent is not :empty
        for(u : User in results){
          userFragment(u)
        }
      </div>

      // pagination
      if(hasPrev){
        button[onclick:=prev()]{"Prev"}
      } else {
        button[disabled="true"]{"Prev"}
      }

      <span>
        output(page + 1)
      </span>
      
      if(hasNext){
        button[onclick:=next()]{"Prev"}
      } else {
        button[disabled="true"]{"Next"}
      }
    </div>
  </div>
}

access control rules
  rule ajaxtemplate searchUsers(target: Placeholder, prevQuery: String, prevPage: Int){ loggedIn() && principal.isAdmin }