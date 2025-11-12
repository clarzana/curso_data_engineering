with 
source as (

    select * from {{ ref('base_sql_server_dbo__addresses') }}

),

renamed as (

    select
        address_id,
        locality_id,
        --1. zipcode,
        --2. state,
        --3. country,
        address,
        _fivetran_deleted as is_deleted,
        _fivetran_synced as load_date

    from source

)

select * from renamed