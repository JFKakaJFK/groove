# Report: WebDSL Application

The application I set out to build is a habit tracker. The goal is to have a convenient way to keep track of 


- Documentation pains
  - some stuff out of date: email stuff, there is quite a lot of that in there
  - some stuff is simply not documented, overall I have looked more at ./servletapp/built-in.app than the docs
  - codefinder is nice, but it did not help that much because half of what i tried from there simply did not work
- Speed
  - No hot reloading, simply no. Since I used tailwind extra procedure + cache clearing necessary, compileserver config on windows did also not work...
  - terrible experience
- Randomness/weirdnesses
  - everything works fine but eclipse said 100+ errors
  - ambiguities in the parser
  - inconsistent function behaviour
  - sometimes it would not work due to the cache being out of date (even with clean)
- syntax completion only mildly helpful to get started, I soon switched to VSCode and was happier
  - even tough then I mostly used the compiler as feedback
  - had no WebDSL specific syntax highlighting (I used the HTML language mode)
- Another weird thing is that I choose to split up the code in A LOT of files making in IMHO more manageable, BUT introducing loads of cyclic dependencies
  - e.g. of course I could define e.g habit + completion in one file avoiding an otherwise necessary cyclic dependency but I first had all entities in one file and that was very confusing
- Trying to turn the site into something alike a SSR SPA made parts of the code very not KISS and DRY, I fully agree but I wanted to how far I can turn WebDSL into something it is not intended for.
  - I often (very often) needed to let ajax placeholders know about their context, somewhat going against the idea that ajax templates are pages which know nothing about their context


- Using webdsl how it is intended
  - actually not that bad, development is surprisingly fast I did expect it to be a lot worse
- Trying to make something React(ish) out of WebDSL
  - higher order stuff, I miss it soo much (templates, functions, etc as arguments/return type please)
  - One can make it work but it does not feel like a good fit
  - Boilerplating is back!?

Learning WebDSL
  ~ from including installation on Windows to getting the first hang of it took around 20 hrs, but then I effectively had the authentication flow (login, signup, access control, password forgot link, password reset) already implemented
  - understanding the more nuanced stuff took a loot longer, as WebDSL sometimes behaved differently than I expected.
  - overall the time surely could be cut in half/even less if restarting would not take as long...

General wishlist - something along the lines of making the developer experience feeling like it is 2015+
- hot reloading for templates/ajax templates/services (I have no Idea how this could work, but it was the main roadblock in my experience and for the non DB migrating stuff it should be possible)
- more flexibility for templates and functions, higher order stuff and something like react context would be nice (this would do a lot for the development experience of nested ajax templates)
  - non-ajax use case example: 
- good syntax highlighting (currently only WebDSL stuff is highlighted, HTML/CSS/JS are not)
- built in way of documenting code that shows up in editor hints (Typescript spoiled me a bit I guess)
- convenience features for services (basically everything that https://fastapi.tiangolo.com/ offers would be nice ;) )
  - nicer JSON handling for request body parsing and response building (doesn't WebDSL intend to remove boilerplate code?)
  - dynamic API documentation (something like https://github.com/swagger-api/swagger-ui or https://github.com/Redocly/redoc)
  - a way to change the HTTP status code of responses (to avoid reinventing the wheel)

Would I use WebDSL in the future? I like the core idea, it makes some aspects of web development a lot faster/more convenient. If I don't want to use ajax or REST, then I doubt I can be faster using some other framework.
However, the tooling is slow and lacking. While the code is more efficient, using a traditional approach I would not have to wait for `webdsl start`. Sometimes that is not too bad, other times I feel like this holds me back too much. Debugging with `log` is very tedious. The documentation is incomplete, out of date and sometimes omits key details. 

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