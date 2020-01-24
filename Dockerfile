#     - Please check the following URLs for the driver to pick up:
#  All drivers: https://docs.snowflake.net/manuals/release-notes/client-change-log.html#client-changes-by-version
#         ODBC:  https://sfc-repo.snowflakecomputing.com/odbc/linux/index.html
#         JDBC:  https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/
#         Spark: https://repo1.maven.org/maven2/net/snowflake/spark-snowflake_2.11
#         Note: For Spark, the docker currently uses Spark 2.4 with Scala 2.11
#    - Update line 21 with the correct levels to be deployed which executes deploy_snowflake.sh Script
#
# Questions: Zohar Nissare-Houssen - z.nissare-houssen@snowflake.com
#

#Start from the following core stack version
FROM jupyter/all-spark-notebook:latest
USER root
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y libssl-dev libffi-dev
RUN apt-get install -y vim
RUN sudo -u jovyan /opt/conda/bin/pip install --upgrade pyarrow
RUN sudo -u jovyan /opt/conda/bin/pip install --upgrade snowflake-connector-python
RUN sudo -u jovyan /opt/conda/bin/pip install --upgrade snowflake-sqlalchemy
RUN conda install pyodbc
RUN apt-get install -y iodbc libiodbc2-dev libpq-dev libssl-dev
COPY ./deploy_snowflake.sh /
RUN chmod +x /deploy_snowflake.sh
RUN odbc_version=2.20.0 jdbc_version=3.9.2 spark_version=2.5.4-spark_2.4 snowsql_version=1.1.86 /deploy_snowflake.sh
RUN mkdir /home/jovyan/samples
COPY ./pyodbc.ipynb /home/jovyan/samples
COPY ./Python.ipynb /home/jovyan/samples
COPY ./spark.ipynb /home/jovyan/samples
COPY ./SQLAlchemy.ipynb /home/jovyan/samples
RUN chown -R jovyan:users /home/jovyan/samples
