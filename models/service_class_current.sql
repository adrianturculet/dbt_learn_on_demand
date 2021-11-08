/* {{ config(materialized='table') }} */


with product_operations as (

    select *

    from product_operations.item_ledger_entries

),

stock as (

    select *

    from product_operations.stock

),

ledger_stock as (

    select
        posting_date,
        SUM(quantity) as total_quantity,
        service_class

    from product_operations 

    left join stock using (item_no_, location_code)

    group by 1,3
    order by 1,3 asc
)


select * from ledger_stock;

