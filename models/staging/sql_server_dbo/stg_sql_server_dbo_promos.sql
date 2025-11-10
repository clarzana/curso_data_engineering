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
        md5(PROMO_ID)::VARCHAR(32) as PROMO_ID
        , PROMO_ID::VARCHAR(256) as PROMO_NAME
        , DISCOUNT::NUMBER(38, 0) as DISCOUNT_IN_DOLLARS
        , CASE
            WHEN STATUS='inactive'
            THEN FALSE
            WHEN STATUS='active'
            THEN TRUE
            ELSE NULL
        END AS IS_ACTIVE
        , CONVERT_TIMEZONE('UTC', _FIVETRAN_SYNCED)::TIMESTAMP_TZ as DATE_LOAD
        , _FIVETRAN_DELETED::BOOLEAN as IS_DELETED
    FROM src_promos
    UNION
    SELECT
        md5('NOPROMO')::VARCHAR(32) as PROMO_ID
        , 'No promotion'::VARCHAR(256) as PROMO_NAME
        , 0::NUMBER(38, 0) AS DISCOUNT_IN_DOLLARS
        , TRUE AS IS_ACTIVE
        , '1900-01-01 00:00:00 +0000'::TIMESTAMP_TZ AS DATE_LOAD
        , NULL::BOOLEAN as IS_DELETED
)
SELECT * FROM surrogate_ids_and_casting