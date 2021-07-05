---
title: "Talking About APIs as Interaction Layers"
date: "2021-06-27T07:02:27-05:00"
cover: ""
tags: []
description: ""
showFullContent: false
draft: true
---

I remember when I first started exploring the concept of APIs how challenging it was to understand what an API is. "API" isn't a great term for encouraging discussions. "Application programming interface" doesn't give many hints as to what it is either. "API" as a term is ambiguous and has different meanings across several disciplines.

I find myself answering many API questions with "It depends." Should you build an API? It depends. What kind of API should you build? It depends. There's a lot of opportunity to find ways to add clarity around "API."

I had that the thought that the phrase "web communication layer" might help describe the area of APIs that I spend my time working around. 

## What's in a name?

Why might the phrase "web interaction layer" be better than staying with the commonly-accepted term API? We commonly say "Web API" or "HTTP API" to narrow the focus. Maybe we can narrow it even more.

### Why web?

The term API can refer to a REST API or RPC API. It can also refer to interfaces like a class or module in a programming language or a physical interface that lets hardware interact with each other.

"Web" describes a category of interactions that use the internet and HTTP protocols as the primary protocols in the integration layer.

### Why communication?

API stands for application programming interface. The "programming" part of "application programming interface" is more focused on the work and not about the outcome. The phrase itself is technical.

The point of programming against an API is to enable an interaction, where interaction [means](https://www.merriam-webster.com/dictionary/interaction) "mutual or reciprocal action or influence." It's about two pieces of code working together to do an action.

### Why layer?

It's easy to think of writing code that interacts with an API. However, it's the API that allows for code to interact with an application somewhere else. Code over here and code over there both following the same protocols and using the same languages so they can interact with each other.

The concept of "layer" promotes this image, as something sitting between to other things.

## The different category of web interaction layers

There are many different types of APIs. It's sometimes hard to keep them all straight, and many times the term we used doesn't do a good job painting a picture of the APIs intent.

When we think of interaction layers, we can put them into a few different categories.

### Person-centered

This category refers to a type of interaction layer where a person is the main driver of the interaction. 

People call these types of APIs a backends for a frontends. Their purpose is to provide an interface to the person and interact with a system based on the action the person takes.

These types of interaction layers might be server-focused. The server might send HTML to the browser along with JavaScript to progressively enhance the interactions.

This type might also be browser-focused where the server sends a full application rather than a representation in HTML and where the browser acts more as a runtime for that application.

Lastly, this type might be native-focused where a mobile or desktop app is the one using the interaction layer based on a person's actions.

### System-centered

We might think of this category as machine-to-machine communication. We build these kinds of layers for backend and distributed systems where the primary driver of the interaction is an application or a part of the system.

### Custodian-centered

There's overlap between the categories of person-centered and system-centered. What do you call it when an application takes an action on behalf of a person?

This happens when a person authorizes an application through a standard like Oauth to interact as a representative. Though these interactions might start with the actions of a person, a custodian-centered interaction works with another system as if the person was interacting with it directly.

An example would be a web application that interacts with the GitHub API to pull in data or make changes to a repository.

## Last thoughts

I'm not suggesting leaving "API" behind. However, I'm interested in finding better ways to talk about it. When we talk about APIs, what are we talking about? How does this influence our discussion with people new to the industry or with skills that don't focus on technology?

There may be other terms that describe this area or similar areas better. I'm all for exploring those—I'm much less interested in creating something new and more interested in exploring ideas that give color to what we already have.