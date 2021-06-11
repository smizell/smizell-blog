---
title: "Intro to API Design Systems"
date: "2021-06-09T08:05:13-05:00"
cover: ""
tags: [api-design-systems]
description: ""
showFullContent: false
---

I've been tinkering with an idea I called an [API Design System](https://apidesign.systems/). It tries to take the thinking behind Design System patterns and apply them to APIs. You can read the overview on the site to get the idea behind it. I'll share details behind why I've been working on this.

## What we lose writing style guides in text

I've worked at places where we tried to come up with an API style guide. We'd write a bunch of markdown files or Confluence pages stating the requirements, styles, and patterns for building APIs. Then we'd share it with everyone.

The problem was, we had locked all those styles, standards, and requirements away in text. To adhere to them, people had to read the documents, pull the information out manually, and do their best to make sure you followed the guidelines. It didn't work.

## A dash of this standard, a pinch of that standard

When we'd write these style guides, we'd come up with a list of standards that we'd either require people to follow or allow them to follow if they chose. And sometimes we'd make it more granular than that—we'd require part of a standard and allow for the other parts. Not only could you not pick any standard, but you might not be able to use the entirety of a standard.

To add to the complexity, if we didn't find standards that met our needs or matched current practices, we'd come up with our own and define them in the style guide. Sometimes they'd be more thought out. Other times they'd be underspecified at best.

This left us with a bunch of files with MUSTs and SHOULDs scattered around referencing all or part of existing standards while including custom standards that were often lacking. There's opportunity there for improvement.

## When the style guide meets reality

The challenge with defining a style guide after people have built APIs is that you need to define a path forward for adoption. Are teams required to convert their existing APIs to this new style? Are they required to adhere to all MUSTs and MUST NOTs in the guide? What about the SHOULDs?

No matter what approach to gain adoption, it's a challenge to evaluate an API against the style guides, come up with areas that need attention or improvement, and set aside the time to do the work.

When is an API considered in conformance? What are the requirements for existing APIs? It's hard to determine based on markdown files.

## Applying design system thinking

Design systems provide reusable components and patterns for people building UIs. The design systems aren't documents to read but components people can use that capture the company's brand, language, voice, and interactions and make them usable in applications.

Taking this idea and applying it to APIs, how can we take those markdown files and turn them into something teams can use programmatically to design and build APIs.

The first step might be to generate a checklist of the requirements, maybe listing out all the MUSTs and MUST NOTs. Maybe another step is to provide specific patterns that people can build tests around that ensure they are using the right interactions. And maybe another idea would be to provide a way for people to define their own well-defined standards.

This is the idea [API Design Systems](https://apidesign.systems/) is trying to capture.

## What's next with API Design Systems

The project is an exploration into the idea at this point. It might be too complex at this point or it might not provide the right level of detail for capturing existing style guides. I'll be writing more here as I work on the project.

And if you have any interest in this idea, please [get in touch](https://twitter.com/Stephen_Mizell). Or drop into [the GitHub repository](https://github.com/smizell/api-design-systems) where I'm capturing the work.





