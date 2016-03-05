#!/bin/bash
# See https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db
set -o errexit

# build (CHANGE THIS)
npm run build

# Check Branch
git branch -a

echo "Travis Branch: $TRAVIS_BRANCH";
echo "Travis TAG: $TRAVIS_BRANCH";
echo "gitHUbTOken $GITHUB_TOKEN";
echo "gitHUbRef $GITHUB_REF";

# Remove and Recreate tempGHPages directory
rm -rf tempGHPages
mkdir tempGHPages

# Copy Files
cp -r ./docs ./tempGHPages
cp -a ./dist/. ./tempGHPages

# Init
cd tempGHPages
git init

# config
git config --global user.email "cchandurkar@gmail.com"
git config --global user.name "cchandurkar"

# Echo
echo "Deploying to gh-pages";

# deploy
git add --all

echo "Commiting";

git commit -m "Updating Docs"

echo "Pushing";
echo "https://${GITHUB_TOKEN}@$github.com/${GITHUB_REF}.git";

git push --force "https://${GITHUB_TOKEN}@${GITHUB_REF}" master:gh-pages > /dev/null 2>&1

# Remove tempGHPages directory
rm -rf tempGHPages
