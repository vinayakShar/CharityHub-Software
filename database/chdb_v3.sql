--                    --
-- Charityhub Database--
--                    --


--              --
--TABLE CREATION--
--              --

CREATE TABLE public.address (
    address_id integer NOT NULL,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMENT ON TABLE public.address IS 'Addresses associated with user billing and Charity information. ';

-- Charity Type Category Table

--CREATE TABLE public.category (
--    category_id integer NOT NULL,
  --  type character varying(25) NOT NULL
--);

--COMMENT ON COLUMN public.category.category_id IS 'This is an integer so algorithms can search/filter numerically
--Example:
--Animal Rescue equals the int "1"
--Homelessness equals the int "2" ';


-- City Table

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city character varying(50) NOT NULL,
    country_id integer NOT NULL
);

-- Country Table

CREATE TABLE public.country (
    country_id integer NOT NULL,
    country character varying(50) NOT NULL
);

-- Charity Accounts Table

CREATE TABLE public.org_account (
    org_id integer NOT NULL,
    name character varying(100) NOT NULL,
  --  category_id integer NOT NULL,
    create_date date NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    payment_id integer NOT NULL,
    activebool integer NOT NULL,
    verifiedbool integer NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    form_link character varying NOT NULL
);

COMMENT ON COLUMN public.org_account.form_link IS 'Reference to charity creation documents/form, presumingly stored on cloudserver';


-- Charity Details Table

CREATE TABLE public.org_details (
    org_id integer NOT NULL,
    tag text,
    mission text,
    type1 text,
    type2 text,
    type3 text,
    url text,
    url_fb text,
    url_tw text,
    url_in text,
    address_id integer
);


-- User Account Table


CREATE TABLE public.user_account (
    account_id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50) NOT NULL,
    address_id smallint NOT NULL,
    create_date date NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    active integer NOT NULL,
    password character varying NOT NULL,
    username character varying(20) NOT NULL
);

-- Payment Table

CREATE TABLE public.payment (
    transaction_id integer NOT NULL,
    payment_id integer NOT NULL,
    account_id smallint NOT NULL,
    amount numeric(5,2) NOT NULL,
    type integer NOT NULL,
    payment_date timestamp without time zone DEFAULT now() NOT NULL
);



--       --
--       --
--INSERTS--
--       --
--       --


-- Category INSERT

--INSERT INTO public.category (category_id, type) VALUES(1, 'Disaster');
--INSERT INTO public.category (category_id, type) VALUES(2, 'Animal Rescue');
--INSERT INTO public.category (category_id, type) VALUES(3, 'Environmental');
--INSERT INTO public.category (category_id, type) VALUES(4, 'Healthcare');
--INSERT INTO public.category (category_id, type) VALUES(5, 'Education');
--INSERT INTO public.category (category_id, type) VALUES(6, 'Arts');
--INSERT INTO public.category (category_id, type) VALUES(7, 'Hunger');
--INSERT INTO public.category (category_id, type) VALUES(8, 'Housing');
--INSERT INTO public.category (category_id, type) VALUES(9, 'International');
--INSERT INTO public.category (category_id, type) VALUES(10, 'The Rent is Too Damn High');
--INSERT INTO public.category (category_id, type) VALUES(11, 'iPhone For Jacob');


-- Payment INSERT

INSERT INTO public.payment(transaction_id, account_id, amount, payment_date, payment_id, type)
VALUES(1, 1, 100, '2020-04-20 16:20:00', 1, 0);

INSERT INTO public.payment(transaction_id, account_id, amount, payment_date, payment_id, type)
VALUES(2, 2, 200, '2020-04-20 16:20:00', 2, 0);

INSERT INTO public.payment(transaction_id, account_id, amount, payment_date, payment_id, type)
VALUES(3, 3, 300, '2020-04-20 16:20:00', 3, 0);

INSERT INTO public.payment(transaction_id, account_id, amount, payment_date, payment_id, type)
VALUES(4, 4, 400, '2020-04-20 16:20:00', 4, 0);


-- User INSERT

INSERT INTO public.user_account (account_id, first_name, last_name, email, address_id, create_date, last_update, active, password, username)
VALUES (1, 'Micah', 'NA', 'test@test.com', 1, '2020-10-12', '2020-10-12 09:54:43', 1, 'test', 'test');

INSERT INTO public.user_account (account_id, first_name, last_name, email, address_id, create_date, last_update, active, password, username)
VALUES (2, 'Joseph', 'NA', 'test2@test.com', 1, '2020-10-12', '2020-10-12 09:54:43', 1, 'test2', 'test2');

INSERT INTO public.user_account (account_id, first_name, last_name, email, address_id, create_date, last_update, active, password, username)
VALUES (3, 'Vinny', 'NA', 'test3@test.com', 1, '2020-10-12', '2020-10-12 15:19:07', 1, 'test3', 'test3');

INSERT INTO public.user_account (account_id, first_name, last_name, email, address_id, create_date, last_update, active, password, username)
VALUES (4, 'Matt', 'NA', 'test4@test.com', 1, '2020-10-12', '2020-10-12 15:19:07', 1, 'test4', 'test4');


-- Charitiy INSERT

INSERT INTO public.org_account (org_id, name, create_date, email, password, payment_id, activebool, verifiedbool, last_update, form_link)
VALUES(1, 'Charityhub', '2020-11-03', 'ch@charityhub.org', 'test', 1, 1, 1, '2020-04-20 16:20:00', 'dev/forms/taxevasion.form');

INSERT INTO public.org_account (org_id, name, create_date, email, password, payment_id, activebool, verifiedbool, last_update, form_link)
VALUES(2, 'Mukbangers', '2020-11-03', 'mmm@mukbang.edu', 'test', 2, 1, 1, '2020-04-20 16:20:00', 'dev/forms/taxevasion.form');

INSERT INTO public.org_account (org_id, name, create_date, email, password, payment_id, activebool, verifiedbool, last_update, form_link)
VALUES(3, 'Jacob Needs An iPhone', '2020-11-03', 'upgrade@jnai.org', 'test', 3, 1, 1, '2020-04-20 16:20:00', 'dev/forms/taxevasion.form');

INSERT INTO public.org_account (org_id, name, create_date, email, password, payment_id, activebool, verifiedbool, last_update, form_link)
VALUES(4, 'Captain Philips Inner City Sailing Fund', '2020-11-03', 'da-captain@philipfund.edu', 'test', 4, 1, 1, '2020-04-20 16:20:00', 'dev/forms/taxevasion.form');


-- Details INSERT

INSERT INTO public.org_details (org_id, tag, mission, type1, type2, type3, url, url_fb, url_tw, url_in, address_id)
VALUES(1, 'Connecting people to charity.', 'Create a secure marketplace for charitable fundraising that puts the power of change in the hands of the people.', 'International', '', '', 'https://charityhub.com', 'facebook.com/charityhub', 'twitter.com/charity_hub', 'linkedin.com/charityhub', 1);

INSERT INTO public.org_details (org_id, tag, mission, type1, type2, type3, url, url_fb, url_tw, url_in, address_id)
VALUES(2, 'Food Meets Face.', 'Take all the food and put it one place, the mouths of heros brave enough to face the tough challenges our future needs.',
  'Hunger', 'International', '', 'https://mukbangers.net', 'facebook.com/mukbangers', 'twitter.com/mukbangumstyle', 'linkedin.com/muckbangers', 2);

INSERT INTO public.org_details (org_id, tag, mission, type1, type2, type3, url, url_fb, url_tw, url_in, address_id)
VALUES(3, 'Help Jacob get a new Line', 'Jacob really needs an iPhone because we all hate green text messages.', 'iPhone For Jacob', 'Healthcare', 'Animal Rescue',
  'https://jacobiPhone.org', 'facebook.com/jacobiPhone', 'twitter.com/iPhoneJacob', 'linkedin.com/jacobiPhone', 3);

INSERT INTO public.org_details (org_id, tag, mission, type1, type2, type3, url, url_fb, url_tw, url_in, address_id)
VALUES(4, 'Nautical Expertise for Life', 'Captain Philip "Da-Captian" Knott teaches Inner City Kids lifeskills through the ancient privileged hobby of nautical navigation helping them set sail to success.',
  'Education', '', 'The Rent is Too Damn High', 'https://dacaptain.edu', 'facebook.com/dacaptain', 'twitter.com/dacaptain', 'linkedin.com/philipknott', 4);


-- City INSERT (600 Cities)

INSERT INTO public.city (city_id, city, country_id) VALUES (1, 'A Corua (La Corua)', 87);
INSERT INTO public.city (city_id, city, country_id) VALUES (2, 'Abha', 82);
INSERT INTO public.city (city_id, city, country_id) VALUES (3, 'Abu Dhabi', 101);
INSERT INTO public.city (city_id, city, country_id) VALUES (4, 'Acua', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (5, 'Adana', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (6, 'Addis Abeba', 31);
INSERT INTO public.city (city_id, city, country_id) VALUES (7, 'Aden', 107);
INSERT INTO public.city (city_id, city, country_id) VALUES (8, 'Adoni', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (9, 'Ahmadnagar', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (10, 'Akishima', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (11, 'Akron', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (12, 'al-Ayn', 101);
INSERT INTO public.city (city_id, city, country_id) VALUES (13, 'al-Hawiya', 82);
INSERT INTO public.city (city_id, city, country_id) VALUES (14, 'al-Manama', 11);
INSERT INTO public.city (city_id, city, country_id) VALUES (15, 'al-Qadarif', 89);
INSERT INTO public.city (city_id, city, country_id) VALUES (16, 'al-Qatif', 82);
INSERT INTO public.city (city_id, city, country_id) VALUES (17, 'Alessandria', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (18, 'Allappuzha (Alleppey)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (19, 'Allende', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (20, 'Almirante Brown', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (21, 'Alvorada', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (22, 'Ambattur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (23, 'Amersfoort', 67);
INSERT INTO public.city (city_id, city, country_id) VALUES (24, 'Amroha', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (25, 'Angra dos Reis', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (26, 'Anpolis', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (27, 'Antofagasta', 22);
INSERT INTO public.city (city_id, city, country_id) VALUES (28, 'Aparecida de Goinia', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (29, 'Apeldoorn', 67);
INSERT INTO public.city (city_id, city, country_id) VALUES (30, 'Araatuba', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (31, 'Arak', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (32, 'Arecibo', 77);
INSERT INTO public.city (city_id, city, country_id) VALUES (33, 'Arlington', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (34, 'Ashdod', 48);
INSERT INTO public.city (city_id, city, country_id) VALUES (35, 'Ashgabat', 98);
INSERT INTO public.city (city_id, city, country_id) VALUES (36, 'Ashqelon', 48);
INSERT INTO public.city (city_id, city, country_id) VALUES (37, 'Asuncin', 73);
INSERT INTO public.city (city_id, city, country_id) VALUES (38, 'Athenai', 39);
INSERT INTO public.city (city_id, city, country_id) VALUES (39, 'Atinsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (40, 'Atlixco', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (41, 'Augusta-Richmond County', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (42, 'Aurora', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (43, 'Avellaneda', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (44, 'Bag', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (45, 'Baha Blanca', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (46, 'Baicheng', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (47, 'Baiyin', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (48, 'Baku', 10);
INSERT INTO public.city (city_id, city, country_id) VALUES (49, 'Balaiha', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (50, 'Balikesir', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (51, 'Balurghat', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (52, 'Bamenda', 19);
INSERT INTO public.city (city_id, city, country_id) VALUES (53, 'Bandar Seri Begawan', 16);
INSERT INTO public.city (city_id, city, country_id) VALUES (54, 'Banjul', 37);
INSERT INTO public.city (city_id, city, country_id) VALUES (55, 'Barcelona', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (56, 'Basel', 91);
INSERT INTO public.city (city_id, city, country_id) VALUES (57, 'Bat Yam', 48);
INSERT INTO public.city (city_id, city, country_id) VALUES (58, 'Batman', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (59, 'Batna', 2);
INSERT INTO public.city (city_id, city, country_id) VALUES (60, 'Battambang', 18);
INSERT INTO public.city (city_id, city, country_id) VALUES (61, 'Baybay', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (62, 'Bayugan', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (63, 'Bchar', 2);
INSERT INTO public.city (city_id, city, country_id) VALUES (64, 'Beira', 63);
INSERT INTO public.city (city_id, city, country_id) VALUES (65, 'Bellevue', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (66, 'Belm', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (67, 'Benguela', 4);
INSERT INTO public.city (city_id, city, country_id) VALUES (68, 'Beni-Mellal', 62);
INSERT INTO public.city (city_id, city, country_id) VALUES (69, 'Benin City', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (70, 'Bergamo', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (71, 'Berhampore (Baharampur)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (72, 'Bern', 91);
INSERT INTO public.city (city_id, city, country_id) VALUES (73, 'Bhavnagar', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (74, 'Bhilwara', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (75, 'Bhimavaram', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (76, 'Bhopal', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (77, 'Bhusawal', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (78, 'Bijapur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (79, 'Bilbays', 29);
INSERT INTO public.city (city_id, city, country_id) VALUES (80, 'Binzhou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (81, 'Birgunj', 66);
INSERT INTO public.city (city_id, city, country_id) VALUES (82, 'Bislig', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (83, 'Blumenau', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (84, 'Boa Vista', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (85, 'Boksburg', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (86, 'Botosani', 78);
INSERT INTO public.city (city_id, city, country_id) VALUES (87, 'Botshabelo', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (88, 'Bradford', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (89, 'Braslia', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (90, 'Bratislava', 84);
INSERT INTO public.city (city_id, city, country_id) VALUES (91, 'Brescia', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (92, 'Brest', 34);
INSERT INTO public.city (city_id, city, country_id) VALUES (93, 'Brindisi', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (94, 'Brockton', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (95, 'Bucuresti', 78);
INSERT INTO public.city (city_id, city, country_id) VALUES (96, 'Buenaventura', 24);
INSERT INTO public.city (city_id, city, country_id) VALUES (97, 'Bydgoszcz', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (98, 'Cabuyao', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (99, 'Callao', 74);
INSERT INTO public.city (city_id, city, country_id) VALUES (100, 'Cam Ranh', 105);
INSERT INTO public.city (city_id, city, country_id) VALUES (101, 'Cape Coral', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (102, 'Caracas', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (103, 'Carmen', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (104, 'Cavite', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (105, 'Cayenne', 35);
INSERT INTO public.city (city_id, city, country_id) VALUES (106, 'Celaya', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (107, 'Chandrapur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (108, 'Changhwa', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (109, 'Changzhou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (110, 'Chapra', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (111, 'Charlotte Amalie', 106);
INSERT INTO public.city (city_id, city, country_id) VALUES (112, 'Chatsworth', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (113, 'Cheju', 86);
INSERT INTO public.city (city_id, city, country_id) VALUES (114, 'Chiayi', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (115, 'Chisinau', 61);
INSERT INTO public.city (city_id, city, country_id) VALUES (116, 'Chungho', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (117, 'Cianjur', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (118, 'Ciomas', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (119, 'Ciparay', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (120, 'Citrus Heights', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (121, 'Citt del Vaticano', 41);
INSERT INTO public.city (city_id, city, country_id) VALUES (122, 'Ciudad del Este', 73);
INSERT INTO public.city (city_id, city, country_id) VALUES (123, 'Clarksville', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (124, 'Coacalco de Berriozbal', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (125, 'Coatzacoalcos', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (126, 'Compton', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (127, 'Coquimbo', 22);
INSERT INTO public.city (city_id, city, country_id) VALUES (128, 'Crdoba', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (129, 'Cuauhtmoc', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (130, 'Cuautla', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (131, 'Cuernavaca', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (132, 'Cuman', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (133, 'Czestochowa', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (134, 'Dadu', 72);
INSERT INTO public.city (city_id, city, country_id) VALUES (135, 'Dallas', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (136, 'Datong', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (137, 'Daugavpils', 54);
INSERT INTO public.city (city_id, city, country_id) VALUES (138, 'Davao', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (139, 'Daxian', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (140, 'Dayton', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (141, 'Deba Habe', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (142, 'Denizli', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (143, 'Dhaka', 12);
INSERT INTO public.city (city_id, city, country_id) VALUES (144, 'Dhule (Dhulia)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (145, 'Dongying', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (146, 'Donostia-San Sebastin', 87);
INSERT INTO public.city (city_id, city, country_id) VALUES (147, 'Dos Quebradas', 24);
INSERT INTO public.city (city_id, city, country_id) VALUES (148, 'Duisburg', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (149, 'Dundee', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (150, 'Dzerzinsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (151, 'Ede', 67);
INSERT INTO public.city (city_id, city, country_id) VALUES (152, 'Effon-Alaiye', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (153, 'El Alto', 14);
INSERT INTO public.city (city_id, city, country_id) VALUES (154, 'El Fuerte', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (155, 'El Monte', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (156, 'Elista', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (157, 'Emeishan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (158, 'Emmen', 67);
INSERT INTO public.city (city_id, city, country_id) VALUES (159, 'Enshi', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (160, 'Erlangen', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (161, 'Escobar', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (162, 'Esfahan', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (163, 'Eskisehir', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (164, 'Etawah', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (165, 'Ezeiza', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (166, 'Ezhou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (167, 'Faaa', 36);
INSERT INTO public.city (city_id, city, country_id) VALUES (168, 'Fengshan', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (169, 'Firozabad', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (170, 'Florencia', 24);
INSERT INTO public.city (city_id, city, country_id) VALUES (171, 'Fontana', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (172, 'Fukuyama', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (173, 'Funafuti', 99);
INSERT INTO public.city (city_id, city, country_id) VALUES (174, 'Fuyu', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (175, 'Fuzhou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (176, 'Gandhinagar', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (177, 'Garden Grove', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (178, 'Garland', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (179, 'Gatineau', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (180, 'Gaziantep', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (181, 'Gijn', 87);
INSERT INTO public.city (city_id, city, country_id) VALUES (182, 'Gingoog', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (183, 'Goinia', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (184, 'Gorontalo', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (185, 'Grand Prairie', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (186, 'Graz', 9);
INSERT INTO public.city (city_id, city, country_id) VALUES (187, 'Greensboro', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (188, 'Guadalajara', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (189, 'Guaruj', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (190, 'guas Lindas de Gois', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (191, 'Gulbarga', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (192, 'Hagonoy', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (193, 'Haining', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (194, 'Haiphong', 105);
INSERT INTO public.city (city_id, city, country_id) VALUES (195, 'Haldia', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (196, 'Halifax', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (197, 'Halisahar', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (198, 'Halle/Saale', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (199, 'Hami', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (200, 'Hamilton', 68);
INSERT INTO public.city (city_id, city, country_id) VALUES (201, 'Hanoi', 105);
INSERT INTO public.city (city_id, city, country_id) VALUES (202, 'Hidalgo', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (203, 'Higashiosaka', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (204, 'Hino', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (205, 'Hiroshima', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (206, 'Hodeida', 107);
INSERT INTO public.city (city_id, city, country_id) VALUES (207, 'Hohhot', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (208, 'Hoshiarpur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (209, 'Hsichuh', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (210, 'Huaian', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (211, 'Hubli-Dharwad', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (212, 'Huejutla de Reyes', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (213, 'Huixquilucan', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (214, 'Hunuco', 74);
INSERT INTO public.city (city_id, city, country_id) VALUES (215, 'Ibirit', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (216, 'Idfu', 29);
INSERT INTO public.city (city_id, city, country_id) VALUES (217, 'Ife', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (218, 'Ikerre', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (219, 'Iligan', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (220, 'Ilorin', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (221, 'Imus', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (222, 'Inegl', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (223, 'Ipoh', 59);
INSERT INTO public.city (city_id, city, country_id) VALUES (224, 'Isesaki', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (225, 'Ivanovo', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (226, 'Iwaki', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (227, 'Iwakuni', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (228, 'Iwatsuki', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (229, 'Izumisano', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (230, 'Jaffna', 88);
INSERT INTO public.city (city_id, city, country_id) VALUES (231, 'Jaipur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (232, 'Jakarta', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (233, 'Jalib al-Shuyukh', 53);
INSERT INTO public.city (city_id, city, country_id) VALUES (234, 'Jamalpur', 12);
INSERT INTO public.city (city_id, city, country_id) VALUES (235, 'Jaroslavl', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (236, 'Jastrzebie-Zdrj', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (237, 'Jedda', 82);
INSERT INTO public.city (city_id, city, country_id) VALUES (238, 'Jelets', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (239, 'Jhansi', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (240, 'Jinchang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (241, 'Jining', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (242, 'Jinzhou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (243, 'Jodhpur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (244, 'Johannesburg', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (245, 'Joliet', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (246, 'Jos Azueta', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (247, 'Juazeiro do Norte', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (248, 'Juiz de Fora', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (249, 'Junan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (250, 'Jurez', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (251, 'Kabul', 1);
INSERT INTO public.city (city_id, city, country_id) VALUES (252, 'Kaduna', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (253, 'Kakamigahara', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (254, 'Kaliningrad', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (255, 'Kalisz', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (256, 'Kamakura', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (257, 'Kamarhati', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (258, 'Kamjanets-Podilskyi', 100);
INSERT INTO public.city (city_id, city, country_id) VALUES (259, 'Kamyin', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (260, 'Kanazawa', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (261, 'Kanchrapara', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (262, 'Kansas City', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (263, 'Karnal', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (264, 'Katihar', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (265, 'Kermanshah', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (266, 'Kilis', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (267, 'Kimberley', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (268, 'Kimchon', 86);
INSERT INTO public.city (city_id, city, country_id) VALUES (269, 'Kingstown', 81);
INSERT INTO public.city (city_id, city, country_id) VALUES (270, 'Kirovo-Tepetsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (271, 'Kisumu', 52);
INSERT INTO public.city (city_id, city, country_id) VALUES (272, 'Kitwe', 109);
INSERT INTO public.city (city_id, city, country_id) VALUES (273, 'Klerksdorp', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (274, 'Kolpino', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (275, 'Konotop', 100);
INSERT INTO public.city (city_id, city, country_id) VALUES (276, 'Koriyama', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (277, 'Korla', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (278, 'Korolev', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (279, 'Kowloon and New Kowloon', 42);
INSERT INTO public.city (city_id, city, country_id) VALUES (280, 'Kragujevac', 108);
INSERT INTO public.city (city_id, city, country_id) VALUES (281, 'Ktahya', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (282, 'Kuching', 59);
INSERT INTO public.city (city_id, city, country_id) VALUES (283, 'Kumbakonam', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (284, 'Kurashiki', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (285, 'Kurgan', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (286, 'Kursk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (287, 'Kuwana', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (288, 'La Paz', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (289, 'La Plata', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (290, 'La Romana', 27);
INSERT INTO public.city (city_id, city, country_id) VALUES (291, 'Laiwu', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (292, 'Lancaster', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (293, 'Laohekou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (294, 'Lapu-Lapu', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (295, 'Laredo', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (296, 'Lausanne', 91);
INSERT INTO public.city (city_id, city, country_id) VALUES (297, 'Le Mans', 34);
INSERT INTO public.city (city_id, city, country_id) VALUES (298, 'Lengshuijiang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (299, 'Leshan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (300, 'Lethbridge', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (301, 'Lhokseumawe', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (302, 'Liaocheng', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (303, 'Liepaja', 54);
INSERT INTO public.city (city_id, city, country_id) VALUES (304, 'Lilongwe', 58);
INSERT INTO public.city (city_id, city, country_id) VALUES (305, 'Lima', 74);
INSERT INTO public.city (city_id, city, country_id) VALUES (306, 'Lincoln', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (307, 'Linz', 9);
INSERT INTO public.city (city_id, city, country_id) VALUES (308, 'Lipetsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (309, 'Livorno', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (310, 'Ljubertsy', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (311, 'Loja', 28);
INSERT INTO public.city (city_id, city, country_id) VALUES (312, 'London', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (313, 'London', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (314, 'Lublin', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (315, 'Lubumbashi', 25);
INSERT INTO public.city (city_id, city, country_id) VALUES (316, 'Lungtan', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (317, 'Luzinia', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (318, 'Madiun', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (319, 'Mahajanga', 57);
INSERT INTO public.city (city_id, city, country_id) VALUES (320, 'Maikop', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (321, 'Malm', 90);
INSERT INTO public.city (city_id, city, country_id) VALUES (322, 'Manchester', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (323, 'Mandaluyong', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (324, 'Mandi Bahauddin', 72);
INSERT INTO public.city (city_id, city, country_id) VALUES (325, 'Mannheim', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (326, 'Maracabo', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (327, 'Mardan', 72);
INSERT INTO public.city (city_id, city, country_id) VALUES (328, 'Maring', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (329, 'Masqat', 71);
INSERT INTO public.city (city_id, city, country_id) VALUES (330, 'Matamoros', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (331, 'Matsue', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (332, 'Meixian', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (333, 'Memphis', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (334, 'Merlo', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (335, 'Mexicali', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (336, 'Miraj', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (337, 'Mit Ghamr', 29);
INSERT INTO public.city (city_id, city, country_id) VALUES (338, 'Miyakonojo', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (339, 'Mogiljov', 13);
INSERT INTO public.city (city_id, city, country_id) VALUES (340, 'Molodetno', 13);
INSERT INTO public.city (city_id, city, country_id) VALUES (341, 'Monclova', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (342, 'Monywa', 64);
INSERT INTO public.city (city_id, city, country_id) VALUES (343, 'Moscow', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (344, 'Mosul', 47);
INSERT INTO public.city (city_id, city, country_id) VALUES (345, 'Mukateve', 100);
INSERT INTO public.city (city_id, city, country_id) VALUES (346, 'Munger (Monghyr)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (347, 'Mwanza', 93);
INSERT INTO public.city (city_id, city, country_id) VALUES (348, 'Mwene-Ditu', 25);
INSERT INTO public.city (city_id, city, country_id) VALUES (349, 'Myingyan', 64);
INSERT INTO public.city (city_id, city, country_id) VALUES (350, 'Mysore', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (351, 'Naala-Porto', 63);
INSERT INTO public.city (city_id, city, country_id) VALUES (352, 'Nabereznyje Telny', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (353, 'Nador', 62);
INSERT INTO public.city (city_id, city, country_id) VALUES (354, 'Nagaon', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (355, 'Nagareyama', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (356, 'Najafabad', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (357, 'Naju', 86);
INSERT INTO public.city (city_id, city, country_id) VALUES (358, 'Nakhon Sawan', 94);
INSERT INTO public.city (city_id, city, country_id) VALUES (359, 'Nam Dinh', 105);
INSERT INTO public.city (city_id, city, country_id) VALUES (360, 'Namibe', 4);
INSERT INTO public.city (city_id, city, country_id) VALUES (361, 'Nantou', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (362, 'Nanyang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (363, 'NDjamna', 21);
INSERT INTO public.city (city_id, city, country_id) VALUES (364, 'Newcastle', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (365, 'Nezahualcyotl', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (366, 'Nha Trang', 105);
INSERT INTO public.city (city_id, city, country_id) VALUES (367, 'Niznekamsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (368, 'Novi Sad', 108);
INSERT INTO public.city (city_id, city, country_id) VALUES (369, 'Novoterkassk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (370, 'Nukualofa', 95);
INSERT INTO public.city (city_id, city, country_id) VALUES (371, 'Nuuk', 40);
INSERT INTO public.city (city_id, city, country_id) VALUES (372, 'Nyeri', 52);
INSERT INTO public.city (city_id, city, country_id) VALUES (373, 'Ocumare del Tuy', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (374, 'Ogbomosho', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (375, 'Okara', 72);
INSERT INTO public.city (city_id, city, country_id) VALUES (376, 'Okayama', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (377, 'Okinawa', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (378, 'Olomouc', 26);
INSERT INTO public.city (city_id, city, country_id) VALUES (379, 'Omdurman', 89);
INSERT INTO public.city (city_id, city, country_id) VALUES (380, 'Omiya', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (381, 'Ondo', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (382, 'Onomichi', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (383, 'Oshawa', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (384, 'Osmaniye', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (385, 'ostka', 100);
INSERT INTO public.city (city_id, city, country_id) VALUES (386, 'Otsu', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (387, 'Oulu', 33);
INSERT INTO public.city (city_id, city, country_id) VALUES (388, 'Ourense (Orense)', 87);
INSERT INTO public.city (city_id, city, country_id) VALUES (389, 'Owo', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (390, 'Oyo', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (391, 'Ozamis', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (392, 'Paarl', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (393, 'Pachuca de Soto', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (394, 'Pak Kret', 94);
INSERT INTO public.city (city_id, city, country_id) VALUES (395, 'Palghat (Palakkad)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (396, 'Pangkal Pinang', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (397, 'Papeete', 36);
INSERT INTO public.city (city_id, city, country_id) VALUES (398, 'Parbhani', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (399, 'Pathankot', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (400, 'Patiala', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (401, 'Patras', 39);
INSERT INTO public.city (city_id, city, country_id) VALUES (402, 'Pavlodar', 51);
INSERT INTO public.city (city_id, city, country_id) VALUES (403, 'Pemalang', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (404, 'Peoria', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (405, 'Pereira', 24);
INSERT INTO public.city (city_id, city, country_id) VALUES (406, 'Phnom Penh', 18);
INSERT INTO public.city (city_id, city, country_id) VALUES (407, 'Pingxiang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (408, 'Pjatigorsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (409, 'Plock', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (410, 'Po', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (411, 'Ponce', 77);
INSERT INTO public.city (city_id, city, country_id) VALUES (412, 'Pontianak', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (413, 'Poos de Caldas', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (414, 'Portoviejo', 28);
INSERT INTO public.city (city_id, city, country_id) VALUES (415, 'Probolinggo', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (416, 'Pudukkottai', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (417, 'Pune', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (418, 'Purnea (Purnia)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (419, 'Purwakarta', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (420, 'Pyongyang', 70);
INSERT INTO public.city (city_id, city, country_id) VALUES (421, 'Qalyub', 29);
INSERT INTO public.city (city_id, city, country_id) VALUES (422, 'Qinhuangdao', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (423, 'Qomsheh', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (424, 'Quilmes', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (425, 'Rae Bareli', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (426, 'Rajkot', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (427, 'Rampur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (428, 'Rancagua', 22);
INSERT INTO public.city (city_id, city, country_id) VALUES (429, 'Ranchi', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (430, 'Richmond Hill', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (431, 'Rio Claro', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (432, 'Rizhao', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (433, 'Roanoke', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (434, 'Robamba', 28);
INSERT INTO public.city (city_id, city, country_id) VALUES (435, 'Rockford', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (436, 'Ruse', 17);
INSERT INTO public.city (city_id, city, country_id) VALUES (437, 'Rustenburg', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (438, 's-Hertogenbosch', 67);
INSERT INTO public.city (city_id, city, country_id) VALUES (439, 'Saarbrcken', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (440, 'Sagamihara', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (441, 'Saint Louis', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (442, 'Saint-Denis', 79);
INSERT INTO public.city (city_id, city, country_id) VALUES (443, 'Sal', 62);
INSERT INTO public.city (city_id, city, country_id) VALUES (444, 'Salala', 71);
INSERT INTO public.city (city_id, city, country_id) VALUES (445, 'Salamanca', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (446, 'Salinas', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (447, 'Salzburg', 9);
INSERT INTO public.city (city_id, city, country_id) VALUES (448, 'Sambhal', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (449, 'San Bernardino', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (450, 'San Felipe de Puerto Plata', 27);
INSERT INTO public.city (city_id, city, country_id) VALUES (451, 'San Felipe del Progreso', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (452, 'San Juan Bautista Tuxtepec', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (453, 'San Lorenzo', 73);
INSERT INTO public.city (city_id, city, country_id) VALUES (454, 'San Miguel de Tucumn', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (455, 'Sanaa', 107);
INSERT INTO public.city (city_id, city, country_id) VALUES (456, 'Santa Brbara dOeste', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (457, 'Santa F', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (458, 'Santa Rosa', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (459, 'Santiago de Compostela', 87);
INSERT INTO public.city (city_id, city, country_id) VALUES (460, 'Santiago de los Caballeros', 27);
INSERT INTO public.city (city_id, city, country_id) VALUES (461, 'Santo Andr', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (462, 'Sanya', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (463, 'Sasebo', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (464, 'Satna', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (465, 'Sawhaj', 29);
INSERT INTO public.city (city_id, city, country_id) VALUES (466, 'Serpuhov', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (467, 'Shahr-e Kord', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (468, 'Shanwei', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (469, 'Shaoguan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (470, 'Sharja', 101);
INSERT INTO public.city (city_id, city, country_id) VALUES (471, 'Shenzhen', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (472, 'Shikarpur', 72);
INSERT INTO public.city (city_id, city, country_id) VALUES (473, 'Shimoga', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (474, 'Shimonoseki', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (475, 'Shivapuri', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (476, 'Shubra al-Khayma', 29);
INSERT INTO public.city (city_id, city, country_id) VALUES (477, 'Siegen', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (478, 'Siliguri (Shiliguri)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (479, 'Simferopol', 100);
INSERT INTO public.city (city_id, city, country_id) VALUES (480, 'Sincelejo', 24);
INSERT INTO public.city (city_id, city, country_id) VALUES (481, 'Sirjan', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (482, 'Sivas', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (483, 'Skikda', 2);
INSERT INTO public.city (city_id, city, country_id) VALUES (484, 'Smolensk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (485, 'So Bernardo do Campo', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (486, 'So Leopoldo', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (487, 'Sogamoso', 24);
INSERT INTO public.city (city_id, city, country_id) VALUES (488, 'Sokoto', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (489, 'Songkhla', 94);
INSERT INTO public.city (city_id, city, country_id) VALUES (490, 'Sorocaba', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (491, 'Soshanguve', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (492, 'Sousse', 96);
INSERT INTO public.city (city_id, city, country_id) VALUES (493, 'South Hill', 5);
INSERT INTO public.city (city_id, city, country_id) VALUES (494, 'Southampton', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (495, 'Southend-on-Sea', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (496, 'Southport', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (497, 'Springs', 85);
INSERT INTO public.city (city_id, city, country_id) VALUES (498, 'Stara Zagora', 17);
INSERT INTO public.city (city_id, city, country_id) VALUES (499, 'Sterling Heights', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (500, 'Stockport', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (501, 'Sucre', 14);
INSERT INTO public.city (city_id, city, country_id) VALUES (502, 'Suihua', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (503, 'Sullana', 74);
INSERT INTO public.city (city_id, city, country_id) VALUES (504, 'Sultanbeyli', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (505, 'Sumqayit', 10);
INSERT INTO public.city (city_id, city, country_id) VALUES (506, 'Sumy', 100);
INSERT INTO public.city (city_id, city, country_id) VALUES (507, 'Sungai Petani', 59);
INSERT INTO public.city (city_id, city, country_id) VALUES (508, 'Sunnyvale', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (509, 'Surakarta', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (510, 'Syktyvkar', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (511, 'Syrakusa', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (512, 'Szkesfehrvr', 43);
INSERT INTO public.city (city_id, city, country_id) VALUES (513, 'Tabora', 93);
INSERT INTO public.city (city_id, city, country_id) VALUES (514, 'Tabriz', 46);
INSERT INTO public.city (city_id, city, country_id) VALUES (515, 'Tabuk', 82);
INSERT INTO public.city (city_id, city, country_id) VALUES (516, 'Tafuna', 3);
INSERT INTO public.city (city_id, city, country_id) VALUES (517, 'Taguig', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (518, 'Taizz', 107);
INSERT INTO public.city (city_id, city, country_id) VALUES (519, 'Talavera', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (520, 'Tallahassee', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (521, 'Tama', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (522, 'Tambaram', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (523, 'Tanauan', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (524, 'Tandil', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (525, 'Tangail', 12);
INSERT INTO public.city (city_id, city, country_id) VALUES (526, 'Tanshui', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (527, 'Tanza', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (528, 'Tarlac', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (529, 'Tarsus', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (530, 'Tartu', 30);
INSERT INTO public.city (city_id, city, country_id) VALUES (531, 'Teboksary', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (532, 'Tegal', 45);
INSERT INTO public.city (city_id, city, country_id) VALUES (533, 'Tel Aviv-Jaffa', 48);
INSERT INTO public.city (city_id, city, country_id) VALUES (534, 'Tete', 63);
INSERT INTO public.city (city_id, city, country_id) VALUES (535, 'Tianjin', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (536, 'Tiefa', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (537, 'Tieli', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (538, 'Tokat', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (539, 'Tonghae', 86);
INSERT INTO public.city (city_id, city, country_id) VALUES (540, 'Tongliao', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (541, 'Torren', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (542, 'Touliu', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (543, 'Toulon', 34);
INSERT INTO public.city (city_id, city, country_id) VALUES (544, 'Toulouse', 34);
INSERT INTO public.city (city_id, city, country_id) VALUES (545, 'Trshavn', 32);
INSERT INTO public.city (city_id, city, country_id) VALUES (546, 'Tsaotun', 92);
INSERT INTO public.city (city_id, city, country_id) VALUES (547, 'Tsuyama', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (548, 'Tuguegarao', 75);
INSERT INTO public.city (city_id, city, country_id) VALUES (549, 'Tychy', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (550, 'Udaipur', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (551, 'Udine', 49);
INSERT INTO public.city (city_id, city, country_id) VALUES (552, 'Ueda', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (553, 'Uijongbu', 86);
INSERT INTO public.city (city_id, city, country_id) VALUES (554, 'Uluberia', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (555, 'Urawa', 50);
INSERT INTO public.city (city_id, city, country_id) VALUES (556, 'Uruapan', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (557, 'Usak', 97);
INSERT INTO public.city (city_id, city, country_id) VALUES (558, 'Usolje-Sibirskoje', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (559, 'Uttarpara-Kotrung', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (560, 'Vaduz', 55);
INSERT INTO public.city (city_id, city, country_id) VALUES (561, 'Valencia', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (562, 'Valle de la Pascua', 104);
INSERT INTO public.city (city_id, city, country_id) VALUES (563, 'Valle de Santiago', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (564, 'Valparai', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (565, 'Vancouver', 20);
INSERT INTO public.city (city_id, city, country_id) VALUES (566, 'Varanasi (Benares)', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (567, 'Vicente Lpez', 6);
INSERT INTO public.city (city_id, city, country_id) VALUES (568, 'Vijayawada', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (569, 'Vila Velha', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (570, 'Vilnius', 56);
INSERT INTO public.city (city_id, city, country_id) VALUES (571, 'Vinh', 105);
INSERT INTO public.city (city_id, city, country_id) VALUES (572, 'Vitria de Santo Anto', 15);
INSERT INTO public.city (city_id, city, country_id) VALUES (573, 'Warren', 103);
INSERT INTO public.city (city_id, city, country_id) VALUES (574, 'Weifang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (575, 'Witten', 38);
INSERT INTO public.city (city_id, city, country_id) VALUES (576, 'Woodridge', 8);
INSERT INTO public.city (city_id, city, country_id) VALUES (577, 'Wroclaw', 76);
INSERT INTO public.city (city_id, city, country_id) VALUES (578, 'Xiangfan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (579, 'Xiangtan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (580, 'Xintai', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (581, 'Xinxiang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (582, 'Yamuna Nagar', 44);
INSERT INTO public.city (city_id, city, country_id) VALUES (583, 'Yangor', 65);
INSERT INTO public.city (city_id, city, country_id) VALUES (584, 'Yantai', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (585, 'Yaound', 19);
INSERT INTO public.city (city_id, city, country_id) VALUES (586, 'Yerevan', 7);
INSERT INTO public.city (city_id, city, country_id) VALUES (587, 'Yinchuan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (588, 'Yingkou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (589, 'York', 102);
INSERT INTO public.city (city_id, city, country_id) VALUES (590, 'Yuncheng', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (591, 'Yuzhou', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (592, 'Zalantun', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (593, 'Zanzibar', 93);
INSERT INTO public.city (city_id, city, country_id) VALUES (594, 'Zaoyang', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (595, 'Zapopan', 60);
INSERT INTO public.city (city_id, city, country_id) VALUES (596, 'Zaria', 69);
INSERT INTO public.city (city_id, city, country_id) VALUES (597, 'Zeleznogorsk', 80);
INSERT INTO public.city (city_id, city, country_id) VALUES (598, 'Zhezqazghan', 51);
INSERT INTO public.city (city_id, city, country_id) VALUES (599, 'Zhoushan', 23);
INSERT INTO public.city (city_id, city, country_id) VALUES (600, 'Ziguinchor', 83);


--
--Country INSERT (109 Countries)
--

INSERT INTO public.country (country_id, country) VALUES (1, 'Afghanistan');
INSERT INTO public.country (country_id, country) VALUES (2, 'Algeria');
INSERT INTO public.country (country_id, country) VALUES (3, 'American Samoa');
INSERT INTO public.country (country_id, country) VALUES (4, 'Angola');
INSERT INTO public.country (country_id, country) VALUES (5, 'Anguilla');
INSERT INTO public.country (country_id, country) VALUES (6, 'Argentina');
INSERT INTO public.country (country_id, country) VALUES (7, 'Armenia');
INSERT INTO public.country (country_id, country) VALUES (8, 'Australia');
INSERT INTO public.country (country_id, country) VALUES (9, 'Austria');
INSERT INTO public.country (country_id, country) VALUES (10, 'Azerbaijan');
INSERT INTO public.country (country_id, country) VALUES (11, 'Bahrain');
INSERT INTO public.country (country_id, country) VALUES (12, 'Bangladesh');
INSERT INTO public.country (country_id, country) VALUES (13, 'Belarus');
INSERT INTO public.country (country_id, country) VALUES (14, 'Bolivia');
INSERT INTO public.country (country_id, country) VALUES (15, 'Brazil');
INSERT INTO public.country (country_id, country) VALUES (16, 'Brunei');
INSERT INTO public.country (country_id, country) VALUES (17, 'Bulgaria');
INSERT INTO public.country (country_id, country) VALUES (18, 'Cambodia');
INSERT INTO public.country (country_id, country) VALUES (19, 'Cameroon');
INSERT INTO public.country (country_id, country) VALUES (20, 'Canada');
INSERT INTO public.country (country_id, country) VALUES (21, 'Chad');
INSERT INTO public.country (country_id, country) VALUES (22, 'Chile');
INSERT INTO public.country (country_id, country) VALUES (23, 'China');
INSERT INTO public.country (country_id, country) VALUES (24, 'Colombia');
INSERT INTO public.country (country_id, country) VALUES (25, 'Congo, The Democratic Republic of the');
INSERT INTO public.country (country_id, country) VALUES (26, 'Czech Republic');
INSERT INTO public.country (country_id, country) VALUES (27, 'Dominican Republic');
INSERT INTO public.country (country_id, country) VALUES (28, 'Ecuador');
INSERT INTO public.country (country_id, country) VALUES (29, 'Egypt');
INSERT INTO public.country (country_id, country) VALUES (30, 'Estonia');
INSERT INTO public.country (country_id, country) VALUES (31, 'Ethiopia');
INSERT INTO public.country (country_id, country) VALUES (32, 'Faroe Islands');
INSERT INTO public.country (country_id, country) VALUES (33, 'Finland');
INSERT INTO public.country (country_id, country) VALUES (34, 'France');
INSERT INTO public.country (country_id, country) VALUES (35, 'French Guiana');
INSERT INTO public.country (country_id, country) VALUES (36, 'French Polynesia');
INSERT INTO public.country (country_id, country) VALUES (37, 'Gambia');
INSERT INTO public.country (country_id, country) VALUES (38, 'Germany');
INSERT INTO public.country (country_id, country) VALUES (39, 'Greece');
INSERT INTO public.country (country_id, country) VALUES (40, 'Greenland');
INSERT INTO public.country (country_id, country) VALUES (41, 'Holy See (Vatican City State)');
INSERT INTO public.country (country_id, country) VALUES (42, 'Hong Kong');
INSERT INTO public.country (country_id, country) VALUES (43, 'Hungary');
INSERT INTO public.country (country_id, country) VALUES (44, 'India');
INSERT INTO public.country (country_id, country) VALUES (45, 'Indonesia');
INSERT INTO public.country (country_id, country) VALUES (46, 'Iran');
INSERT INTO public.country (country_id, country) VALUES (47, 'Iraq');
INSERT INTO public.country (country_id, country) VALUES (48, 'Israel');
INSERT INTO public.country (country_id, country) VALUES (49, 'Italy');
INSERT INTO public.country (country_id, country) VALUES (50, 'Japan');
INSERT INTO public.country (country_id, country) VALUES (51, 'Kazakstan');
INSERT INTO public.country (country_id, country) VALUES (52, 'Kenya');
INSERT INTO public.country (country_id, country) VALUES (53, 'Kuwait');
INSERT INTO public.country (country_id, country) VALUES (54, 'Latvia');
INSERT INTO public.country (country_id, country) VALUES (55, 'Liechtenstein');
INSERT INTO public.country (country_id, country) VALUES (56, 'Lithuania');
INSERT INTO public.country (country_id, country) VALUES (57, 'Madagascar');
INSERT INTO public.country (country_id, country) VALUES (58, 'Malawi');
INSERT INTO public.country (country_id, country) VALUES (59, 'Malaysia');
INSERT INTO public.country (country_id, country) VALUES (60, 'Mexico');
INSERT INTO public.country (country_id, country) VALUES (61, 'Moldova');
INSERT INTO public.country (country_id, country) VALUES (62, 'Morocco');
INSERT INTO public.country (country_id, country) VALUES (63, 'Mozambique');
INSERT INTO public.country (country_id, country) VALUES (64, 'Myanmar');
INSERT INTO public.country (country_id, country) VALUES (65, 'Nauru');
INSERT INTO public.country (country_id, country) VALUES (66, 'Nepal');
INSERT INTO public.country (country_id, country) VALUES (67, 'Netherlands');
INSERT INTO public.country (country_id, country) VALUES (68, 'New Zealand');
INSERT INTO public.country (country_id, country) VALUES (69, 'Nigeria');
INSERT INTO public.country (country_id, country) VALUES (70, 'North Korea');
INSERT INTO public.country (country_id, country) VALUES (71, 'Oman');
INSERT INTO public.country (country_id, country) VALUES (72, 'Pakistan');
INSERT INTO public.country (country_id, country) VALUES (73, 'Paraguay');
INSERT INTO public.country (country_id, country) VALUES (74, 'Peru');
INSERT INTO public.country (country_id, country) VALUES (75, 'Philippines');
INSERT INTO public.country (country_id, country) VALUES (76, 'Poland');
INSERT INTO public.country (country_id, country) VALUES (77, 'Puerto Rico');
INSERT INTO public.country (country_id, country) VALUES (78, 'Romania');
INSERT INTO public.country (country_id, country) VALUES (79, 'Runion');
INSERT INTO public.country (country_id, country) VALUES (80, 'Russian Federation');
INSERT INTO public.country (country_id, country) VALUES (81, 'Saint Vincent and the Grenadines');
INSERT INTO public.country (country_id, country) VALUES (82, 'Saudi Arabia');
INSERT INTO public.country (country_id, country) VALUES (83, 'Senegal');
INSERT INTO public.country (country_id, country) VALUES (84, 'Slovakia');
INSERT INTO public.country (country_id, country) VALUES (85, 'South Africa');
INSERT INTO public.country (country_id, country) VALUES (86, 'South Korea');
INSERT INTO public.country (country_id, country) VALUES (87, 'Spain');
INSERT INTO public.country (country_id, country) VALUES (88, 'Sri Lanka');
INSERT INTO public.country (country_id, country) VALUES (89, 'Sudan');
INSERT INTO public.country (country_id, country) VALUES (90, 'Sweden');
INSERT INTO public.country (country_id, country) VALUES (91, 'Switzerland');
INSERT INTO public.country (country_id, country) VALUES (92, 'Taiwan');
INSERT INTO public.country (country_id, country) VALUES (93, 'Tanzania');
INSERT INTO public.country (country_id, country) VALUES (94, 'Thailand');
INSERT INTO public.country (country_id, country) VALUES (95, 'Tonga');
INSERT INTO public.country (country_id, country) VALUES (96, 'Tunisia');
INSERT INTO public.country (country_id, country) VALUES (97, 'Turkey');
INSERT INTO public.country (country_id, country) VALUES (98, 'Turkmenistan');
INSERT INTO public.country (country_id, country) VALUES (99, 'Tuvalu');
INSERT INTO public.country (country_id, country) VALUES (100, 'Ukraine');
INSERT INTO public.country (country_id, country) VALUES (101, 'United Arab Emirates');
INSERT INTO public.country (country_id, country) VALUES (102, 'United Kingdom');
INSERT INTO public.country (country_id, country) VALUES (103, 'United States');
INSERT INTO public.country (country_id, country) VALUES (104, 'Venezuela');
INSERT INTO public.country (country_id, country) VALUES (105, 'Vietnam');
INSERT INTO public.country (country_id, country) VALUES (106, 'Virgin Islands, U.S.');
INSERT INTO public.country (country_id, country) VALUES (107, 'Yemen');
INSERT INTO public.country (country_id, country) VALUES (108, 'Yugoslavia');
INSERT INTO public.country (country_id, country) VALUES (109, 'Zambia');


--
--ALTERATIONS
--

-- PRIMARY Keys

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);

--ALTER TABLE ONLY public.category
  --  ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT customer_pkey PRIMARY KEY (account_id);

ALTER TABLE ONLY public.org_account
    ADD CONSTRAINT org_account_pkey PRIMARY KEY (org_id);

ALTER TABLE ONLY public.org_details
    ADD CONSTRAINT org_details_pkey PRIMARY KEY (org_id);

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);

-- FOREIGN Keys

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_city_fkey FOREIGN KEY (city_id)
    REFERENCES public.city(city_id);

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_fkey FOREIGN KEY (country_id)
    REFERENCES public.country(country_id);

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_customer_id_fkey FOREIGN KEY (account_id)
    REFERENCES public.user_account(account_id);

--ALTER TABLE ONLY public.payment
  --  ADD CONSTRAINT payment_org_id_fkey FOREIGN KEY (payment_id)
    --REFERENCES public.org_account(payment_id);

ALTER TABLE ONLY public.org_account
    ADD CONSTRAINT org_account_org_id_fkey FOREIGN KEY (payment_id)
    REFERENCES public.payment(payment_id);

ALTER TABLE ONLY public.org_details
    ADD CONSTRAINT org_details_org_id_fkey FOREIGN KEY (org_id)
    REFERENCES public.org_account(org_id);

--ALTER TABLE ONLY public.category
  --  ADD CONSTRAINT category_category_id_fkey FOREIGN KEY (category_id)
    --REFERENCES public.org_account(category_id);

--ALTER TABLE ONLY public.org_account
  --  ADD CONSTRAINT org_account_category_id_fkey FOREIGN KEY (category_id)
    --REFERENCES public.category(category_id);




--CREATE INDEX idx_fk_address_id
  --  ON public.user_account
    --USING btree (address_id);

--CREATE INDEX idx_fk_city_id
  --  ON public.address
    --USING btree (city_id);

--CREATE INDEX idx_fk_country_id
  --  ON public.city
    --USING btree (country_id);

--CREATE INDEX idx_fk_customer_id
  --  ON public.payment
    --USING btree (account_id);

--CREATE INDEX idx_last_name
  --  ON public.user_account
    --USING btree (last_name);

  --  CREATE TYPE charity_type AS ENUM (
    --    'Homelessness',
      --  'Disaster',
        --'Animal Rescue',
        --'Environmental',
      --  'Healthcare',
  --      'Education',
--        'Arts',
  --      'Hunger',
    --    'Housing',
      --  'International'
  --  );
