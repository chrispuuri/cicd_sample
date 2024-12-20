{{ config(
    tags=["phone_numbers", "jaffle_shop", "customer"]
) }}

{# Create a sample dataset of phone numbers to align with existing Jaffle Shop customers to show Multi-active satellite #}
with unpivoted_phone_numbers as (
    select *,
    rank() over (order by email) id
    from (
        {{ dbt_utils.unpivot(relation=ref('us_phone_numbers'), field_name="phone_type", value_name="phone_number", exclude=["email"], remove=["first_name","last_name","company_name","address","city","county","state","zip", "web"]) }}
        ) p
)
select id,
iff(phone_type = 'PHONE1', 'Home', 'Work') phone_type,
phone_number
from unpivoted_phone_numbers

