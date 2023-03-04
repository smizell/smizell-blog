# Benefits

## Improved API design workflow

When you can focus an API design discussion on the conversational language of the organization, you can include a cross-functional group of people that may not be familiar with HTTP, JSON, or URL patterns. This is because a tailored DSL can omit those technical details and rely on the tooling to apply them to the final technical design. Including more people improves the design process, and constraining the design with the organization's conversational language helps move toward a higher-quality design. The language-oriented approach can help bring newcomers and senior designers together in a discussion, as well as help those newcomers quickly learn API design through a DSL and toolset. Non-technical people and newcomers can join the discussion immediately rather than requiring training on general-purpose formats, API design practices, and tooling.

Including product, marketing, and sales people in the discussion helps ensure that the API design matches the terms used to talk about the product with the organization's customers. Leaving these roles out of the design discussion risks using mismatched terms. A cross-functional group will design a better API with a language-oriented approach.

Similarly, a design process that narrows the conversation to the necessary design details will enable a shorter feedback loop between the conversation and the design. The design discussion allows people to experiment with different design ideas quickly and rely on tooling to see how their ideas impact the technical details rather than having to know all the details on their own.

## Faster adoption

Teams can adopt a DSL faster than they can a general-purpose format and supplemental tooling. The language-oriented approach makes language the most important thing and simplifies the surface area of concepts and practices the teams need to learn and adopt. If people can learn the DSL, then they immediately get all the additional workflow benefits of the language-oriented approach that would normally require a considerable amount of work in a format-oriented approach.

A DSL does not eliminate the need for developers to learn HTTP, JSON, URL patterns, or the organization's style guide. However, it does eliminate the need for them to know how to design APIs using those details. Likewise, it reduces the level of expertise they need for API design. This enables non-technical people to design technical APIs by focusing on the DSL and leaving all the other technical standards and specifications to tooling.

## Multiple tailored approaches

Many organizations have multiple ways to build APIs—the old way, the really old way, and the new way—not to mention varying approaches like building async APIs, gRPC, and GraphQL. Each approach can be supported in tooling or have its own DSL if necessary. The language-oriented approach doesn't prevent an organization from creating more than one DSL. Rather, the language-oriented approach encourages finding ways to capture the conversational language in a DSL. Sometimes there are multiple conversational languages due to differing protocols and tools.

Over time, with a language-oriented approach, organizations can get comfortable with the idea of creating tailored languages that help them share organizational knowledge at scale. The tailored languages don't have to be just for APIs: they can be for UIs, for other technologies, for internal workflows and processes, and for common design patterns.

## Generating OpenAPI from the DSL

Organizations can generate compliant OpenAPI documents. A DSL that has a fraction of the lines can generate OpenAPI documents many times its size and complexity. This is a benefit of going from the particular to the universal. An OpenAPI that is generated from a DSL will be fully compliant with the organization's standards and guidelines because the DSL prevents people from designing a non-compliant API. Although it doesn't guarantee that the API solves the use cases or problems, it does guarantee the design is compliant.

Additionally, organizations can go beyond what OpenAPI offers with their DSL, incorporating conversational languages and approaches that OpenAPI doesn't support. OpenAPI allows for using a wide range of API standards and practices, but people have to know these standards and practices well enough to include them in their API design. A good example of this is the standard for [conditional requests](https://www.rfc-editor.org/rfc/rfc7232). To use this standard, people need to know which HTTP headers to use and where to put the headers in the OpenAPI document.

Instead of knowing these details, a DSL and related tooling can apply these standards and practices automatically based on the API design. With conditional requests, a DSL might have a feature to say a specific resource supports [ETags](https://www.rfc-editor.org/rfc/rfc7232#section-2.3), and the tooling would be able to add the relevant HTTP headers and status codes into the resulting OpenAPI document.

## Building workflows and change management into the DSL

Some parts of an API design might be in the conceptual phase. Others might be in development, and others may be meant to be restricted to certain roles, such as admins or vendors. It can be helpful to have OpenAPI documents for each of these scenarios and roles. Organizations can allow designers and developers to label parts of the API design based on these scenarios, roles, use cases, and statuses. OpenAPI doesn't provide support for this, but a DSL can.

Building workflows and change management into the DSL can enable people to play with design ideas apart from the development phase. It can give people the freedom to explore API features while keeping the designs of the features separate from public and vendor-specific API documentation. These labels can signal to others that certain parts of the API are conceptual and should not be developed yet. Making workflow a first-class feature of the DSL can also provide the basis for notifying consumers of upcoming changes.

Lastly, organizations can build features to express deprecation and sunsetting directly into their DSL. They can add messaging, dates, and plans for deprecating parts of the API and eventually sunsetting it. And OpenAPI generators can add deprecation and [sunset headers](https://www.rfc-editor.org/rfc/rfc8594) into the generated OpenAPI document to make the process easier.

## API compliance tests

A DSL allows organizations to ensure that the API design and implementation match. Organizations can create small tools that generate tests based on the design rather than writing tests separate from the design. Using their DSL in their tests, teams can ensure that the design and implementation match. This can promote a test-driven development approach where the failing compliance tests guide the team on how to implement the API. With tests like these, people can also understand the impacts of an API change. This is another way of improving quality: not only will the design and implementation always stay in sync, but so will the design and tests.

## Runtime tooling

A DSL can be embedded into a programming language so that it can be used for runtime validations. The DSL becomes the source of truth on the schemas for the request and response bodies. If used in runtime, then it acts as another step to ensure that the design and implementation match. This is not unique to the language-oriented approach; JSON Schema from OpenAPI can be used the same way. However, the language-oriented approach does allow for performing validation beyond what JSON Schema allows if the scenario calls for it.

The language-oriented approach is about orienting the entire API development lifecycle, even the runtime, around the organization's conversational language. The DSL is a tool to make this possible—it guides the design but can also guide the development, testing, and deployment phases of the API development lifecycle.

## Designing with code

There's an ongoing debate about which approach is best for API design: design-first or code-first. If a DSL is embedded into a programming language, then teams can use the DSL to design API changes in the code before writing the implementation. This promotes rapid prototyping as the implementation has a direct dependency on the design. Engineers can work through a design and immediately see how it would look within their code and what parts of the application it affects. Moreover, it can allow for people to follow a design-first approach by enabling them to iterate on a design and prototype ideas with code as part of the design process.