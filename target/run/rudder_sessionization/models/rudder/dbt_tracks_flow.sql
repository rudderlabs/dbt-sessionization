
  
    

    create or replace table `rudderstack-367610`.`dbt_jluiscases`.`dbt_tracks_flow`
    
    
    OPTIONS()
    as (
      /*

We leverage analytic functions like first_value and nth_value to create 5-event sequences that capture the flow of events during a session. 5 can be increased or decreased as per requirements.

*/



with derived_table as (
          select
            event_id,
            session_id,
            track_sequence_number,
            first_value(event IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as event,
            dbt_visitor_id,
            timestamp,
            nth_value(event,2 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as second_event,
            nth_value(event,3 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as third_event,
            nth_value(event,4 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as fourth_event,
            nth_value(event,5 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as fifth_event,
            nth_value(event,6 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as six_event,
            nth_value(event,7 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as seven_event,
            nth_value(event,8 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as eight_event,
            nth_value(event,9 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as ninth_event,
            nth_value(event,10 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as ten_event,
            nth_value(event,11 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as eleven_event,
            nth_value(event,12 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as twelve_event,
            nth_value(event,13 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as thirteen_event,
            nth_value(event,14 IGNORE NULLS) over(partition by session_id order by track_sequence_number asc) as fourteen_event,
            
            from `rudderstack-367610`.`dbt_jluiscases`.`dbt_track_facts`
        )

          select event_id
            , session_id
            , track_sequence_number
            , event
            , dbt_visitor_id
            , cast(timestamp as timestamp) as timestamp
            , second_event as event_2
            , third_event as event_3
            , fourth_event as event_4
            , fifth_event as event_5
            , six_event as event_6
            , seven_event as event_7
            , eight_event as event_8
            , ninth_event as event_9
            , ten_event as event_10
            , eleven_event as event_11
            , twelve_event as event_12
            , thirteen_event as event_13
            , fourteen_event as event_14
            
  
      from derived_table a
    );
  