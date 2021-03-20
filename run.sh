#!/bin/bash

mkdir /root/.ssh 2> /dev/null
echo "ssh-${SSH_KEYTYPE} ${SSH_PUBKEY} ${GIT_EMAIL}" > /root/.ssh/id_${SSH_KEYTYPE}.pub
echo "-----BEGIN OPENSSH PRIVATE KEY-----" > /root/.ssh/id_${SSH_KEYTYPE}
echo "${SSH_PRIVKEY}"|tr ' ' '\n' >> /root/.ssh/id_${SSH_KEYTYPE}
echo "-----END OPENSSH PRIVATE KEY-----" >> /root/.ssh/id_${SSH_KEYTYPE}

chmod 600 /root/.ssh/* 2> /dev/null

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

cd /app
git clone "${GIT_REPOSITORY}" git
cd git

git remote set-url origin ${GIT_EMAIL}:${GIT_REPOSITORY_SHORTNAME}.git

for F in $(echo ${FILES_TO_COMMIT}|tr ',' '\n'); do
	F_COPY="$F"
	if [ $F_COPY == '.' ]; then F='*'; fi
	rm -rf "$F_COPY"
	cp -r /volume/"$F_COPY" .
	git add "$F"
done

git commit -m "Automated update"
git push -u ${GIT_ORIGIN} ${GIT_BRANCH}
