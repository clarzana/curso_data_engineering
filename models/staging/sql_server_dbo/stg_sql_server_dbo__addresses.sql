with 
source as (

    select * from {{ ref('base_sql_server_dbo_addresses') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['zipcode', 'state', 'country'])}}::varchar(32) as locality_id,
        address_id,
        --1. zipcode,
        --2. state,
        --3. country,
        address,
        _fivetran_deleted as is_deleted,
        _fivetran_synced as load_date

    from source

)

select * from renamed