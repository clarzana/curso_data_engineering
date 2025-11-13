with source as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        shipping_service_id,
        shipping_service_name,
    from source
    union all
    select
         {{ dbt_utils.generate_surrogate_key(['NULL']) }}::varchar(32) as shipping_service_id,
         "Shipping service name unknown" as shipping_service_name

)

select * from renamed