
/* create a new stock table that adds an extra 'ABCD' segment from the stock-keeping table from 
the last 7 days using the GCP warehouse principles (time travel) for automatic & free snapshots storage up to 7 days */

WITH linked_stock_snapshot AS (SELECT A.*,
    B.historic_service_class
      
FROM product_operations.stock A 
    FOR SYSTEM_TIME AS OF TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 HOUR) 

  LEFT JOIN  (
      SELECT service_class AS historic_service_class,
                    item_no_,
                    location_code,
              FROM
              product_operations.`stock`
                FOR SYSTEM_TIME AS OF TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 HOUR)) B

USING (item_no_, location_code)

)

SELECT * FROM linked_stock_snapshot
