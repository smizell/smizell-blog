# Getting started with the Language-Oriented Approach

## The steps for getting started

### 1. Capture the conversational language

The first step of the language-oriented approach is to work through capturing the conversational language. What are the terms used during the API design process? What are the patterns used in API designs? What are the ways those terms and patterns are used to create boundaries and guardrails around the API design? This conversational language will contain technical and non-technical details and will capture the style and design approach of the organization.

Defining this conversational language can be as straightforward as talking about API designs and documenting the words, topics, and phrases used. This task is required of any approach to API design, and it's especially important for the language-oriented approach. It's a process that can be quick or take an organization months with a dedicated API team.

It's helpful in this step to examine existing API style guides to see how other companies approach API design. Arnaud Lauret created a repository of these style guides called the [API Stylebook](https://apihandyman.io/toolbox/apistylebook/). Though a conversational language can go beyond style guides, these style guides can be a great starting point.

### 2. Categorize the conversational language

The next part is to categorize the conversational language into the language that is necessary for the design discussion and language that can be applied through tooling. 

The goal is to find a design language that strips away the details that are already decided. Organizations know their URL patterns. They know what HTTP methods to use when and what status codes to use for those HTTP methods: they also know the formats for their error messages. These are all details that can be left up to the tooling.

The resulting design language should provide enough terminology that allows for designing APIs based on the organization's style. The design language may contain some technical details, but only those details that require discussion during an API design conversation.

This separation is what creates the value of the language-oriented approach. In orienting the design process around the conversational language necessary for an API design, and relying on tooling to add the other details, people can design APIs quickly and iterate on ideas, all while generating conformant OpenAPI documents.

### 3. Codify design language as a DSL

API designers use design language to describe the unique details around an API. For example, a designer might describe a customer resource and include the properties that make up a customer, such as name, email, and address. If these are the terms the organization uses, then the DSL should allow for capturing these details using terms like "resources" and "properties" and should provide the framework for discussing and authoring an API separate from the more technical and fixed details.

The DSL should map to the conversational language. It should give people the vocabulary they need to design an API while limiting the details that can be left up to the tooling. The DSL should enable rapid design discussions by removing the hindrances related to making decisions that have already been made. There isn't a magic formula for finding this balance. It takes time and collaborative work to make a DSL that provides the right level of freedom and restriction.

It's also important to keep the DSL minimal and focused. It's tempting to add features to the DSL "just in case." In the early stages of creating a DSL, only add what's needed. Base the DSL on real-world scenarios. Work with someone who is designing an API and determine whether the DSL provides what's needed for a full design. Talk with non-technical people to see if the language makes sense in a conversational setting. There will always be the pull to move from "tailored" to "general-purpose": but the benefits come from keeping the DSL tailored to the organization.

Lastly, creating a DSL offers organizations the opportunity to be prescriptive and opinionated regarding API design for the sake of lowering the barrier to entry. Formats like OpenAPI try to not incorporate opinions because they're meant for describing many different kinds of API designs. But because a DSL is meant only for the context of the organization, it can be prescriptive based on that context. This falls in line with keeping the DSL minimal and focused—providing freedoms and restrictions and finding balance in what people can and cannot describe.

### 4. Build tooling around the DSL

A format-oriented API development workflow validates a general-purpose format such as OpenAPI after someone writes the document. The challenge is that an API designer can use any feature of the general-purpose format during the design process, but they will only find out whether their design conforms to the API governance model once they validate the design. There's no good way to skip the details that can be left out of the design conversation.

The language-oriented approach is different. With it, the designer uses a DSL to design the API and relies on tooling to generate a general-purpose format. The tooling uses the DSL and adds the details that people can skip. Put another way, the API designer writes in a language tailored to their organization's conversational language, then generates a general-purpose format like OpenAPI that conforms to the organization's API governance model. The API governance model is implicitly applied as part of this process because the OpenAPI document will always follow the organization's rules.

The tooling allows the organization to use the DSL as the source of truth for an API design. This process makes the DSL a human-readable reference as well as a be machine-readable format that can be used at design, build, and runtime.

### 5. Create training and documentation on using the DSL

Both general-purpose formats and DSLs require training, but DSLs limit what API designers have to use during the design process. Organizations can organize training and documentation around their DSL and how it applies to the conversational language and API style as a whole. People can still learn the API governance model, but they don't have to know it well enough to author API designs. This improves adoption due to the limited surface area of API design terminology.

## Technical approaches for creating a tailored API design language

### Creating a YAML format

The automobile API example above used YAML as the format for the DSL. Although YAML works, it can be complex, and create user-experience issues.

* YAML uses white space as a way to distinguish nesting. This works well in shorter documents but becomes more difficult to deal with in larger documents.
* If you use YAML, then you need a way to validate the YAML. This takes work to produce a good user experience.

YAML is a great starting point, as no tooling or development environment is needed.

The YAML from the example section in this book looked like this:

```yaml
resources:
- name: automobile
  operations:
  - list
  - retrieve
  properties:
    make: string
    model: string
    year: string
```

### Using code

Another option is to embed the DSL in a programming language. For instance, the automobile API example might look like this in Python.

```python
Resource(
  name="automobile",
  properties=[
    Property("make")
    Property("model")
    Property("year")
  ],
  operations=["list", "retrieve"]
)
```

The DSL here is Python code. It can be checked for correctness and provide nice integrated development environment (IDE) support. 

Many organizations are discovering that code is better than YAML. AWS created the [Cloud Development Kit](https://docs.aws.amazon.com/cdk/v2/guide/home.html) (CDK)—a tool to define infrastructure with code—to augment AWS Cloud Formation, a YAML format. They went this way because of all the benefits and abilities you get from a programming language and the languages package ecosystem.

If a code approach is used, then it's best to provide a way to serialize and deserialize the DSL definition into JSON or YAML for the sake of portability.

The downside of code is that it requires someone who knows how to code to design using it. They need the programming environment set up on their computer and the understanding of how to use the embedded DSL. Someone might argue that this excludes certain non-technical people from the API design process. In any case, it's important to consider the skills needed for API design in an organization before going this route.

### Using existing tooling

There are formats like [Smithy](https://awslabs.github.io/smithy/2.0/index.html) and [Cadl](https://github.com/microsoft/cadl) that people can use to create a tailored DSL. In addition to their own conventions, they also provide ways to extend their functionality. These tools provide features for linting and validating API descriptions and for generating or emitting artifacts based on the API description. Generating formats like OpenAPI that conform to an organization's style guide is one of the main benefits of the language-oriented approach, and tools like these can accelerate a move toward that approach.

We'll look at Smithy and Cadl more in the Case Studies section.
