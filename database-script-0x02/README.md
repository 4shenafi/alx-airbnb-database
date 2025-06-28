# Airbnb-clone Database Seed Data

This repository (`alx-airbnb-database`) contains seed data for an Airbnb-clone database in the `database-script-0x02` directory.  
The seed data populates the database with realistic sample data for testing and development, aligning with the schema defined in `database-script-0x01`.

---

## Directory Structure

```
database-script-0x02/
  ├── seed.sql    # SQL script to insert sample data into the database tables
  └── README.md   # This file, documenting the seed data and its usage
```

---

## Seed Data Overview

The `seed.sql` file populates the following tables with sample data:

- **User:** 5 users (2 hosts, 2 guests, 1 admin)  
  _Example:_ Alice Smith (host), Carol Williams (guest), Emma Davis (admin)
- **Location:** 4 locations across different cities/countries  
  _Example:_ New York, NY, USA; Toronto, ON, Canada
- **Property:** 5 properties listed by hosts, tied to locations  
  _Example:_ "Cozy NYC Loft" ($150/night), "Sydney Beach House" ($250/night)
- **Booking:** 6 bookings by guests for properties, with varying statuses (confirmed, pending, canceled)  
  _Example:_ Carol books NYC Loft for July 1-3, 2025
- **Payment:** 6 payments tied to bookings, using different payment methods  
  _Example:_ $300 payment for a 2-night booking at NYC Loft
- **Review:** 4 reviews by guests for properties, with ratings and comments  
  _Example:_ Carol rates NYC Loft 5 stars with "Amazing stay!"
- **Message:** 5 messages between users (e.g., guest-host communication)  
  _Example:_ Carol asks Alice about loft availability

---

## Data Characteristics

- **Realism:**  
  Reflects real-world usage with multiple users, properties in different locations, bookings with realistic dates and prices, and related payments, reviews, and messages.
- **Consistency:**  
  Adheres to schema constraints (e.g., foreign keys, unique constraints, rating range 1-5, `end_date > start_date`).
- **Calculations:**  
  Payment amounts align with booking durations and property prices (e.g., 2 nights at $150/night = $300).
- **UUIDs:**  
  Hardcoded for simplicity; in production, use a UUID generator.

---

## Schema Reference

The seed data is designed for the schema defined in `database-script-0x01/schema.sql`, which is in **Third Normal Form (3NF)**.  
**Key schema features:**

- **Tables:** User, Location, Property, Booking, Payment, Review, Message
- **Constraints:**  
  - Unique `User.email`  
  - Unique `Review(property_id, user_id)`  
  - Foreign keys with `ON DELETE CASCADE` (except `Property.location_id` with `RESTRICT`)  
  - Checks (e.g., `Booking.end_date > start_date`)
- **Indexes:**  
  On primary keys, foreign keys, and `User.email` for performance

---

## ER Diagram

The ER diagram visualizes the schema and relationships (created with a tool like Draw.io).  
It shows entities, attributes, and relationships (e.g., 1:N for User to Property).

---

## Usage

1. **Ensure the database schema is created** using `database-script-0x01/schema.sql`.
2. **Execute `seed.sql`** in a SQL database (e.g., MySQL, PostgreSQL) to populate the tables:

   ```sh
   # PostgreSQL
   psql -U username -d alx_airbnb_database -f seed.sql

   # MySQL
   mysql -u username -p alx_airbnb_database < seed.sql
   ```

3. **Verify data integrity** (e.g., foreign key relationships, unique constraints).
4. **Use the data** for testing application features like booking, payment processing, or messaging.

---

## Notes

- **Dependencies:** The schema must be created before running `seed.sql` to satisfy foreign key constraints.
- **UUID Support:** Ensure the database supports UUIDs (e.g., `uuid-ossp` extension in PostgreSQL or `CHAR(36)` in MySQL).
- **Scalability:** The sample data is small for testing; scale up as needed for larger datasets.
