/*

With the events mapped to sessions (dbt_session_tracks), one can now stipulate the session end time as the timestamp of the last event (in other words, the highest timestamp) in that session. The next table encapsulates this data. It also contains few columns that can be of aid specifically for analytics involving e-commerce sites/applications.

*/




SELECT s.session_id
        , cast(MAX(map.timestamp) as timestamp) AS ended_at
        , count(distinct map.event_id) AS num_pvs
        , count(case when map.event = 'viewed_product' then event_id else null end) as cnt_viewed_product
        , count(case when map.event = 'signup' then event_id else null end) as cnt_signup
      FROM `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_tracks` AS s
      LEFT JOIN `rudderstack-367610`.`dbt_jluiscases`.`dbt_track_facts` as map on map.session_id = s.session_id
      GROUP BY 1