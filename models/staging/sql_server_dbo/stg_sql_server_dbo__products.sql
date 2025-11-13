{{
  config(
    materialized='incremental',
    unique_key='product_id',
    on_schema_change='fail'
  )
}}


with 
source as (
    select * from {{ source('sql_server_dbo', 'products') }}
),

renamed as (

    select
        product_id::varchar(256),
        price::float,
        name,
        inventory as number(38, 0),
        _fivetran_deleted::boolean as is_deleted,
        _fivetran_synced::timestamp_tz as load_date
    from source

)

select * from renamed