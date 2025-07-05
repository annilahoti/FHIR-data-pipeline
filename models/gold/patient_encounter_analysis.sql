{{ config(materialized='table') }}

SELECT
    p.patient_id AS patient_id,
    p.gender AS gender,
    p.birth_date AS birth_date,
    e.encounter_id AS encounter_id,
    e.encounter_class_code AS encounter_type,
    e.start_date AS encounter_start,
    e.end_date AS encounter_end,
    DATEDIFF(e.end_date, e.start_date) AS length_of_stay_days,
    e.encounter_status AS status
FROM {{ ref('patient_silver') }} p
JOIN {{ ref('encounter_silver') }} e
    ON p.patient_id = e.patient_id
WHERE p.gender IS NOT NULL
  AND e.start_date IS NOT NULL
  AND e.end_date IS NOT NULL
  AND e.patient_id IS NOT NULL
