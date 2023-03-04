# Comparisons to design-first and code-first

## How does it compare to design-first?

The design-first approach is one that encourages teams to consider the API design before writing code to implement the API. The goal is to include more people in the design conversation with the hope of creating a better-quality API design that conforms to the organization's API style guide and standards.

The language-oriented approach is meant to strengthen the design-first approach by focusing the up-front design process on the conversational language of an organization and by shielding the conversation from repetitive, technical, and protocol-specific details. The language-oriented approach is a design-first approach.

Using OpenAPI in a design-first approach, the API designers have to think about URLs, HTTP methods, status codes, and JSON Schema. They also have to understand how every detail they put into the OpenAPI document aligns with the organization's OpenAPI style guide and standards. This can raise the barrier to entry for bringing non-technical people into the discussion, which can lead to a less impactful design discussion.

The language-oriented approach keeps many of those details out of the conversation and relies on tooling to generate OpenAPI documents that include all the details based on the language-oriented API design. By doing so, it enables a higher-quality design-first approach than one that uses OpenAPI as the primary design tool.

## How does it compare to code-first?

A code-first approach is one with which people generate OpenAPI documents from the code itself. The OpenAPI document isn’t the starting point in a code-first approach. Rather, it’s an artifact of the build process. Developers like the code-first approach because it means that they don’t have to do work twice, which would include writing an OpenAPI document and then putting the same details in the code.

Following a code-first approach doesn't mean that people don't do any upfront design. However, "code-first" has come to describe scenarios where developers charge forward and start working on the API before considering the use cases and needs of the consumer. It's also meant to describe scenarios in which developers design and build APIs without any involvement from product, UX, marketing, QA, and other non-developer stakeholders.

There are several approaches to generating OpenAPI documents from code. Using one approach, the API design is adjacent to the code. It resides in the comments, and tooling looks through the comments for the design details.

Below is an example of how this looks using a tool called [OpenAPI Comment Parser](https://github.com/bee-travels/openapi-comment-parser).

```js
/**
 * GET /users
 * @summary Returns a list of users.
 * @response 200 - A JSON array of user names
 * @responseContent {string[]} 200.application/json
 */
```

The problem here is that the design and implementation can easily get out of sync.

Another approach is one where the OpenAPI document is derived from the implementation. This is better than keeping the design adjacent to the implementation because it does a better job of ensuring that the design and implementation are in sync.

Below is an example using [FastAPI](https://fastapi.tiangolo.com/). FastAPI uses Python type hints and a library called [Pydantic](https://pydantic-docs.helpmanual.io/) to define types that can be used both for static analysis and input validation in an API.

```python
from typing import Union

from fastapi import FastAPI

app = FastAPI()

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}
```

The FastAPI tooling can derive an OpenAPI document from the URLs and type hints. Developers can write code that is descriptive of the API and have human-friendly documentation generated automatically, which makes for a shorter feedback loop and ensures the API design always matches the implementation.

Both of these approaches bring the design and implementation closer together. The challenge is, though, how does an organization ensure that teams are following a good design process that includes the right stakeholders and considers the consumer's needs?

The language-oriented approach can allow organizations to use code as the method for authoring API designs. Teams can use this code as part of their implementation to ensure they are in sync. And since the design code and implementation code are separate, tooling can use the design independently of the implementation. Although this takes more development work to create API design tooling, and requires a larger investment for polyglot organizations, it can be an accelerator to following good design principles that result in high-quality APIs.

The language-oriented approach encourages generating OpenAPI as a build artifact in the same way the code-first approach does. It tries to keep the design and implementation in sync and reduce work so that people design once and reuse the design in their implementation.

## Using the language-oriented approach to augment other approaches

The language-oriented approach is not in opposition to existing API design approaches like design-first and code-first. Rather, it strengthens other approaches by the method of defining a conversational language that focuses the design process on the non-technical details. The technical details are left for later exploration, either in technical discovery, prototyping, or implementation. Design can happen up front, it can drive the code, and it can be the source of truth for generating OpenAPI documents. This blends the design-first and code-first approaches rather than putting them against each other, and it orients the design process around the right design details.