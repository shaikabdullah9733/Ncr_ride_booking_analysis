-- NCR Ride Booking Analysis
-- Data Analyst Portfolio Project
-- Tool: MySQL
-- Dataset: NCR Ride Booking Dataset
-- =========================================================
-- NCR RIDE BOOKING ANALYSIS
-- SQL BUSINESS ANALYSIS
-- =========================================================

USE ncr_ride_analysis;

#1 What is the total number of bookings?

SELECT 
      COUNT(*) AS total_bookings 
FROM ncr_ride_bookings_clean;

#2 What is the distribution of bookings by status?

SELECT
    `Booking Status`,
    COUNT(*) AS total_bookings
FROM ncr_ride_bookings_clean
GROUP BY `Booking Status`
ORDER BY total_bookings DESC;

#3 How many bookings were completed successfully?

SELECT
    COUNT(*) AS completed_bookings
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed';

#4 How many bookings were cancelled?

SELECT
    COUNT(*) AS cancelled_bookings
FROM ncr_ride_bookings_clean
WHERE `Booking Status` IN ('Cancelled by Driver', 'Cancelled by Customer');

#5 What are the main reasons for customer cancellations?

SELECT
    `Reason for cancelling by customer`,
    COUNT(*) AS cancellation_count
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Cancelled by Customer'
GROUP BY `Reason for cancelling by Customer`
ORDER BY cancellation_count DESC;

#6 What are the main reasons for driver cancellations?

SELECT
    `Driver Cancellation Reason`,
    COUNT(*) AS cancellation_count
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Cancelled by Driver'
GROUP BY `Driver Cancellation Reason`
ORDER BY cancellation_count DESC;

#7 What are the main reasons for incomplete rides?

SELECT
    `Incomplete Rides Reason`,
    COUNT(*) AS incomplete_count
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Incomplete'
GROUP BY `Incomplete Rides Reason`
ORDER BY incomplete_count DESC;

#8 What is the average booking value of completed rides?

SELECT
    AVG(`Booking Value`) AS average_booking_value
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed';

#9 What is the total booking value generated from completed rides?

SELECT
    SUM(`Booking Value`) AS total_booking_value
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed';

#10 Which vehicle types have the highest number of bookings?

SELECT
    `Vehicle Type`,
    COUNT(*) AS total_bookings
FROM ncr_ride_bookings_clean
GROUP BY `Vehicle Type`
ORDER BY total_bookings DESC;

#11 What are the most commonly used payment methods?

SELECT
    `Payment Method`,
    COUNT(*) AS total_bookings
FROM ncr_ride_bookings_clean
GROUP BY `Payment Method`
ORDER BY total_bookings DESC;

#12 What is the average ride distance for completed rides?

SELECT
    AVG(`Ride Distance`) AS average_ride_distance
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed';

#13 What is the average driver rating?

SELECT
    AVG(CAST(`Driver Ratings` AS DECIMAL(3,2))) AS average_driver_rating
FROM ncr_ride_bookings_clean
WHERE `Driver Ratings` <> 'Not Rated';

#14 What is the average customer rating?

SELECT
    AVG(CAST(`Customer Rating` AS DECIMAL(3,2))) AS average_customer_rating
FROM ncr_ride_bookings_clean
WHERE `Customer Rating` <> 'Not Rated';

#15 What are the top pickup locations by total bookings?

SELECT
    `Pickup Location`,
    COUNT(*) AS total_bookings
FROM ncr_ride_bookings_clean
GROUP BY `Pickup Location`
ORDER BY total_bookings DESC
LIMIT 10;

#16 What are the top drop locations by total bookings?

SELECT
    `Drop Location`,
    COUNT(*) AS total_bookings
FROM ncr_ride_bookings_clean
GROUP BY `Drop Location`
ORDER BY total_bookings DESC
LIMIT 10;

#17 Which vehicle types have the highest number of completed rides?

SELECT
    `Vehicle Type`,
    COUNT(*) AS completed_bookings
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY `Vehicle Type`
ORDER BY completed_bookings DESC;

#18 Which vehicle types generate the highest total booking value?

SELECT
    `Vehicle Type`,
    SUM(`Booking Value`) AS total_booking_value
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY `Vehicle Type`
ORDER BY total_booking_value DESC;

#19 What is the average booking value for each vehicle type?

SELECT
    `Vehicle Type`,
    AVG(`Booking Value`) AS average_booking_value
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY `Vehicle Type`
ORDER BY average_booking_value DESC;

# Changing the column name

SHOW COLUMNS FROM ncr_ride_bookings_clean;

ALTER TABLE ncr_ride_bookings_clean
CHANGE COLUMN `ï»¿Date` `Date` TEXT;
SHOW COLUMNS FROM ncr_ride_bookings_clean;

#20 How does the number of bookings change month by month?

SELECT 
    MONTHNAME(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS month,
    COUNT(*) AS total_bookings
FROM ncr_ride_bookings_clean
WHERE STR_TO_DATE(`Date`, '%d-%m-%Y')
      BETWEEN STR_TO_DATE('01-01-2024', '%d-%m-%Y')
      AND STR_TO_DATE('30-12-2024', '%d-%m-%Y')
GROUP BY 
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y')),
    MONTHNAME(STR_TO_DATE(`Date`, '%d-%m-%Y'))
ORDER BY 
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y'));
    
#21 What is the average vehicle arrival time (VTAT) for completed rides?
    
SELECT
    AVG(`Avg VTAT`) AS average_vtat
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed';

#22 What is the average customer trip arrival time (CTAT) for completed rides?

SELECT
    AVG(`Avg CTAT`) AS average_ctat
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed';

#23 Which payment methods are most commonly used for completed rides?

SELECT
    `Payment Method`,
    COUNT(*) AS completed_bookings
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY `Payment Method`
ORDER BY completed_bookings DESC;

#24 What is the average booking value for each payment method?

SELECT
    `Payment Method`,
    AVG(`Booking Value`) AS average_booking_value
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY `Payment Method`
ORDER BY average_booking_value DESC;

#25 Which pickup locations have the highest number of completed rides?

SELECT
    `Pickup Location`,
    COUNT(*) AS completed_bookings
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY `Pickup Location`
ORDER BY completed_bookings DESC
LIMIT 10;

#26 Which pickup locations have the highest number of rides where no driver was found?

SELECT
    `Pickup Location`,
    COUNT(*) AS no_driver_found
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'No Driver Found'
GROUP BY `Pickup Location`
ORDER BY no_driver_found DESC
LIMIT 10;

#27 How does the total booking value from completed rides change month by month?

SELECT
    MONTHNAME(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS month,
    SUM(`Booking Value`) AS total_booking_value
FROM ncr_ride_bookings_clean
WHERE `Booking Status` = 'Completed'
GROUP BY
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y')),
    MONTHNAME(STR_TO_DATE(`Date`, '%d-%m-%Y'))
ORDER BY
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y'));

