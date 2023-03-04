# The cascading challenges of OpenAPI and design-first

It's common for API designs to drift apart in an organization. Over time, they become inconsistent and differ in quality, especially as organizations build more APIs and rely on them for leveraging a competitive advantage. At some point—as a way to incorporate a product mindset into their API approach and improve the developer experience for their customers—an organization may institute an API program that encourages quality, consistency, and knowledge sharing across their API development teams and workflows.

The industry pushes organizations to standardize around a format-oriented, design-first approach. In this approach, cross-functional teams—product managers, developers, QA engineers, and others—work together on an API design before anyone starts writing code and building the API. Once established, the API design becomes the source of truth, guiding the development process on how to build the API and instructing the QA engineers on how to use and test the API. The design-first approach is a good approach, but being format-oriented complicates the process.

## On choosing OpenAPI

The most popular general-purpose format in the industry for defining the HTTP and schema details for an API is OpenAPI. Many organizations choose OpenAPI as their API description language because of its popularity in the industry, its wide range of tooling support, and the breadth of design possibilities the OpenAPI specification affords. OpenAPI can work as the foundational piece of a design-first approach within an organization's API program.

Although OpenAPI is a great specification with many great tools, in choosing OpenAPI to drive their design-first approach, organizations set themselves up for a cascade of challenges: a solution to one problem leads to the creation of more. The industry may be set on OpenAPI as the standard format, but the industry is fractured on which tools, processes, and workflows organizations should use to develop a holistic API program that their teams can adopt.

## Authoring OpenAPI versus reading OpenAPI

OpenAPI is a great tool for describing the details of an API, but it’s not a great tool for people to use to author API designs. Teaching people how to use OpenAPI for authoring can incur a significant cost to adoption.

In a format-oriented approach, API designers work directly with OpenAPI as they design APIs. Some people write YAML directly and others use tools that provide a way to interact with OpenAPI graphically. This adds required skills that go beyond the ability to read OpenAPI. Tools like [Swagger UI](https://swagger.io/tools/swagger-ui/) and [Redoc](https://redocly.com/redoc/) make it easier to read and use OpenAPI as a reference. But learning how to author OpenAPI—even with graphical tools—can take time, and experience is required to do it well. This is an often overlooked cost of using OpenAPI. Though it's a great format with a great tooling ecosystem, it takes time to learn how to use it for designing APIs directly.

## Governing how people write OpenAPI

Organizations need a way to ensure people use OpenAPI correctly so that everyone designs and builds APIs the same way with the same level of quality. To do so, organizations define an **API governance model**, which is a set of practices, patterns, and rules that guide the API design process and are applied to an OpenAPI document at design-time and build-time to check for conformance.

An API governance model might include the patterns for URLs, the required status codes for certain operation types, the casing to use for JSON properties, the required parts of an OpenAPI document, and the parts of the OpenAPI specification that are not allowed. The challenge is this: not only does every API team need to understand how to design using OpenAPI, but they must also understand how to use OpenAPI that follow the organizational constraints defined in an API governance model. This is a barrier to entry for newcomers and a high cognitive load for designers.

Applying an API governance model at scale is challenging. Without tooling, organizations need a centralized API design review process. An API governance model requires training and knowledge sharing to help people learn the patterns and rules and the reasons for them being in the model. To promote the success of an API program, organizations build or buy tools that programmatically apply the rules of an API governance model at scale. These tools apply the API governance model to OpenAPI documents during the design, development, and deployment phases and act as a key tool for API development. Checking OpenAPI documents for conformance is commonly referred to as *linting*, and whereas it can catch many issues, it cannot fully constrain the use of OpenAPI because it is focused on the format—not on the design process itself.

## Additional challenges that arise

Consider the challenges an organization faces in garnering adoption of OpenAPI and an API governance model. They must do the following:

* Train people on how to use OpenAPI to design APIs
* Define an API governance model for guiding API designs
* Codify an API governance model in tooling and apply it programmatically
* Train people on the requirements, constraints, and benefits of the API governance model
* Incorporate this new API design and development workflow into every team's workflow
* Evolve the API governance model over time

This is an expensive and ongoing project. It takes expertise. And even after checking off the items above, an organization is left with other challenges:

* How do teams ensure that the API design matches the implementation? How do engineers know when they've correctly developed the API?
* How do teams ensure that the API documentation is correct?
* How do teams ensure that their API tests match the API design?

The possibility for inconsistency is always present. These challenges can lead to a disjointed API development lifecycle, such that the API design and documentation are disconnected from the testing and implementation.

It may take months of work to realize that all the time and effort that went into setting up OpenAPI with API governance model tooling has led to a disjointed API development lifecycle that doesn't provide all the desired benefits. Moreover, if an organization is fortunate enough to catch these secondary challenges up front, they will still need the expertise to approach the challenges and ensure that they can roll out and scale up their API program.
