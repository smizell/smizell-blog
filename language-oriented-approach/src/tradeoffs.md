# Tradeoffs

## You still need expertise

The language-oriented approach requires someone who can lead the organization through the process of creating a DSL and the tooling around it. Over time, tooling for creating DSLs will improve as more people adopt the language-oriented approach, but for now, it requires experienced practitioners.

Expertise is always needed to create a good API program, and development work is always required to put good practice in place. With the language-oriented approach, the practitioner works to define how the conversational language translates into a format like OpenAPI, whereas with a format-oriented approach, the practitioner works to restrict the use of OpenAPI to match the conversational language. The language-oriented approach changes the kind of work needed, but it does not remove it.

## You still need to create and codify an API governance model

With any approach, you're going to create an API governance model and the tooling around it. The language-oriented approach only changes the way you approach the API governance model. Similar to how you need expertise to develop tooling around the language-oriented approach, you still need expertise who can help define an API governance model and apply it through tooling.

One difference is that API designers do not have to know how to write OpenAPI documents that conform to the API governance model—the tooling can do that for them. However, the language-oriented approach doesn't remove the need for an API governance model.

## You still need OpenAPI knowledge

You don't abandon OpenAPI when you follow the language-oriented approach. This is because the language-oriented approach is not about creating an alternative general-purpose format. It's about limiting the surface area of API design so people can generate general-purpose formats that meet organizational standards and guidelines. Organizations will continue to need people who understand OpenAPI, its tooling, and its benefits. The upside of the language-oriented approach is that it doesn't require everyone to know how to design APIs in OpenAPI directly. They might need to know how to read and use the tooling around OpenAPI, but they won't have to know the details and nuances of the format.

## You will continue having maintenance costs

The language-oriented approach requires upfront and ongoing work. It requires work to make sure all the tooling and workflows successfully meet the needs of the organization. Organizations will have to continually evaluate whether their approach is suiting the needs of their teams and customers, and they will have to make adjustments along the way. Additionally, since they have tailored tools and workflows, they will have to work to maintain the tools and workflows over time. In some cases, where organizations build lots of tooling around their DSL, more maintenance costs may be involved than those incurred by a format-oriented approach.

## You will create a workflow that is counter to the industry-wide approach

The language-oriented approach may give the feel and appearance of being a Not Invented Here (NIH) approach by which organizations build their own tools rather than purchase turnkey software. This can make the language-oriented approach a harder sell at times. It also affects new hires who may be familiar with turnkey processes and solutions who have to shift their approach in how they design and develop APIs.

The language-oriented approach accepts that people will always have to learn an organization's conversational language, no matter the approach. However, even though people might have to learn more with a format-oriented approach, the familiarity of OpenAPI and the tooling around it might make the approach seem like the better option. This is something to consider when deciding whether or not to follow the language-oriented approach and create a DSL. Do the benefits outweigh the familiarity of OpenAPI?