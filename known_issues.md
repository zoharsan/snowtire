# Known issues / Change Log / Gotchas

#### 2020-04-20:

- ZN: Fixed Dockerfile to pull the pandas optimized connector for snowflake (snowflake-connector-python[pandas]).
- ZN: Tested latest drivers as of to date, including latest Spark Optimized driver version 2.7 and updated Dockerfile.

#### 2019-02-14:

- ZN: SnowSQL CLI version 1.2.4 has deployment issues which will be fixed in 1.2.5. As a workaround, just build the docker with 1.2.2, and launching SnowSQL will auto-upgrade the image.
- PG: To allow reads against GCP, add the following option to the Spark connector:
```
'use_copy_unload':'false'
```

#### 2019-02-13:

- ZN: Jupyter-Stacks latest image updated on 02/11 upgraded Spark to 2.4.5 version which breaks pyspark. Fixed Dockerfile to pick-up last working version.
