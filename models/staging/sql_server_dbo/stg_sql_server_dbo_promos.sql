{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
), 
surrogate_ids_and_casting AS (
    SELECT
        md5(PROMO_ID) as PROMO_ID::VARCHAR(32)
        , PROMO_ID as PROMO_NAME::VARCHAR(256)
        , DISCOUNT as DISCOUNT_IN_DOLLARS::NUMBER(38, 0)
        , CASE
            WHEN STATUS='inactive'
            THEN FALSE
            WHEN STATUS='active'
            THEN TRUE
            ELSE NULL
        END AS IS_ACTIVE
        , CONVERT_TIMEZONE('UTC', _FIVETRAN_SYNCED) as DATE_LOAD::TIMESTAMP_TZ
        , _FIVETRAN_DELETED as IS_DELETED::BOOLEAN
    FROM src_promos
    UNION
    SELECT
        md5('NOPROMO') as PROMO_ID::VARCHAR(32)
        , 'No promotion' as PROMO_NAME::VARCHAR(256)
        , 0 AS DISCOUNT_IN_DOLLARS::NUMBER(38, 0)
        , TRUE AS IS_ACTIVE
        , '1900-01-01 00:00:00 +0000' AS DATE_LOAD::TIMESTAMP_TZ
        , NULL as IS_DELETED::BOOLEAN
)
SELECT * FROM surrogate_ids_and_casting