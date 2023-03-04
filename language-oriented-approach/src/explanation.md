# What is a language-oriented approach?

Hidden within the cascade of challenges of OpenAPI is the task of defining the language an organization uses to talk about and design APIs—their conversational language. The conversational language captures the terms, requirements, patterns, standards, and best practices that people use conversationally as they design APIs.

OpenAPI isn't enough to ensure that people follow the organization's conversational language. Processes, workflows, and tools are required to augment OpenAPI. With the language-oriented approach, however, organizations orient their API design and development workflows around the organization's conversational language.

The language-oriented approach encourages organizations to begin building an API program by defining their conversational language and then creating a tailored DSL around it. Organizations follow this by building tooling around their tailored DSL, such as tooling that generates OpenAPI documents that conform to their API guidelines and standards.

## Conversational language as a way to talk about API design

For example, when designing an API, someone might say the phrase "to create a new customer in our system, API consumers should send a POST request to the collection resource URL for the customer." Industry terms are present in this statement—terms like "POST request" and "URL" that fit within HTTP and URL standards—but there are also terms that mean something within the given context of the organization. What's a collection? What does a collection URL look like? When would someone use a collection URL? These context-specific terms may be unique to the organization or to a given API design standard.

As an organization standardizes the way they build APIs, they define and refine their conversational language as a way to both restrict and guide API design discussions. The conversational language provides guardrails around what a design can and cannot include.

## Making the conversational language first class with a tailored DSL

With the language-oriented approach, the conversational language is first class. There's no need to translate an API design discussion into an OpenAPI document. The design is captured directly in the DSL using the same language. The DSL is thus an organization's way of codifying the conversational language. Using the example above, the DSL might provide a way of describing a "collection resource" that allows for a "create" action, all while leaving out the more technical details.

## Leaving the details to tooling

How an organization represents "collection resources" and "create actions" in OpenAPI is left up to the tooling that generates the OpenAPI document. A collection resource might have a specific pattern for URLs. There's no need for that to be part of the design conversation because the organization has already decided what that pattern should be.

The language-oriented approach focuses on defining the organization's language first—the way they talk about APIs—then building a DSL around that language that can be integrated with industry-wide tooling and standards like OpenAPI. In this way, organizations would use their DSL as a language in a design-first approach. 

## From the particulars to the universal

Design-first encourages people to design an API and its features before building and deploying the API so as to achieve a better API design that conforms to the organizational standards. The language-oriented approach seeks to continue this best practice and improve upon it rather than abandon it.

The language-oriented approach improves on current approaches by going from the particulars to the universal—from the tailored DSL to the general-purpose format. People start the API design process with their tailored DSL, capturing the particulars of the API design, then they use tooling to convert that DSL into something universal and general-purpose like OpenAPI. With a format-oriented approach, this process is flipped, requiring people start with a general-purpose format and apply governance rules to limit that format to the particular details of the organization.

Focusing on the particulars allows people in an organization to ignore the areas of the universal that are irrelevant to the design conversation and let tooling deal with how their conversational language maps to a general-purpose format like OpenAPI. This improves the design process and ensures a better API design.