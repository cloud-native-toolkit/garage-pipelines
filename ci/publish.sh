#!/usr/bin/env bash

set +x

git ch gh-pages
git pull

cp ./tmp/stable/* ./stable
rm -rf ./tmp