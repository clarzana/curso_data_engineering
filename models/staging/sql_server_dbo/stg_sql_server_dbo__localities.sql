{{
    config(
        materialized='incremental',
        unique_key='_row',
        on_schema_change='fail'
    )
}}


with 
source as (

    select * from {{ ref('base_sql_server_dbo__addresses') }}

),

renamed as (

    select
        locality_id,
        state,
        country,
        zipcode
    from source

)

select * from renamed