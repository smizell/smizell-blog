---
title: "Testing an API Without HTTP"
date: "2021-07-05T20:15:12-05:00"
cover: ""
tags: []
description: ""
showFullContent: false
draft: true
---


Organizing code into layers is a good strategy for testing software. Each layer can be tested independently apart from the other layers. Integration tests can be used later to make sure the layers fit together. At this point, there doesn't need to be many integration tests because the purpose isn't to test the layers themselves, just the integration of the layers.

The first layer for a web API is the part that receives a request and sends a response. I've never tested this layer in my code because it's managed by other people. These are projects like Express.js, Django, Flask, Ruby on Rails, and so on. I can trust that they've built the layer handling HTTP requests and responses.

The next layer is one that converts the request into something specific to my domain and later converts the response into the request format for the HTTP layer. This layer is what's called a [representor](https://github.com/the-hypermedia-project/charter).

This layer can take domain specific values and errors and convert them into JSON responses to be sent over HTTP. For example, this layer may know that when my core code raises `ResourceNotFound` that it should convert it into a `problems+json` and set the status to 404.

This layer can be unit tested, and the tests can be straightforward. The example above needs to ensure that it can correctly handle the `ResourceNotFound` exception. Once I've written that piece of code and tested it, I can trust that it works.

Finally there's the core of the application. This layer receives representor objects and returns representor objects. In some cases, it may raise errors that an outer layer can handle.

Since this layer is separated from the outside world, I don't need HTTP to test the API. The HTTP is delegated to another layer outside the scope of the core tests.

This lets me create representations of the outer layers, pass those values into the core, and check the values it returns. Since I'm trusting the layers above, I don't need to transform those values into HTTP or JSON. This is the important part—if I don't include HTTP or JSON in the core of my code, I don't need to use those technologies to test my code. I can write a lot of fast tests to help me validate my design and refactor later.

