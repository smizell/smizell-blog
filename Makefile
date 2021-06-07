commit-content:
	git checkout main
	git status
	git add content
	git commit -m "Publishing content $(shell date)"

publish: commit-content
	git push origin main

.PHONY: commit-content publish