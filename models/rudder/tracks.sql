{{ config(materialized='table') }}
SELECT *
FROM big-query-integration-poc.RudderAutoTrack.tracks
ORDER BY sent_at DESC

