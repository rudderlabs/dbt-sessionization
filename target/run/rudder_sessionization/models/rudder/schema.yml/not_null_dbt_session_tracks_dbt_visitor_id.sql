select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select dbt_visitor_id
from `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_tracks`
where dbt_visitor_id is null



      
    ) dbt_internal_test