{{
  config(
    materialized='incremental',
    unique_key='event_id',
    on_schema_change='fail'
  )
}}

with 
source as (

    select * from {{ ref('base_sql_server_dbo__events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type_id,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id,
        _fivetran_deleted as is_deleted,
        _fivetran_synced as load_date

    from source

)

select * from renamed