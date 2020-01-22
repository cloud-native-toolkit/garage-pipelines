# Garage pipelines

## Publishing to repo

. Run `./ci/build.sh`

This script should package up the pipelines into gzip'd tarballs, change to the `gh-pages` branch, copy the files in the
correct locations, and generates the index.yaml file.

. Commit and push the changes to the `gh-pages` branch

