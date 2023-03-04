---
title: "Enterprise edition: where did the API go?"
date: "2023-03-04T12:37:21-06:00"
cover: ""
tags: []
description: ""
showFullContent: false
---

I recently wrote about [a trend in the frontend world](/posts/2023/02/where-did-the-api-go/) where people are working to make the API disappear. This week, a new framework called [Service Weaver](https://serviceweaver.dev/) popped up that strives for this just from a microservices perspective. There's a [Google blog post](https://opensource.googleblog.com/2023/03/introducing-service-weaver-framework-for-writing-distributed-applications.html) that goes into detail bout Service Weaver:

> Service Weaver allows you to write your application as a modular monolith and deploy it as a set of microservices. 

It says that Service Weaver decouples "the process of writing the application from runtime considerations such as how the application is split into microservices, what data serialization formats are used, and how services are discovered." In other words, with Service Weaver, write your code in a way that feels local and let Service Weaver deal with the complicated runtime complexities (e.g. the API).

The blog post describes Google's motivation for creating Service Weaver:

> While writing microservices-based applications, we found that the overhead of maintaining multiple different microservice binaries—with their own configuration files, network endpoints, and serializable data formats—significantly slowed our development velocity.

Like with the frontend trend, Service Weaver is about focusing on the business logic and forgetting about the network as much as possible. It's all about improving the way people develop applications.

This pattern isn't new, which many people on the internet were quick to point. "Haven't we learned anything?" Others brought up the [fallacies of distributed computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing). A few mentioned Erlang. But I think it's important to not dismiss this project or trend so quickly.

What's interesting to me is how Service Weaver comes with a lot of important tooling for building microservices. Logging, metrics,  tracing, profiling, routing, versioning—these are all headings in their documentation and a key piece to building applications with Service Weaver.

> Method calls are executed with at-most-once semantics. This means that Service Weaver does not automatically retry method calls that fail. However, you can detect and retry failed method calls explicitly using `weaver.ErrRetriable`.

The code to retry looks like this ([copied from the docs](https://serviceweaver.dev/docs.html#components-semantics)):

```go
// Retry the cache.Get method call up to five times.
var val string
var err error
for i := 0; i < 5; i++ {
    val, err = cache.Get(ctx, "key")
    if errors.Is(err, weaver.ErrRetriable) {
        // Retriable system error! Retry.
        continue
    }
    break
}
```

So the network doesn't *completely* disappear—you still have to consider network issues when you want to go beyond the default. However, a project like Service Weaver could help people start with an application that's simpler to build, deploy, observe, and maintain and evolve it into something more complicated over time without having to do a massive monolith-to-microservice transition.

I have similar questions as I had with the frontend trend. What happens when someone wants to call one of the microservices? Is the modular monolith the main interface to the application? Or can other teams write their own code in the language of their choice that integrates with the Service Weaver microservices? Does Service Weaver neglect one of the key benefits of microservices: providing a clear boundary of cross-team ownership?

Lastly, I found this piece of information intriguing. It was [a reply tweet from Kelsey Hightower](https://twitter.com/kelseyhightower/status/1631665871109365762) when asked if this is used internally at Google:

> We do not use this internally at Google. Unlike gRPC, Service Weaver is a new project from the ground up like Go and Kubernetes were.

This means that Service Weaver is a reimagining of how the creators think people should build microservices. They started over, and decided this is the best way forward, a way forward where people build applications and think less about APIs.