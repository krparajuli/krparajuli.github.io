---
layout: post
title:  "Quickstart a Python Conda Project"
date:   2021-02-04 23:15:00 -0500
categories: Python Conda Project Start Quickstart
---


Python offers different options for environment management with Pip, Virtualenv, Conda and others. It can be confusing to master different environment management tools and be efficient. I have added a custom project here to serve as a starter project and have provided instructions to work with it.

# Contents
 - [Setup](#setup) 
 - [Initializing](#initializing)
 - [Activating and Working](#activating-and-working)
 - [Adding and Removing Packages](#adding-and-removing-packages)
 - [Deactivating and Logging out](#deactivating-and-logging-out)
 - [Pycharm or IDEs setup](#pycharm-or-ides-setup)
 - [Pip with Conda](#pip-with-conda)


### Setup
Fork the [conda-starter https://github.com/krparajuli/conda-starter](https://github.com/krparajuli/conda-starter) project into your github followed by cloning into your local machine. Alternatively, download and unzip it to your machine.

If you do not wish to fork or download this repo, you can create a project folder (example: named `conda-started`). Go inside the folder and create a yaml file (example: named `conda-environment,yaml`). Put the following lines into the yaml file. 

```
  name: conda-starter

  channels:
    - conda-forge
    - defaults

  dependencies:
    - python=3.7  # Required for a python project
    - pip=20.0    # Useful to have - you may need it down the road    
    - pandas=1.2  # This package is added as an example. Add or remove packages as needed
```

### Initializing

*To be used for the first time only - while creating this project on your computer.*

Initialize the conda environment.

```
    conda env create --prefix ./conda-env --file conda-environment.yml
```

---
### Activating and Working

To start working on the project, get into the project folder and activate the project conda environment
```
    cd /path/to/project
    conda activate --prefix ./conda-env
```
The environment is activated. You should see `(/path/to/project/conda-env)` on the prompt on your terminal. You can start working on the project.

### Adding or Removing Packages
To add or remove packages, add or remove dependencies in `conda-environment.yml` file.
```
dependencies:
  - pip=20.0
  - python=3.7
  - pandas=1.2
  - jupyterlab=1.2   # new package to be added
```
Save the file and update the environment.
```
    conda env update --prefix ./conda-env --file conda-environment.yml --prune
```
The above command updates the environment by adding the package.

**Alternatively**, if you want to install all packages fresh after cleaning the existing environment, run the following:
```
    conda env update --prefix ./conda-env --file conda-environment.yml --force
```

### Deactivating and Logging out
To stop working on the project and switch out of it, deactivate the environment.
```
    conda deactivate
```
You should see `(base)` on the prompt on the terminal now.

*You are done working for now. Go have fun. :)*

---
### Pycharm or IDEs setup

Important instruction to run this program on PyCharm or similar IDE
Once the conda environment has been created by using the SETUP step above. You have to configure the interpreter to use
the existing `conda-env` environment.

---
### Pip with Conda
You can and, at times, have to use `pip` with `conda`. Refer to this documentation to understand the process.
[Anaconda Blog on Pip within Conda](https://www.anaconda.com/blog/using-pip-in-a-conda-environment)