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
        
        CONVERT_TIMEZONE('UTC', _FIVETRAN_SYNCED)::TIMESTAMP_TZ as DATE_LOAD
        , _FIVETRAN_DELETED::BOOLEAN as IS_DELETED
    FROM src_orders
)
SELECT * FROM renaming_casting