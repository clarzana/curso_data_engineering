with source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['source.promo_id']) }}::varchar(32) as promo_id
        promo_id as promo_name,
        discount,
        {{ dbt_utils.generate_surrogate_key(['source.status']) }}::varchar(32) as promo_status_id
        status as promo_status_name,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed