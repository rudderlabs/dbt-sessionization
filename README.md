# Sessionization using DBT and RudderStack

This repository contains a sample DBT project for RudderStack. It can be applied on Rudder data residing in BigQuery. This DBT project creates "session" abstractions on top of RudderStack's `track` event data. The materialized DBT tables and views are used for the same.

## Overview

This project builds on top data from the `tracks` table which is created by default in all the RudderStack warehouse destinations. Developers having access to a RudderStack BigQuery destination can start using this code by simply changing the dataset and schema names in the following files:
* `models/rudder/dbt_aliases_mapping.sql`
* `models/rudder/dbt_mapped_tracks.sql`

For example, a statement like `... from big-query-integration-poc.RudderAutoTrack.tracks` will need to be changed 
to ` ... from MyBigQueryDataSet.MyRudderSchema.tracks`

## How to Use This Repository

This project was created on DBT Cloud (https://cloud.getdbt.com). Hence there is no `profiles.yml` file with the connection information. Developers who want to execute the models on the Command Line Interface (CLI) mode will need to create additional configuration files by following the directions provided [here](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/)

**Note**: While this code has been tested for Google BigQuery, it should also be usable for other RudderStack-supported data warehouses like Amazon Redshift and Snowflake. The only differences that might arise are with regards to functions related to timestamp handling and analytics. Even then, we believe the code should be usable by just replacing the BigQuery functions with their counterparts from Redshift or Snowflake as required.

### Sequence of Commands

The sequence in which the DBT models should be executed for a fresh run is as follows:
* `dbt_aliases_mapping`

This model/table has two attributes/columns - `alias` and `dbt_visitor_id`. This table captures the linkages between one or more `anonymous_id` values (`alias`) and a `user_id` (`dbt_visitor_id`).

* `dbt_mapped_tracks`

This table has columns - `event_id`, `anonymous_id`, `dbt_visitor_id`, `timestamp`, `event`, `idle_time_minutes`.
`event` represents the actual event name. `timestamp` corresponds to the instant when the event was actually generated.
`idle_time_minutes` captures the time gap between the event and the immediate preceeding one.

* `dbt_session_tracks`

This table contains columns - `session_id`, `dbt_visitor_id`, `session_start_at`, `session_sequence_number`, `next_session_start_at`. 

The data in the `dbt_mapped_tracks` table is partitioned first by `dbt_visitor_id`. It is then partitioned farther into 
groups of events where within one group the time-gap i.e. `idle_time_minutes` is not more than 30. In other words - if `idle_time_minutes`for an event is more than 30, a new group is created. 

These groups of sequential events are essentially the sessions.The value of 30 can be modified in the model definition. 
The `session_sequence_number` represent the order of the session for a particular user.
The `session_id` is of the form `session_sequence_number - dbt_visitor_id`.

* dbt_track_facts

This table has columns - `anonymous_id`, `timestamp`, `event_id`, `event`, `session_id`, `dbt_visitor_id`, 
`track_sequence_number`. 

In this table, the information from `dbt_session_tracks` is tied back to the records in the `dbt_mapped_tracks` table.
Each event is now tied to a `session_id` and within the session also, the event is assigned a `track_sequence_number`.

* dbt_session_track_facts

The columns in this table are - `session_id`, `ended_at`, `num_pvs`, `cnt_viewed_product`, `cnt_signup`.
`num_pvs` captures the number of distinct events in that session. `cnt_viewed_product` captures the total number of times 'view_product' events were triggered. This is only for illustrative purposes; developers might want to monitor statistics 
for a different event type.

* dbt_user_session_facts

The columns in this table are `dbt_visitor_id`, `first_date`, `last_date`, `number_of_sessions`. This table captures the 
time period for which the user has been active and the number of sessions they have created in that time.

* dbt_session_duration

This table captures the duration for each session of a user; the associated columns are `dbt_visitor_id`, `session_id` and 
`session_duration`.

* dbt_tracks_flow

The columns in this table are - `event_id`, `session_id`, `track_sequence_number`, `event`, `dbt_visitor_id`, `timestamp`,
`event_2`, `event_3`, `event_4`, `event_5`. This is essentially a table where each event and 4 subsequent events are 
represented in each record. 

**Note**: A sample analysis query is provided at `analysis/dbt_top_users_by_avg_session_duration.sql`
