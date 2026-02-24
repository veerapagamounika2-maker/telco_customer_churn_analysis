CREATE DATABASE CHURN_ANALYSIS

SELECT * FROM dbo.telco

select count(*) as total_rows
from telco

select TOP  10 *
from telco


SELECT Gender, Count(*) as TotalCount,
Count(*) * 1.0 / (Select Count(*) from telco)  as Percentage
from telco
Group by Gender;


SELECT Contract, Count(Contract) as TotalCount,
Count(Contract) *  1.0 / (Select Count(Contract) from telco)  as Percentage
from telco
Group by Contract

  
                                                               "null values"
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_totalcharges
FROM telco;

                                                                   "DELETE NULLS"
DELETE FROM telco
WHERE TotalCharges IS NULL;

"DELETE NULLS"
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_totalcharges
FROM telco;
                                 

SELECT COUNT(*) 
FROM telco
WHERE TotalCharges IS NULL;

"CHECK TARGET VARIABLE"

SELECT Churn,
COUNT(*) AS total,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM telco
GROUP BY Churn;

                     "churn rate"


SELECT
    COUNT(*) AS total_customers,

    SUM(CAST(Churn AS INT)) AS churned_customers,

    ROUND(
        SUM(CAST(Churn AS INT)) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco;

                                                   "leaving the by contract"
SELECT
    Contract,
    COUNT(*) AS total,
    SUM(CAST(Churn AS INT)) AS churned,
    ROUND(SUM(CAST(Churn AS INT))*100.0/COUNT(*),2) AS churn_rate
FROM telco
GROUP BY Contract;


                                                        "tenure by age"


SELECT
    CASE
        WHEN tenure < 6 THEN '0-6 months'
        WHEN tenure < 12 THEN '6-12 months'
        ELSE '1+ year'
    END AS tenure_group,

    COUNT(*) AS total,
    SUM(CAST(Churn AS INT)) AS churned,
    ROUND(SUM(CAST(Churn AS INT))*100.0/COUNT(*),2) AS churn_rate
FROM telco
GROUP BY
    CASE
        WHEN tenure < 6 THEN '0-6 months'
        WHEN tenure < 12 THEN '6-12 months'
        ELSE '1+ year'
    END;

	                  "by payment method"




SELECT
    PaymentMethod,
    COUNT(*) AS total,
    SUM(CAST(Churn AS INT)) AS churned,
    ROUND(SUM(CAST(Churn AS INT))*100.0/COUNT(*),2) AS churn_rate
FROM telco
GROUP BY PaymentMethod;



                     "by internet service"





SELECT
    InternetService,
    COUNT(*) AS total,
    SUM(CAST(Churn AS INT)) AS churned,
    ROUND(SUM(CAST(Churn AS INT))*100.0/COUNT(*),2) AS churn_rate
FROM telco
GROUP BY InternetService;



SELECT TOP 20 *
FROM telco
WHERE Churn = 1
AND Contract = 'Month-to-month'
AND tenure < 6
ORDER BY TotalCharges DESC;