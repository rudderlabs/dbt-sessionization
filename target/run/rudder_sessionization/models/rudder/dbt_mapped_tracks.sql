
  
    

    create or replace table `rudderstack-367610`.`dbt_jluiscases`.`dbt_mapped_tracks`
    
    
    OPTIONS()
    as (
      /*

 Use the ID generated while creating dbt_aliases_mapping to link all events for the same user on that device. Also note the idle time between events

*/



select *
        ,timestamp_diff(cast(timestamp as timestamp), cast(lag(timestamp) over(partition by dbt_visitor_id order by timestamp) as timestamp), minute) as idle_time_minutes
      from (
        select t.id as event_id
          ,t.anonymous_id
          ,a2v.dbt_visitor_id
          ,t.timestamp
          ,t.event as event
        from `rudderstack-367610`.`rudder_1`.`tracks` as t
        inner join `rudderstack-367610`.`dbt_jluiscases`.`dbt_aliases_mapping` as a2v
        on a2v.alias = coalesce(t.user_id, t.anonymous_id)
        )
    );
  