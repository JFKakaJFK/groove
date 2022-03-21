# Assignment 2

## Development Experience

I have already done quite a few projects with React, so I was already quite familiar with React at the beginning of the project. Initially I was wondering about playing around with the relatively new Remix framework, but I decided to go with the good old `create-react-app` since I did not want to spend too much time familiarizing myself with another new framework on top of `mobx` (so far my projects did not require enough state management to warrant using `redux`/`mobx`), `react-query` and the `WebDSL` side of things.

Overall I have spent around 2 hours getting set up the client side with all the different providers including setting up basic API fetching and state handling.

- state management interesting, react-query for async state (api stuff), mobx for synchronous state (client side selection + preferences)

- why not something like entities for defining json request bodies and responses? This could make automatic validation easy, removing a lot of the boilerplate and would allow for something like swagger/openapi to be integrated.
- while we are at it, i found it quite annoying that even for post requests webdsl sometimes returned the 404/403 pages with status 200 ok. Thus i did not rely on access control rules but instead used if(loggedIn()) extensively

- Client server communication POST only and without really using route parameters in favour of JSON objects with overlay 

- hotswapping? https://github.com/HotswapProjects/HotswapAgent

API Development
- works. Thats about it.
- JSON handling is awkward, error handling is somewhat nonexistent.


```
service currentUserService(){
  var res := Response();
  if( isPOST() ){
    if ( loggedIn() ){
      return Ok(res, principal.json());
    } else { // BOILERPLATE
      return Err(res, 401, "Not authenticated");
    }
  } else { // BOILERPLATE
    return Err(res, "Invalid request");
  }
}
```

Testing/Dummy data
- tried to add 100 Test users with up to 5 habits and about 1 year of completion history,
  but WebDSL ran out of memory (>30k lines)