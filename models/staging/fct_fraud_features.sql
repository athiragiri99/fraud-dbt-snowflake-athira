{{ config(materialized='table', unique_key='Time') }}
WITH features AS (
  SELECT *,
    Time % 86400/3600 as hour_of_day,
    CASE WHEN Time % 86400/3600 BETWEEN 0 AND 6 THEN 1 ELSE 0 END as is_night,
    LOG(Amount + 1) as log_amount,
    NTILE(10) OVER (ORDER BY Amount) as amount_decile
  FROM {{ ref('stg_fraud_transactions') }}
)
SELECT * FROM features
