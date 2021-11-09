/* uncomment the command below if we want to create model as a table instead of view*/

/* {{ config(materialized='table') }} */

/* create the measure required and link 'service_class_snapshot_more_than_7_days' model 
OR link 'service_class_snapshot_up_to_7_days' model */

WITH final AS (SELECT 
        posting_date,
        SUM(quantity) as total_quantity,
        service_class,
        historic_service_class /* historic service class */
    from {{ ref('clean_ledger')}}

    left join {{ ref('service_class_snapshot_more_than_7_days')}} using (item_no_, location_code)
    group by 1,3,4
    order by 1,3 asc
    )

SELECT * FROM final 
ORDER BY 1,3 ASC