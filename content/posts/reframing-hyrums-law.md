---
title: Reframing Hyrum's Law
date: '2022-02-12T11:01:17-06:00'
cover: ''
tags:
- api
description: ''
showFullContent: false
---

Hyrum's Law says:

> With a sufficient number of users of an API, it does not matter what you promise in the contract: all observable behaviors of your system will be depended on by somebody.

But by itself it's not all that helpful to me. It's like saying, "with a sufficient number of people, a room will be overcrowded." Is that according to Fire Marshalls? Introverts? How big is the room? Just as important as the point of overcrowding are the symptoms of a room that's approaching overcrowding.

What are some things we can be thinking about and watching out for to limit the effects of people depending on all observable behavior in our APIs? How can we reframe Hyrum's Law for smaller, newer APIs?

* People are crafty. They'll find things your API does that you never realized. "If I put `%` in the search query param I get all the results without pagination!"
* Some of those people won't be afraid to use undocumented features like these in their production application. They just want to get their work done.
* And as soon as a consumer like this uses an undocumented feature, they will perceive any breakage as your fault. There's the obligatory [XKCD comic for this](https://xkcd.com/1172/).
* Consumers should be careful what they depend on and providers should be careful what they expose.
* We have a limited understanding of what our APIs actually do. Check out [this problem Heroku had](https://blog.heroku.com/json-schema-document-debug-apis).
* The implementation behind your API will leak into your interface, which will leak into your consumer's code. See [here](https://www.hyrumslaw.com/) for "The Law of Implicit Interfaces": "Given enough use, there is no such thing as a private implementation."
* We need to find ways to limit our unknown unknowns. We have to be proactive in limiting the complexity we put into our designs.
* The behavior of an API is a contract of its own. We should explain the intended behavior to our consumers the best we can.

The more people that integrate with an API, the more complicated things get. But this doesn't mean we have to assume that "all observable behavior of your system will be depended on by somebody" will be true on day one, and it doesn't mean we have worry that every change we do will break someone's code. It takes time and change to get there. What we can do is do our best to explain our intentions and expectations while understanding people are going to use our APIs in surprising ways.
