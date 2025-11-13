{{
  config(
    materialized='view'
  )
}}

with src_promos as (
    select * 
    from {{ ref('base_sql_server_dbo__promos') }}
), 
surrogate_ids_and_casting as (
    select
        promo_status_id,
        promo_status_name
    from src_promos
    union all
    select
         md5("nostatus")::varchar(32) as promo_status_id
        , 'No status'::varchar(256) as promo_status_name
)
select * from surrogate_ids_and_casting