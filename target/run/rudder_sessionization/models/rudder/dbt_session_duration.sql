

  create or replace view `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_duration`
  OPTIONS()
  as /*

Table containing a useful session metric - session duration

*/



select 
    s1.dbt_visitor_id
    , s1.session_id
    , timestamp_diff(cast(s2.ended_at as timestamp), cast(s1.session_start_at as timestamp), minute) as session_duration
from
    `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_tracks` as s1
    LEFT JOIN `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_track_facts` as s2
      ON s1.session_id = s2.session_id;

