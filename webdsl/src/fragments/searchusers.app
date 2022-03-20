module searchusers

imports src/entities
imports src/views

ajax template singleUser(u: User, self: Placeholder, updateParent: String){
  action upgrade(){
    u.roles.add(PREMIUM);
    u.save();
    replace(self, singleUser(u, self, updateParent));
  }
  
  action delete(){
    u.delete();

    // yeah this is not a pretty hack, but more convenient than passing all parent args for the sake of updating...
    runscript("triggerSubmit('~updateParent')");
  }

  button[class="hidden", id=id, onclick:=delete()]{ }

  <th>
    <div class="grid">
      output(u.name)
      <div class="flex gap-2"> // badges
        if(u.isAdmin){
          <span class="badge badge-primary uppercase">"admin"</span>
        }
        if(u.isPremium){
          <span class="badge uppercase">"premium"</span>
        }
      </div>
    </div>
  </th>
  <td>"~u.habitInfo().count/~u.habitInfo().totalCompletions"</td>
  <td>"~u.habitInfo().longestActiveStreak/~u.habitInfo().longestStreak"</td>
  <td>
    if(u.newsletter){
      <input type="checkbox" class="toggle" disabled="true" checked="true">
    } else {
      <input type="checkbox" class="toggle" disabled="true">
    }
  </td>
  <td>
    <div class="flex justify-end items-center gap-2">
      if(!u.isPremium){
        button[class="btn btn-circle btn-sm", onclick := upgrade(), title="Upgrade to premium"]{ iAward(16) }
      }
      if(u != principal){ // admin user cannot self delete
        button[class="btn btn-circle btn-error btn-sm", title="Delete user", onclick="if(confirm('Are you sure?')){triggerSubmit('~id');}"]{ iTrash(16) }
      }
    </div>
  </td>
}

ajax template searchUsers(target: Placeholder, prevQuery: String, prevPage: Int){
  var query : String := prevQuery
  var page : Int := prevPage
  var hasPrev : Bool := page > 0
  var hasNext : Bool := false
  var results : [User] := List<User>()
  
  init{
    if (prevQuery.isNullOrEmpty()){ // if there is no query show all users
      results := from User order by name asc;
    } else {
      // do search
      var searcher := UserSearcher()
        //.fields(["name", "email"])
        //.field("name")
        .query(prevQuery)
        .setOffset(25*page)
        .setLimit(26)
        .sortAsc("name");

      log(">>>>"); log(searcher.getQuery()); log(","); log(searcher.count());

      hasNext := searcher.count() > 25;
      results := searcher.setLimit(25).results();
    }
  }

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

  action reload(){
    replace( target, searchUsers(target, query, page) );
  }

  submit reload()[class="hidden", id=id]{}

  card({
    form[class="contents"]{
      <div class="form-control">
        <div class="input-group">
          input(query)[class="input input-bordered", placeholder="Search"]
          submit searchUsers()[class="btn", ajax]{ iSearch(24) }
        </div>
      </div>
    }
  }, {
    toNewsletter[class="btn"]{"Send newsletter"}
  }){
    if(results.length > 0 || page > 0){

      <div class="overflow-x-auto w-full">
        <table class="table w-full">
          <thead>
            <tr>
              <th>"User"</th>
              <th>"#Habits / #Completions"</th>
              <th>"Active / Longest Streak"</th>
              <th class="text-center">"Subscribed to"<br/>"Newsletter"</th>
              <th></th>
            </tr>
          </thead>

          <tbody>
            for(u : User in results){
              placeholder <tr> ph {
                singleUser(u, ph, id)
              }
            }
          </tbody>
          
          <tfoot>
            <tr>
              <th colspan="5">
                <div class="flex justify-center items-center">
                  <div class="btn-group">
                    if(hasPrev){
                      button[class="btn btn-sm", onclick:=prev()]{"Prev"}
                    } else {
                      button[class="btn btn-sm", disabled="true"]{"Prev"}
                    }
                  
                    <button class="btn btn-sm btn-active" disabled="true">output(page + 1)</button>
                  
                    if(hasNext){
                      button[class="btn btn-sm", onclick:=next()]{"Next"}
                    } else {
                      button[class="btn btn-sm", disabled="true"]{"Next"}
                    }
                  </div>
                </div>
              </th>
            </tr>
          </tfoot>
        </table>
      </div>
      
    } else {
      <div class="grid place-items-center h-96">
        <div>"No Users matching that query"</div>
      </div>
    }
  }
}

access control rules
  rule ajaxtemplate singleUser(u: User, s: Placeholder, p: String){ loggedIn() && (u == principal || principal.isAdmin) }
  rule ajaxtemplate searchUsers(target: Placeholder, prevQuery: String, prevPage: Int){ loggedIn() && principal.isAdmin }