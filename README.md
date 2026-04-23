# 📊 Luxury Housing Sales Analysis – Bengaluru

## 🚀 Project Overview
This project focuses on building an end-to-end real estate analytics solution using Python, SQL, and Power BI. The dataset was cleaned and transformed using Python, stored in a SQL database, and visualized using Power BI dashboards.

---

## 🎯 Problem Statement
- Clean raw data using Python  
- Load into SQL database  
- Build Power BI dashboards  

---

## 🛠️ Tech Stack
- Python (Pandas, NumPy)  
- MySQL  
- Power BI  
- Git & GitHub  

---

## 📂 Dataset
- Shape: (101000, 18)  
- Includes housing and transaction data  

---

## ⚙️ Feature Engineering
- Booking_Status → Derived from Transaction_Type  
- Booking_Flag → Binary (1/0)  
- Price_per_Sqft → Calculated  
- Quarter_Number → Extracted  

---

## 🗄️ SQL
- Database creation  
- Table schema  
- Business queries  

📂 Full queries: `sql/luxury_housing_queries.sql`

---

## 📊 Power BI Dashboard

### DAX Measures
```DAX
Booking_Count = COUNTROWS(luxury_housing)
Successful_Bookings = SUM(luxury_housing[Booking_Flag])
Booking_Conversion_Rate = DIVIDE([Successful_Bookings], [Booking_Count], 0)
Project_Count = DISTINCTCOUNT(luxury_housing[Project_Name])