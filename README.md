# docker-git-updater

This software includes a [Docker](https://www.docker.com) container able to update a git repository by (periodically) monitoring a shared volume.
This can be useful when automated updates of some files on your git repository are accomplished, even by another [Docker](https://www.docker.com) container (see, e.g. [auino/covid19-report](https://github.com/auino/covid19-report)).

### Environment variables needed ###

Following environment variables have to be set up:
* `GIT_REPOSITORY` the URL of the git repository (e.g. `https://github.com/auino/docker-git-updater.git`)
* `GIT_REPOSITORY_SHORTNAME` the short name of the git repository (e.g. `auino/docker-git-updater`)
* `GIT_BRANCH` the branch of the git repository
* `GIT_ORIGIN` the origin of the git repository
* `GIT_EMAIL` the email used for push activities
* `GIT_USERNAME` the git username to use
* `SSH_KEYTYPE` the SSH keys type (e.g. `rsa` or `ed25519`)
* `SSH_PUBKEY` the raw public key
* `SSH_PRIVKEY` the raw private key (without any space or newline)
* `FILES_TO_COMMIT` the comma-separated list of files to commit, or `.` to commit the entire volume content

### Shared volume directory ###

The `/volume` directory has to be shared with this container, even in read-only mode.

### Installation ###

* Optionally, generate a private/public SSH key pair to use for environment variables initialization (the contents of the variables have to be set to the raw keys found in `$HOME/.ssh/id_*`:
```
ssh-keygen -t ed25519 -C "$GIT_EMAIL"
```
* Clone the repository:
```
git clone https://github.com/auino/docker-git-updater.git
```
* Build the Docker image:
```
docker build -t docker-git-updater .
```
* Optionally, save the Docker image to file:
```
docker save docker-git-updater:latest|gzip > docker-git-updater.tar.gz
```
* Run the Docker container and/or configure a periodic run of itself (e.g. through `cron`):
```
docker run -v <git_folder>:/volume -w /volume -d docker-git-updater:latest
```
where `<git_folder>` identifies the folder of your git repository including updates.

### Contacts ###

You can find me on Twitter as [@auino](https://twitter.com/auino).
