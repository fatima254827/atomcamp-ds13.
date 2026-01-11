CREATE SCHEMA hospital_management_system;
use hospital_management_system;

-- Hospitals
CREATE TABLE hospitals (
    hospital_id INT PRIMARY KEY,
    name VARCHAR(100),
    address TEXT,
    phone VARCHAR(20)
);

-- Doctors
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialty VARCHAR(100),
    hospital_id INT,
    email VARCHAR(100),
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
);

-- Patients
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    address TEXT,
    phone VARCHAR(30)
);

-- Appointments
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    hospital_id INT,
    name VARCHAR(100),
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
);

-- Medications
CREATE TABLE medications (
    medication_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

-- Prescriptions
CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    medication_id INT,
    prescribed_date DATE,
   FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id)
);

-- Rooms
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_no VARCHAR(20),
    department_id INT,
    capacity INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- insert in patients table 
INSERT INTO patients (patient_id, name, dob, address, phone)
VALUES (1, 'Norma Fisher', '1940-08-27', '6607 Sharp Common, Chadstad, UT 04351', '+1-718-549-4576x95978'),
(2, 'Jorge Sullivan', '1942-04-20', '35192 Aaron Shoals, Lake Adrianstad, UT 03731', '001-880-565-5803x91715'),
(3, 'Elizabeth Woods', '2012-11-19', 'USNS Villarreal, FPO AE 60013', '+1-708-481-0950'),
(4, 'Susan Wagner', '1938-03-25', '420 Michael Mountains Suite 485, New Victoria, CT 70392', '847-676-0375x20782'),
(5, 'Peter Montgomery', '1954-12-10', '2235 Joel Ferry, Nathanton, VI 17833', '+1-897-430-7992x97595'),
(6, 'Theodore Mcgrath', '1938-05-04', '12648 Yang Divide Suite 451, South Cynthia, SC 69865', '966.535.6433x43895'),
(7, 'Stephanie Collins', '1936-01-22', '65735 Farley Course Apt. 141, Port Jacqueline, MO 24799', '+1-359-925-3248x289'),
(8, 'Stephanie Sutton', '2010-08-22', '37582 Ford Route Apt. 734, Port Hollymouth, AL 29170', '632.595.9318x7346'),
(9, 'Brian Hamilton', '1964-06-08', '926 Davis Parks Apt. 864, North Josephton, AL 34130', '(665)600-3392x871'),
(10, 'Susan Levy', '1949-02-22', '1454 Caitlin Camp Apt. 448, Davidbury, MH 21938', '001-976-656-0105x249'),
(11, 'Sean Green', '1948-01-29', '8298 Amanda Loop Suite 447, Ashleyberg, GA 16661', '+1-267-753-1118'),
(12, 'Kimberly Smith', '1993-09-24', '9728 Gomez Mountains Suite 377, Trevorton, NV 39846', '001-591-693-0014x1962'),
(13, 'Jennifer Summers', '2021-11-09', '93057 Oneal Branch Apt. 160, Blaketown, KY 84436', '622-593-2234x7429'),
(14, 'April Snyder', '1980-02-18', '94316 Moran Lights, West Robert, MH 90609', '926-423-9058'),
(15, 'Dana Nguyen', '2015-10-13', '285 Jason Ferry Suite 566, Pricebury, WY 26216', '001-441-994-9302x39062'),
(16, 'Cheryl Bradley', '1979-11-26', '060 Cynthia Ways, West Brian, SC 89301', '+1-508-653-2757'),
(17, 'Walter Pratt', '1986-05-01', '184 Jenkins Center Suite 977, Janetborough, MA 35349', '+1-331-457-4589x43486'),
(18, 'Bobby Flores', '1995-10-03', '50402 Kristin Springs, New Randy, PW 29464', '(319)618-2726x4832'),
(19, 'Tasha Rodriguez', '2007-02-22', '191 Morris Motorway Suite 408, East Miguelborough, VI 69250', '456.280.5668x289'),
(20, 'Michelle Kelley', '2002-11-21', '4486 Olson Well, North Kevin, OH 09982', '897-389-6373x6118'),
(21, 'Kimberly Maynard', '2023-10-31', '706 Stevens Crest Apt. 131, South Nicole, IL 58256', '572.503.3319x66183'),
(22, 'Laurie Wallace', '2001-11-28', '602 Tracy Crossroad Suite 556, New Rachelside, WY 26870', '813.618.2938x9896'),
(23, 'Janice Johnston', '2016-03-15', '978 Nelson Brook Apt. 912, Wrightport, FM 96980', '+1-479-505-5303x73830'),
(24, 'Collin Lopez', '1953-03-26', 'Unit 0886 Box 0164, DPO AE 97138', '971.794.4654x191'),
(25, 'Mary Alvarez', '1982-11-14', '843 Calvin Inlet, Jesusfort, LA 76792', '+1-791-432-6307x428'),
(26, 'Peter Mcdowell', '1988-07-23', '855 Lisa Wells, Mooreburgh, NY 10522', '885-851-5334'),
(27, 'Sarah Villanueva', '2008-12-30', '9332 Kathleen Knoll, Lake Vernon, PW 14658', '(402)871-4283x9752'),
(28, 'Kimberly Myers', '1978-01-30', '957 Parker Forges, Lake Natasha, AS 97149', '331-722-7862x047'),
(29, 'Desiree Cain', '2005-11-16', '142 Warner View Suite 460, North Leslie, WA 33217', '+1-611-873-8009x1749'),
(30, 'Stephanie Lawrence', '1969-08-27', '345 Kevin Knolls Apt. 250, Burtontown, IA 06394', '(531)498-2730'),
(31, 'Lauren Hayes', '1987-06-17', '05623 Graham Knolls Suite 256, Smithview, ND 70144', '001-992-629-9211x414'),
(32, 'Whitney Stark', '2011-04-21', '91662 Vincent Road Apt. 153, East Sonya, AS 22631', '001-660-812-7055'),
(33, 'Angela Salazar', '2006-07-05', '169 Christine Mount, New Carolyn, KS 45098', '(204)633-1923x8375'),
(34, 'Mr. Ryan Sanchez', '1993-10-24', '07154 Stephen Parkways Suite 265, Lindafurt, AL 41233', '(598)682-5986x34174'),
(35, 'Autumn Robinson', '1934-09-14', '708 Villa Camp Suite 616, Tylertown, KY 97488', '001-941-552-7067x04896'),
(36, 'Faith Cabrera', '1951-01-22', 'Unit 4943 Box 8856, DPO AA 27891', '(604)816-4377'),
(37, 'Charles Wolfe', '1980-04-19', '98522 Mathis Viaduct Apt. 909, West Michael, SC 38960', '(397)242-0354'),
(38, 'Kenneth Kent', '1957-08-01', '620 Ashley Mills Apt. 507, Julieborough, CA 72443', '(745)893-5621x35772'),
(39, 'Melanie Johnson', '1940-08-03', 'USNV Dodson, FPO AE 69907', '(565)891-1872x10867'),
(40, 'Lisa Johnston', '2012-01-27', '188 Fischer Grove, Justinchester, WI 94599', '+1-216-404-9244x8185'),
(41, 'Jacob Hooper', '2019-07-20', '885 Lee Tunnel Suite 208, Port Donna, WY 74331', '9156573359'),
(42, 'Alex Woodward', '1961-12-08', '86930 Rice Estate Apt. 570, New Patricia, KY 24767', '+1-527-660-1015'),
(43, 'Caleb Clark', '1971-05-30', 'USCGC Miller, FPO AA 31530', '+1-218-541-1894'),
(44, 'Taylor Johnson', '2007-08-03', '132 Mclean Meadow Suite 446, Chelsealand, ME 04450', '227-822-7427'),
(45, 'Brian Green', '1940-04-14', '66660 Gomez Port Apt. 945, South Thomashaven, DC 05951', '5119416346'),
(46, 'Matthew Bell', '1992-05-16', '0131 Williams Ville Apt. 562, Richardberg, PA 19832', '+1-798-785-2609x6934'),
(47, 'Jonathan Williams', '1946-02-21', '022 Renee Squares Apt. 808, Herringstad, AS 77293', '674.554.2237x5057'),
(48, 'William Gonzalez', '1960-07-09', '243 Murphy Station, Kimberlyhaven, NH 20843', '4172823695'),
(49, 'Nicholas Massey', '2009-05-18', '209 Darlene Bypass Suite 137, Port Stephen, GA 93500', '867.675.0393x1721'),
(50, 'Caroline Chambers', '1939-09-06', '8081 Smith Trail, North Ronaldstad, OK 59690', '616.808.7503'),
(51, 'Amy Lowe', '1937-12-01', '512 Schaefer Falls Apt. 059, North Robert, AR 92099', '984.810.1566x634'),
(52, 'Gloria King', '1972-04-16', '92516 Scott Rapids Suite 497, Whitemouth, AS 35123', '+1-606-947-2666'),
(53, 'Jessica Thompson', '1978-12-12', '51105 Gregory Ridges Apt. 578, Alvarezton, ND 53183', '+1-954-969-2506'),
(54, 'Jason Carroll', '2012-05-20', '81155 Thomas Bypass Apt. 840, South Matthewside, UT 19753', '313-453-6095x2271'),
(55, 'Emily Howard', '1999-03-26', '395 Timothy Road, Williamsbury, SC 37407', '+1-603-220-8662x467'),
(56, 'Danielle Castro', '1995-04-21', '3267 Walter Dam, Cunninghamtown, GA 77001', '(872)211-7444'),
(57, 'Patrick Rogers', '1948-04-22', '220 Madison Pass Apt. 001, Port Eric, WY 50291', '001-645-571-0437'),
(58, 'Douglas Allen', '2023-06-27', '9532 Dixon Place Suite 126, Tammychester, MH 57653', '(216)400-1504x4000'),
(59, 'Heather Roberts', '1971-09-08', '63769 Mary Harbor Suite 809, Mcdowellview, AZ 80581', '+1-327-519-2082x111'),
(60, 'Travis Schultz', '1989-09-28', '180 Jennifer Burg Suite 661, Munozburgh, GA 45130', '376-411-7782'),
(61, 'Michelle Hughes', '1969-06-26', '481 Reed Road, Katiehaven, WV 07566', '(768)821-8083x165'),
(62, 'Matthew Smith', '1938-12-01', '95460 Arnold Bypass Suite 463, Dennisville, RI 47288', '239-212-9654x5850'),
(63, 'George Allen', '1977-01-23', '671 Kimberly Plains Apt. 223, East Anthony, DC 65125', '(643)622-1772'),
(64, 'Jamie Hutchinson', '1948-04-21', '516 Nolan Junctions Suite 826, Jimmyfurt, MI 51653', '(402)655-3187'),
(65, 'Jennifer Morales', '1937-08-09', 'USNV Oconnell, FPO AA 13308', '531-893-5614x68505'),
(66, 'Jennifer Bates', '1990-04-01', '09981 Caitlin Rapids, West Haleyburgh, MS 11691', '7688424041'),
(67, 'Jeremy Green', '1991-05-19', '57517 Silva Glen, Burnettbury, GA 74116', '9435245812'),
(68, 'Joseph Freeman', '1944-02-28', '202 Franklin Fords, Ericksonfurt, KS 03275', '001-299-416-4040'),
(69, 'Nicole Henson', '1984-02-09', '79061 Cook Parkways Suite 079, West Marissafort, OH 85040', '726-739-8308x37879'),
(70, 'Eric Owens PhD', '1965-11-19', '38524 Stephen Cliff Suite 696, West Timothyville, LA 18991', '(910)865-2736x903'),
(71, 'Robin Lopez', '1969-03-10', '02983 Antonio Lodge, Kleinville, NJ 73841', '001-462-326-6734x12904'),
(72, 'Miss Angela Swanson DVM', '2004-07-24', '03374 Walker Park Suite 851, West Ashleybury, WA 48669', '(842)964-8658'),
(73, 'Michael Stewart', '1978-10-24', 'USNS Hall, FPO AE 97807', '914.595.4446x980'),
(74, 'Mitchell Smith', '2013-12-31', '6921 Kelly Ways Suite 355, Ramirezfurt, WI 94134', '(746)900-6814x00768'),
(75, 'Kelsey Davis', '1989-08-05', 'Unit 1741 Box 7253, DPO AP 25003', '578.379.2909x53461'),
(76, 'Matthew Russo', '1976-09-23', 'USNV Porter, FPO AE 89774', '(697)927-5727'),
(77, 'William Garcia', '1991-08-05', '8799 Emma Parkway Suite 735, North Thomasfurt, MH 30303', '483-405-8468x91428'),
(78, 'Jennifer Miller', '1965-02-02', '90614 Jessica Fall Apt. 250, North Alan, ND 01091', '253-400-7719'),
(79, 'Jesse Sparks', '1945-11-14', '73089 Jones Fall, East Sarah, MS 62718', '+1-779-329-4145x2750'),
(80, 'Brandi Meyer', '1996-02-10', '60940 Padilla Views Suite 729, West Sierraville, KY 03663', '991-844-9520'),
(81, 'Hannah Wiggins', '1990-09-01', '3953 Romero Crest, Lake Rhondaville, NY 59180', '(531)664-7676x2636'),
(82, 'Albert Williams', '2005-08-27', '526 Bennett Port Suite 373, Timothychester, AK 59090', '427-955-4753'),
(83, 'Kristin Potts', '1946-02-14', '673 Allen Neck, Thomasmouth, LA 47683', '(953)772-1899'),
(84, 'Susan Williams', '2016-09-29', '134 Sophia Drives, Benjaminburgh, WI 61921', '(715)724-5116'),
(85, 'Meredith Rios', '2006-08-16', '7326 Kristin Unions, Pamhaven, ID 95387', '650-334-2282x7318'),
(86, 'Stephanie Bowman', '2017-03-15', '97939 Johnson Oval Suite 830, North Dennismouth, VI 88870', '3614677220'),
(87, 'Joshua Clark', '2013-03-18', '645 Jennings Estates, Angelastad, VT 57929', '+1-416-991-4199x1346'),
(88, 'Alexa Hernandez', '1995-12-22', '1231 Stephanie Lock Suite 835, North Richardland, PR 54546', '001-945-326-4221x385'),
(89, 'Richard Higgins', '2007-08-10', '302 Parker Plains Apt. 197, East Robertstad, ME 11473', '986-847-0252x73312'),
(90, 'Marc Williams', '1981-05-24', '098 Hernandez Green, New Sergiobury, MS 50840', '753-915-2339'),
(91, 'William Roberts', '2005-05-18', '94102 Sims Port Suite 187, Florestown, DE 57418', '397-684-4099x24388'),
(92, 'Joshua Carter', '1951-09-15', '01630 Baker Crescent, Kellyborough, WA 71505', '821.707.8889x986'),
(93, 'David Williams', '2005-01-27', '802 Weiss Route Suite 525, New Annaland, KS 75278', '+1-253-457-2807x201'),
(94, 'Joseph Jones', '1974-09-11', '270 Michael Point, East Heather, IN 52803', '001-710-854-3103x25689'),
(95, 'Gary Perry', '2002-10-12', '2458 Jason Village Suite 248, North Donnamouth, ME 93087', '860.493.9070'),
(96, 'Terry Wells', '1975-09-04', '19041 Jennifer Flats Suite 716, Martinezshire, NH 42985', '001-631-692-5447x58675'),
(97, 'Vanessa Cooper', '2005-09-29', '640 Mary Route, Charlesmouth, MD 72308', '885.465.6403x746'),
(98, 'Michael Simmons', '1941-06-18', '38249 Kristi Manor Suite 934, Reneeside, NM 59327', '(473)429-3148'),
(99, 'Nicholas Kline', '1938-09-13', '2803 Reyes Garden Apt. 412, South Alexis, WV 47971', '+1-471-473-6210x80119'),
(100, 'Lori Bennett', '2018-10-08', '374 Powell Mountains, East Jennahaven, MI 27038', '001-735-551-1672'),
(101, 'Margaret Jones', '1978-06-09', '2284 Howard Way, Schaeferburgh, IA 99887', '+1-439-497-9412x613'),
(102, 'Paul Brown', '2015-10-12', '384 Jennifer Turnpike, North Robert, MS 66761', '001-244-552-7581x160'),
(103, 'James Stone', '2019-09-18', '871 Melissa Place Apt. 103, Coleview, MT 45759', '863-256-9151x79743'),
(104, 'John Richards', '1994-09-02', '129 Joyce Walks Apt. 081, Wrightberg, PA 82666', '(752)918-4709x228'),
(105, 'Jenny Richardson', '1986-02-22', '92555 Shaw Spurs Suite 207, New Randy, NJ 40008', '001-616-747-4060x712'),
(106, 'Debbie Waters MD', '1954-02-13', '5596 Riley Square Suite 933, Robinsonhaven, GA 67302', '492-377-0952x6042'),
(107, 'Austin Boyer', '1943-02-04', '4647 Kristine Fields Suite 710, New Dakota, KS 00638', '(587)382-6528x59211'),
(108, 'Stephanie Hayes', '2008-06-05', '92594 Emily Shoals, North Cathyburgh, MP 41186', '673.906.5459'),
(109, 'Barbara Sanders', '2014-09-03', 'USNS Long, FPO AA 97276', '704.676.3708x96539'),
(110, 'Andrew Gould', '2004-10-30', '96102 Brittney Groves Suite 363, Jackburgh, NM 86758', '(624)431-5624'),
(111, 'Charles Gonzalez', '1997-07-19', '300 Merritt Bypass Apt. 816, Martinborough, VT 08557', '(701)926-6119x3813'),
(112, 'Joshua Hernandez', '1972-06-29', '4779 Adams Rue, South Lindaburgh, MH 14614', '+1-991-622-9990'),
(113, 'Victoria Hernandez MD', '1962-02-28', '762 Miranda Spur Apt. 912, Phillipsville, TX 56307', '480.971.0093'),
(114, 'Sherry Simpson', '1944-11-22', '588 Alan Rest, Port Stephanieville, MT 50971', '001-538-649-9125x80954'),
(115, 'Erica Jimenez', '1973-01-07', '52169 Brandon Loop Apt. 096, New Jessica, ME 53807', '6964515451'),
(116, 'Mr. Dakota Lynch II', '1985-08-16', '782 Dawn Radial, Port Christopher, NJ 38224', '(200)496-0636x974'),
(117, 'Victor Nolan', '2017-09-28', '0081 Danielle Drives, Port Kathleen, DC 15510', '001-497-581-0012x669'),
(118, 'Amanda Hernandez', '2018-11-26', 'USS Yang, FPO AA 19553', '+1-581-700-6642x6056'),
(119, 'Richard Kirby', '1972-02-03', '53475 Ruiz Pine, North Lesliefurt, WI 53362', '+1-530-567-8035x729'),
(120, 'Michelle Roman', '1943-08-12', '132 Poole Pass Suite 212, North Patrick, OK 15689', '8316455422');


-- check
SELECT * FROM hospitals;
SELECT * FROM doctors