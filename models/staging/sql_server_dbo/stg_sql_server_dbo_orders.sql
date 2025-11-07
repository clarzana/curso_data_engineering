{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
), 
renaming_casting AS (
    SELECT
        
        , CONVERT_TIMEZONE('UTC', _FIVETRAN_SYNCED) as DATE_LOAD::TIMESTAMP_TZ
        , _FIVETRAN_DELETED as IS_DELETED::BOOLEAN
    FROM src_orders
)
SELECT * FROM renaming_casting