import os
from dotenv import load_dotenv
import pandas as pd
import mysql.connector
from pathlib import Path

# Load env variables
load_dotenv()

host = os.getenv("MYSQL_HOST")
user = os.getenv("MYSQL_USER")
password = os.getenv("MYSQL_PASSWORD")
database = os.getenv("MYSQL_DATABASE")

# File path
BASE_DIR = Path(__file__).resolve().parent.parent
FILE_PATH = BASE_DIR / "notebooks" / "cleaned_luxury_housing.csv"

# Load CSV
df = pd.read_csv(FILE_PATH)

# Convert date
df["Purchase_Quarter"] = pd.to_datetime(df["Purchase_Quarter"]).dt.date

# Connect to MySQL
conn = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

cursor = conn.cursor()

# Insert query
insert_query = """
INSERT INTO luxury_housing (
    Property_ID, Micro_Market, Project_Name, Developer_Name,
    Unit_Size_Sqft, Configuration, Ticket_Price_Cr, Transaction_Type,
    Buyer_Type, Purchase_Quarter, Connectivity_Score, Amenity_Score,
    Possession_Status, Sales_Channel, NRI_Buyer, Locality_Infra_Score,
    Avg_Traffic_Time_Min, Price_per_Sqft, Quarter_Number,
    Booking_Flag, Booking_Status
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

data = [tuple(row) for row in df.itertuples(index=False, name=None)]

# Insert data in batches (safe way)
batch_size = 10000

for i in range(0, len(data), batch_size):
    cursor.executemany(insert_query, data[i:i+batch_size])
    conn.commit()

print("Data inserted successfully!")

cursor.close()
conn.close()