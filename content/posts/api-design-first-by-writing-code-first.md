---
title: "API Design First by Writing Code First"
date: "2020-12-17T16:57:26-05:00"
cover: ""
tags: [api, design-with-code]
description: ""
showFullContent: false
---

I was on a team that needed to design a new API. As a Design First team, we'd normally start off with an OpenAPI file. But this time we started with some code. We opened up our IDE, created a Python file, and started coding models and endpoints.

It might seem like we switched to a Code First approach since we started with code. But this wasn't the case for us. We talked about the design as we went. We worked through models and behavior. We made sure we were using the right terms. And we included a broader audience in the discussion than developers. The only difference from the common Design First approach was that we wrote Python instead of YAML.

Design First and Code First aren't opposing ideas. Writing code, experimenting, and getting developer feedback is a cornerstone of building good API products. And as we'll see, we can use code as a way to work through a design.

## What Design First is trying to teach us

We all practice design first. Whether we capture the design in OpenAPI, write it in a Word document, or think about it in our heads, we're designing. Design First doesn't imply that it's the only approach that does design or the only approach that considers design upfront. Rather, Design First as an approach pushes us to broaden the design discussion because design requires more than developers. Design First encourages us to prototype and iterate with people who understand the problem, people who will be using the API, people who will be writing documentation for it, and people who will be building and operating the service.

The problem is, it's too easy to leave the API discussions to the developers—APIs are technical products after all. But an API is more than the bits and the bytes. An API is something that helps someone else make progress in their work.

A good design discussion focuses on the experience. A good experience takes good marketing, good documentation and tutorials, good operations, and an API that fits the need.

It's also true that Design First encourages us to write our designs in a format like OpenAPI upfront. But that doesn't mean we can't write any code during the design phase. We miss out when we don't. Prototyping and experimenting are vital to the design process to help validate the design.

On the flip side, when we say "Code First," we're trying to discourage an approach that only thinks about the code. We practice Code First when we write code and deploy it with no thought of the experience.

Design First and Code First as terms seem to convey order. But instead of focusing on the order of our work or when we write code, we should consider the principles that help drive a good API design process.

## An example: building a Bookmark API

We'll look at this idea through the lens of designing a real API with code. The example we'll use is a Bookmark API. We'll keep it simple for now—it's only for storing bookmarks. In a real-world API, there would be many more scenarios to consider.

For our tool for designing with code, we'll use a Python web framework called [FastAPI](https://fastapi.tiangolo.com/). It may feel odd to choose a web framework. However, it will illustrate how we can use code to work through the design process.

Our exploration here isn't saying it's wrong to start by writing OpenAPI in YAML. Rather we're looking at the same process we might use with OpenAPI but with a different workflow and with different tooling.

## Getting started with designing our core

We'll start with designing the core of our application based on the problems we're trying to solve—for us that's capturing bookmarks as we surf the web.

When we talk about the core with the full design team, we're trying to talk of a solution separate from the outside world. We don't talk about HTTP or JSON yet. There's no database talk, and there's no discussion about microservices or monoliths. We talk about what the core of our application is and what it will do. This forces us to consider how our core interacts with the rest of the world at its boundaries.

Designing boundaries is how to design good APIs—it's boundaries all the way down. In our example we'll work to create well-defined boundaries that will make our API implementation nimble and evolvable over time.

FastAPI—the tool we're using to work through the design—uses another library called [Pydantic](https://pydantic-docs.helpmanual.io/). We use it to define our core models in plain Python objects. We also get good IDE support and type checking. With plain objects we can write terse models that are easy to read, experiment with, and hook into an API. We can also export our models later to OpenAPI and JSON Schema so our design won't be locked into the code.

Because our models are defined as code, we can interact with them in a REPL as soon as we write them. The point of prototyping is to shorten the feedback loop, and that's what we're doing here. Normally we'd only be able to experiment with interactions like this when we'd built the API or used a mock server. But with this we can tinker and try things without defining the technical details of the interface.

For our API, our core Bookmark model might look something like this.

```python
from datetime import datetime
from typing import Optional
from pydantic import BaseModel

class Bookmark(BaseModel):
    bookmark_url: str
    accessed: Optional[datetime] = None
    title: str
    description: str
```

We'd start by talking through this. What's a bookmark? When would we capture one? What properties are important? Which ones are required? We may uncover new models as we talk through this, which we could quickly add without losing focus.

No matter the tools, this is a great place to start any design process, especially when working with OpenAPI, we can start by writing out the schemas before considering how the URLs, methods, and status codes might be arranged.

## Defining an interface for our storage layer

We're still not ready to move to the HTTP specifics yet. First we'll think about the interface between our core Bookmark model and a storage layer like a database.

It's important that we keep all of these models separate. [Mike Amundsen has a helpful quote](http://amundsen.com/talks/2016-11-apistrat-wadm/2016-11-apistrat-wadm.pdf) that I frequently think about:

> Your data model is not your object model is not your resource model is not your affordance model.

That's four different models in an API. Yet we rarely think of two or more in a design process.

In order to work with these different models, we need boundaries between them all. When we don't define these boundaries, we get into situations where a change to our database model results in a breaking change for our API. The better the boundaries, the more evolvable our API will be because a change in one area will have less impact on the change of another.

For our Bookmark API, we'll create a small interface for our storage layer. We don't need a database yet so we'll store records in memory. This might even help us since we don't have to think about the database design.

```python
class Record(GenericModel, Generic[T]):
    id: uuid.UUID
    data: T


class Storage(BaseModel):
    records: List[Record] = []

    def save(self, item):
        r = Record(data=item, id=uuid.uuid4())
        self.records.append(r)
        return r

    def filter_by_model(self, model_cls):
        return (
            record for record in self.records
            if isinstance(record.data, model_cls)
        )

    def find_by_id(self, model_cls, inst_id):
        model_records = self.filter_by_model(model_cls)
        match = (
            record for record in model_records
            if record.id == inst_id
        )
        return next(match, None)
```

This pattern of creating an interface in front of something like a database is called the [Repository Pattern](https://martinfowler.com/eaaCatalog/repository.html). This keeps our core design free from our database design.

## Defining our Representors

We also need to keep our core design separate from our API design. Our object model isn't our resource model, as Amundsen's quote says above.

When we say we create a boundary between our core and API, we mean we create a boundary between our core code and technical details around networks, protocols, and serialization formats. We'll refer to the pattern for this boundary as the Representor Pattern.

What happens if we don't create this boundary?

1. Any API client will interact directly with our core code. The point of an API is to create a separation and distance to foster interaction. We create this separation when we insulate our core code from the outside world.
1. The other side is that without this boundary we tie our core design to our API. We won't be able to change our core models without directly affecting our API.
1. We also mix together API code and core code. What if we want to build a CLI tool around it later? Desktop client? Or V2 of our API? It's faster to skip this boundary up front, but we'll pay for it later.
1. We make testing difficult when we skip this boundary. Without this boundary, we can only test our core code by testing it from the outside or by mocking HTTP requests and responses.

The Representor Pattern allows us to define representations of our core models and core behaviors apart from protocols and media types. This separation means we can test and evolve our API apart from these details.

We'll use a Collection Pattern and create generic models for it. This might act as a style guide for us in the future, allowing us to create every model the exact way.

```python
# These are generic types in Python that let us write classes without
# specifying the type we'll use. This will let us generically design
# these and reuse them for other models.

class Item(GenericModel, Generic[T]):
    url: str
    data: T


class Collection(GenericModel, Generic[T]):
    url: str
    items: List[T]
```

We'll hook our core `Bookmark` model into these generic models to create a bookmark collection and item model.

```python
class BookmarkItem(Item[Bookmark]):
    pass

class BookmarkCollection(Collection[BookmarkItem]):
    pass
```

Now we'll write some glue to coordinate using our repository models with our representor models. We use the `app` here to build the URL for the representations. It's helpful that our core code doesn't know about that.

```python
def bookmark_item_from_record(app, bookmark_record):
    url = app.url_path_for("bookmark_item", bookmark_id=bookmark_record.id)
    return BookmarkItem(url=url, **bookmark_record.data.dict())

def bookmark_collection_from_records(app, bookmark_records):
    url = app.url_path_for("bookmark_collection")
    bookmark_items = [
        bookmark_item_from_record(app, record)
        for record in bookmark_records
    ]
    return BookmarkCollection(url=url, items=bookmark_items)
```

We could test this layer independently of core logic and independently of the network, HTTP, or JSON. There's no need to mock a network when you are building a boundary around it.

Granted, it starts to feel that our discussion has we've moved from the design into the implementation. This is because we have to scaffold the representor pattern the same we had to scaffold the repository pattern. Tools would make this better.

Also, it's important to see that we don't have to keep implementation discussions out of the design discussions just like we don't have to keep code out of the design discussions. Everyone's input helps shape the design and sometimes there are implementation constraints such as legacy code.

## Experimenting in the REPL

We still haven't done any API stuff yet—we're just building boundaries and layers for the sake of prototyping, but at this point we could drop back into a REPL and try out interacting with the core, the storage layer, and the API layer.

```
# Some information removed for the sake of brevity
>>> from api import Bookmark, BookmarkItem, BookmarkCollection, Storage
>>> from datetime import datetime
>>> bookmark = Bookmark(...)
>>> storage = Storage()
>>> storage.save(bookmark)
>>> bookmark = storage.filter_by_model(Bookmark)
>>> bookmark_collection_from_records(app, records)
```

No database, no server, no client. We're interacting with core model without setting up the rest of the world. Our boundaries define how the outside world interacts with our core.

The feedback we can get from interacting with the core may influence important design questions. How might the users interact with collections of bookmarks? Will they want to filter them by certain properties? Will they want to sort them? Are there certain states of links we'd want to surface? This exercise can influence design and may push us to write a few more functions for interacting with the resources before considering HTTP.

## Finally, getting to the URLs, HTTP, and JSON

We're now ready to wire up our core to the web. This is straightforward with FastAPI.

```python
app = FastAPI(title="Bookmark API")
storage = Storage()


@app.get(
    "/bookmarks",
    response_model=BookmarkCollection,
    tags=["Bookmark"]
)
def bookmark_collection():
    book_records = storage.filter_by_model(Bookmark)
    return bookmark_collection_from_records(app, book_records)


@app.post(
    "/bookmarks",
    response_model=BookmarkItem,
    status_code=201,
    tags=["Bookmark"]
)
def create_bookmark(bookmark: Bookmark):
    bookmark_record = storage.save(bookmark)
    return bookmark_item_from_record(app, bookmark_record)


@app.get(
    "/bookmarks/{bookmark_id}",
    response_model=BookmarkItem,
    tags=["Bookmark"]
)
def bookmark_item(bookmark_id: uuid.UUID):
    bookmark_record = storage.find_by_id(Bookmark, bookmark_id)
    return bookmark_item_from_record(app, bookmark_record)
```

We defined two methods, `GET` and `POST` for a `/bookmarks` URL and a status code for our `POST` method. We also define the response models based on what we've already built.

At this point we're ready to spin up our API server and tryout the API. FastAPI will give us a Swagger UI Page and an `openapi.json` file to download once it's up and running.

I've deployed this code so you can try it out.

- [Bookmark API](https://bookmark-api.glitch.me)
- [Swagger UI](https://bookmark-api.glitch.me/docs)
- [OpenAPI File](https://bookmark-api.glitch.me/openapi.json)

FastAPI creates the schema for our Bookmark model, Bookmark Item, and Bookmark Collection. It does this based on how we wired up the models with the endpoints.

With FastAPI and our Pydantic models, we get runtime validation, compile-time type checking, build-time tooling with OpenAPI, and runtime validation. That's a lot.

## Our takeaways

We looked at a lot of important concepts that can be applied to any design process.

1. We need more people with different skills and experiences in the design discussion. We'll benefit from that even if we generate our OpenAPI from code annotations.
1. We need to make prototyping and experimenting a fundamental part of the API design process. It's important to write code and try out ideas.
1. We need to consider the core of our application apart from the rest of the world, especially HTTP and JSON. This is how we build in quality and agility.
1. We need to think through the boundaries of our application. This may be a database, the web itself, or another service we'll depend on. This is how we prepare for change.
1. We need good design patterns that help the design discussion. Patterns give language to difficult technical concepts.

Good API design relies on good architectural design. And poor architectural design hinders any API design, especially over time. We learn over time that everything is design, and we're all designers.
