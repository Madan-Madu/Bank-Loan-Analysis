
-- Total Loan Applications

use banking_case;
SELECT * FROM bank_loan_data;

-- MTD Loan Applications

select count(id) as Total_loan_application from bank_loan_data; 

-- PMTD Loan Applications

SELECT COUNT(id) AS MTD_Total_loan_application
FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

SELECT COUNT(id) AS MTD_Total_loan_application
FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Total Funded amount

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

--  MTD Total Funded Amount

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12;

-- PMTD Total Funded Amount

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11;

-- Total Amount Received

SELECT SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECEIVED FROM bank_loan_data;

-- MTD Total Amount Received

SELECT SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECEIVED FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

--  PMTD Total Amount Received

SELECT SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECEIVED FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Average Interest Rate

SELECT round(AVG(int_rate),4)*100 AS Avg_Int_Rate FROM bank_loan_data;

-- MTD Average Interest

SELECT AVG(int_rate) *100 AS Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- PMTD Average Interest

SELECT AVG(COALESCE(int_rate, 0)) * 100 AS PMTD_Avg_Int_Rate 
FROM bank_loan_data 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11 
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Avg DTI

SELECT round(AVG(dti),3)*100 AS Avg_DTI FROM bank_loan_data;

-- MTD Avg DTI

SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- PMTD Avg DTI


SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Good Loan Percentage
        
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Good Loan Applications

SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received

SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Bad Loan Percentage

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Bad Loan Applications

SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount

SELECT SUM(LOAN_AMOUNT) AS Bad_loan_Funded_Amount From bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received

SELECT SUM(total_payment) AS Bad_Loan_Amount_Received From bank_loan_data
WHERE loan_status = 'Charged Off';

-- LOAN STATUS

SELECT
		LOAN_STATUS,
        COUNT(ID) AS Total_loan_applications,
        sum(total_payment) as Total_Payment_Received,
        SUM(loan_amount) as Total_funded_amount,
        AVG(INT_rate * 100) as Interest_rate,
        avg(dti * 100) as DTI
FROM bank_loan_data
group by loan_status
ORDER BY loan_status DESC;

-- 

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
group by loan_status;

-- STATE

SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

-- Loan Term Analysis
SELECT  
    term AS Term,  
    COUNT(id) AS Total_Loan_Applications,  
    SUM(loan_amount) AS Total_Funded_Amount,  
    SUM(total_payment) AS Total_Amount_Received  
FROM bank_loan_data  
GROUP BY term  
ORDER BY term;  

-- Employee Length Analysis

SELECT  
    emp_length AS Employee_Length,  
    COUNT(id) AS Total_Loan_Applications,  
    SUM(loan_amount) AS Total_Funded_Amount,  
    SUM(total_payment) AS Total_Amount_Received  
FROM bank_loan_data  
GROUP BY emp_length  
ORDER BY emp_length;

-- PURPOSE

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose desc;

-- HOME OWNERSHIP

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
where grade = 'A' and address_state = 'CA'
GROUP BY home_ownership
ORDER BY count(id) desc;




