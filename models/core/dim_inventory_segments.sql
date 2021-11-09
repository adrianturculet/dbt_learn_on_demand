/* create model as a table instead of view*/

 {{ config(materialized='table') }} 

/* create the measure required and link 'service_class_snapshot_more_than_7_days' model 
OR link 'service_class_snapshot_up_to_7_days' model */

WITH final AS (SELECT 
        posting_date,
        SUM(quantity) AS total_quantity,
        service_class,
        historic_service_class /* historic service class */
    FROM {{ ref('stg_clean_ledger')}}

    LEFT JOIN {{ ref('stg_service_class_snapshot_more_than_7_days')}} 
    
    USING (item_no_, location_code)
    
    GROUP BY 1,3,4
    ORDER BY 1,3 ASC
    )

SELECT * FROM final 
ORDER BY 1,3 ASC