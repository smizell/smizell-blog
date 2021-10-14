---
title: How Netflix Reduces the Surface Area of Coupling
date: '2021-10-14T07:48:58-05:00'
cover: ''
tags: []
description: ''
showFullContent: false
---

I wrote about coupling in [API by Design](http://apibydesign.com) and the characteristics associated with it. One of those characteristics is the coupling's surface area which defines the number of resources, schemas, and properties upon which an API client depends. The larger the surface area, the more likely an API change will require an API client change. API consumers can limit this risk by relying on less of the API.

Netflix talks about [how they use Protobuf FieldMask](https://netflixtechblog.com/practical-api-design-at-netflix-part-1-using-protobuf-fieldmask-35cfdc606518) to allow consumers to specify which fields they use in order to solve complexity issues. They say:

> Some response fields can be expensive to compute, some fields can require remote calls to other services. Remote calls are never free; they impose extra latency, increase probability of an error, and consume network bandwidth. How can we understand which fields the caller doesn’t need to be supplied in the response, so we can avoid making unnecessary computations and remove calls?

This is a look at coupling from the server's perspective. As server developers, they want to reduce the number of fields because some of those fields can be expensive to compute. We could also make the jump that more expensive fields create more opportunities for bugs and issues.

By limiting the fields, the consumer can limit the surface area of the coupling and reduce the likelihood an API change will affect them. Not only does the provider avoid expensive fields, consumers avoid relying on those expensive fields. The responses are more stable and have lower response times. It's a win-win.

Netflix provides a way for the consumer to do this server-side by sending the FieldMask. Another approach for consumers is to do this client-side. This doesn't get all the benefits like reducing compute time on the server, but it can protect the internals of the API client from API complexity associated with unused areas of the API.

Complexity is unavoidable. But consumers and providers alike can find ways to limit their exposure to it and reduce or remove it from their systems over time. Finding ways to reduce the surface area of coupling is a good place for both groups to start.
