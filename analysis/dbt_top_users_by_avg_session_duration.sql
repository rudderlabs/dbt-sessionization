/*

Sample analysis query. List of users by average session duration

*/

{{ config(materialized='view') }}

select 
    dbt_visitor_id
    , avg(session_duration) as avg_session_duration
from
        {{ ref('dbt_session_duration') }}
group by
    dbt_visitor_id
order by
    avg_session_duration
