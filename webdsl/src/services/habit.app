module habit

service habitsService(){

}

service userService(){
  var res := Response();
  if( isPOST() ){
    var req := JSONObject(readRequestBody());
    case( requestMethod(req) ){
      "QUERY" {
        if(!loggedIn()){
          return Err(res, 401, "Not authenticated");
        } else {
          var uid := expectString(req, res, "id");
          var u : User := null;
          if(uid.isNullOrEmpty()){
            u := principal;
          } else if( uid.length() > 0 ) {
            if(principal.isAdmin){
              u := findUser(uid);
            } else {
              Err(res, 403, "Unauthorized");
            }
          }

          if(u != null){
            return Ok(res, "user", u.json());
          } else {
            return Err(res, 404, "User not found");
          }
        }
      }
      "CREATE" {
        // TODO read body and create user, will log user in
        // email, name, password, notifications

        // create user, see if validateSave

        // if so send verification email
      }
      "UPDATE" {}
      "DELETE" {}
      default {}
    }
  } else {
    return Err(res, "Invalid request");
  }
}

service testService(){
  var json := JSONObject(readRequestBody());
  log(json);
  json.put("_method", getHttpMethod());
  return json;
}

access control rules
  rule page testService(){ true }
