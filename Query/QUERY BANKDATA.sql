SELECT * FROM bankdata

SELECT loan_status,
COUNT(id) AS Loancount,
SUM(total_payment) AS TotalPayment,
SUM(loan_amount) AS TotFundedAmt,
AVG(int_rate * 100) AS IntRate,
AVG(dti * 100) AS DTI
FROM bankdata
GROUP BY loan_status

A. BANK LOAN REPORT | SUMMARY
/*KPIS*/
/* 1. Total Applications*/
SELECT COUNT(id) AS Total_Applications FROM bankdata

/* 2. MTD Loan Applications */
SELECT COUNT(id) AS Total_MTDApplications FROM bankdata
WHERE MONTH(issue_date) = 12

/* 3. PMTD(Previous MTD) Loan Applications */
SELECT COUNT(id) AS Total_MTDApplications FROM bankdata
WHERE MONTH(issue_date) = 11

/* 4. Total_Funded_Amt*/
SELECT SUM(loan_amount) AS TotFundedAmt FROM bankdata

/* 5. MTD Total_Funded_Amt*/
SELECT SUM(loan_amount) AS TotFundedAmt FROM bankdata
WHERE MONTH(issue_date) = 12

/* 6. PMTD Total_Funded_Amt*/
SELECT SUM(loan_amount) AS TotFundedAmt FROM bankdata
WHERE MONTH(issue_date) = 11

/* 7. Total Amount Received */
SELECT SUM(total_payment) AS Total_Amt_Collected FROM bankdata

/* 8. MTD Total Amount Received */
SELECT SUM(total_payment) AS Total_Amt_Collected FROM bankdata
WHERE MONTH(issue_date) = 12

/* 9. PMTD Total Amount Received */
SELECT SUM(total_payment) AS Total_Amt_Collected FROM bankdata
WHERE MONTH(issue_date) = 11

/* 10. Average Interest Rate*/
SELECT AVG(int_rate * 100) As AvgIntRate FROM bankdata

/* 11. MTD Average Interest Rate */
SELECT AVG(int_rate * 100) As AvgIntRate FROM bankdata
WHERE MONTH(issue_date) = 12

/* 12. PMTD Average Interest Rate */
SELECT AVG(int_rate * 100) As AvgIntRate FROM bankdata
WHERE MONTH(issue_date) = 11

/* 13. Avg DTI */
SELECT AVG(dti * 100) AS AvgDTI FROM bankdata

/* 14. MTD Avg DTI */
SELECT AVG(dti * 100) AS AvgDTI FROM bankdata
WHERE MONTH(issue_date) = 12

/* 15. PMTD Avg DTI */
SELECT AVG(dti * 100) AS AvgDTI FROM bankdata
WHERE MONTH(issue_date) = 11

/* 16. Good Loan Percentage */ 
SELECT DISTINCT loan_status FROM bankdata
SELECT (COUNT(CASE 
				WHEN loan_status = 'Fully Paid' OR loan_status = 'Current'
				THEN id 
			   END)  * 100.0) / COUNT(id) AS Good_Loan_Percentage
FROM bankdata

/* 17. Good Loan Applications */
SELECT COUNT(id) AS Good_Loan_Applications FROM bankdata
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* 18. Good Loan Funded Amount */
SELECT SUM(loan_amount) AS Good_Funded_Amt FROM bankdata
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* 19. Good Loan Amount Received */
SELECT SUM(total_payment) AS Good_Loan_Amt_Received FROM bankdata
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* 20. Bad Loan Percentage */
SELECT (COUNT(CASE 
				WHEN loan_status = 'Charged off' 
				THEN id 
				END) * 100.0) / COUNT(id) AS Bad_Loan_Percentage
FROM bankdata

/* 21. Bad Loan Applications */
SELECT COUNT(id) FROM bankdata
WHERE loan_status = 'Charged off'

/* 22. Bad Loan Funded Amount */ 
SELECT SUM(loan_amount) AS Bad_Funded_Amt FROM bankdata
WHERE loan_status = 'Charged off'

/* 23. Bad Loan Amount Received */
SELECT SUM(total_payment) FROM bankdata
WHERE loan_status = 'Charged off'

/* LOAN STATUS */ 

/* 24. Loan Status */
SELECT
        loan_status,
        COUNT(id) AS Loan_Count,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bankdata
    GROUP BY
        loan_status
        
/* 25. Last Month Loan Status */
SELECT 
       loan_status,
       SUM(total_payment) AS MTD_Total_Amt_Received,
       SUM(loan_amount) AS MTD_Total_Funded_Amt
FROM bankdata
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

B. BANK LOAN REPORT | OVERVIEW

/*MONTH*/
SELECT 
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH,issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bankdata
GROUP BY MONTH(issue_date), DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)

/*STATE*/
SELECT * FROM bankdata
SELECT
    address_state AS State,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bankdata
GROUP BY address_state
ORDER BY address_state

/*Term*/
SELECT
    term AS Term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bankdata
GROUP BY term
ORDER BY term

/*Emp Length*/
SELECT
    emp_length AS Employee_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bankdata
GROUP BY emp_length
ORDER BY emp_length

/*Purpose*/
SELECT
    purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bankdata
GROUP BY purpose
ORDER BY purpose

/*Home Ownership*/
SELECT 
    home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bankdata
GROUP BY home_ownership
ORDER BY home_ownership


SELECT * FROM bankdata
/* MTD Loan Applications */
ALTER TABLE bankdata ADD MTD_Loan_Applications INT
UPDATE bankdata SET MTD_Loan_Applications = (SELECT COUNT(id) AS Total_Applications FROM bankdata
WHERE MONTH(issue_date) = 12)

/* PMTD Loan Applications */
ALTER TABLE bankdata ADD PMTD_Loan_Applications INT
UPDATE bankdata SET PMTD_Loan_Applications = (SELECT COUNT(id) AS Total_Applications FROM bankdata
WHERE MONTH(issue_date) = 11)

/* MTD Total Funded Amount */
ALTER TABLE bankdata ADD MTD_Total_Funded_Amount INT
UPDATE bankdata SET MTD_Total_Funded_Amount = (SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bankdata
WHERE MONTH(issue_date) = 12)
SELECT * FROM bankdata

/*PMTD Total Funded Amount */
ALTER TABLE bankdata ADD PMTD_Total_Funded_Amount INT 
UPDATE bankdata SET PMTD_Total_Funded_Amount = (SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bankdata
WHERE MONTH(issue_date) = 11)

/*MTD TOTAL AMOUNT RECEIVED */
ALTER TABLE bankdata ADD MTD_Total_Amount_Received INT 
UPDATE bankdata SET MTD_Total_Amount_Received = ( SELECT SUM(total_payment) AS Total_Amount_Collected FROM bankdata
WHERE MONTH(issue_date) = 12)

/* PMTD TOTAL AMOUNT RECEIVED */
ALTER TABLE bankdata ADD PMTD_Total_Amount_Received INT 
UPDATE bankdata SET PMTD_Total_Amount_Received = ( SELECT SUM(total_payment) AS Total_Amount_Collected FROM bankdata
WHERE MONTH(issue_date) = 11)


