CREATE DATABASE luxury_housing_db;
USE luxury_housing_db;

CREATE TABLE luxury_housing (
    Property_ID VARCHAR(20),
    Micro_Market VARCHAR(100),
    Project_Name VARCHAR(100),
    Developer_Name VARCHAR(100),
    Unit_Size_Sqft FLOAT,
    Configuration VARCHAR(20),
    Ticket_Price_Cr FLOAT,
    Transaction_Type VARCHAR(20),
    Buyer_Type VARCHAR(50),
    Purchase_Quarter DATE,
    Connectivity_Score FLOAT,
    Amenity_Score FLOAT,
    Possession_Status VARCHAR(50),
    Sales_Channel VARCHAR(50),
    NRI_Buyer VARCHAR(10),
    Locality_Infra_Score FLOAT,
    Avg_Traffic_Time_Min INT,
    Price_per_Sqft FLOAT,
    Quarter_Number INT,
    Booking_Flag INT,
    Booking_Status VARCHAR(20)
);

# 1. Market Trends
SELECT 
    Quarter_Number,
    Micro_Market,
    COUNT(*) AS Booking_Count
FROM luxury_housing
WHERE Booking_Flag = 1
GROUP BY Quarter_Number, Micro_Market
ORDER BY Quarter_Number, Micro_Market;

# 2. Builder Performance
SELECT 
    Developer_Name,
    SUM(Ticket_Price_Cr) AS Total_Ticket_Sales,
    AVG(Ticket_Price_Cr) AS Avg_Ticket_Size
FROM luxury_housing
GROUP BY Developer_Name
ORDER BY Total_Ticket_Sales DESC;

# 3. Amenity Impact
SELECT 
    ROUND(Amenity_Score, 1) AS Amenity_Score,
    AVG(Booking_Flag) AS Booking_Conversion_Rate,
    COUNT(*) AS Project_Count
FROM luxury_housing
GROUP BY ROUND(Amenity_Score, 1)
ORDER BY Amenity_Score;

# 4. Booking Conversion by Micro-Market
SELECT 
    Micro_Market,
    SUM(Booking_Flag) AS Total_Booked,
    COUNT(*) AS Total_Records,
    ROUND(SUM(Booking_Flag) * 100.0 / COUNT(*), 2) AS Conversion_Rate
FROM luxury_housing
GROUP BY Micro_Market
ORDER BY Conversion_Rate DESC;

# 5. Configuration_Demand
SELECT 
    Configuration,
    COUNT(*) AS Booking_Count
FROM luxury_housing
WHERE Booking_Flag = 1
GROUP BY Configuration
ORDER BY Booking_Count DESC;

# 6. Sales Channel Efficiency
SELECT 
    Sales_Channel,
    SUM(Booking_Flag) AS Successful_Bookings,
    COUNT(*) AS Total_Records,
    ROUND(SUM(Booking_Flag) * 100.0 / COUNT(*), 2) AS Conversion_Rate
FROM luxury_housing
GROUP BY Sales_Channel
ORDER BY Conversion_Rate DESC;

# 7. Quarterly Builder Contribution
SELECT 
    Developer_Name,
    Quarter_Number,
    SUM(Ticket_Price_Cr) AS Total_Revenue
FROM luxury_housing
GROUP BY Developer_Name, Quarter_Number
ORDER BY Quarter_Number, Total_Revenue DESC;

# 8. Possession Status Analysis
SELECT 
    Possession_Status,
    Buyer_Type,
    Booking_Status,
    COUNT(*) AS Record_Count
FROM luxury_housing
GROUP BY Possession_Status, Buyer_Type, Booking_Status
ORDER BY Possession_Status, Buyer_Type;

# 9. Geographical Insights
SELECT 
    Micro_Market,
    COUNT(DISTINCT Property_ID) AS Project_Count
FROM luxury_housing
GROUP BY Micro_Market
ORDER BY Project_Count DESC;

# 10. Top Performers
SELECT 
    Developer_Name,
    SUM(Ticket_Price_Cr) AS Total_Revenue,
    SUM(Booking_Flag) AS Successful_Bookings,
    ROUND(SUM(Booking_Flag) * 100.0 / COUNT(*), 2) AS Conversion_Rate
FROM luxury_housing
GROUP BY Developer_Name
ORDER BY Total_Revenue DESC
LIMIT 5;