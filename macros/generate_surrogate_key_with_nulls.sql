{% macro generate_surrogate_key_with_nulls(key_name, null_key) -%}

    {%- if key_name|trim is none or key_name|trim=="" -%}

        md5("no" + {{null_key}})

    {%- else -%}

        {{ dbt_utils.generate_surrogate_key(key_name) }}

    {%- endif -%}

{%- endmacro %}