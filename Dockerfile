#     - Please check the following URLs for the driver to pick up:
#  All drivers: https://docs.snowflake.net/manuals/release-notes/client-change-log.html#client-changes-by-version
#         ODBC:  https://sfc-repo.snowflakecomputing.com/odbc/linux/index.html
#         JDBC:  https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/
#         Spark: https://repo1.maven.org/maven2/net/snowflake/spark-snowflake_2.11
#         Note: For Spark, the docker currently uses Spark 2.4 with Scala 2.11
#    - Update line 26 with the correct levels to be deployed which executes deploy_snowflake.sh Script
#
# Questions: Zohar Nissare-Houssen - z.nissare-houssen@snowflake.com
#

#Start from the following core stack version
FROM jupyter/all-spark-notebook:1c8073a927aa
USER root
RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y libssl-dev libffi-dev && \
    apt-get install -y vim
RUN sudo -u jovyan /opt/conda/bin/python -m pip install --upgrade pip
RUN sudo -u jovyan /opt/conda/bin/python -m pip install --upgrade pyarrow
RUN sudo -u jovyan /opt/conda/bin/python -m pip install --upgrade snowflake-connector-python[pandas]
RUN sudo -u jovyan /opt/conda/bin/python -m pip install --upgrade snowflake-sqlalchemy
RUN sudo -u jovyan /opt/conda/bin/python -m pip install --upgrade plotly
RUN conda install pyodbc
RUN conda install -c conda-forge jupyterlab-plotly-extension --yes
RUN apt-get install -y iodbc libiodbc2-dev libssl-dev
COPY ./deploy_snowflake.sh /
RUN chmod +x /deploy_snowflake.sh
RUN odbc_version=2.21.8 jdbc_version=3.12.10 spark_version=2.8.1-spark_2.4 snowsql_version=1.2.9 /deploy_snowflake.sh
RUN mkdir /home/jovyan/samples
COPY ./pyodbc.ipynb /home/jovyan/samples
COPY ./Python.ipynb /home/jovyan/samples
COPY ./spark.ipynb /home/jovyan/samples
COPY ./SQLAlchemy.ipynb /home/jovyan/samples
RUN chown -R jovyan:users /home/jovyan/samples
RUN sudo -u jovyan /opt/conda/bin/jupyter trust /home/jovyan/samples/pyodbc.ipynb
RUN sudo -u jovyan /opt/conda/bin/jupyter trust /home/jovyan/samples/Python.ipynb
RUN sudo -u jovyan /opt/conda/bin/jupyter trust /home/jovyan/samples/spark.ipynb
RUN sudo -u jovyan /opt/conda/bin/jupyter trust /home/jovyan/samples/SQLAlchemy.ipynb
