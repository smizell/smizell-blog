---
title: "Turning an API Into a Programming Language"
date: "2021-06-25T07:57:22-05:00"
cover: ""
tags: []
description: ""
showFullContent: false
---

What if we could combine the power of HTTP with the universal qualities of URLS to create a way to build an API that works like code? It would be a way to turn the web into a programming language of sorts, to treat an API as if it were code.

To explain this weird idea, we'll think about it in terms of calling functions with HTTP calls similar to how you'd call functions in code.

To keep it simple, we'll define a function as a URL that handles a POST request that contains arguments in the body. It does something with the arguments then returns a response with a value.

## Functions that take arguments

We'll look at a few examples to see how this might work. All this [code is on Glitch](https://glitch.com/edit/#!/api-as-code) if you'd like to tinker with it.

We'll start by creating an `add` function. We'll send in an `args` property with an array of two numbers. We make the call with HTTPie:

```sh
http post "https://api-as-code.glitch.me/add" args:="[1, 2]"
```

And get back `{ "value": 3 }`.

The `args:="[1, 2]"` is a way to write JSON on the command line so HTTPie can send it. The corresponding request body would look like `{ "args": [1, 2] }`.

This isn't all that exciting yet, but we'll get there.

## Currying our functions

Next we'll curry this function using query parameters. We'll do this by using an `args` query parameter and an `args` request body property.

```sh
http post "https://api-as-code.glitch.me/add?args=1" args:="[2]"
```

The API code will combine the query `args` which is `[1]` and body `args` which is `[2]` to make `[1, 2]` and return the same result as the first request.

## Higher-order functions by passing around URLs

Next we'll introduce another idea: higher-order functions. This lets us pass functions around as arguments to compose functions together to get new results.

For this example we'll look at a `map` function which takes a function as the first argument and a list of items to iterate over as the second.

Since we can curry our `add` function, we'll create a call that maps over a list of numbers and adds 4 to them.

In JavaScript, the code might look like this.

```js
const add4 = (n) => n + 4;
const items = [1, 2, 3];
items.map(add4)
```

Our API-as-code example that does something similar looks like:

```sh
http post https://api-as-code.glitch.me/map \
args:='["https://api-as-code.glitch.me/add?args=4", [1, 2, 3]]'
```

The underlying code will asynchronously apply that function to each item in the array and return the value. Here's what we get when we make that call.

```js
{ "value": [5, 6, 7] }
```

At this point, we can start thinking about ways to write and compose any type of function we might want to run. We could find a way to write out this "code" using its own syntax, parse it, then execute it across any URL it might use.

## But... why?

This is a fun Friday morning experiment. The downside to this all is that it could result in lots of API calls to execute all the code. Our `map` example above performed three requests in the backend to call the `add` function for each number. This would be very slow in some situations.

But there's something interesting to me about it.

* It allows for sharing code that can be executed across many environments. You could imagine sharing code that did a specific calculation or validation that you don't want to duplicate all over the place. As long as the environment can make HTTP calls, it can "run" the code.
* Since we're using URLs to reference functions, it provides a way to call functions across any number of APIs or services. In our example, we could have had the `add` function on one API and the `map` function on another. Not only are the functions composable, they are extensible as long as the client can access the APIs.
* Related, since we can run parts of the code on different APIs, it allows for interesting asynchronous code. The APIs would have to have a shared way of doing asynchronous work, but once they did they could poll or use webhooks to do more complicated work while sharing the way the work is done.
* It would allow exposing full libraries like [Lodash](https://lodash.com/) or [Ramda](https://ramdajs.com/) for composing together transformations that can be replicated outside JavaScript.
* Function calls could return their own callbacks, resulting in executing new code that wasn't on the client before. Entire algorithms could be changed with a new URL and no client update.

Important: I'm not proposing anyone do this! Introducing a network between function calls opens things up to a whole new world of hurt.

But with the right media type to express how this would operate, it could allow for an API client that could receive code and execute it without any knowledge around how the code runs other than making API calls. You could even write a whole programming language with nice syntax that parses into these API calls.

And what's even more interesting is that you could use hypermedia to make it more powerful and more extensible. If you write the code around link names and relations rather than specific URLs, it means you can move the code around how you like without changing the code itself. I could imagine code that requires a namespace which lists all the available functions related to their URLs, all of which could change at any moment.

I wouldn't be surprised if someone has done this before. It's  near to RPC, and there's even a paper on [RPC chaining](https://www.microsoft.com/en-us/research/wp-content/uploads/2009/04/rpcchains-nsdi2009.pdf). If you know of someone who's done this, please [let me know](/contact/)!