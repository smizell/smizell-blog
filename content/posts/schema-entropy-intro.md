+++
title = "Understanding API Complexity Through Schema Entropy"
date = "2021-05-21T13:34:36-05:00"
description = ""
showFullContent = false
+++

I'm working on a personal project with the goal of giving insights into the complexity of an API design. We don't have many ways or tools for looking at complexity, and the ones we do require experience and knowledge of API design. I'm hoping to find ways to look at complexity through a different lens.

One way I'm working on now is what I call schema entropy.

## An intro to the idea of schema entropy

Schema entropy is a way to look at the complexity of an API schema by determining how many variations of the schema are possible. We'll look at the schema below to help share how that works.

```yaml
type: object
properties:
  name:
    type: string
  email:
    type: string
  phone:
    type: string
    nullable: true
  required: [name]
```

The schema above has three properties—`name`, `email`, and `phone`. The `name` property is required while the others are optional. The `phone` property can also be null.

How many variations of the structure of this object are there?

1. name
2. name, email
3. name, email, phone
4. name, email, phone as null
5. name, phone
6. name, phone as null

While this alone doesn't show us the full picture of the complexity of the schema, we can see how quickly the number of possible variations for a schema can grow.

How many of those variations are tested by the API producer? Which of these variations aren't possible based on the underlying application? Do any of these variations affect clients in ways that they haven't planned for?

## An example from Stripe

We can look at a schema from Stripe's API to explore its complexity. The example below is their `status_transitions` schema.

```yaml
type: object
properties:
	canceled:
	  description: The time that the order was canceled.
	  format: unix-time
	  nullable: true
	  type: integer
	fulfiled:
	  description: The time that the order was fulfilled.
	  format: unix-time
	  nullable: true
	  type: integer
	paid:
	  description: The time that the order was paid.
	  format: unix-time
	  nullable: true
	  type: integer
	returned:
	  description: The time that the order was returned.
	  format: unix-time
	  nullable: true
	  type: integer
```

These are four properties, but they produce 81 different variations—each property can be an integer, undefined, or null. Four properties with three options means we calculate 3^4 to get 81. Adding another optional and nullable integer field would make it 3^5 or 243 variations.

The simplest schema has one variation. It can have many properties, but if they are all required, there aren't other scenarios to consider for the structure of the corresponding JSON.

## Working to reduce entropy as API consumers

A high schema entropy doesn't guarantee problems will occur, nor does it tell you exactly what problems could occur. It mainly calls out areas of complexity, and points to schemas that require more care when consuming.

To protect themselves, an API consumer could work eliminate possible errors by handling every possible variation. Unfortunately, this isn't possible for schemas with more than a few properties based on the schema alone.

Another option is to reduce the number of variations that one has to deal with. If a schema has eight different variations, the API consumer can figure out ways to handle one or two of them depending on the combination of properties needed.

For example, let's go back to my original example. If I'm writing API consumer code that interacts with that API schema, and I require both the `name` and `email` to be present to successfully execute my code, then I can define a more narrow and restrictive schema where both `name` and `email` are required. This reduces the number of variations from six to one.

This helps because a missing `email` property is valid JSON according the schema, but my code will fail without it. This means I have to require it, and thus reduce the number of variations that I deal with in the process.

This is why applying a full JSON Schema to a response is an expensive operation, one that may not fully protect an application, and one that may not satisfy the needs of the API consumer.

## Increasing entropy for API providers

Weirdly enough, there are cases where API providers want to increase entropy as they evolve their APIs. One scenario is when they are evolving a request body schema.

This is because any change that reduces the number of variations has the potential to break the code for an API consumer. This is because they may have code that depends on that variation. This is also true of API response bodies.

If the change in the request body schema keeps the number of variations the same, it means the change added a required field. This modifies an existing variation that someone might be relying on.

The only path forward is to create a new variation, usually by making a new property optional. This is the same as thinking of breaking changes, but it gives a way to capture some of those without defining what counts as a breaking change.

## Do you have any interest in this?

If you have any interest in this, I'd love to chat. [Email me](mailto:smizell@hey.com) and I can share more details. I'm looking at ways to look at complexity beyond the number of variations in a schema. There are different angles from which we can look that help show how complex a schema is.