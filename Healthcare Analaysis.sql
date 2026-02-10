CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    medical_condition VARCHAR(100),
    admission_date DATE,
    discharge_date DATE,
    hospital VARCHAR(100),
    insurance_provider VARCHAR(100),
    billing_amount DECIMAL(10,2),
    admission_type VARCHAR(50),
    medication VARCHAR(100),
    test_results VARCHAR(50)
);

#Average Length of Stay by Medical Condition

SELECT 
    medical_condition,
    AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay_days
FROM patients
GROUP BY medical_condition
ORDER BY avg_stay_days DESC;


#Hospital Workload Analysis

SELECT 
    hospital,
    COUNT(*) AS total_admissions
FROM patients
GROUP BY hospital
ORDER BY total_admissions DESC;


#Readmission Risk Indicator (≤30 Days Stay)


SELECT 
    patient_id,
    medical_condition,
    DATEDIFF(discharge_date, admission_date) AS stay_days
FROM patients
WHERE DATEDIFF(discharge_date, admission_date) <= 30;


#Billing Analysis by Insurance Provider

SELECT 
    insurance_provider,
    ROUND(AVG(billing_amount), 2) AS avg_billing,
    SUM(billing_amount) AS total_billing
FROM patients
GROUP BY insurance_provider
ORDER BY total_billing DESC;



#High-Cost Patients (Top 10%)

WITH cost_rank AS (
    SELECT *,
           NTILE(10) OVER (ORDER BY billing_amount DESC) AS cost_bucket
    FROM patients
)
SELECT patient_id, billing_amount
FROM cost_rank
WHERE cost_bucket = 1;


#Admission Type Distribution

SELECT 
    admission_type,
    COUNT(*) AS admissions
FROM patients
GROUP BY admission_type;



#Medication Effectiveness Indicator

SELECT 
    medication,
    test_results,
    COUNT(*) AS cases
FROM patients
GROUP BY medication, test_results
ORDER BY cases DESC;














