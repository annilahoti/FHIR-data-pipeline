{{ config(
    materialized='table'
) }}

SELECT
  id::STRING AS encounter_id,
  status::STRING AS encounter_status,
  class.code::STRING AS encounter_class_code,
  period.start::TIMESTAMP AS start_date,
  period.end::TIMESTAMP AS end_date
FROM {{ source('fhir_clean', 'encounter') }}
WHERE id IS NOT NULL
