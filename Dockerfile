#Start from the following core stack version
FROM jupyter/all-spark-notebook:latest
USER root
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y libssl-dev libffi-dev
RUN apt-get install -y vim
RUN sudo -u jovyan /opt/conda/bin/pip install --upgrade snowflake-connector-python
RUN sudo -u jovyan /opt/conda/bin/pip install --upgrade snowflake-sqlalchemy
RUN conda install pyodbc
COPY ./snowflake_linux_x8664_odbc-2.19.3.tgz /
RUN apt-get install -y iodbc libiodbc2-dev libpq-dev libssl-dev
RUN gunzip /snowflake_linux_x8664_odbc-2.19.3.tgz
RUN tar -xvf /snowflake_linux_x8664_odbc-2.19.3.tar
RUN ./snowflake_odbc/iodbc_setup.sh
COPY ./snowflake-jdbc-3.8.3.jar /home/jovyan
RUN chown jovyan:users /home/jovyan/snowflake-jdbc-3.8.3.jar
COPY ./snowflake-jdbc-3.8.0.jar /usr/local/spark/jars
COPY ./spark-snowflake_2.11-2.4.14-spark_2.4.jar /usr/local/spark/jars
COPY ./snowsql-1.1.81-linux_x86_64.bash /
RUN SNOWSQL_DEST=/usr/bin SNOWSQL_LOGIN_SHELL=/home/jovyan/.profile bash /snowsql-1.1.81-linux_x86_64.bash
