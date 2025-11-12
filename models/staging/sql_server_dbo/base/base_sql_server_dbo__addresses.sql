with
source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        {{dbt_utils.generate_surrogate_key(['zipcode', 'state', 'country'])}}::varchar(32) as locality_id
        state,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
