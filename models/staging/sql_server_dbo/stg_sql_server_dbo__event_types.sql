with 
source as (

    select * from {{ ref('base_sql_server_dbo__events') }}

),

renamed as (

    select
        event_type_id,
        event_type_desc,
    from source

)

select * from renamed