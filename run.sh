#!/bin/bash

cd /app
git clone "${GIT_REPOSITORY}" git
cd git

for F in $(echo ${FILES_TO_COMMIT}|tr ',' '\n'); do
	git add "$F"
	if [ $F == '.' ]; then F='*'; fi
	rm -rf "$F"
	cp -r /volume/"$F" .
done

git commit -m "Automated update"
git push -u ${GIT_ORIGIN} ${GIT_BRANCH}
