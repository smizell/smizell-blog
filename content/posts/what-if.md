---
title: "What If"
date: "2021-10-12T07:29:17-05:00"
cover: ""
tags: []
description: ""
showFullContent: false
---

What if someone asked you to design a new API description format like OpenAPI? What would you include? What would you take away? What would you do differently? What would your focus be?

As I've been thinking about complexity in API design, I had the thought that it might be an interesting exercise to come up with an API description format that aggressively limits complexity in API designs.

How would I do this? I'd start by ripping out as many features as possible. I'd put lots of constraints on the schemas. I'd focus on defining resources and their relationships with each other. I'd get rid of `$ref`. I'd limit or remove the ability to nest things, especially beyond a certain level. I wouldn't allow optional properties. I'd make sure it compiled to OpenAPI. My list goes on.

What if I told you I was working on this format? Would you be excited? Would you be skeptical? Or would you jokingly send me that [XKCD comic about standards](https://xkcd.com/927/)? I go back and forth myself, so we'll see.