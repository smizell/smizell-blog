---
title: Scheduling Posts With Hugo
date: '2021-06-18T11:05:36-05:00'
cover: ''
tags:
- meta
description: ''
showFullContent: false
---

I mentioned in my [latest weeknotes](https://smizell.com/posts/2021/06/weeknote-8/) that I've started using Rake to automate writing tasks for this site. The first ones were for creating a new post and deploying it. I can now run a command that creates the files and opens my editor for writing.

I've wanted to add a way to schedule posts. Lots of times, I keep an idea in my head, sit down to write it out, then immediately publish. I'd like to get into a habit of writing smaller things more often and scheduling them to publish automatically.

But I didn't want to set dates. If I wanted to bump a writing in the schedule, I'd have to edit all the dates.

Today I wrote a Rake task that does the scheduling for me. Now I run:

```sh
rake schedule:new[scheduling-posts-with-hugo]
```

This does a few things.

* Creates a new file using the post archetype
* Pushes the filename to a `schedule.txt` file
* Opens the new file with iA Writer

The archetype file sets `draft` is to `true`. The date is set to today, but I don't care about the date at this point. I'll change that when I publish.

I have another task called `schedule:publish`. This will do:

* Grab the first item in `schedule.txt`
* Remove `draft: true`
* Set the date to now
* Update the content file and the `schedule.txt` file

At that point I can run `rake deploy`, which commits everything in the content folder and the schedule file and pushes it to GitHub.

You can see the [code on GitHub](https://github.com/smizell/smizell-blog/blob/b4503882180b905ed4813c990f1cf32efc15c78a/Rakefile#L38-L73).

Once I get some content scheduled, I'll write a GitHub Action to automatically publish on a recurring basis. I also want to tinker with a draft process that doesn't automatically schedule a post.
