{% snapshot google_sheets_users_snapshot_hard_deletes_invalidate %}

{{
    config(
      target_schema='snapshots',
      unique_key='DNI',
      strategy='timestamp',
      updated_at='FECHA_ALTA_SISTEMA',
      hard_deletes='invalidate',
    )
}}

select * from {{ source('GOOGLE_SHEETS_SNP', 'users') }}

{% endsnapshot %}