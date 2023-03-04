# Scenarios for using the language-oriented approach

It's helpful to know when the language-oriented approach can be helpful. There are many different use cases for APIs, which means there are many different approaches to designing and building them. Some approaches will require more formality and rigor, whereas others might be more ad hoc and organic.

## Designing an API program

Throughout this book, we've discussed ways in which the language-oriented approach can help create a successful API program and put good API practices in place. A tailored DSL can be the foundation for API design across an organization.

The language-oriented approach is well-suited for this scenario as it helps promote quality and consistency at scale.

## Microservices

As companies move to a microservice architecture, they need ways to ensure that teams are empowered to quickly build services that meet the organization's standards. Likewise, development teams need tools that can accelerate rapid designing, prototyping, and development. Having to learn formats like OpenAPI, style guides on how to write conformant OpenAPI, and tooling to check OpenAPI documents can feel like a hindrance to agility. Thus, it can be hard for teams to see the benefit in adding so much rigor.

The language-oriented approach can minimize what people have to know to design internal APIs or microservice-oriented APIs. In addition to the design, code generation can accelerate development and ensure that the design and implementation match the organization's style.

## Public APIs

Internal APIs can have looser requirements regarding how they change because often the consumers of the API are nearby. People can coordinate changes in ways that they can't with public APIs. Because of this, public APIs must have controls in place to prevent unwanted changes from happening.

A DSL can provide the guardrails around how people design and evolve a public API. 

## Backend for a frontend

The browser has become a runtime for many web applications, and teams commonly rely on APIs for server interactions rather than generating HTML on the server. Some teams separate developer roles into frontend and backend for these types of web applications.

To enable these frontend and backend roles to work in parallel, they need a good API design practice that enables them to design an API upfront and use it as the contract for their feature development. In doing so, frontend and backend developers can work toward the same goal.

The language-oriented approach can accelerate this work by limiting the design surface area and enabling the teams to focus on the details that matter and generate OpenAPI documents and frontend API clients from the design.