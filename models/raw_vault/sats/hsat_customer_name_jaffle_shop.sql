{{ config(
    tags=["customer","jaffle_shop"]
    )    
}}

{%- set yaml_metadata -%}
source_model: "primed_jaffle_shop_customers"
src_pk: "HUB_CUSTOMER_HKEY"
src_hashdiff: 
  source_column: "SAT_CUSTOMER_NAME_HASHDIFF"
  alias: "HASH_DIFF"
src_payload:
  - FIRST_NAME 
  - LAST_NAME
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATETIME"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],
                src_eff=metadata_dict["src_eff"],
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"])   }}
