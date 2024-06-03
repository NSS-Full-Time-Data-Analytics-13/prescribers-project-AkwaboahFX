SELECT * FROM prescription;
SELECT * FROM prescriber;

SELECT 
	npi, 
	MAX(total_claim_count) AS total_claims
FROM 
	prescription
GROUP BY 
	npi 

	
SELECT 
    p.npi, 
    pr.nppes_provider_first_name, 
    pr.nppes_provider_last_org_name, 
    pr.specialty_description, 
    MAX(p.total_claim_count) AS total_claims
FROM 
    prescription p
JOIN 
    prescriber pr ON p.npi = pr.npi
GROUP BY 
    p.npi, 
    pr.nppes_provider_first_name, 
    pr.nppes_provider_last_org_name, 
    pr.specialty_description
ORDER BY 
    total_claims DESC


SELECT
	 p.npi,
	 pr.specialty_description,
	 MAX(total_claim_count) AS total_claims	 
FROM 
	prescriber pr
JOIN
	prescription p  
	ON pr.npi = p.npi
GROUP BY 
	p. npi,
    pr. specialty_description
ORDER BY
    total_claims DESC;


SELECT
	p.npi,
	p.drug_name,
	MAX(total_claim_count) AS total_claims,
	pr.specialty_description	
FROM 
	prescription p
JOIN
	prescriber pr
	ON pr.npi = p.npi
WHERE 
	drug_name ILIKE '%CODONE%'		
GROUP BY 
	p.npi,
	p.drug_name,
	pr.specialty_description

ORDER BY 
   total_claims DESC;


SELECT
    p.npi,
    pr.specialty_description
FROM 
    prescriber pr
JOIN
    prescription p
ON
    pr.npi = p.npi
WHERE 
    pr.specialty_description 
NOT ILIKE '%associated_description%' 
OR  
	pr.specialty_description IS NULL
GROUP BY
	p.npi,
	pr.specialty_description
ORDER BY
    specialty_description DESC; 


SELECT 
    drug_name,
	ROUND(SUM(total_drug_cost)/ SUM(total_day_supply), 2) AS cost_per_day
FROM 
	prescription 
GROUP BY 
    drug_name,
	total_drug_cost
ORDER BY
    total_drug_cost DESC;

