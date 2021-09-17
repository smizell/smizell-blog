---
title: "About My Book, API by Design"
date: "2021-09-17T09:17:14-05:00"
cover: '/images/summary-cover.jpg'
tags: []
description: ""
showFullContent: false
---

_This is an excerpt from the book, which is available for preorder now. [Grab a copy](https://smizell.gumroad.com/l/apibydesign) with discount code early-bird._

---

I fell into the topic for my book [_API by Design_](https://smizell.gumroad.com/l/apibydesign) by accident. This is a behind-the-scenes look at how that happened and a deeper glimpse into the premise that API design should be more accessible to people who are just starting out.

## The challenges of API testing

I was researching API testing years before writing this book and discovered Gary Bernhardt’s wonderful talk called Boundaries. He made a claim that it’s not feasible to test the entirety of a system from the outside in. The problem is with the math of it all. There are too many tests to write by hand to test every possible state of the software. If there are just 20 conditionals in the code—if true do this, else do that—you need 220 tests to cover all the possible combinations of those conditionals. That’s over a million tests. Most code is more complex than 20 conditionals.

This creates a problem. Developers are left to try to find bugs by testing a very small percentage of all the possible states of their application. It’s up to them to look in the places where there may be issues in hopes of catching issues early. But it’s a game of chance, writing a few hundred tests by hand hoping to find the problems in a sea of millions of possible states of their software.

So I started reading more about this issue and found how people use fuzzing, property-based testing, and generative testing to let computers do the testing for them rather than write all those tests on their own. The idea is, given a well-defined interface, computers should be able to come up with millions of tests on their own and run them as a way to find bugs before they get into production.

I wanted to do this with APIs. And the OpenAPI document seemed to be the place to start.

To do this, I wrote some code to calculate the possible states of a schema and generate examples for them. I was going to generate a bunch of tests for an API this way by testing all the valid JSON structures and common problems with them. I had a working prototype for my tiny OpenAPI document I was working with and decided to point it at a larger, more-complex OpenAPI document.

My laptop churned and churned trying to create those tests. It never finished. There were too many possible states to generate in a reasonable time without some serious optimization work.

I made a few tweaks and decided to calculate the number of possible states instead of generating all the examples. This was fast, and when I got the numbers back, I was shocked. “There’s no way for me to generate and run this many tests,” I thought. “This is way too complex.” And that was where I started thinking about complexity in API designs.

I realized these calculations gave a sense of the complexity of the API schemas and the overall API. This in itself was useful, so I kept digging.

## The barrier to entry is too high

This is an assumption, but I think that the reason it takes so long to get proficient at API design is because you have to cultivate a feel for what’s complex and what isn’t. You have to know how a decision today will affect the API for months and years to come. This doesn’t leave much hope for the people starting out.

I remember well my experience starting out with APIs. I was working at a small company and needed to build something that could tie two different systems together. An API became the best choice. I started reading, getting books on the topic, finding blog posts, watching videos—the information I needed to learn was spread out all over the place. And the advice was always so divided. I’d read something giving advice for building APIs. Then I’d read something else saying to not build APIs a certain way because it was bad. Then the next thing told me that way was bad and to do it this other way. As someone who struggles with perfectionism, it was tough to have to synthesize so many conflicting approaches.
The lack of metaphors
We communicate primarily through metaphors, and the API industry doesn’t have many great ones. Even the acronym API is unhelpful. It doesn’t convey what it is or how we use it. When I tell people I work on APIs, they always ask what API stands for. My response is, “It stands for application programming interface, but that doesn’t really mean anything to most people.”

We use metaphors for sharing understanding about deeper topics. We talk about time as money—we save it, spend it, waste it, and invest it. In software, we talk about computers as if they were factory workers. We give them jobs, they run tasks, they do work as workers, they pick jobs off a queue. Without metaphors we’re left with the abstract, making it hard to share knowledge with others. That’s where we are with APIs.

## Why I wrote this

APIs are too complex to test. We make it a challenge for newcomers to learn API design. And we lack good ways to talk about these things due to a lack of good metaphors. I wrote this book to try to address these issues.

If API design is about managing complexity, then anyone designing and building them should be able to understand the consequences of their design choices as they make them. We can’t deal with complexity after the fact—the problems compound on themselves and the complexity spreads. And we need a better language to talk about complexity in APIs in order for us to share the knowledge about dealing with it.

I’ve tried to explore these things in this book, using the metaphors of physics and entropy to talk about complexity. I hope this makes the topic more approachable. In doing so it helps everyone—if we can get everyone making better design decisions then we can have better APIs across the entire industry.
