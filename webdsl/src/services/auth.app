module auth

// Supported HTTP methods are GET, HEAD, POST, PUT, TRACE, OPTIONS
// so no DELETE or PATCH.
// Hence the pathname must be enough -> no POST/GET/PUT/DELETE for CRUD

// hacky response building
function Response(): JSONObject {
  var res := JSONObject();
  res.put("error", JSONArray());
  res.put("data", JSONObject());
  return res;
}

function ErrorResponse(res: JSONObject, err: Int, msg: String): JSONObject {
  var e := JSONObject();
  e.put("message", msg);
  e.put("status", err);
  res.getJSONArray("error").put(e);
  return res;
}

function ErrorResponse(res: JSONObject, msg: String): JSONObject {
  // per default answer w/ 400
  return ErrorResponse(res, 400, msg);
}

// TODO
function OKResponse(res: JSONObject, key: String, value: Object): JSONObject {
  var d : JSONObject := res.getJSONObject("data");
  d.put(key, value);
  res.put("data", d);
  return res;
}

// TODO
//function ErrorResponse(res: JSONObject, validationResults: CheckResults){
//  for( ex in validationResults.exeptions ){
//    rollback();
//    ErrorResponse(res, ex.message);
//  }
//  return res;
//}

// Logs a user in or returns an error message
// 
// Payload - POST
// {
//  "email": String,
//  "password": String,
//  "stayLoggedIn": Boolean, (optional)
// }
//
// Response - Success
// {
//  "id": String
// }
//
service loginService(){
  if( getHttpMethod() == "POST" ){
    var req := JSONObject(readRequestBody());
    var res := Response();

    if(!req.has("email")){
      ErrorResponse(res, "Field \"email\" is missing");
    } else if(!req.has("password")){
      ErrorResponse(res, "Field \"password\" is missing");
    } else {
      if(authenticate(req.getString("email"), req.getString("password"))){
        getSessionManager().stayLoggedIn := req.has("stayLoggedIn") && req.getBoolean("stayLoggedIn");
        
        log(0);
        //var s := res.getString("data");
        log(1);
        var d : JSONObject := res.getJSONObject("data");//JSONObject(s);
        log(2);
        d.put("id", principal.email);
        log(3);
        res.put("data", d);
        log(4);
        //OKResponse(res, "id", principal.email);
      } else {
        ErrorResponse(res, 401, "Invalid credentials");
      }
    }

    return res;
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
  rule page loginService(){ true }