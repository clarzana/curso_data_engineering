with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        {{ dbt_utils.generate_surrogate_key(['source.shipping_service']) }}::varchar(32) as shipping_service_id,
        shipping_service as shipping_service_name,
        shipping_cost,
        address_id,
        created_at,
        {{ dbt_utils.generate_surrogate_key(['source.promo_id']) }}::varchar(32) as promo_id,
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