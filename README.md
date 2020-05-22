# Sessionization DBT code for RudderStack

This repository contains a sample DBT project for Rudder stack. It can be applied on Rudder data residing in BigQuery. This DBT project creates "session" abstractions on top of Rudder "track" event data. Materialized DBT tables and views are used for the same.

This project was created on DBT Cloud (https://cloud.getdbt.com). Hence there is no profiles.yml file with connection information. Developers who want to execute the models in Command Line Interface (CLI) mode will need to create additional configuration files (https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/)

While this code has been tested for BigQuery, it should also be usable for other Rudder-supported data warehouses like Redshift and Snowflake. The only differences might arise with regards to functions related to timestamp handling and analytics. Even then, we believe the code should be usable by just replacing the BigQuery functions with their counterparts from Redshift or Snowflake as required.

The sequence in which the DBT models should be executed for a fresh run is as follows:
* dbt_aliases_mapping
* dbt_mapped_tracks
* dbt_session_tracks
* dbt_track_facts
* dbt_session_track_facts
* dbt_user_session_facts
* dbt_session_duration
* dbt_tracks_flow

Sample analysis query is provided at analysis/dbt_top_users_by_avg_session_duration.sql

This project builds on top data from the "tracks" table which is created by default in all Rudder warehouse destinations. Developers having access to a Rudder BigQuery destinationwho can start using this code by simply changing the dataset and schema names in the following files
* models/rudder/dbt_aliases_mapping.sql
* models/rudder/dbt_mapped_tracks.sql

For example, a statement like " ... from big-query-integration-poc.RudderAutoTrack.tracks" will need to be changed 
to " ... from MyBigQueryDataSet.MyRudderSchema.tracks"
