{{ config(materialized='table')}}

-- SELECT
--     p.patient_id,
--     e.patient_id as encounter_patient_id,
--     p.gender,
--     COUNT(e.encounter_id) AS total_encounters
-- FROM {{ ref('patient_silver')}} p
-- LEFT JOIN {{ ref('encounter_silver')}} e
--     ON p.patient_id = e.patient_id
-- GROUP BY p.patient_id, e.patient_id, p.gender
-- ORDER BY total_encounters DESC
select e.patient_id, p.patient_id as patientID
from {{ref('encounter_silver')}} e
JOIN {{ref('patient_silver')}} p
on e.patient_id = p.patient_id