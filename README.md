# Introduction

This docker image aims to provide Snowflake users with a turn key docker environment already set-up with Snowflake drivers on a Jupyter notebook to experiment the various Snowflake connectors available: 

- ODBC
- JDBC
- Python Connector
- Spark Connector

SQL Alchemy python package is also installed as part of this docker image.

The base docker image is [Jupyter Docker Stacks](https://github.com/jupyter/docker-stacks). More specifically, the image used is [jupyter/all-spark-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-all-spark-notebook) which provides a comprehensive jupyter environment including r, sci-py, tensorflow, pyspark among others.

# Prerequisites

- You need git on your Mac.
- You need to download and install [Docker Desktop for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac). You may need to create an account on Docker to be able to download it.

# Instructions

## Download the repository

Change the Directory to a location where you are storing your Docker images:

```
mkdir DockerImages
cd DockerImages
git clone https://github.com/zoharsan/snowflake-jupyter.git
cd snowflake-jupyter
```

## Build the docker image

```
docker build --pull --no-cache -t sf-jupyter .
```
You may get some warnings which are non critical, and/or expected. You can safely ignore them:
```
...
debconf: delaying package configuration, since apt-utils is not installed
...
==> WARNING: A newer version of conda exists. <==
  current version: 4.6.14
  latest version: 4.7.5

Please update conda by running

    $ conda update -n base conda
...
grep: /etc/odbcinst.ini: No such file or directory
...
grep: /etc/odbc.ini: No such file or directory
```

You should see the following message at the very end:
```
Successfully tagged sf-jupyter:latest
```

## Running the image
```
docker run -p 8888:8888 --name sf-notebook sf-jupyter:latest
```
You should see a message like the following the very first time you bring up this image:
```
[I 23:33:42.828 NotebookApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[I 23:33:43.820 NotebookApp] JupyterLab extension loaded from /opt/conda/lib/python3.7/site-packages/jupyterlab
[I 23:33:43.820 NotebookApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 23:33:43.822 NotebookApp] Serving notebooks from local directory: /home/jovyan
[I 23:33:43.822 NotebookApp] The Jupyter Notebook is running at:
[I 23:33:43.822 NotebookApp] http://(a8e53cbad3a0 or 127.0.0.1):8888/?token=eb2222f1a8cd14046ecc5177d4b1b5965446e3c34b8f42ad
[I 23:33:43.822 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 23:33:43.826 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-17-open.html
    Or copy and paste one of these URLs:
        http://(a8e53cbad3a0 or 127.0.0.1):8888/?token=eb2222f1a8cd14046ecc5177d4b1b5965446e3c34b8f42ad
```

## Accessing the image

Open a web browser on: http://localhost:8888

It will prompt you for a Password or token. Enter the token you have in the previous message.

## Working

You can now start uploading templates of jupyter notebooks. I recommend to always keep a local copy of your work once you are done. This can be done in the Jupyter menu: File->Download as.

## Stopping and starting the docker image

Once finished, you can stop the image with the following command:
```
docker stop sf-notebook
```
If you want to resume work, you can start the image with the following command:
```
docker start sf-notebook
```

## Additional handy commands

- To delete the image. WARNING: If you do this, you will lose any notebook you have saved within the container.
```
docker rm sf-notebook
```
- To open a bash session on the docker container, which will be useful to use the snowsql interface:
```
docker exec -it sf-notebook /bin/bash
```
- To copy files in the docker container:
```
docker cp <absolute-file-name> sf-notebook:<absolute-path-name in the container>
Example: docker cp README.md sf-notebook:/
```


