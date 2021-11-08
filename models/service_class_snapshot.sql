SELECT *
FROM {{ ref('service_class_current') }}
  
  FOR SYSTEM_TIME AS OF TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
  
    order by 1,3 asc

