---
title: "Where did the API go?"
date: "2023-02-24T12:56:11-06:00"
cover: ""
tags: []
description: ""
showFullContent: false
features:
- meta-load
---

It's always interested me how GraphQL does all it does without making you think about the HTTP details. You get to focus in on your data and behavior and forget about all the standards and best practices around URLs, HTTP methods, and status codes. Frontend GraphQL tooling takes it further, allowing you to think about data and behavior at the component level rather than API level—the tooling figures out how to optimize the queries to the server across all the components.

So while part of me thinks it's an unfortunate tradeoff to leave HTTP behind, another part of me sees how nice it is to take away a whole world of things to think about. Should resource names be singular or plural in the URL path? Who cares. You don't have to think about it. I like this mental unburdening.

This same trend is happening elsewhere. This week I saw a new tool by [Dustin Getz](https://twitter.com/dustingetz) called [Electric Clojure](https://twitter.com/dustingetz/status/1625178408962473985). The code looks like this:

```clojure
(e/defn Teeshirt-orders [db]
  (e/client
    (dom/h1 (dom/text "Tee-shirt orders"))
    (let [!email (atom "") email (e/watch !email)]
      (ui/input email (e/fn [v] (reset! !email v)))
      (dom/table
        (try
          (e/server
            (e/for
              [x (query-teeshirt-orders db email)]
                (e/client (dom/tr (dom/text (pr-str x))))))
        (catch Pending e
          (dom/props {:class "loading"})))))))
```

In this example, the client code, designated with `e/client`, is smooshed together with the server code, designated with `e/server`. You even see HTML stuff sprinkled throughout as `dom` and `ui`. Notice how there's client code inside the server code, all of which is inside more client code. It's pretty amazing. But where did the API go?

The repository says:

> This is not RPC or client-side ORM. The Electric compiler performs deep graph analysis of your unified frontend/backend program to automatically determine the optimal network cut, and then compile it into separate client and server target programs that cooperate and anticipate each other's needs.

In other words, the Electric compiler builds the API for you (if you feel comfortable calling it an API) based on how you wrote your code. The linked tweet above says Electric is "network transparent," and the repo says this approach allows you to "De-load your mind and relax." More mental unburdening by hiding away the network.

There's also a JavaScript library called [Blitz](https://blitzjs.com/) that has similar goals of making the network disappear. Blitz says of itself:

> Build and iterate on features 10x faster with Blitz RPC than REST, GraphQL, or vanilla API routes. Read and write data from the client with full type safety and without messing with HTTP or serialization.

No HTTP. No thinking about how to structure JSON. We could have lots of discussions around whether RPC is a good approach, but here's a modern framework doing it. Under the hood, Blitz generates RPC client-and-server code and strives to help developers forget there's a big world-wide chasm of networking between their frontend and backend.

Just this morning [I saw another tool](https://www.builder.io/blog/module-extraction-the-silent-web-revolution) that takes a similar approach. [Quik](https://qwik.builder.io/) is framework that has a feature that allows you to write code like this:

```jsx
<button onClick={server$(() => console.log('runs in the server'))}>
   Runs in server
</button>
```

Notice the `server$` function. When you compile this code and click the button in a browser, the `console.log` will run on the server. There's no API to build. Check out the video in [this tweet](https://twitter.com/manucorporat/status/1628758078572175360).

[Manu Mtz.-Almeida](https://twitter.com/manucorporat), author of Quik, writes about [this approach](https://www.builder.io/blog/module-extraction-the-silent-web-revolution):

> Who said you need to choose between edge or serverless? What if you could write a single component file and leverage the entire cloud infrastructure or even web workers?

We spent many years trying to keep HTML and CSS separate in the browser wars, only to merge them back together in React and JSX. Now we're merging worlds across the network.

This approach cuts down on what developers have to think about. Normally, developers put their client code over here and their server code over there. Then they have to make the client and server talk. With Quik, Electric, and Blitz, client and server code are all mingling together in a single section of code. And all the details about making clients and servers communicate over the network is handled by the tooling, not a developer trying to figure out whether to use PUT or PATCH.

There are many other examples of this pattern. Check out how Racket does continuations:

```racket
(page
 (response/xexpr
  `(html
    (body
     (a ([href
          ,(embed/url
            (λ (req)
              "You clicked!"))])
        "Click me")))))
```

The link includes an `embed/url` function as the `href` that runs Racket code when clicked. It's running on the server, not in the browser, but it gives the appearance that Racket code is mixed in with the HTML. Wild.

In some cases, these broader ideas of getting rid of the network aren't new. The [Wikipedia article on RPC](https://en.wikipedia.org/wiki/Remote_procedure_call) is over 20 years old. As someone who loves HTTP, REST, and even using HTML within APIs, I'm still fascinated and interested in the ways people are trying to make it easier to think about and build web applications and move beyond all those details. It comes down the deep feeling of, "Why do we have to think about all this stuff? Could we not?"

Web applications run over a network by nature, and a network always makes you think a zillion details you wouldn't normally have to worry about. We commonly use HTTP and APIs to think through those details. Where there are boundaries there is noise, and we have to deal with the noise. But now things are popping up with different approaches to dealing with the network, mostly in trying to use tools to do all the hard work for you and make the network a quieter place to deal with.

Beyond my fascination with the benefits, I wonder what a generation of frontend-backend alloys will do to development as a whole. APIs are a lot easier to build if you're the only user. What happens when others want to use your application in their code? What if they don't want to use JavaScript? What if you need to do network optimizations when you never touched the network in the first place. Will this melding-of-worlds approach work for microservices, SOA, event-driven architectures, and every other approach where there isn't a browser and a user? It will be interesting to see. And it's probably a worthwhile place to spend time thinking.
