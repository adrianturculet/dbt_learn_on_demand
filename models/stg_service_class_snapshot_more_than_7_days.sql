

/* for a snapshot already existing from the batch workloads 
   we specify the snapshot from a specific moment in time */

WITH linked_stock_snapshot AS (SELECT A.*,
    B.historic_service_class
      
    FROM product_operations.stock A 
  LEFT JOIN  (
      SELECT service_class AS historic_service_class, /* historic service class */
                    item_no_,
                    location_code,
              FROM
              product_operations.`stock-2021-11-08T16_33_41`) B

USING (item_no_, location_code)

)

SELECT * FROM linked_stock_snapshot

