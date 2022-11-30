
  
    

    create or replace table `rudderstack-367610`.`dbt_jluiscases`.`dbt_user_session_facts`
    
    
    OPTIONS()
    as (
      /*

Table containing a useful metric about user sessions - no. of sessions for each user

*/



SELECT
        dbt_visitor_id
        , cast(MIN(s.session_start_at) as timestamp) as first_date
        , cast(MAX(s.session_start_at) as timestamp) as last_date
        , COUNT(*) as number_of_sessions
      FROM `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_tracks` as s
      LEFT JOIN `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_track_facts` as sf
      ON s.session_id = sf.session_id
      GROUP BY 1
    );
  