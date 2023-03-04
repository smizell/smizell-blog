# Example

We can compare the language-oriented approach with a format-oriented approach that uses OpenAPI as the format. In this example, we'll build an API to keep track of automobiles.

## The high-level API design

For this example, consider an API that allows a consumer to do the following:

* Retrieve a collection of automobiles at the URL `/automobiles` using the `GET` HTTP method, which returns an array of automobile representations in JSON. The status code should be `200`.
* Retrieve a single automobile item at `/automobiles/{id}` using the `GET` HTTP method, which returns an automobile representation in JSON. The status code should be `200`.

In addition to these details, the automobile schema should include the properties `id`, `make`, `model`, and `year`, which should all be strings.

## Extracting the rules for an API governance model

We'll define a few rules regarding how we design APIs. This will be a small set compared to a full API governance model. The applicable rules for this design might be as follows:

* All collection URLs should be plural (e.g. `/automobiles`)
* All item URLs should be the collection URL with an ID after it (e.g. `/automobiles/{id}`)
* Use the `GET` method to retrieve the collection and item
* Return a `200` on successful requests

An organization might define these rules in a human-readable document and require people to use them when designing APIs. These rules—along with many others—become the foundation for the API governance model.

## How would we define this in OpenAPI?

In OpenAPI, we'd define the API this way:

```yaml
openapi: 3.0.0
info:
  version: 1.0.0
  title: Automobile API
paths:
  /automobiles:
    get:
      operationId: list-automobiles
      responses:
        200:
          description: Successful operation
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/AutomobileCollection"
  /automobiles/{automobile_id}:
    get:
      operationId: retrieve-automobile
      parameters:
      - name: automobile_id
        in: path
        required: true
        schema: {type: "string"}
      responses:
        200:
          description: Successful operation
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/AutomobileItem"
components:
  schemas:
    AutomobileItem:
      type: object
      properties:
        id: {type: "string"}
        make: {type: "string"}
        model: {type: "string"}
        year: {type: "string"}
    AutomobileCollection:
      type: array
      items:
        $ref: "#/components/schemas/AutomobileItem"
```

Here we can encounter the challenge: how do we know that we defined the API correctly based on the API governance model? Did we use the correct URL patterns for collections and items? Did we use the right status codes? We'd need to codify the rules of our API governance model so that we can apply it to any OpenAPI document we write. This would require a linting tool to make these kinds of checks and provide feedback during the design process.

Designing an API this way requires a few things from us:

* We have to know OpenAPI
* We have to be able to map our API conversation into OpenAPI
* We have to know the API governance model and understand how to design APIs that follow the rules
* We'd need tools that could apply the API governance model rules to an OpenAPI document

To create a successful API program that uses OpenAPI, an organization needs to train people on OpenAPI, define API governance model rules, acquire tools, then create a path for teams to take to adopt this new workflow.

## How would we define this API using a language-oriented approach?

First, consider the following: what are the essentials to the design? Many of the technical details like URL patterns, HTTP methods, and status codes are fixed. The dynamic parts of the design are the resources and their properties. 

Our first task would be to design a DSL. In an ideal situation, we'd create this prior to the API design process. For the current needs, we might design a DSL that includes the resource name, the resource's operations and properties, and each property's types. The DSL might look like this:

```yaml
resources:
- name: <resource-name>
  operations:
  - <operation-name: create, read, update, delete, or list>
  properties:
    <property-name>: <property-type>
```

Using this DSL, we'd come up with a design for our API that looks like this:

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

The OpenAPI document we wrote above by hand was 43 lines. This document using a DSL is nine. Where did all those other details go? Where are the status codes and schemas? What do the URLs look like? Where is the `id` property? These are details that can be left to the tooling that generates the OpenAPI document from the DSL. This is because we know how to generate the OpenAPI operations, include all the right status codes for the right operations, generate URLs based on the resource name, and create the schemas from the properties including the common properties like `id`. We can do this because the details around a large portion of the OpenAPI document are fixed. There's no imperative for people to learn how to write these details in OpenAPI—software can do the work for them.

It's important to note again that this example doesn't provide a full DSL. It's minimal and lacking a lot of features you'd need to build complete APIs. But it shows how you can start small and build up as the needs arise.

You can view a working example of this on GitHub at https://github.com/smizell/language-oriented-example. 