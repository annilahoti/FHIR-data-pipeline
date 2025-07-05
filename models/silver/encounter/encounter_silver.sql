{{ config(materialized='table') }}

SELECT
  id::STRING AS encounter_id,
  status::STRING AS encounter_status,
  class.code::STRING AS encounter_class_code,
  period.start::TIMESTAMP AS start_date,
  period.end::TIMESTAMP AS end_date,
  CAST(
    CASE
      WHEN subject.reference LIKE 'Patient/%' AND split(subject.reference, '/')[1] RLIKE '^[0-9]+$'
      THEN split(subject.reference, '/')[1]
      ELSE NULL
    END AS STRING
  ) AS patient_id
FROM {{ source('fhir_clean', 'encounter') }}
WHERE id IS NOT NULL