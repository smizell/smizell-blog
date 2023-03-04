# Case Studies

## Examples of language-oriented approaches

### AWS and Smithy

AWS has their own language for describing services that they called [Smithy](https://awslabs.github.io/smithy/2.0/index.html). In a talk titled [Scaling APIs with Smithy](https://youtu.be/3GpZzu4guTE), Michael Dowling describes the scaling challenge they faced at AWS around API design and SDK generation. They had many public APIs and thousands of internal APIs, and they needed to scale the API design process across the entire organization. They also had to support a long list of programming languages for their CLIs and SDKs. Dowling described the situation they found themselves in when they realized they needed to scale their API program and tooling:

> We formed API design patterns and best practices, but knowledge sharing was often ad hoc. We also noticed that not every team followed the same practices and our customers told us this leads to steeper learning curves when moving between services.

<!-- 7 min in video -->

They created Smithy to address some of these issues. Dowling describes the purpose of frameworks and API programs as to "reduce the number of choices teams need to make in order to succeed." They worked on Smithy as a way to enable teams across a large organization to build consistent, quality APIs. They were also focused on SDK and code generation, and this approach allowed them to provide better developer experiences with the SDKs and generated code.

Smithy was AWS' attempt to build their own tailored API design language. They tailored Smithy around their model-first process, CLI and SDK generation, and generating OpenAPI documents. A Smithy document that was 102 lines would produce an OpenAPI document of 176 lines. The reduction in lines wasn't the only win—another victory was the reduced area the API designer had to think about and the errors Smithy prevented them from making.

### Microsoft and TypeSpec

[TypeSpec](https://microsoft.github.io/typespec/) by Microsoft is "a language for describing cloud service APIs and generating other API description languages, client and service code, documentation, and other assets." TypeSpec allows developers to write concise and reusable API definitions and generate consistent OpenAPI definitions from those definitions.

TypeSpec is a good example of a company taking a language-oriented approach in order to build quality, consistent APIs at scale. They recognized that the breadth of features offered by OpenAPI could lead to inconsistencies in API designs that might not be obvious at the time of design. So they created a smaller, more concise language for developers that provided the flexibility they needed while creating guardrails around the OpenAPI specification.

In the blog post [Behind the scenes of the Nightscout API](https://devblogs.microsoft.com/azure-sdk/behind-the-scenes-of-the-nightscout-api/), Mark Weitzel and Darrel Miller show how they [refactored their original API definition to use TypeSpec](https://github.com/APIPatterns/nightscoutDescription) and saw an improvement in the design along with a substantial reduction in the number of lines of code they had to write.

> When complete, our [main TypeSpec] file is a concise 66 lines of code, making it easy for a developer to quickly understand the entirety of an API. Taking into account the models, common interfaces, and the documentation, the entire TypeSpec totals around 500 lines of code. When rendered as OpenAPI, the resulting specification is over 5,000 lines of code! By generating the OpenAPI from TypeSpec, we get a specification that conforms to our practices and guidelines. Using TypeSpec to codify guidelines, practices, and patterns to generate cleaner, more consistent specifications, is exactly what the Microsoft Graph and Azure SDK teams are doing!

The TypeSpec code is about 10% the size of the generated OpenAPI. Not only do developers not have to create those extra 4,900 lines of OpenAPI, they also don't have to know how to write those extra lines of OpenAPI. Developers can write in a concise format and let their tooling doing all the hard work. The resulting OpenAPI document is one that automatically matched their guidelines, practices, and patterns. [Brian Terlson shares the same experience](https://mobile.twitter.com/bterlson/status/1572381666286665728) while using TypeSpec:

> It's hard to overstate how much this accelerates API dev. You can go beyond linting by creating API components that ensure developers can only create APIs that follow your organization's guidelines, with customized tooling that helps them eliminate any mistakes.

TypeSpec provides developers with tooling that makes it easier to design the right thing and makes it impossible to build the wrong thing.

### Stripe and their Custom Ruby DSL

Stripe has a custom Ruby DSL that allows them to design their APIs and generate OpenAPI documents from it. Richard Marmorstein shares his experience with API design while working at Stripe in his talk [Artisanal, machine-generated API libraries](https://youtu.be/mgRreyw-Nlg). He describes Stripe's API as having 85 resources and 325 methods at the time. Their challenge was updating and releasing new versions of their seven supported SDK libraries whenever they changed their API. They did all this work by hand, but at some point, they decided to generate the SDKs to make them easier to maintain.

Stripe's API DSL allows them to encode their special cases, especially for field types that OpenAPI doesn't support. Stripe can describe their special types in their DSL and generate the more verbose and less descriptive OpenAPI document that corresponds to it. They can also build their SDK code around this DSL so that they don't have to decode their special cases from a more complex OpenAPI document.

### Crunchy Data and their Custom GO DSL

[Brandur Leach](https://brandur.org) writes about his journey toward a language-oriented approach in his [newsletter article about API documentation](https://brandur.org/nanoglyphs/031-api-docs). His journey took him from Heroku, to Stripe, to Crunchy Data. Leach describes his work on APIs at Heroku, where they used [JSON Hyper-Schema](https://json-schema.org/draft/2019-09/json-schema-hypermedia.html), a general-purpose format similar to OpenAPI, to describe their API:

> Because the schemas lived out-of-band of the API implementation, we needed a way to show that they were right, and continued to be right even as the implementation potentially diverged.

Leach built a tool called [Committee](https://github.com/interagent/committee) to help ensure that the design in JSON Hyper-Schema matched the implementation. Leach shares what he sees as the downside to this approach, though:

> Manually writing Hyper-Schema was time consuming and awful. [...] Furthermore, the whole process was just pretty manual overall. Even once the schema was written, it had to be maintained in step with API development, with changes manually pushed to [Prmd](https://github.com/interagent/prmd) and then published through Devcenter.

Later at Stripe, Leach worked with Stripe's custom API tooling and tailored DSL. He left there to work at Crunchy Data. He describes the situation there before they created their DSL.

> The loop was: hopefully a product person would remember that a new API feature was shipping, and would poke a dev rel person to update the docs. The dev rel person would write some documentation about a feature they understood by way of two hops worth of telephone, hit some endpoints with cURL, and try to capture what came back as best as they could.
>
> The results were about what you’d expect. The docs were enough to get something working, but only about half our total API endpoints were documented. Amongst those that were, fields were often missing or extraneous as the responses had changed since the docs were originally written. Some of it was just flat out wrong.

This is an example of a disjointed API development lifecycle where none of the steps seem to go together. Leach worked on a DSL in Go to address these issues. With this tool, Crunchy Data was able to design their APIs, build correct documentation from the design, and use the design at runtime. Leach sums up their work:

> [On] a successful merge to master, CI pushes a new OpenAPI to the web. A separate GitHub Action wakes up, runs the doc generator and commits any changes. That commit triggers a Heroku deployment and pushes the changes live. Aside from the initial merge on GitHub, no human intervention is required at any point.

This is a good example of using a DSL to create a cohesive API development lifecycle, where everything is connected, from the design to development to documentation.

## Flow and their approach to microservice architecture

Michael Bryzek at [Flow](https://www.flow.io), which is now part of [Global-e](https://www.global-e.com/), talked about their approach to microservices in his talk [Design Microservice Architectures the Right Way](https://youtu.be/j6ow-UemzBc). In his approach, he created a design and development process that used a tailored DSL as a way to ensure all microservices followed the same styles, standards, and patterns for their APIs. Flow's design process started with the DSL, and from there, they generated OpenAPI documents, server code, and even database schemas. The API design language captured in the DSL drove the entire development process.

Bryzek was looking for several benefits when crafting Flow's approach to microservices. Bryzek said good architecture:

* Scales development teams
* Delivers quality
* Enables high performance and low cost
* Supports future features naturally

These are also goals of a language-oriented approach.

One example that shows the power of this approach is where Bryzek shows how they added support in their DSL for tracking personally identifiable information. They could then use this information throughout their entire architecture. Below is a snippet of what their DSL looked like and how they use `personal_data` to signify personally identifiable information. The example has been condensed for the sake of brevity.

```json
{
  "user": {
    "fields": [
      {
        "name": "email",
        "type": "string",
        "required": false,
        "annotations": ["personal_data"]
      }
    ]
  }
}
```

This DSL shows how they were able to go beyond what OpenAPI provides. The DSL becomes the source of truth for their entire development workflow, influencing client and server code generation, database migrations, and as we see here, privacy policies.

### Square and their Custom DSL

In the blog post "[Making OpenAPI / Swagger Bearable With Your Own DSL](https://developer.squareup.com/blog/making-openapi-swagger-bearable-with-your-own-dsl/)," Sebastien Armand describes the approach he took to make it easier to deal with the complexity of OpenAPI. He defines the problem:

> While OpenAPI is great for describing APIs, generating client SDK code and defining API contracts, it's definitely not a great experience to write OpenAPI documents from scratch.

He said that for them, an OpenAPI document describing just 10 endpoints could end up being over 1,000 lines long. This makes it challenging to maintain and read.

Armand decided to create their own DSL to write OpenAPI. He shows an example in his blog post where he designs an entire API in 61 lines of his DSL and generates 550 lines of OpenAPI in YAML—nearly an order of magnitude larger than the DSL. Armand did not release the code for their DSL, though, stating:

> I encourage you and your team to do the same if you write Swagger / OpenAPI documents. However, it's likely your response format or your error format is specific to your API and won't fit what we've done ourselves by customizing this DSL to our service. That's why I encourage you to write your own DSL if you want to get the real benefits from this approach.

His suggestion is to make a DSL because everyone's needs and patterns are different.

### ALPS and the Unified API Design Method

[ALPS](http://alps.io/), which stands for Application Level Profile Semantics, is a format for describing the semantics of an application separate from the technical and implementation details of the application. When used for API design, ALPS acts as an interface design language, enabling people to focus on the interface's properties and actions and leave out the HTTP details. The goal is to improve the design process and make the application-level semantics reusable across many different types of implementations.

Mike Amundsen, one of the authors of the [ALPS specification](https://datatracker.ietf.org/doc/html/draft-amundsen-richardson-foster-alps-04), has a [project](https://github.com/mamund/alps-unified) that uses ALPS as a Unified API Design Document, which is a document that is agnostic of the protocol and implementation and can be converted into many other formats like OpenAPI, AsyncAPI, and Proto3 among others.

In his talk titled [GraphQL, gRPC and REST, Oh My!](https://github.com/mamund/2020-04-unified-api-design), Amundsen tells an API design and governance story where an organization chooses OpenAPI as the backbone of their API design practice. After investing time and money in people, processes, and tools, the organization realizes that they want to support technologies other than OpenAPI, like gRPC or GraphQL. Amundsen asks, what should the organization do? Start over? Invest in more people, processes, and tools for these other formats? Amundsen proposes instead of using OpenAPI as the backbone of an API design practice, organizations should seek a unified design solution. Amundsen shows in his ALPS Unified project how this would be possible.

Although ALPS is not a DSL tailored to a specific organization's conversational API design language, it is minimal enough that an organization could layer on a light set of governance rules and get much closer to a language-oriented approach than they could using OpenAPI directly. Organizations could also create a DSL that they map into ALPS and then into other formats like OpenAPI and AsyncAPI. The ALPS Unified project is a great example of how this is possible.

## What we see with these examples

These examples show organizations and projects that were searching for ways to deal with the challenges of creating an API program at scale. Ultimately, these organizations and projects saw how a format like OpenAPI is not enough for building consistent APIs and maintaining tooling such as documentation or SDKs. They found it was worth the investment in their own DSL because they saw the costs of using a general-purpose format that showed up over time.
