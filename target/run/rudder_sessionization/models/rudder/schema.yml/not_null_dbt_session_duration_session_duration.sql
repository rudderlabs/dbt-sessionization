select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select session_duration
from `rudderstack-367610`.`dbt_jluiscases`.`dbt_session_duration`
where session_duration is null



      
    ) dbt_internal_test