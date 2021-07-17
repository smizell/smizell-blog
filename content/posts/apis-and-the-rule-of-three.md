---
title: "Apis and the Rule of Three"
date: "2021-07-16T13:03:43-05:00"
cover: ""
tags: []
description: ""
showFullContent: false
draft: true
---

Leonard Richardson gave a talk back in 2016 called [The Magic Arrow](https://www.crummy.com/writing/speaking/2016-RESTFest/) where he shares insights into working with APIs. He talked about how had worked on a mobile application that made it where their patrons could borrow and read ebooks. He shared a concept he called "the magic arrow."

When we draw architectural diagrams, we draw boxes and arrows connecting the boxes. We might draw a box for Service A, another for Service B, and an arrow connecting the two. It's easy to know what the boxes are—but what about the arrows? The magic arrows is all that happens between the boxes.

In his work, Richard used a format called Open Publication Distribution System (OPDS) that uses the [Atom Syndication Framework](https://xml2rfc.tools.ietf.org/public/rfc/html/rfc4287.html). He says of this format:

> When I draw architectural diagrams for the Library Simplified project, I'm able to use OPDS to connect all sorts of different components to each other, whether it's a client-server relationship with a human on one end, or a machine-to-machine integration with no human in the loop. OPDS is a magic arrow that can connect all sorts of components.

In many different disciplines, we have what's called the Rule of Three. Writers use it to structure stories with a beginning, middle and end. Comedians use it to set up punchlines where the first two items in a list are related and the last has a comedic punch to it. And developers use it while refactoring code to help them decide when they should create an abstraction around something they repeated three times. There are many other examples of the Rule of Three.

When I started out working with APIs, I had a different perspective than Richardson. I would draw diagrams where the API was one of the boxes. In my diagram, there was a client and an API. And I'd connect the client and API boxes with an arrow. Richardson mentions this practice in his talk.

> I see a lot of these architectural diagrams, and usually the API drawn as a box that communicates with another box—the client—via an arrow. [...] This diagram implies that the API is a unique thing that lives on one computer. Most of the time, that's accurate! But that's not a good thing! It means we've given up the benefits of extensibility and reusability. 

When we think of architecture as something made up of two things—a client and API—we miss the opportunity to consider how we might make client-server interaction extensibility and reusability. Many organizations realize this too late. After their teams build dozens of different APIs that follow different practices and patterns, someone might look around and notice the inconsistencies. They'll make the case it's time to define API guidelines for everyone to follow to prevent this from continuing.

The best definition I can come up with for an API is: an API is all the stuff that lets two or more applications interact. This "stuff" would include among many things TCP/IP, HTTP, and JSON—anything and everything that happens along the magic arrows.

There are three things in my definition. There's the server application, the client application, and the magic arrow. The magic arrow includes all the standards, specifications, and semantics that allow those two application to interact. It's the Rule of Three for API architectures. The more magic we add to the arrows, the more extensible and reusable our API designs will be.





