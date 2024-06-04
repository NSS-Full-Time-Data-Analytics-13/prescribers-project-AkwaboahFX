SELECT * FROM prescription;
SELECT * FROM prescriber;

SELECT 
	npi, 
	SUM(total_claim_count) AS total_claims
FROM 
	prescription
GROUP BY 
	npi 
ORDER BY 
	total_claims DESC
LIMIT 1;

	
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
	MAX(total_claim_count) AS total_claims,
	specialty_description	
FROM 
	prescriber 
INNER JOIN
	prescription USING (npi)
INNER JOIN
	drug USING (drug_name) 
WHERE 
	opioid_drug_flag = 'Y'		
GROUP BY 
	specialty_description
ORDER BY 
   total_claims DESC;


SELECT
    specialty_description
FROM 
    prescriber
LEFT JOIN
    prescription USING (npi)
GROUP BY
	specialty_description
HAVING SUM
    (total_claim_count) IS NULL;


SELECT
	specialty_description,
	ROUND(SUM(CASE WHEN opioid_drug_flag = 'Y' 
	THEN total_claim_count END)/SUM(total_claim_count)*100, 2) 
	AS percent_opioids
FROM 
	prescriber
INNER JOIN
	prescription USING (npi)
INNER JOIN 
	drug USING (drug_name)
GROUP BY 
	specialty_description	
ORDER BY
	percent_opioids DESC NULLS LAST;

	
SELECT 
    generic_name,
	SUM(total_drug_cost)::money AS total_cost 
FROM 
	prescription
INNER JOIN
	drug USING (drug_name)
GROUP BY 
    generic_name
ORDER BY
    total_cost DESC;


SELECT 
    