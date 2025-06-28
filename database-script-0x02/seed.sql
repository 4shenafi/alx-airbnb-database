-- Insert sample data into User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('550e8400-e29b-41d4-a716-446655440000', 'Alice', 'Smith', 'alice.smith@email.com', 'hash123', '+12345678901', 'host', '2025-06-01 10:00:00'),
    ('550e8400-e29b-41d4-a716-446655440001', 'Bob', 'Johnson', 'bob.johnson@email.com', 'hash456', '+12345678902', 'host', '2025-06-01 11:00:00'),
    ('550e8400-e29b-41d4-a716-446655440002', 'Carol', 'Williams', 'carol.williams@email.com', 'hash789', '+12345678903', 'guest', '2025-06-02 09:00:00'),
    ('550e8400-e29b-41d4-a716-446655440003', 'David', 'Brown', 'david.brown@email.com', 'hash012', '+12345678904', 'guest', '2025-06-02 10:00:00'),
    ('550e8400-e29b-41d4-a716-446655440004', 'Emma', 'Davis', 'emma.davis@email.com', 'hash345', '+12345678905', 'admin', '2025-06-03 08:00:00');

-- Insert sample data into Location table
INSERT INTO Location (location_id, street_address, city, state, country, postal_code)
VALUES
    ('a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o6', '123 Main St', 'New York', 'NY', 'USA', '10001'),
    ('a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o7', '456 Queen St', 'Toronto', 'ON', 'Canada', 'M5V 2A8'),
    ('a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o8', '789 King St', 'London', NULL, 'UK', 'SW1A 1AA'),
    ('a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o9', '101 Ocean Dr', 'Sydney', 'NSW', 'Australia', '2000');

-- Insert sample data into Property table
INSERT INTO Property (property_id, host_id, location_id, name, description, pricepernight, created_at, updated_at)
VALUES
    ('b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p7', '550e8400-e29b-41d4-a716-446655440000', 'a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o6', 'Cozy NYC Loft', 'Modern loft in downtown Manhattan', 150.00, '2025-06-05 12:00:00', '2025-06-05 12:00:00'),
    ('b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p8', '550e8400-e29b-41d4-a716-446655440000', 'a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o7', 'Toronto Lakeview Condo', 'Spacious condo with lake views', 120.00, '2025-06-06 14:00:00', '2025-06-06 14:00:00'),
    ('b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p9', '550e8400-e29b-41d4-a716-446655440001', 'a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o8', 'London Townhouse', 'Charming townhouse near Big Ben', 200.00, '2025-06-07 10:00:00', '2025-06-07 10:00:00'),
    ('b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6q0', '550e8400-e29b-41d4-a716-446655440001', 'a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o9', 'Sydney Beach House', 'Beachfront property with ocean views', 250.00, '2025-06-08 11:00:00', '2025-06-08 11:00:00'),
    ('b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6q1', '550e8400-e29b-41d4-a716-446655440000', 'a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o6', 'NYC Studio Apartment', 'Compact studio in the heart of NYC', 100.00, '2025-06-09 13:00:00', '2025-06-09 13:00:00');

-- Insert sample data into Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status, created_at)
VALUES
    ('c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7q8', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p7', '550e8400-e29b-41d4-a716-446655440002', '2025-07-01', '2025-07-03', 'confirmed', '2025-06-10 09:00:00'),
    ('c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7q9', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p8', '550e8400-e29b-41d4-a716-446655440003', '2025-07-05', '2025-07-07', 'confirmed', '2025-06-11 10:00:00'),
    ('c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r0', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p9', '550e8400-e29b-41d4-a716-446655440002', '2025-07-10', '2025-07-12', 'pending', '2025-06-12 11:00:00'),
    ('c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r1', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6q0', '550e8400-e29b-41d4-a716-446655440003', '2025-07-15', '2025-07-18', 'confirmed', '2025-06-13 12:00:00'),
    ('c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r2', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6q1', '550e8400-e29b-41d4-a716-446655440002', '2025-07-20', '2025-07-22', 'canceled', '2025-06-14 13:00:00'),
    ('c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r3', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p7', '550e8400-e29b-41d4-a716-446655440003', '2025-07-25', '2025-07-27', 'confirmed', '2025-06-15 14:00:00');

-- Insert sample data into Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    ('d4e5f6g7-h8i9-40j1-k2l3-m4n5o6p7q8r9', 'c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7q8', 300.00, '2025-06-10 09:30:00', 'credit_card'),
    ('d4e5f6g7-h8i9-40j1-k2l3-m4n5o6p7q8s0', 'c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7q9', 240.00, '2025-06-11 10:30:00', 'paypal'),
    ('d4e5f6g7-h8i9-40j1-k2l3-m4n5o6p7q8s1', 'c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r0', 400.00, '2025-06-12 11:30:00', 'stripe'),
    ('d4e5f6g7-h8i9-40j1-k2l3-m4n5o6p7q8s2', 'c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r1', 750.00, '2025-06-13 12:30:00', 'credit_card'),
    ('d4e5f6g7-h8i9-40j1-k2l3-m4n5o6p7q8s3', 'c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r2', 200.00, '2025-06-14 13:30:00', 'paypal'),
    ('d4e5f6g7-h8i9-40j1-k2l3-m4n5o6p7q8s4', 'c3d4e5f6-g7h8-49i0-j1k2-l3m4n5o6p7r3', 300.00, '2025-06-15 14:30:00', 'stripe');

-- Insert sample data into Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('e5f6g7h8-i9j0-41k2-l3m4-n5o6p7q8r9s0', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p7', '550e8400-e29b-41d4-a716-446655440002', 5, 'Amazing stay, great location!', '2025-07-04 10:00:00'),
    ('e5f6g7h8-i9j0-41k2-l3m4-n5o6p7q8r9s1', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p8', '550e8400-e29b-41d4-a716-446655440003', 4, 'Comfortable, but a bit noisy.', '2025-07-08 11:00:00'),
    ('e5f6g7h8-i9j0-41k2-l3m4-n5o6p7q8r9s2', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6q0', '550e8400-e29b-41d4-a716-446655440003', 5, 'Fantastic beach house!', '2025-07-19 12:00:00'),
    ('e5f6g7h8-i9j0-41k2-l3m4-n5o6p7q8r9s3', 'b2c3d4e5-f6g7-48h9-i0j1-k2l3m4n5o6p7', '550e8400-e29b-41d4-a716-446655440003', 3, 'Good, but could use better amenities.', '2025-07-28 13:00:00');

-- Insert sample data into Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('f6g7h8i9-j0k1-42l3-m4n5-o6p7q8r9s0t1', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', 'Is the loft available for July 1-3?', '2025-06-09 08:00:00'),
    ('f6g7h8i9-j0k1-42l3-m4n5-o6p7q8r9s0t2', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440002', 'Yes, it’s available! Please book soon.', '2025-06-09 09:00:00'),
    ('f6g7h8i9-j0k1-42l3-m4n5-o6p7q8r9s0t3', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 'Can I check in early on July 15?', '2025-06-12 10:00:00'),
    ('f6g7h8i9-j0k1-42l3-m4n5-o6p7q8r9s0t4', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 'Early check-in is possible, please confirm.', '2025-06-12 11:00:00'),
    ('f6g7h8i9-j0k1-42l3-m4n5-o6p7q8r9s0t5', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440000', 'Please update your property listing.', '2025-06-15 15:00:00');