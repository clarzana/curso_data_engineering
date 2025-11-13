with source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        
        event_id,
        page_url,
        {{ dbt_utils.generate_surrogate_key(['source.event_type']) }}::varchar(32) as event_type_id,
        event_type as event_type_desc,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed