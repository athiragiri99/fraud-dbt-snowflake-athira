sql
select 
customer_id,
count(*) as total_txns,
sum(amount) as total_amount,
max(is_fraud) as fraud_flag
from{{ref('stg_transactions')}}
group by customer_id


