---
title: "A Rule of Three for APIs"
date: "2021-07-17T13:03:43-05:00"
cover: ""
tags: [api]
description: ""
showFullContent: false
---

Leonard Richardson gave a talk back in 2016 called [The Magic Arrow](https://www.crummy.com/writing/speaking/2016-RESTFest/). He shared his experiences building a mobile application for the New York Public Library that allowed the patrons to borrow and read ebooks. He found there were characteristics of architectural designs that made them more extensible and reusable, and he summed them up under the idea of the magic arrow.

When we draw architectural diagrams, we draw boxes and connect them with arrows. For instance, we might draw a box for Service A, another for Service B, and an arrow connecting the two. It's easy to define what the boxes are—but what about the arrows?

Richardson worked with a format called [Open Publication Distribution System](https://opds.io/) (OPDS) that makes use of the [Atom Syndication Framework](https://xml2rfc.tools.ietf.org/public/rfc/html/rfc4287.html). He says of this format:

> When I draw architectural diagrams for the Library Simplified project, I'm able to use OPDS to connect all sorts of different components to each other, whether it's a client-server relationship with a human on one end, or a machine-to-machine integration with no human in the loop. OPDS is a magic arrow that can connect all sorts of components.

OPDS was the arrow on his diagram that gave his architecture a bit of magic that's hard to find elsewhere. [Jump over](https://www.crummy.com/writing/speaking/2016-RESTFest/img4.png) to his slides to see how he used OPDS to connect all the boxes in his diagram.

In many different disciplines, we have what's called the Rule of Three. Writers use it to structure stories with a beginning, middle, and end. Comedians use it to set up punchlines—the first two items in a list are related while the last has the comedic punch to it. And [developers use it while refactoring code](https://en.wikipedia.org/wiki/Rule_of_three_(computer_programming)) to help them decide when they should create an abstraction around something they repeated three times. There are [many other examples](https://en.wikipedia.org/wiki/Rule_of_three) for the Rule of Three.

When I started out working with APIs, I had a different perspective than Richardson's magic arrows. In my diagrams, I drew a box for a client and another for an API. Then I'd connect the client and API boxes with an arrow. I never considered the arrow to be its own thing like Richardson—my arrows were boring lines that lacked prestige.

Richardson mentions this practice in his talk.

> I see a lot of these architectural diagrams, and usually the API drawn as a box that communicates with another box—the client—via an arrow. [...] This diagram implies that the API is a unique thing that lives on one computer. Most of the time, that's accurate! But that's not a good thing! It means we've given up the benefits of extensibility and reusability. 

When we think of architecture as something made up of two things—a client and API—we miss the opportunity to consider how we might make client-server interaction extensibility and reusability. Many organizations realize this when it's too late. After years of building build dozens of APIs that follow different practices and patterns, someone finally looks around to notice the inconsistencies and rigidness of the architecture. It's easy for them to make the case that it's time to define API guidelines for everyone to follow to prevent this from continuing. However, the guidelines are commonly less focused on magic arrows and more focused on consistency.

Things change for us when we use a Rule of Three like this for APIs. Instead of a single box in a diagram, we can think of APIs as all the stuff that allows applications to interact, stuff like HTTP, JSON, and formats like OPDS. The more magic we can sprinkle on the arrows, the more extensible and reusable our designs can be.

The web was born out of this pattern to make the arrows magic. Tim Berners-Lee [says this](https://webfoundation.org/about/vision/history-of-the-web/) of his experiences that led to him proposing the web:

> In those days, there was different information on different computers, but you had to log on to different computers to get at it. Also, sometimes you had to learn a different program on each computer. Often it was just easier to go and ask people when they were having coffee.

This lines up with Richardson's observation that treating an API as a box in your diagram "implies that the API is a unique thing that lives on one computer." It's a picture of the current API practice where every API is different and separate. For Berners-Lee, moving the magic away from the computer to the arrows resulted in the web enabling people to connect all kinds of different systems with a single set of technologies.

The magic arrow and the Rule of Three can change how we think about APIs. It can change the way we design APIs. And most importantly, it can change the way we interact with other application over time. The technology of the WWW—HTTP, HTML, and browsers—changed the way we interacted with global information. This same power is available for APIs.

