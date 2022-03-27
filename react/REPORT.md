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

Problems
- so I thought lets add a chart, why not. I've already done some stuff with d3 (also here at the TU (yeah its horrible :) https://info-vis.netlify.app/))
  but making charts with d3 from scratch is not as convenient as using some wrapper. I haven't  done that in a long time and so I wanted to try something new, maybe nivo charts. The configurator is nice, you basically have a gui to make your chart. So I had the react component, the data and somehow it didn't work. The typescript support also was lackluster and the documentation was outdated. I spent some time trying to figure out whats wrong but then gave up and tried react-charts. That one is in beta and 


  not retrieve all data at once, there should be a list/search component where you get many results but not all the details, and there should be a detail component where you retrieve additional information from the API. For example, upon the application loading you retrieve and show a list of book titles. Only when the user clicks a book title you retrieve details about that book with a separate query and show detailed information on a separate page or a modal dialog.
  - I guess that would be the habit part of the home page
  - and the specific habit pages

have at least one feature for adding and updating an entity in the WebDSL application, this should include some input component other than text, e.g. dropdown or datepicker.
- color input here we go again (and a bunch of checkboxes)

REST client (Postman/Hoppscotch/Insomnia) very useful as usual