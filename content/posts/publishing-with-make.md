---
title: "Publishing With Make"
date: "2021-06-07T08:46:05-05:00"
cover: ""
tags: []
description: ""
categories: [meta]
showFullContent: false
---

I [mentioned before](https://smizell.com/posts/2021/05/ok-fine/) my habit of tinkering on my site's code without end. This kept me from writing. So I started over. I wanted to set myself up for writing more frequently, and starting over felt like the best move.

I also wanted to keep a lookout for other areas that created friction. One I quickly saw was using Git. It's not great for the writing process.

I'd create a file, stage it, commit it, then push it. I did these last three steps over and over to fix small things, adding commit messages like "Fix typo" or "Correct grammar." I was just going through the motions—I don't really care about the commit messages.

So I put together a simple [Makefile](https://github.com/smizell/smizell-blog/blob/6c7430240c72c78433bc256d4be7d3ff08157e3c/Makefile) to make this work.

```makefile
commit-content:
	git checkout main
	git status
	git add content
	git commit -m "Publishing content $(shell date)"

publish: commit-content
	git push origin main

.PHONY: commit-content publish
```

This is assuming that I want to commit everything in the `content` directory, which has always been true. Now when I write and want to publish, I run `make publish` and it goes through all the motions for me.

Once it's on GitHub, Netlify picks it up and publishes a new site in a few seconds.