--OBFUSCATE CCNUMBER : PROBLEM
CREATE VIEW v_PublicPaymentInfo AS
SELECT 
CustomerID,
FirstName,
LastName,
CONCAT(LEFT(PaymentNumber, 6), REPLICATE('*', LEN(PaymentNumber) - 6)) AS PaymentCard
FROM Customers
