# Database Normalization for Airbnb-clone Platform

This document reviews the database schema for an Airbnb-clone platform, evaluates it against normalization principles, and adjusts it to ensure **Third Normal Form (3NF)** compliance.  
It includes the normalized schema, an explanation of normalization steps, and a reference to the ER diagram.

---

## Original Schema

### Entities and Attributes

#### **User**

| Attribute       | Type                                   | Constraints                        |
|-----------------|----------------------------------------|------------------------------------|
| `user_id`       | UUID                                   | Primary Key, Indexed               |
| `first_name`    | VARCHAR                                | NOT NULL                           |
| `last_name`     | VARCHAR                                | NOT NULL                           |
| `email`         | VARCHAR                                | UNIQUE, NOT NULL                   |
| `password_hash` | VARCHAR                                | NOT NULL                           |
| `phone_number`  | VARCHAR                                | NULL                               |
| `role`          | ENUM (`guest`, `host`, `admin`)        | NOT NULL                           |
| `created_at`    | TIMESTAMP                              | DEFAULT CURRENT_TIMESTAMP          |

---

#### **Property**

| Attribute        | Type         | Constraints                                 |
|------------------|--------------|---------------------------------------------|
| `property_id`    | UUID         | Primary Key, Indexed                        |
| `host_id`        | UUID         | Foreign Key → `User.user_id`                |
| `name`           | VARCHAR      | NOT NULL                                    |
| `description`    | TEXT         | NOT NULL                                    |
| `location`       | VARCHAR      | NOT NULL                                    |
| `pricepernight`  | DECIMAL      | NOT NULL                                    |
| `created_at`     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                   |
| `updated_at`     | TIMESTAMP    | ON UPDATE CURRENT_TIMESTAMP                 |

---

#### **Booking**

| Attribute      | Type      | Constraints                                 |
|----------------|-----------|---------------------------------------------|
| `booking_id`   | UUID      | Primary Key, Indexed                        |
| `property_id`  | UUID      | Foreign Key → `Property.property_id`        |
| `user_id`      | UUID      | Foreign Key → `User.user_id`                |
| `start_date`   | DATE      | NOT NULL                                    |
| `end_date`     | DATE      | NOT NULL                                    |
| `total_price`  | DECIMAL   | NOT NULL                                    |
| `status`       | ENUM (`pending`, `confirmed`, `canceled`) | NOT NULL   |
| `created_at`   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |

---

#### **Payment**

| Attribute        | Type      | Constraints                                 |
|------------------|-----------|---------------------------------------------|
| `payment_id`     | UUID      | Primary Key, Indexed                        |
| `booking_id`     | UUID      | Foreign Key → `Booking.booking_id`          |
| `amount`         | DECIMAL   | NOT NULL                                    |
| `payment_date`   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |
| `payment_method` | ENUM (`credit_card`, `paypal`, `stripe`) | NOT NULL   |

---

#### **Review**

| Attribute      | Type      | Constraints                                 |
|----------------|-----------|---------------------------------------------|
| `review_id`    | UUID      | Primary Key, Indexed                        |
| `property_id`  | UUID      | Foreign Key → `Property.property_id`        |
| `user_id`      | UUID      | Foreign Key → `User.user_id`                |
| `rating`       | INTEGER   | CHECK (`rating` >= 1 AND `rating` <= 5), NOT NULL |
| `comment`      | TEXT      | NOT NULL                                    |
| `created_at`   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |

---

#### **Message**

| Attribute      | Type      | Constraints                                 |
|----------------|-----------|---------------------------------------------|
| `message_id`   | UUID      | Primary Key, Indexed                        |
| `sender_id`    | UUID      | Foreign Key → `User.user_id`                |
| `recipient_id` | UUID      | Foreign Key → `User.user_id`                |
| `message_body` | TEXT      | NOT NULL                                    |
| `sent_at`      | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |

---

### Relationships

- **User to Property:** One-to-Many (`host_id` references `User.user_id`)
- **User to Booking:** One-to-Many (`user_id` references `User.user_id`)
- **Property to Booking:** One-to-Many (`property_id` references `Property.property_id`)
- **Booking to Payment:** One-to-One (`booking_id` references `Booking.booking_id`)
- **User to Review:** One-to-Many (`user_id` references `User.user_id`)
- **Property to Review:** One-to-Many (`property_id` references `Property.property_id`)
- **User to Message (Sender):** One-to-Many (`sender_id` references `User.user_id`)
- **User to Message (Recipient):** One-to-Many (`recipient_id` references `User.user_id`)

---

## Normalization Review

Normalization ensures a database is free of redundancy and anomalies, adhering to:

- **First Normal Form (1NF)**
- **Second Normal Form (2NF)**
- **Third Normal Form (3NF)**

### **First Normal Form (1NF)**

- **Requirement:** All attributes must be atomic, and each table must have a primary key.
- **Evaluation:**  
  - All attributes are atomic (e.g., `email`, `location`, `rating` are single-valued).
  - Each table has a primary key (all UUIDs).
  - No repeating groups or arrays.

**Status:** ✅ The schema is already in 1NF.

---

### **Second Normal Form (2NF)**

- **Requirement:** Must be in 1NF, and all non-key attributes must depend on the entire primary key (no partial dependencies in composite keys).
- **Evaluation:**  
  - All tables use a single-column primary key (UUID), so partial dependencies are not applicable.
  - Non-key attributes fully depend on their respective primary keys.

**Status:** ✅ The schema is in 2NF.

---

### **Third Normal Form (3NF)**

- **Requirement:** Must be in 2NF, and no non-key attribute depends on another non-key attribute (no transitive dependencies).
- **Evaluation:**  
  - **User:** All attributes depend only on `user_id`. No transitive dependencies.
  - **Property:** Attributes like `name`, `description`, `location`, `pricepernight` depend on `property_id`. However, `location` as a single VARCHAR could introduce redundancy if it stores complex data (e.g., city, state, country).
  - **Booking:** `total_price` might depend on `start_date`, `end_date`, and `Property.pricepernight`, suggesting a potential transitive dependency. Ideally, `total_price` should be calculated dynamically or validated.
  - **Payment, Review, Message:** Attributes depend only on their primary keys.

#### **Issues Identified**
- **Property.location:** Storing as a single VARCHAR risks redundancy. A separate `Location` table could normalize this.
- **Booking.total_price:** Storing `total_price` risks inconsistency. It should be calculated or validated.

---

## Normalized Schema (3NF)

To achieve 3NF:
- Introduce a **Location** table to normalize `Property.location`.
- Remove `Booking.total_price` as a stored attribute; calculate it dynamically or enforce consistency.

### **Updated Entities and Attributes**

#### **User** _(Unchanged)_

| Attribute       | Type                                   | Constraints                        |
|-----------------|----------------------------------------|------------------------------------|
| `user_id`       | UUID                                   | Primary Key, Indexed               |
| `first_name`    | VARCHAR                                | NOT NULL                           |
| `last_name`     | VARCHAR                                | NOT NULL                           |
| `email`         | VARCHAR                                | UNIQUE, NOT NULL                   |
| `password_hash` | VARCHAR                                | NOT NULL                           |
| `phone_number`  | VARCHAR                                | NULL                               |
| `role`          | ENUM (`guest`, `host`, `admin`)        | NOT NULL                           |
| `created_at`    | TIMESTAMP                              | DEFAULT CURRENT_TIMESTAMP          |

---

#### **Location** _(New)_

| Attribute        | Type      | Constraints                        |
|------------------|-----------|------------------------------------|
| `location_id`    | UUID      | Primary Key, Indexed               |
| `street_address` | VARCHAR   | NOT NULL                           |
| `city`           | VARCHAR   | NOT NULL                           |
| `state`          | VARCHAR   | NULL                               |
| `country`        | VARCHAR   | NOT NULL                           |
| `postal_code`    | VARCHAR   | NULL                               |

---

#### **Property** _(Modified)_

| Attribute        | Type      | Constraints                                 |
|------------------|-----------|---------------------------------------------|
| `property_id`    | UUID      | Primary Key, Indexed                        |
| `host_id`        | UUID      | Foreign Key → `User.user_id`                |
| `location_id`    | UUID      | Foreign Key → `Location.location_id`        |
| `name`           | VARCHAR   | NOT NULL                                    |
| `description`    | TEXT      | NOT NULL                                    |
| `pricepernight`  | DECIMAL   | NOT NULL                                    |
| `created_at`     | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |
| `updated_at`     | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP                 |

---

#### **Booking** _(Modified)_

| Attribute      | Type      | Constraints                                 |
|----------------|-----------|---------------------------------------------|
| `booking_id`   | UUID      | Primary Key, Indexed                        |
| `property_id`  | UUID      | Foreign Key → `Property.property_id`        |
| `user_id`      | UUID      | Foreign Key → `User.user_id`                |
| `start_date`   | DATE      | NOT NULL                                    |
| `end_date`     | DATE      | NOT NULL                                    |
| `status`       | ENUM (`pending`, `confirmed`, `canceled`) | NOT NULL   |
| `created_at`   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |

> **Note:** `total_price` is removed as a stored attribute.  
> It can be calculated as:  
> `DATEDIFF(end_date, start_date) * Property.pricepernight`  
> or enforced via a trigger/constraint to ensure consistency with `Payment.amount`.

---

#### **Payment** _(Unchanged)_

| Attribute        | Type      | Constraints                                 |
|------------------|-----------|---------------------------------------------|
| `payment_id`     | UUID      | Primary Key, Indexed                        |
| `booking_id`     | UUID      | Foreign Key → `Booking.booking_id`          |
| `amount`         | DECIMAL   | NOT NULL                                    |
| `payment_date`   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |
| `payment_method` | ENUM (`credit_card`, `paypal`, `stripe`) | NOT NULL   |

---

#### **Review** _(Unchanged, with added constraint)_

| Attribute      | Type      | Constraints                                 |
|----------------|-----------|---------------------------------------------|
| `review_id`    | UUID      | Primary Key, Indexed                        |
| `property_id`  | UUID      | Foreign Key → `Property.property_id`        |
| `user_id`      | UUID      | Foreign Key → `User.user_id`                |
| `rating`       | INTEGER   | CHECK (`rating` >= 1 AND `rating` <= 5), NOT NULL |
| `comment`      | TEXT      | NOT NULL                                    |
| `created_at`   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |
| Constraint: UNIQUE (`property_id`, `user_id`) to prevent multiple reviews by the same user for the same property. |

---

#### **Message** _(Unchanged)_

| Attribute      | Type      | Constraints                                 |
|----------------|-----------|---------------------------------------------|
| `message_id`   | UUID      | Primary Key, Indexed                        |
| `sender_id`    | UUID      | Foreign Key → `User.user_id`                |
| `recipient_id` | UUID      | Foreign Key → `User.user_id`                |
| `message_body` | TEXT      | NOT NULL                                    |
| `sent_at`      | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                   |

---

### **Updated Relationships**

- **User to Property:** One-to-Many (`host_id` references `User.user_id`)
- **Location to Property:** One-to-Many (`location_id` references `Location.location_id`)
- **User to Booking:** One-to-Many (`user_id` references `User.user_id`)
- **Property to Booking:** One-to-Many (`property_id` references `Property.property_id`)
- **Booking to Payment:** One-to-One (`booking_id` references `Booking.booking_id`)
- **User to Review:** One-to-Many (`user_id` references `User.user_id`)
- **Property to Review:** One-to-Many (`property_id` references `Property.property_id`)
- **User to Message (Sender):** One-to-Many (`sender_id` references `User.user_id`)
- **User to Message (Recipient):** One-to-Many (`recipient_id` references `User.user_id`)

---
