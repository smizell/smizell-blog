---
title: "Robustness, Tolerant Readers, and JSON Schema"
date: "2021-07-06T07:28:00-05:00"
cover: ""
tags: [schema-entropy]
description: ""
showFullContent: false
---

I've been exploring the topic of [schema entropy](/tags/schema-entropy/), the idea that we can understand the complexity of a schema by exploring all possible variations of the schema. The more variations, the higher the schema. The higher the schema, the more complex it is.

When evolving an API, it's helpful to look at how the entropy of schemas change. For example, with request bodies, it's necessary to increase entropy for each schema change. This is because reducing entropy or keeping it the same may break an API client.

## Common robustness practices: ensuring you're increasing entropy

One way that people make sure they're increasing entropy when they change their API is to require any new property in a schema to be optional. This is called the [Robustness Principle](https://en.wikipedia.org/wiki/Robustness_principle), or Postel's Law, or the [Tolerant Reader pattern](https://martinfowler.com/bliki/TolerantReader.html).

When looking at schema entropy and robustness, if an API provider adds a required property, entropy stays the same. This has the potential of breaking clients because it alters existing variations—variations that existing API clients are relying on not changing. Making the new property optional ensures that all the existing variations go unchanged.

This works at reducing breaking changes. But this universal rule isn't always needed. For example, it should be OK to add required properties to API responses as long as the API clients are tolerant of new, unrecognized properties. 

## An idea to keep APIs robust: public and private schemas

Schema entropy shows that a single JSON Schema can express thousands—sometimes millions—of variations. The more entropy, the more possibilities of bugs and problems. Unfortunately, with current robustness practices, it's required to increase entropy exponentially to safely evolve APIs.

But what if it wasn't? What if we thought of ways to slow the increase in entropy while being tolerant of existing API clients.

One possible way to do this is to maintain two schemas: the strict, public schema and the tolerant, private schema.

For example, say we have this simple schema below for a request body. We'll say an API client sends JSON that conforms to this schema when trying to create a new customer.

```js
{
  "type": "object",
  "properties": {
    "name": { "type": "string" }
  },
  "required": ["name"]
}
```

Now let's say we want to add a new `email` property. If we follow the robustness rules we looked at above, we'd have to make `email` optional. We do this so we don't break clients that are unaware of the `email` property.

However, what if instead of making it optional, we specified publicly that we require `email` yet we tolerate it privately when existing clients don't include it.

The schema might look like this. I've added my own extension here to show how it might look as an example. I'm not proposing this as an extension.

```js
{
  "type": "object",
  "properties": {
    "name": { "type": "string" },
    "email": { "type": "string" }
  },
  "required": ["name", "email"],
  "x-tolerant": ["email"]
}
```

Any new client knows `email` should be included. If they use this public schema, they'll be able to use the schema to validate their request bodies and get feedback when `email` is missing. And existing clients will work like they did before because the API is tolerant when `email` is missing. It feels like the opposite side of the coin to deprecating a field.

An API provider could go a step further and provide warnings when an API client triggers a tolerant property. API providers could include warnings in the response, the headers, or send an email to the consumers out of band.

## Versioning schemas as another way to stay robust

Above I used an `x-tolerant` property to express how the API reacts when a required field is missing. There are other ways to get this same result.

One is to version the schemas. That gives you the same functionality as `x-tolerant`, though it requires one of two things:

1. API consumers must send the version of the schema they're using, which puts the burden on them to add it to their requests
2. API producers must pin consumers to a schema version and require they explicitly change it to get access to new properties—this is [what Stripe does](https://stripe.com/blog/api-versioning) but at the API level and not the schema level

Doing something like `x-tolerant` eliminates any burden on the consumer, though it does require API providers to support tolerance in this way. That will always be the case, though. API providers don't get robustness without supporting it.

## Robustness takes work

It's important that API consumers follow a similar approach. They should only validate schema properties they need. Adding a new property in an API response should never break an API client. Even a breaking change on an unused property shouldn't break an API client. This is a consumer being "liberal in what it accepts."

To make this work, API providers have to create a separation between what's publicly expressed as the current schema and what's tolerated by the provider. Robustness doesn't require that everything be defined as optional, it just requires that API providers have some level of tolerance for API changes.

We can express this idea by modifying Postel's Law: be conservative in how you publicly document your schemas and be liberal in how you apply those schemas.