---
title: "Moving From High to Low Schema Entropy"
date: "2021-06-11T09:56:50-05:00"
cover: ""
tags: [schema-entropy]
description: ""
showFullContent: false
draft: true
---

Entropy is concerned with the amount of thermal energy that is available for work. The higher the entropy, the less the available energy for work. And vice versa.

The second law of thermodynamics states entropy will increase over time in a closed system until it reaches equilibrium. All the available energy will level out eventually as entropy increases.

I recently wrote about the idea of [understanding the complexity of a schema by measuring its entropy](https://smizell.com/posts/2021/05/understanding-api-complexity-through-schema-entropy/). One way to look at a schema's entropy is to calculate the number of possible variations of a schema. The more variations, the higher the entropy. The higher the entropy, the more difficult it is to work with an API.

## Entropy and business logic code

In any application, there will be code that tries to capture the rules and logic of a business domain. We'll refer to this as the core of an application. It's best to create layers of abstraction around this core to insulate it from the entropy of the outside world.

The purpose of this layer is to lower the entropy the core code has to deal with. It's about making it easier for one application to do work with another application.

This is what an API does.

Think about how you might make a JavaScript application interact with a Python one. There's too much entropy—or disorder—for one to work directly with the other. At best we'd have to make JavaScript understand the way Python works in order to call methods, use data, or interact with the software's memory.

Rather than make JavaScript work like Python, our first step would be to add a layer between them. We'd pass messages across a communication channel in that layer that both applications could understand and use. In other words, we lowered the entropy and make more energy available for work and interaction. We'd reduce the chaos.

Over time we'd find ways to standardize these interactions, giving us protocols like HTTP. But APIs aren't immune to this increase of entropy over time. Our work isn't done when we design or build the API.

## Higher entropy APIs and API consumers

A schema with a higher entropy creates disorder. It's like trying to wash the windshield of a car as it drives by you. The more disorder, the higher the difficulty for interaction. You want to slow that car down or park it to do your work.

Let's consider an example schema.

```yaml
type: object
properties:
	name:
		type: string
	address:
		type: object
		properties:
			street:
				type: string
			city:
				type: string
			state:
				type: string
			zip:
				type: string
required: [name]
```

In this example, we have an object with an optionally-nested `address` object. Because it's optional, the `address` object may not be there at runtime based on this schema.

If our core code is relying on the address properties, without a layer between it and the API, we'd have to do the following checks to make sure we've insulated our code from failures.

* Is the API response an object?
* If so, does it have an address property?
* If so, does it have a street property?
* If so, give me the value of the street property
* Otherwise, raise an error

This means we can't safely add this into our core code:

```javascript
response.address.street
```

This is because we might encounter an error like "Uncaught TypeError: Cannot read property 'street' of undefined" when `address` is absent.

You may have encountered code like this:

```javascript
if (reponse && response.address && response.address.street) {
  // work with response.address.street
} else {
  // error
}
```

Some languages have features that can help. TypeScript has the Optional Chaining and Nullish Coalescing. The code below won't throw an error if the address is absent. It will resolve as `undefined`.

```typescript
response?.address?.street
```

But while this works, it introduces a problem—there's now code in the core that is absorbing the entropy of the external API. The core code knows too much about the API. It has no layer between itself	 and the outside world.

## The Law of Demeter and entropy

There's something called the [Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter) that tries to provide guidelines for this scenario. For most people, this law is reduced to limiting the number of dots in a chained call. In that view, the Law of Demeter would encourage us to only have one dot.

But dots and levels of nested calls doesn't give us insight into what we're trying to avoid, which is the problem of coupling code to other code with a higher entropy.

The Law of Demeter is trying to say, if you want to reduce the complexity of your code, you have to insulate it from the chaos of outside world. This requires putting energy into the system in order to lower the entropy and simplify interaction.

## The business challenge of lowering entropy

Back to our example above, in order to lower the entropy, we need a layer between our core logic and the API to ensure the data needed is there, and to shape the data in a way that is compatible with the core code. It would do all the steps listed out that check the data and handle any failures apart from the core.

This helps because the core logic is where all the conditions and checks happen. And in order to make this core logic easier to use, test, debug, and evolve, it needs to be insulated from the outside world.

There are patterns that promote this approach. There's the hexagonal architecture. There's the onion architecture. There's the idea of [Functional Core, Imperative Shell](https://www.destroyallsoftware.com/talks/boundaries). There's also [the representor pattern](https://github.com/the-hypermedia-project/charter#representor-pattern) that creates separation between core code and an API. They're all seeking to lower entropy.

But they cost more. They take more time to build. And importantly they take buy-in from the team and knowledge share about the practice. It's easier in the short run to not lower the entropy.

However, over time, this shows up as tech debt—it's really the essence of it. Tests slow down with each new feature. It gets harder to evolve the code. API changes cause unforeseen breakages. The external entropy spreads throughout the entire system, and it won't stop until everything is in complete disorder—chaos—or until someone invests the energy to lower it.

Thankfully this is changing. We have practices like chaos engineering that invoke some unused variation of the system as a way to find the less-resilient parts—areas that aren't as insulated to the inherent entropy in the system. We need to borrow this approach in the API design and testing space, too.

## Fewer variations means a lower entropy

For a consumer writing code around the schema we used above, it would help to lower the possible number of variations the core code has to deal with. Ideally, it would be one variation. If there are variations that need to be handled in the core, they can be included at that point, but there's no need to do it from the outset.

In finding ways to measure variations, we can find ways to lower the entropy for API consumers, and in the end reduce the effect of an API even as it changes.

Measuring variations also helps API providers. It can help them ensure they aren't putting unnecessary entropy into their design. Increasing entropy is unavoidable just like in the real world. But understanding how much entropy an API designer is putting into the design can help inform good decisions.