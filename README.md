# Garage pipelines

This repository is used by the [IBM Garage Cloud Native Toolkit CLI](https://github.com/ibm-garage-cloud/ibm-garage-cloud-cli) `igc enable` command.  It contains the default pipelines used when choosing what pipeline to add to your project.  You can **use this template** and customize the pipelines to suit your needs.  Run the `igc enable` command with the `--repo` argument to pass in the location of your copy of this template.  

The `igc enable` command expects the pipelines to be packaged into gzip'd tarballs and published to GitHub Pages. Therefore the url format for the command would be `igc enable --repo https://<org-name>.github.io/<repo-name>/` 

Where 
* `<org-name>` is the name of your github organization or owner.
* `<repo-name>` is the name of the github repo.  


## Customizing the pipelines in this repository

To customize the pipelines in this repo 
1. Click the ![use this template](./images/use-this-template.png) button
2. Select the owner/organization and enter a repository name
3. Select **Include all branches**, we need the publish and gh_pages branches as well
4. Click the ![create repository from template](./images/create-repository-from-template.png) button.

You can now modify the pipelines to suit your needs.  

Before you can use your pipelines you need to publish them to GitHub pages.

# Publishing the repository to GitHub pages

There are three ways you can publish the pipelines.

* GitHub Actions
* Travis
* Manually

## Publishing the repo using GitHub Actions

The GitHub actions are located in the `.github/workflows/publish.yaml` file. When creating a copy of this template in a GitHub environment that supports actions they should automatically publish your pipelines

## Publishing the repo using Traivs

There is a `.travis.yml` file located in the repo.  Update the `REPO_URL` environment variable and then configure Travis.

## Publishing the repo manually

There is a `./ci/build.sh` script in the repository.  

Run this script which should package up the pipelines into gzip'd tarballs, change to the `gh-pages` branch, copy the files into the correct locations, and generates the index.yaml file.

Commit and push the changes to the `gh-pages` branch

