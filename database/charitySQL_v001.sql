/* SQL for CharityHub Database */

/* Address Table*/

-- Table: public.address

-- DROP TABLE public.address;

CREATE TABLE IF NOT EXISTS public.address
(
    address_id integer NOT NULL,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT address_pkey PRIMARY KEY (address_id)
)

TABLESPACE pg_default;


COMMENT ON TABLE public.address
    IS 'Addresses associated with user billing and Charity information. ';
-- Index: idx_fk_city_id

-- DROP INDEX public.idx_fk_city_id;

CREATE INDEX idx_fk_city_id
    ON public.address USING btree
    (city_id ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.category

    -- DROP TABLE public.category;

INSERT INTO address(address_id, address, address2, district, city_id, postal_code, phone, last_update)
VALUES (1, '0000-00', '1111-11', 'test district', 2, '33333', '444-444-4444', 2020-01-01 00:00:00);


/* Category(Charity Type) Table*/


    CREATE TABLE IF NOT EXISTS public.category
    (
        category_id integer NOT NULL,
        name character varying(25) NOT NULL,
        CONSTRAINT category_pkey PRIMARY KEY (category_id)
    )

    TABLESPACE pg_default;

/* City Table */

    -- Table: public.city

    -- DROP TABLE public.city;

    CREATE TABLE IF NOT EXISTS public.city
    (
        city_id integer NOT NULL,
        city character varying(50) NOT NULL,
        country_id smallint NOT NULL,
        CONSTRAINT city_pkey PRIMARY KEY (city_id)
    )

TABLESPACE pg_default;


    -- Index: idx_fk_country_id

    -- DROP INDEX public.idx_fk_country_id;

    CREATE INDEX idx_fk_country_id
        ON public.city USING btree
        (country_id ASC NULLS LAST)
        TABLESPACE pg_default;


/* Country Table */

        -- Table: public.country

      -- DROP TABLE public.country;

      CREATE TABLE IF NOT EXISTS public.country
      (
          country_id integer NOT NULL,
          country character varying(50) NOT NULL,
          CONSTRAINT country_pkey PRIMARY KEY (country_id)
      )

TABLESPACE pg_default;

/* Charity Organization Account Table (Charity Info) */

          -- Table: public.org_account

          -- DROP TABLE public.org_account;

          CREATE TABLE IF NOT EXISTS public.org_account
          (
              "Organization Name" character varying NOT NULL,
              activebool boolean NOT NULL,
              category_id integer NOT NULL,
              create_date integer NOT NULL,
              "email address" character varying NOT NULL,
              password character varying NOT NULL,
              payment_id integer NOT NULL,
              verifiedbool boolean NOT NULL,
              last_update time,
              form_link character varying NOT NULL,
              org_id integer NOT NULL,
              CONSTRAINT org_account_pkey PRIMARY KEY (org_id)
          )

TABLESPACE pg_default;


    /* Payment Table ($$$) */

    -- Table: public.payment

-- DROP TABLE public.payment;

CREATE TABLE IF NOT EXISTS public.payment
(
    payment_id integer NOT NULL,
    account_id smallint NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL,
    transaction_id integer NOT NULL,
    CONSTRAINT payment_pkey PRIMARY KEY (payment_id)
)

TABLESPACE pg_default;

-- Index: idx_fk_customer_id

-- DROP INDEX public.idx_fk_customer_id;

CREATE INDEX idx_fk_customer_id
    ON public.payment USING btree
    (account_id ASC NULLS LAST)
    TABLESPACE pg_default;

/* User Account Table */

-- Table: public.user_account

-- DROP TABLE public.user_account;

CREATE TABLE IF NOT EXISTS public.user_account
(
    account_id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50) NOT NULL,
    address_id smallint NOT NULL,
    activebool boolean NOT NULL DEFAULT true,
    create_date date NOT NULL, --DEFAULT ('now'::text)::date,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    active integer NOT NULL,
    password character varying NOT NULL,
    username character varying(20) NOT NULL,
    CONSTRAINT user_account_pkey PRIMARY KEY (account_id)
)

TABLESPACE pg_default;

-- Index: idx_fk_address_id

-- DROP INDEX public.idx_fk_address_id;

CREATE INDEX idx_fk_address_id
    ON public.user_account USING btree
    (address_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_last_name

-- DROP INDEX public.idx_last_name;

CREATE INDEX idx_last_name
    ON public.user_account USING btree
    (last_name ASC NULLS LAST)
    TABLESPACE pg_default;
