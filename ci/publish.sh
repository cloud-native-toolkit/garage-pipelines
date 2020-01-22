#!/usr/bin/env bash

git ch gh-pages
git pull

cp ./tmp/* .
rm -rf ./tmp
