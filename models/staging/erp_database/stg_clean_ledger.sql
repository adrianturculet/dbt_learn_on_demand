/* create a clean ledger ready to be linked to the table containing 'Service Class' segments*/

WITH clean_ledger AS (
    SELECT
        posting_date,
        item_no_, 
        quantity,
        location_code
        

    FROM product_operations.item_ledger_entries
    
    )

SELECT * FROM clean_ledger