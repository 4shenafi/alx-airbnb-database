# Airbnb-clone  Database Schema

This repository (`alx-airbnb-database`) contains the database schema for an Airbnb-clone , defined in the `database-script-0x01` directory.  
The schema supports user management, property listings, bookings, payments, reviews, and messaging, and is designed to be in **Third Normal Form (3NF)** for minimal redundancy and data integrity.

---


## Schema Overview

### Entities and Attributes

#### **User**  
_Represents platform users (guests, hosts, admins)._

| Attribute       | Type                 | Constraints                |
|-----------------|---------------------|----------------------------|
| `user_id`       | UUID                | Primary Key                |
| `first_name`    | VARCHAR(50)         | NOT NULL                   |
| `last_name`     | VARCHAR(50)         | NOT NULL                   |
| `email`         | VARCHAR(100)        | UNIQUE, NOT NULL           |
| `password_hash` | VARCHAR(255)        | NOT NULL                   |
| `phone_number`  | VARCHAR(20)         | NULL                       |
| `role`          | ENUM                | (`guest`, `host`, `admin`) |
| `created_at`    | TIMESTAMP           | DEFAULT CURRENT_TIMESTAMP  |

---

#### **Location**  
_Stores normalized location data for properties._

| Attribute        | Type           | Constraints                |
|------------------|----------------|----------------------------|
| `location_id`    | UUID           | Primary Key                |
| `street_address` | VARCHAR(100)   | NOT NULL                   |
| `city`           | VARCHAR(50)    | NOT NULL                   |
| `state`          | VARCHAR(50)    | NULL                       |
| `country`        | VARCHAR(50)    | NOT NULL                   |
| `postal_code`    | VARCHAR(20)    | NULL                       |

---

#### **Property**  
_Represents rentable properties._

| Attribute        | Type           | Constraints                                |
|------------------|----------------|--------------------------------------------|
| `property_id`    | UUID           | Primary Key                                |
| `host_id`        | UUID           | Foreign Key → `User.user_id`               |
| `location_id`    | UUID           | Foreign Key → `Location.location_id`       |
| `name`           | VARCHAR(100)   | NOT NULL                                   |
| `description`    | TEXT           | NOT NULL                                   |
| `pricepernight`  | DECIMAL(10,2)  | NOT NULL                                   |
| `created_at`     | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP                  |
| `updated_at`     | TIMESTAMP      | ON UPDATE CURRENT_TIMESTAMP                |

---

#### **Booking**  
_Manages property reservations._

| Attribute      | Type           | Constraints                                |
|----------------|----------------|--------------------------------------------|
| `booking_id`   | UUID           | Primary Key                                |
| `property_id`  | UUID           | Foreign Key → `Property.property_id`       |
| `user_id`      | UUID           | Foreign Key → `User.user_id`               |
| `start_date`   | DATE           | NOT NULL                                   |
| `end_date`     | DATE           | NOT NULL                                   |
| `status`       | ENUM           | (`pending`, `confirmed`, `canceled`)       |
| `created_at`   | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP                  |

---

#### **Payment**  
_Records booking payments._

| Attribute        | Type           | Constraints                                |
|------------------|----------------|--------------------------------------------|
| `payment_id`     | UUID           | Primary Key                                |
| `booking_id`     | UUID           | Foreign Key → `Booking.booking_id`         |
| `amount`         | DECIMAL(10,2)  | NOT NULL                                   |
| `payment_date`   | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP                  |
| `payment_method` | ENUM           | (`credit_card`, `paypal`, `stripe`)        |

---

#### **Review**  
_Stores property reviews._

| Attribute      | Type           | Constraints                                |
|----------------|----------------|--------------------------------------------|
| `review_id`    | UUID           | Primary Key                                |
| `property_id`  | UUID           | Foreign Key → `Property.property_id`       |
| `user_id`      | UUID           | Foreign Key → `User.user_id`               |
| `rating`       | INTEGER        | (1-5), NOT NULL                            |
| `comment`      | TEXT           | NOT NULL                                   |
| `created_at`   | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP                  |

---

#### **Message**  
_Facilitates user communication._

| Attribute      | Type           | Constraints                                |
|----------------|----------------|--------------------------------------------|
| `message_id`   | UUID           | Primary Key                                |
| `sender_id`    | UUID           | Foreign Key → `User.user_id`               |
| `recipient_id` | UUID           | Foreign Key → `User.user_id`               |
| `message_body` | TEXT           | NOT NULL                                   |
| `sent_at`      | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP                  |

---

## Constraints

- **Unique:**  
  - `User.email`  
  - `Review(property_id, user_id)` (prevents duplicate emails and multiple reviews per user per property)
- **Foreign Keys:**  
  - Enforce referential integrity (e.g., `Property.host_id` references `User.user_id`)
- **Check:**  
  - `Booking.end_date > start_date`  
  - `Review.rating` between 1 and 5
- **On Delete:**  
  - `CASCADE` for most foreign keys (e.g., deleting a user removes their properties)  
  - `RESTRICT` for `Property.location_id` to prevent orphaned properties

---

## Indexes

- **Primary Keys:** Automatically indexed (`user_id`, `property_id`, etc.)
- **Additional Indexes:**
  - `User.email`: Speeds up login and user lookups
  - `Property.host_id`, `Property.location_id`: Optimizes host and location queries
  - `Booking.property_id`, `Booking.user_id`: Enhances booking retrieval
  - `Payment.booking_id`: Speeds up payment queries
  - `Review.property_id`, `Review.user_id`: Optimizes review lookups
  - `Message.sender_id`, `Message.recipient_id`: Improves message retrieval

---

## Normalization

The schema is in **3NF**:

- **Location Table:** Normalizes property location data to avoid redundancy.
- **Booking:** Excludes `total_price` to eliminate transitive dependencies; calculate as  
  `DATEDIFF(end_date, start_date) * Property.pricepernight` in queries.
- **Review:** `UNIQUE` constraint on (`property_id`, `user_id`) ensures data integrity.

