CREATE DATABASE tourism;

USE tourism;

CREATE TABLE destinations (
    destination_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    description TEXT,
    rating DECIMAL(3, 2)
);

CREATE TABLE hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    destination_id INT,
    rating DECIMAL(3, 2),
    address TEXT,
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(255) NOT NULL,
    hotel_id INT,
    check_in_date DATE,
    check_out_date DATE,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

INSERT INTO destinations (name, country, description, rating)
VALUES
    ('Bali', 'Indonesia', 'Pulau Dewata', 4.5),
    ('Yogyakarta', 'Indonesia', 'Kota Gudeg', 4.3),
    ('Bandung', 'Indonesia', 'Kota Kembang', 4.7),
    ('Eiffel Tower', 'France', 'Iconic Landscape', 4.2);

INSERT INTO hotels (name, destination_id, rating, address)
VALUES
    ('Hotel Pantai Bali', 1, 4.4, 'Jalan Pantai Kuta, Bali'),
    ('Hotel Keraton', 2, 4.2, 'Jalan Malioboro, Yogyakarta'),
    ('Hotel Savoy Homann', 3, 4.8, 'Jalan Asia Afrika, Bandung'),
    ('Hotel Marriot', 4, 4.8, '123 Rue de la Tour, Paris');

INSERT INTO bookings (guest_name, hotel_id, check_in_date, check_out_date)
VALUES
    ('Nafisa Alfiani', 1, '2023-09-15', '2023-09-20'),
    ('Jane Chook', 2, '2023-10-10', '2023-10-15'),
    ('Kailash', 3, '2023-11-05', '2023-11-10');

-- no 1
SELECT * FROM destinations;

-- no 2
SELECT * FROM hotels;

-- no 3
SELECT * FROM bookings;

-- no 4
SELECT hotels.name, hotels.rating, hotels.address
FROM hotels
JOIN destinations ON hotels.destination_id = destinations.destination_id
WHERE destinations.name = 'Bali';

-- no 5
SELECT AVG(hotels.rating) AS average_rating
FROM hotels
JOIN destinations ON hotels.destination_id = destinations.destination_id
WHERE destinations.name = 'Yogyakarta';
