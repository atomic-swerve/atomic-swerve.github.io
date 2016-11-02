#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd out

git init
git config user.name "Piers Excell-Rehm"
git config user.email "pmexcell@gmail.com"

git remote add upstream "https://$GH_TOKEN@github.com/atomic-swerve/atomic-swerve-io.git"
git fetch upstream
git reset upstream/gh-pages

echo "atomic-swerve.github.io" > CNAME

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages