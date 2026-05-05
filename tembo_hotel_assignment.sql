--DDL

CREATE SCHEMA IF NOT EXISTS tembo_hotel;

SET search_path TO tembo_hotel;

-- Staging table: all columns as TEXT to accept dirty CSV data as-is
CREATE TABLE IF NOT EXISTS bookings_staging (
    booking_id          TEXT,  
    guest_name          TEXT,
    guest_phone         TEXT,  
    guest_city          TEXT,
    guest_nationality   TEXT,  
    room_no             TEXT,
    room_type           TEXT,  
    room_rate_per_night TEXT,
    check_in_date       TEXT,  
    check_out_date      TEXT,
    nights_stayed       TEXT,  
    staff_name          TEXT,
    staff_department    TEXT,  
    staff_salary        TEXT,
    payment_method      TEXT,  
    booking_status      TEXT,
    total_amount        TEXT,  
    service_used        TEXT,
    service_price       TEXT,  
    guest_rating        TEXT
);

select * from bookings_staging;


-- PROBLEM 1: Duplicate booking_id
-- Verify
SELECT booking_id, COUNT(*) FROM bookings_staging
GROUP BY booking_id HAVING COUNT(*) > 1;
 
-- Fix: delete the exact duplicate row (same data, same booking_id)
DELETE FROM bookings_staging
WHERE ctid NOT IN (
    SELECT MIN(ctid) FROM bookings_staging GROUP BY booking_id
);

-- PROBLEM 2: guest_name in ALL CAPS (e.g. ALICE MWANGI, PETER MWANGI)
-- ------------------------------------------------------------
-- Verify
SELECT booking_id, guest_name FROM bookings_staging
WHERE guest_name = UPPER(guest_name) AND guest_name <> INITCAP(guest_name);
 
-- Fix
UPDATE bookings_staging
SET guest_name = INITCAP(guest_name)
WHERE guest_name = UPPER(guest_name) AND guest_name <> INITCAP(guest_name);
 
 
-- ------------------------------------------------------------
-- PROBLEM 3: guest_name in all lowercase (e.g. brian otieno, grace wanjiru)
-- ------------------------------------------------------------
-- Verify
SELECT booking_id, guest_name FROM bookings_staging
WHERE guest_name = LOWER(guest_name);
 
-- Fix
UPDATE bookings_staging
SET guest_name = INITCAP(guest_name)
WHERE guest_name = LOWER(guest_name);
 
 
-- ------------------------------------------------------------
-- PROBLEM 4: guest_name has leading/trailing spaces (e.g. '  Carol Wanjiku  ')
-- ------------------------------------------------------------
-- Verify
SELECT booking_id, guest_name FROM bookings_staging
WHERE guest_name <> TRIM(guest_name);
 
-- Fix
UPDATE bookings_staging
SET guest_name = TRIM(guest_name)
WHERE guest_name <> TRIM(guest_name);

-- Shorter Version
update bookings_staging bs 
set guest_name = trim(initcap(guest_name))
where guest_name != initcap(guest_name) 
or guest_name like ' %' or guest_name like '% ';
 

-- PROBLEM 5: Payment Method 
-- Verify
SELECT DISTINCT payment_method FROM bookings_staging bs
;

-- Fix
UPDATE bookings_staging bs 
SET payment_method = 'M-Pesa'
WHERE bs.payment_method = 'mpesa'
;

-- PROBLEM 6: Room Type
-- Verify
SELECT DISTINCT room_type, count(*) as count
FROM bookings_staging bs 
GROUP BY bs.room_type 
ORDER BY bs.room_type ;

-- Fix
UPDATE bookings_staging bs 
SET room_type = trim(initcap(bs.room_type ))
WHERE bs.room_type <> initcap(bs.room_type )
;
UPDATE bookings_staging bs 
SET room_type = 'Deluxe'
WHERE bs.room_type = 'Dlx'
;
UPDATE bookings_staging bs 
SET room_type = 'Standard'
WHERE bs.room_type = 'Std'
;

--- PROBLEM 7: Phone number
-- Verify
SELECT guest_phone, count (*) AS count
FROM bookings_staging bs
WHERE bs.guest_phone IS NULL 
OR bs.guest_phone = ''
GROUP BY bs.guest_phone 
;

-- Fix
UPDATE bookings_staging
SET guest_phone = 'Not Provided'
WHERE guest_phone IS NULL OR guest_phone = ''
;

select * from bookings_staging bs ;

-- Verify
SELECT guest_phone
FROM bookings_staging bs 
WHERE guest_phone like '%254%' or bs.guest_phone  like '%-%'
;

-- Fix
UPDATE bookings_staging bs 
SET guest_phone = regexp_replace(bs.guest_phone , '[^0-9]', '', 'g')
WHERE bs.guest_phone like '%-%'
;

UPDATE bookings_staging bs 
SET guest_phone = CASE
	WHEN guest_phone LIKE '+2547%' THEN CONCAT('0', SUBSTRING(guest_phone, 5))
	WHEN guest_phone LIKE '2547%' THEN CONCAT('0', SUBSTRING(guest_phone, 4))
	ELSE guest_phone
END
WHERE guest_phone IS NOT NULL 
;

select * from bookings_staging bs LIMIT 50;

--- PROBLEM 8: City Names
-- Verify
SELECT DISTINCT guest_city, count(*) AS count
FROM bookings_staging bs 
GROUP BY bs.guest_city 
;

-- Fix
UPDATE bookings_staging bs 
SET guest_city = trim(initcap(bs.guest_city ))
WHERE bs.guest_city IS NOT NULL
;

UPDATE bookings_staging bs 
SET guest_city = 'Not Provided'
WHERE bs.guest_city IS NULL OR bs.guest_city = ''
;
UPDATE bookings_staging bs 
SET guest_city = 'Thika'
WHERE bs.guest_city LIKE 'Thika%'
;

select * from bookings_staging bs ;

--- PROBLEM 9: Ratings
-- Verify
SELECT booking_id, guest_name, guest_rating
FROM bookings_staging bs 
WHERE trim(bs.guest_rating ) NOT IN ('1', '2', '3', '4', '5')
;

-- Fix
UPDATE bookings_staging bs 
SET guest_rating = NULL 
WHERE bs.guest_rating IS NOT NULL 
AND bs.guest_rating NOT IN ('1', '2', '3', '4', '5')
;

select distinct bs.guest_rating, count(*) as count from bookings_staging bs 
group by bs.guest_rating ;

--- PROBLEM 10: Booking Status
-- Verify
SELECT DISTINCT booking_status
from bookings_staging bs 
;

-- Fix
UPDATE bookings_staging bs 
SET booking_status = initcap(bs.booking_status )
WHERE bs.booking_status != initcap(bs.booking_status )
;

--- PROBLEM 11: Date Formats
-- Verify 
SELECT bs.booking_id , bs.check_in_date, bs.check_out_date 
FROM bookings_staging bs 
WHERE bs.check_in_date  NOT SIMILAR TO '[0-9]{4}-[0-9]{2}-[0-9]{2}'
OR bs.check_out_date NOT SIMILAR TO '[0-9]{4}-[0-9]{2}-[0-9]{2}'
;

-- Fix DD/MM/YYYY (e.g. 05/03/2024)
UPDATE bookings_staging bs 
SET check_in_date = TO_CHAR(TO_DATE(check_in_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE check_in_date ~ '^\d{2}/\d{2}/\d{4}$'
;

UPDATE bookings_staging bs 
SET check_out_date = TO_CHAR(TO_DATE(check_out_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE check_out_date ~ '^\d{2}/\d{2}/\d{4}$'
;

-- Fix 15-11-2024 format entries with LIKE pattern (BK9005)
UPDATE bookings_staging
SET check_in_date = TO_CHAR(TO_DATE(check_in_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE check_in_date ~ '^\d{2}-\d{2}-\d{4}$'
  AND check_in_date NOT LIKE '____-__-__';

UPDATE bookings_staging
SET check_out_date = TO_CHAR(TO_DATE(check_out_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE check_out_date ~ '^\d{2}-\d{2}-\d{4}$'
  AND check_out_date NOT LIKE '____-__-__';


-- Fix DD-MM-YY (2-digit year, e.g. 28-01-24)
SELECT booking_id, check_in_date, check_out_date
FROM bookings_staging
WHERE check_in_date ~ '^\d{2}-\d{2}-\d{2}$'
   OR check_out_date ~ '^\d{2}-\d{2}-\d{2}$';

UPDATE bookings_staging
SET check_in_date = TO_CHAR(TO_DATE(check_in_date, 'DD-MM-YY'), 'YYYY-MM-DD')
WHERE check_in_date ~ '^\d{2}-\d{2}-\d{2}$';

UPDATE bookings_staging
SET check_out_date = TO_CHAR(TO_DATE(check_out_date, 'DD-MM-YY'), 'YYYY-MM-DD')
WHERE check_out_date ~ '^\d{2}-\d{2}-\d{2}$';

-- Fix 15-11-2024 format entries 
-- Step 1: Fix genuine DD-MM-YYYY (day <= 12 is ambiguous, but month > 12 proves MM-DD)
-- First handle the unambiguous ones where the SECOND segment > 12 (must be MM-DD-YYYY)
UPDATE bookings_staging
SET check_in_date = TO_CHAR(TO_DATE(check_in_date, 'MM-DD-YYYY'), 'YYYY-MM-DD')
WHERE check_in_date ~ '^\d{2}-\d{2}-\d{4}$'
  AND check_in_date NOT LIKE '____-__-__'
  AND SPLIT_PART(check_in_date, '-', 2)::INT > 12;  -- second segment > 12 = it's the month
  
UPDATE bookings_staging bs 
SET check_out_date = to_char(to_date(bs.check_out_date, 'MM-DD-YYYY'), 'YYYY-MM-DD')
WHERE bs.check_out_date ~ '^\d{2}-\d{2}-\d{4}$'
	AND bs.check_out_date NOT LIKE '____-__-__'
	AND split_part(check_out_date, '-', 2)::INT >12
;

-- Step 2: Handle the rest as DD-MM-YYYY (second segment <= 12, treat as month)
UPDATE bookings_staging
SET check_in_date = TO_CHAR(TO_DATE(check_in_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE check_in_date ~ '^\d{2}-\d{2}-\d{4}$'
  AND check_in_date NOT LIKE '____-__-__'
  AND SPLIT_PART(check_in_date, '-', 2)::INT <= 12;

UPDATE bookings_staging
SET check_out_date = TO_CHAR(TO_DATE(check_out_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE check_out_date ~ '^\d{2}-\d{2}-\d{4}$'
  AND check_out_date NOT LIKE '____-__-__'
  AND SPLIT_PART(check_in_date, '-', 2)::INT <= 12;

SELECT * FROM bookings_staging bs ;

--- PROBLEM 12: Check out before Check in
--Verify
SELECT booking_id, guest_name, check_in_date, check_out_date, nights_stayed
FROM bookings_staging bs 
WHERE check_in_date > bs.check_out_date 
;

--fIX
UPDATE bookings_staging bs 
SET check_in_date = '2024-09-08', check_out_date = '2024-09-10'
WHERE bs.booking_id = 'BK9002'
;

UPDATE bookings_staging bs 
SET check_in_date  = '24-10-02', check_out_date = '24-10-05', nights_stayed = 3
WHERE bs.booking_id = 'BK9003'
;

UPDATE bookings_staging
SET check_out_date = TO_CHAR(
        DATE_TRUNC('month', check_in_date::DATE)                  
        + (SPLIT_PART(check_out_date, '-', 3)::INT - 1) * INTERVAL '1 day',       ---more readable than DATE_TRUNC('month', check_in_date::DATE) + (17 - 1)
        'YYYY-MM-DD'
    ),
    nights_stayed = SPLIT_PART(check_out_date, '-', 3)::INT
                  - SPLIT_PART(check_in_date, '-', 3)::INT
WHERE booking_id IN ('BK0027', 'BK0007', 'BK0127')
;

SELECT * FROM bookings_staging bs ;

---PROBLEM 13: Total amount
-- Verify
SELECT bs.booking_id , total_amount FROM bookings_staging bs 
WHERE bs.total_amount LIKE '%KES%';

-- Fix
UPDATE bookings_staging bs 
SET total_amount = NULLIF(TRIM(regexp_replace(bs.total_amount, '[^0-9]', '', 'g')), '')
WHERE bs.total_amount LIKE '%KES%'
;

-- Verify
SELECT bs.booking_id ,bs.guest_name , total_amount FROM bookings_staging bs 
WHERE bs.total_amount LIKE '%,%';

-- Fix
UPDATE bookings_staging bs 
SET total_amount = NULLIF(regexp_replace(bs.total_amount, '[^0-9]', '', 'g'), '')
WHERE bs.total_amount ~ '[^0-9]'  -- Using Trim here is redudntant because [^0-9] catches the spaces as well
;

SELECT * FROM bookings_staging bs ;

--- PROBLEM 14: Staff Salaries
SELECT staff_name, staff_salary FROM bookings_staging bs 
WHERE bs.staff_salary LIKE '%K%' OR bs.staff_salary LIKE ',' OR bs.staff_salary = '';

--Fix
UPDATE bookings_staging bs 
SET staff_salary = NULLIF(regexp_replace(bs.staff_salary , '[^0-9]', '', 'g'), '')
WHERE bs.staff_salary LIKE '%K%' OR bs.staff_salary LIKE ','
;

---PROBLEM 15: Nationality
--Verify
SELECT DISTINCT guest_nationality FROM bookings_staging bs ;

--Fix
UPDATE bookings_staging bs 
SET guest_nationality = CASE 
	WHEN guest_nationality <> initcap(bs.guest_nationality )
		THEN initcap(bs.guest_nationality )
	ELSE bs.guest_nationality 
END
;

--- OTHER VERIFICATIONS
-- Check that every service used was paid for
SELECT bs.booking_id , guest_name, service_used, service_price
FROM bookings_staging bs 
WHERE bs.service_used IS NOT NULL AND bs.service_used != '';

--Check that every cancelled booking was not paid for
SELECT bs.booking_id , guest_name, booking_status, bs.total_amount 
FROM bookings_staging bs 
WHERE bs.booking_status = 'Cancelled';  

/* --Not sure whether the total amount is meant to be amount paid or estimation so did not apply fix
 * 
UPDATE bookings_staging bs 
SET total_amount = NULL
WHERE bs.booking_status = 'Cancelled'
;
*/

-----------------------------DELIVERABLES---------------------------------
SELECT * FROM bookings_staging bs ;
CREATE TABLE IF NOT EXISTS bookings (
    booking_id           VARCHAR(10)    PRIMARY KEY,
    guest_name           VARCHAR(100)   NOT NULL,
    guest_phone          VARCHAR(20),
    guest_city           VARCHAR(50),
    guest_nationality    VARCHAR(50),
    room_no              INT,
    room_type            VARCHAR(20)    CHECK (room_type IN ('Standard','Deluxe','Suite','Penthouse')),
    room_rate_per_night  NUMERIC(10,2),
    check_in_date        DATE,
    check_out_date       DATE,
    nights_stayed        INT,
    staff_name           VARCHAR(100),
    staff_department     VARCHAR(50)    CHECK (staff_department IN ('Front Desk','Housekeeping','Restaurant','Security','Management')),
    staff_salary         NUMERIC(10,2),
    payment_method       VARCHAR(20)    CHECK (payment_method IN ('M-Pesa','Cash','Card','Bank Transfer')),
    booking_status       VARCHAR(20)    CHECK (booking_status IN ('Checked Out','Cancelled','No Show')),
    total_amount         NUMERIC(10,2),
    service_used         VARCHAR(100),
    service_price        NUMERIC(10,2),
    guest_rating         INT            CHECK (guest_rating BETWEEN 1 AND 5)
);


---For Defensive Coding
INSERT INTO bookings
SELECT
    booking_id,
    TRIM(INITCAP(guest_name)),
    TRIM(guest_phone),
    TRIM(INITCAP(guest_city)),
    TRIM(INITCAP(guest_nationality)),
    room_no::INT,
    room_type,
    room_rate_per_night::NUMERIC,
    check_in_date::DATE,
    check_out_date::DATE,
    NULLIF(nights_stayed, '')::INT,
    TRIM(INITCAP(staff_name)),
    staff_department,
    NULLIF(REGEXP_REPLACE(staff_salary, '[^0-9]', '', 'g'), '')::NUMERIC,
    payment_method,
    booking_status,
    NULLIF(REGEXP_REPLACE(total_amount, '[^0-9]', '', 'g'), '')::NUMERIC,
    NULLIF(TRIM(service_used), ''),
    NULLIF(TRIM(service_price), '')::NUMERIC,
    NULLIF(guest_rating, '')::INT
FROM bookings_staging
;

--- Final Clean View 
CREATE OR REPLACE VIEW v_clean_bookings AS
SELECT *
FROM bookings
WHERE booking_status IS NOT NULL
  AND check_in_date IS NOT NULL
  AND check_out_date IS NOT NULL
  AND check_out_date >= check_in_date
;

SELECT * FROM V_clean_bookings;

-- 1. REVENUE ANALYSIS
--- Total revenue by month
SELECT
    TO_CHAR(check_in_date, 'YYYY-MM') AS month,
    SUM(total_amount)                  AS total_revenue
FROM v_clean_bookings
WHERE booking_status = 'Checked Out'
GROUP BY month
ORDER BY month DESC;

-- Total revenue by room type
SELECT
    room_type,
    SUM(total_amount) AS total_revenue
FROM v_clean_bookings
WHERE booking_status = 'Checked Out'
GROUP BY room_type
ORDER BY total_revenue DESC;

-- Total revenue by payment method
SELECT
    payment_method,
    SUM(total_amount) AS total_revenue
FROM v_clean_bookings
WHERE booking_status = 'Checked Out'
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- 2. OCCUPANCY
--- Booking count and average nights by room type
SELECT
	room_type,
    COUNT(*)                         AS total_bookings,
    ROUND(AVG(nights_stayed), 2)     AS avg_nights_stayed
FROM v_clean_bookings
GROUP BY room_type
ORDER BY total_bookings DESC;


-- 3. GUEST INSIGHTS
--- Top 10 cities guests come from
SELECT
    guest_city,
    COUNT(*) AS guest_count
FROM v_clean_bookings
GROUP BY guest_city
ORDER BY guest_count DESC
LIMIT 10;

--- Average rating per room type
SELECT
    room_type,
    ROUND(AVG(guest_rating), 2) AS avg_rating
FROM v_clean_bookings
WHERE guest_rating IS NOT NULL
GROUP BY room_type
ORDER BY avg_rating DESC;

-- 4. STAFF PERFORMANCE
-- Which staff handled the most bookings?
SELECT
    staff_name,
    COUNT(*) AS total_bookings
FROM v_clean_bookings
GROUP BY staff_name
ORDER BY total_bookings DESC;

-- Which department generates the most revenue?
SELECT
    staff_department,
    SUM(total_amount) AS total_revenue
FROM v_clean_bookings
WHERE booking_status = 'Checked Out'
GROUP BY staff_department
ORDER BY total_revenue DESC;

-- 5. TRENDS (Window Functions)
--- Revenue by month with month-over-month growth
WITH monthly_revenue AS (
    SELECT
        TO_CHAR(check_in_date, 'YYYY-MM') AS month,
        SUM(total_amount)    AS revenue
    FROM v_clean_bookings
    WHERE booking_status = 'Checked Out'
    GROUP BY month
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month)  AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 2)   AS growth
FROM monthly_revenue
ORDER BY month;

SELECT * FROM v_clean_bookings vcb ;

-- Busiest vs quietest months
SELECT
    TO_CHAR(check_in_date, 'YYYY-MM') AS month,
    COUNT(*)    AS bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS busiest_rank
FROM v_clean_bookings
GROUP BY month
ORDER BY busiest_rank;



-- 6. CANCELLATIONS
-- Cancellation rate per room type
SELECT
    room_type,
    COUNT(*)    AS total_bookings,
    SUM(CASE WHEN booking_status IN ('Cancelled', 'No Show') THEN 1 ELSE 0 END) AS lost_bookings,
    ROUND(
        SUM(CASE WHEN booking_status IN ('Cancelled', 'No Show') THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*)
    , 2)   AS cancellation_rate_pct
FROM v_clean_bookings
GROUP BY room_type
ORDER BY cancellation_rate_pct DESC;

-- Revenue lost from cancellations and no-shows
SELECT
    booking_status,
    COUNT(*)          AS count,
    SUM(total_amount) AS revenue_lost
FROM v_clean_bookings
WHERE booking_status IN ('Cancelled', 'No Show')
GROUP BY booking_status;


-- DELIVERABLE 3A : VIEWS (4 business areas)
---Revenue view
CREATE OR REPLACE VIEW v_revenue AS
SELECT
    TO_CHAR(check_in_date, 'YYYY-MM')  AS month,
    TO_CHAR(check_in_date, 'FMMonth') AS month_name,
    EXTRACT(YEAR FROM check_in_date)::INT  AS year,
    room_type,
    payment_method,
    COUNT(*) AS total_bookings,
    SUM(total_amount)   AS total_revenue,
    SUM(CASE WHEN booking_status = 'Checked Out'
        THEN total_amount ELSE 0 END) AS confirmed_revenue,
    SUM(CASE WHEN booking_status IN ('Cancelled', 'No Show')
        THEN total_amount ELSE 0 END)                 AS revenue_lost,
    ROUND(AVG(total_amount), 2)   AS avg_booking_value,
    COUNT(CASE WHEN booking_status = 'Checked Out'
        THEN 1 END)    AS confirmed_bookings,
    COUNT(CASE WHEN booking_status IN ('Cancelled', 'No Show')
        THEN 1 END)    AS lost_bookings,
    ROUND(
        SUM(CASE WHEN booking_status = 'Checked Out'
            THEN total_amount ELSE 0 END) * 100.0 /
        NULLIF(SUM(total_amount), 0)
    , 2)    AS revenue_collection_rate_pct
FROM bookings
WHERE check_in_date IS NOT NULL
GROUP BY
    TO_CHAR(check_in_date, 'YYYY-MM'),
    TO_CHAR(check_in_date, 'FMMonth'),
    EXTRACT(YEAR FROM check_in_date),
    room_type,
    payment_method;

--- Occupancy view
CREATE OR REPLACE VIEW v_occupancy AS
SELECT
    room_no,
    room_type,
    room_rate_per_night,
    COUNT(*)    AS total_bookings,
    SUM(nights_stayed)    AS total_nights,
    ROUND(AVG(nights_stayed), 2)   AS avg_nights,
    COUNT(CASE WHEN booking_status = 'Checked Out'
        THEN 1 END)  AS confirmed_stays,
    COUNT(CASE WHEN booking_status IN ('Cancelled', 'No Show')
        THEN 1 END)   AS lost_stays,
    SUM(CASE WHEN booking_status = 'Checked Out'
        THEN nights_stayed ELSE 0 END)    AS confirmed_nights,
    ROUND(AVG(
        CASE WHEN booking_status = 'Checked Out'
        THEN nights_stayed END)
    , 2)   AS avg_confirmed_nights,
    SUM(CASE WHEN booking_status = 'Checked Out'
        THEN total_amount ELSE 0 END)  AS total_room_revenue,
    ROUND(
        SUM(CASE WHEN booking_status = 'Checked Out'
            THEN total_amount ELSE 0 END) /
        NULLIF(SUM(CASE WHEN booking_status = 'Checked Out'
            THEN nights_stayed ELSE 0 END), 0)
    , 2)    AS revenue_per_night,
    ROUND(
        COUNT(CASE WHEN booking_status = 'Checked Out'
            THEN 1 END) * 100.0 /
        NULLIF(COUNT(*), 0)
    , 2)    AS occupancy_rate_pct
FROM bookings
GROUP BY
    room_no,
    room_type,
    room_rate_per_night;

-- Guest view
CREATE OR REPLACE VIEW v_guests AS
SELECT
    guest_name,
    guest_city,
    guest_nationality,
    COUNT(*)    AS total_stays,
    SUM(total_amount)    AS total_spent,
    ROUND(AVG(guest_rating), 2)   AS avg_rating,
    SUM(CASE WHEN booking_status = 'Checked Out'
        THEN total_amount ELSE 0 END)    AS confirmed_spent,
    COUNT(CASE WHEN booking_status IN ('Cancelled', 'No Show')
        THEN 1 END)    AS total_cancellations,
    ROUND(
        COUNT(CASE WHEN booking_status IN ('Cancelled', 'No Show')
            THEN 1 END) * 100.0 /
        NULLIF(COUNT(*), 0)
    , 2)  AS cancellation_rate_pct
FROM v_clean_bookings
GROUP BY
    guest_name,
    guest_city,
    guest_nationality;

---- Staff view
CREATE OR REPLACE VIEW v_staff AS
SELECT
    staff_name,
    staff_department,
    staff_salary,
    COUNT(*)   AS bookings_handled,
    SUM(total_amount)    AS revenue_generated,
    SUM(CASE WHEN booking_status = 'Checked Out'
        THEN total_amount ELSE 0 END)   AS confirmed_revenue,
    COUNT(CASE WHEN booking_status = 'Checked Out'
        THEN 1 END)  AS successful_checkouts,
    COUNT(CASE WHEN booking_status IN ('Cancelled', 'No Show')
        THEN 1 END)   AS cancellations_handled,
    ROUND(AVG(guest_rating), 2)     AS avg_guest_rating,
    ROUND(
        SUM(CASE WHEN booking_status = 'Checked Out'
            THEN total_amount ELSE 0 END) /
        NULLIF(COUNT(CASE WHEN booking_status = 'Checked Out'
            THEN 1 END), 0)
    , 2)   AS avg_revenue_per_checkout
FROM v_clean_bookings
GROUP BY
    staff_name,
    staff_department,
    staff_salary;

-- DELIVERABLE 3B : INDEXES
CREATE INDEX IF NOT EXISTS idx_room_no  ON bookings (room_no);
CREATE INDEX IF NOT EXISTS idx_staff_name ON bookings (staff_name);
CREATE INDEX IF NOT EXISTS idx_guest_city ON bookings (guest_city);
CREATE INDEX IF NOT EXISTS idx_check_in_date  ON bookings (check_in_date);
CREATE INDEX IF NOT EXISTS idx_booking_status ON bookings (booking_status);
CREATE INDEX IF NOT EXISTS idx_room_type  ON bookings (room_type);


