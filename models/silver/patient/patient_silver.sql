{{ config(materialized='table') }}

SELECT
  id AS patient_id,
  gender,
  birthDate AS birth_date,
  active,
  resourceType AS resource_type
FROM {{ source('fhir_clean', 'patient') }}
WHERE gender IS NOT NULL
