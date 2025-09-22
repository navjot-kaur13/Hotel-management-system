-- ========================
-- 🧱 CREATE TABLES
-- ========================

CREATE TABLE hotel (
  hotel_id NUMBER PRIMARY KEY,
  hotel_name VARCHAR2(25),
  hotel_address VARCHAR2(25),
  hotel_phone VARCHAR2(25)
);

CREATE TABLE room (
  room_id NUMBER PRIMARY KEY,
  hotel_id NUMBER,
  room_price NUMBER,
  room_size VARCHAR2(25),
  room_capacity NUMBER,
  CONSTRAINT room_fk FOREIGN KEY(hotel_id) REFERENCES hotel(hotel_id)
);

CREATE TABLE guest (
  guest_id NUMBER PRIMARY KEY,
  guest_name VARCHAR2(25),
  guest_phone VARCHAR2(25),
  guest_email VARCHAR2(35)
);

CREATE TABLE room_reservation (
  room_id NUMBER,
  guest_id NUMBER,
  booking_id NUMBER,
  booking_invoice NUMBER,
  CONSTRAINT reserv_pk PRIMARY KEY(room_id, guest_id),
  FOREIGN KEY(room_id) REFERENCES room(room_id),
  FOREIGN KEY(guest_id) REFERENCES guest(guest_id)
);

CREATE TABLE event (
  event_id NUMBER PRIMARY KEY,
  event_name VARCHAR2(25)
);

CREATE TABLE event_in_hotel (
  event_id NUMBER,
  guest_id NUMBER,
  reserv_id NUMBER,
  start_date DATE,
  end_date DATE,
  event_invoice NUMBER,
  CONSTRAINT room_hotel_pk PRIMARY KEY(event_id, guest_id)
);

CREATE TABLE room_registry (
  room_id NUMBER,
  hotel_id NUMBER,
  registry_date DATE,
  room_availability VARCHAR2(25),
  CONSTRAINT registry_pk PRIMARY KEY(room_id, registry_date)
);

-- ========================
-- 📥 INSERT DATA
-- ========================

INSERT INTO hotel VALUES (23001, 'FOUR SEASONS', 'BANGLORE', '9981235476');
INSERT INTO hotel VALUES (54981, 'GRAND MERCURE', 'MYSORE', '8421974550');
-- Add more hotel entries...

INSERT INTO room VALUES (101, 23109, 4000, 'SMALL', 1);
-- Add more room entries...

INSERT INTO guest VALUES (123456, 'RAHUL', '9875486213', 'rahul@gmail.com');
-- Add more guest entries...

INSERT INTO room_reservation VALUES (101, 123456, 10001, 465728);
-- Add more reservations...

INSERT INTO event VALUES (1001, 'BIRTHDAY PARTY');
-- Add more events...

INSERT INTO event_in_hotel VALUES (1001, 123456, 20002, '07-JUL-2024', '07-JUL-2024', 12453);
-- Add more event bookings...

INSERT INTO room_registry VALUES (207, 32116, '01-DEC-2024', 'AVAILABLE');
-- Add more registry entries...

-- ========================
-- 🛠️ UPDATE & DELETE
-- ========================

UPDATE room SET room_price = 6000 WHERE room_id = 207;
DELETE FROM event WHERE event_id = 1001;

-- ========================
-- 📊 AGGREGATE QUERIES
-- ========================

SELECT COUNT(event_id) FROM event;
SELECT MIN(room_price) FROM room;
SELECT guest_name, guest_email FROM guest ORDER BY guest_name;
SELECT hotel_id, room_size FROM room WHERE room_price > 8000 GROUP BY hotel_id, room_size;

-- ========================
-- 🔗 JOIN, UNION, DROP
-- ========================

SELECT R.room_id, R.room_price, R.room_size, R.room_capacity,
       H.hotel_name, H.hotel_address, H.hotel_phone
FROM room R
JOIN hotel H ON R.hotel_id = H.hotel_id;

SELECT * FROM room_reservation NATURAL JOIN guest;

SELECT guest_name AS name_or_address, guest_email AS details FROM guest
UNION
SELECT hotel_name, hotel_address FROM hotel;

DROP TABLE room_reservation;
