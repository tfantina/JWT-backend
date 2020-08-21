# Rails API Backend Example

I started working on this to get a bit more familiar with Rails as an API (I did not generate this with the `--api` flag because I wanted to also include a Rails powerd site at some point in the future. 

You will notice that the `User` model and tests are almost over-engineered in comparison to the `Post` model that is because I was planning on basing my social network experment on this code but in the end I decided to take a more monolithic approach for the MVP because I could move a lot faster and using something like off the shelf Devise cookie based authentication would be a lot more secure for a lot less work.

## Things to Note 📝

If you're looking to build an API or follow along there are a few choices I made on this project for sessions.  Absent are refresh tokens and a better token blocklist which would have to be iplemented for this to be anything more than a toy app.

Sessions are created through with the `/lib/json_web_token.rb` class which includes both create and block methods.  A token is created, at the moment is is only added to a block list (with `lib/blocklist_creator.rb`) when a user logs out but I suppose there would be other incidents where we would want to block tokens.

The `ApplicationController` contains a protected method `AuthenticateRequest!` which creates a `current_user` from the JWT passed in the header (or throws an error).

JSON is searlized with Netflix's 🎬 FastJsonAPI, which I don't love, it's apparently fast but lacks the documentation of other libraries. I wrote an `ErrorSerializer`, a `SessionSerializer` and started on a `UserSerializer` none of which are fully optomized, the `SessionSerializer` in particular shouldn't be passing around a session token!

## CURL tests

### Create a user
```shell
 curl -X POST -d email="travis@example.com" -d password="password1" http://localhost:3000/api/v1/registrations
```

### Create a session
```shell
 curl -X POST -d email="travis@example.com" -d password="password1" http://localhost:3000/api/v1/sessions/
```

### Test  Logged in user
```shell 
 curl -X GET -H "Authorization: Bearer <<token>>" http://localhost:3000/api/v1/post/index
```

### Create a post:
```shell 
 curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer <<token>>" -d '{"post": {"title": "This is a post", "content": "This is some ole content" }}'  http://localhost:3000/api/v1/posts/
```

### Test Logout
``` shell
curl -X DELETE -d user_id="1" -d auth_token="<<token>>" http://localhost:3000/api/v1/sessions/1
```

One thing I don't like is that we pass the token as a param for the logout action, it should be passed in the header, I don't have the time to look at that right now but if I ever do build something with this archetecture I will be sure to only pass tokens in the headers.
