---
title: "Designing Change"
date: "2021-06-01T07:39:40-05:00"
author: "Stephen Mizell"
authorTwitter: "Stephen_Mizell"
tags: [api]
showFullContent: false
---

When we design an API—among many things—we're designing how we think the API will change.

We often reach for versioning to handle this, but versioning is a small part of the change discussion. For instance, will the versions be for the entire API or for individual resources? Will we support each version forever, or will we deprecate and sunset all or parts of versions? And at what point do we switch to a new version?

Then there are the guarantees about how we change the API. What kinds of breaking changes will we introduce, if any? How will we communicate upcoming changes with the consumers? How long in advance do we notify them so they have time to plan? How might consumers find out about past changes when they've encountered an issue?

Lastly, the degree of the relationship between the producers and consumers affects the amount of care we need to put into thinking about change. If the API is used by a single team, change is easier because that team controls the client and the server. If the API is meant for many teams across a company, it's a bit harder, though the other teams are down the hall or in another chat channel. But if it's something for thousands to use outside the company where communication is limited, change needs more attention.





