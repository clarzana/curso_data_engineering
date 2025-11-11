with 

source as (

    select * from {{ source('GOOGLE_SHEETS_SNP', 'users') }}

),

renamed as (

    select
        nombre,
        dni,
        email,
        fecha_alta_sistema

    from source

)

select * from renamed