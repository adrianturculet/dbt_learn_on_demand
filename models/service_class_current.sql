/* {{ config(materialized='table') }} */



with ledger_stock as (

    select
        posting_date,
        SUM(quantity) as total_quantity,
        service_class

    from product_operations.item_ledger_entries

    left join product_operations.stock using (item_no_, location_code)

    group by 1,3
    order by 1,3 asc
)


select * from ledger_stock

