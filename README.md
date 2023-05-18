# Developing Zep documentation

## Create a Python virtual environment

Create a Python virtual env for `mkdocs` to run in. Activate the environment and install required dependencies.

```bash
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r docs/requirements.txt
```

## Start a `mkdocs` server

Running a `mkdocs` server locally allows you to preview changes as you write markdown files.

```bash
mkdocs serve
```

Point your browser to http://127.0.0.1:8000/

## `mkdocs` config

The `mkdocs.yml` file contains the config.

You may need to modify the `nav` section if you're adding new files to the documentation.

## Deploying the docs
Create a PR and push to the main branch. A GitHub Action will compile the docs and push them to the `gh-pages` branch. GitHub automatically updates the site with content from this branch.
