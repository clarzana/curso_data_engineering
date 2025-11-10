{{
  config(
    materialized='view'
  )
}}

with src_promos as (
    select * 
    from {{ source('sql_server_dbo', 'promos') }}
), 
surrogate_ids_and_casting as (
    select
        md5(promo_id)::varchar(32) as promo_id
        , promo_id::varchar(256) as promo_name
        , discount::number(38, 0) as discount_in_dollars
        , md5(status)::varchar(32) as promo_status_id
        , convert_timezone('utc', _fivetran_synced)::timestamp_tz as load_date
        , _fivetran_deleted::boolean as is_deleted
    from src_promos
    union all
    select
        md5('nopromo')::varchar(32) as promo_id
        , 'no promotion'::varchar(256) as promo_name
        , 0::number(38, 0) as discount_in_dollars
        , md5('active')::varchar(32) as promo_status_id
        , '1900-01-01 00:00:00 +0000'::timestamp_tz as load_date
        , null::boolean as is_deleted
)
select * from surrogate_ids_and_casting