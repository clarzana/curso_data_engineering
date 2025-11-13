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
        -- No usamos isnull o coalesce porque el resultado de hacer generate_surrogate_key
        -- sobre un array que contenga cualquier número de NULLs no es NULL, sino un hash
        {{dbt_utils.generate_surrogate_key(['zipcode', 'state', 'country'])}}::varchar(32) as locality_id,
        state,
        _fivetran_deleted,
        _fivetran_synced,
    from source

)

select * from renamed
