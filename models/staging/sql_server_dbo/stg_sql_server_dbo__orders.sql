{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}


with 
source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (

    select
        order_id,
        shipping_service_id,
        shipping_cost,
        address_id,
        created_at,
        case
        when trim(promo_id) is null or trim(promo_id)==""
        then md5("nopromo")
        
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed