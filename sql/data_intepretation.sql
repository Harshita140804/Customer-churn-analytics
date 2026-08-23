
CREATE TABLE telco_churn (
    CustomerID VARCHAR(50),
    `Count` INT,
    Country VARCHAR(100),
    State VARCHAR(100),
    City VARCHAR(100),
    `Zip Code` INT,
    `Lat Long` VARCHAR(100),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6),
    Gender VARCHAR(20),
    `Senior Citizen` VARCHAR(10),
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    `Tenure Months` INT,
    `Phone Service` VARCHAR(20),
    `Multiple Lines` VARCHAR(30),
    `Internet Service` VARCHAR(30),
    `Online Security` VARCHAR(30),
    `Online Backup` VARCHAR(30),
    `Device Protection` VARCHAR(30),
    `Tech Support` VARCHAR(30),
    `Streaming TV` VARCHAR(30),
    `Streaming Movies` VARCHAR(30),
    Contract VARCHAR(30),
    `Paperless Billing` VARCHAR(20),
    `Payment Method` VARCHAR(50),
    `Monthly Charges` DECIMAL(10,2),
    `Total Charges` VARCHAR(30),
    `Churn Label` VARCHAR(10),
    `Churn Value` INT,
    `Churn Score` INT,
    CLTV INT,
    `Churn Reason` VARCHAR(255)
);

DESCRIBE telco_churn;
LOAD DATA LOCAL INFILE 'E:/python/Project/Telco_customer_churn.csv'
INTO TABLE telco_churn
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS Total_Rows
FROM telco_churn;

SELECT *
FROM telco_churn
LIMIT 5;

SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM telco_churn;

SELECT
    `Churn Label`,
    COUNT(*) AS Customer_Count
FROM telco_churn
GROUP BY `Churn Label`;

SELECT
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Gender
ORDER BY Churn_Rate_Percent DESC;

SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Contract
ORDER BY Churn_Rate_Percent DESC;

SELECT
    `Internet Service`,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY `Internet Service`
ORDER BY Churn_Rate_Percent DESC;

SELECT
    `Payment Method`,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY `Payment Method`
ORDER BY Churn_Rate_Percent DESC;

SELECT
    CASE
        WHEN `Tenure Months` <= 12 THEN 'Short-term'
        WHEN `Tenure Months` <= 36 THEN 'Mid-term'
        ELSE 'Long-term'
    END AS Tenure_Segment,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Tenure_Segment
ORDER BY Churn_Rate_Percent DESC;

SELECT
    CASE
        WHEN `Monthly Charges` < 40 THEN 'Low'
        WHEN `Monthly Charges` < 80 THEN 'Medium'
        ELSE 'High'
    END AS Monthly_Charge_Segment,
    
    COUNT(*) AS Total_Customers,
    
    SUM(
        CASE 
            WHEN `Churn Label` = 'Yes' THEN 1 
            ELSE 0 
        END
    ) AS Churned_Customers,
    
    ROUND(
        SUM(
            CASE 
                WHEN `Churn Label` = 'Yes' THEN 1 
                ELSE 0 
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent

FROM telco_churn

GROUP BY Monthly_Charge_Segment

ORDER BY Churn_Rate_Percent DESC;




