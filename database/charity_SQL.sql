/* SQL for CharityHub Database */



/* Address Table*/

-- Table: public.address

-- DROP TABLE public.address;

CREATE TABLE public.address
(
    address_id integer NOT NULL,
    address character varying(50) COLLATE pg_catalog."default" NOT NULL,
    address2 character varying(50) COLLATE pg_catalog."default",
    district character varying(20) COLLATE pg_catalog."default" NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10) COLLATE pg_catalog."default",
    phone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT address_pkey PRIMARY KEY (address_id)
)

TABLESPACE pg_default;

ALTER TABLE public.address
    OWNER to postgres;

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


/* Category(Charity Type) Table*/


    CREATE TABLE public.category
    (
        category_id integer NOT NULL,
        name character varying(25) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT category_pkey PRIMARY KEY (category_id)
    )

    TABLESPACE pg_default;

    ALTER TABLE public.category
        OWNER to postgres;

    COMMENT ON COLUMN public.category.category_id
        IS 'This is an integer so algorithms can search/filter numerically.
    Example:
    Animal Rescue equals the int "1".
    Homelessness equals the int "2". ';


/* City Table */

    -- Table: public.city

    -- DROP TABLE public.city;

    CREATE TABLE public.city
    (
        city_id integer NOT NULL,
        city character varying(50) COLLATE pg_catalog."default" NOT NULL,
        country_id smallint NOT NULL,
        CONSTRAINT city_pkey PRIMARY KEY (city_id)
    )

    TABLESPACE pg_default;

    ALTER TABLE public.city
        OWNER to postgres;
    -- Index: idx_fk_country_id

    -- DROP INDEX public.idx_fk_country_id;

    CREATE INDEX idx_fk_country_id
        ON public.city USING btree
        (country_id ASC NULLS LAST)
        TABLESPACE pg_default;


/* Country Table */

        -- Table: public.country

      -- DROP TABLE public.country;

      CREATE TABLE public.country
      (
          country_id integer NOT NULL,
          country character varying(50) COLLATE pg_catalog."default" NOT NULL,
          CONSTRAINT country_pkey PRIMARY KEY (country_id)
      )

      TABLESPACE pg_default;

      ALTER TABLE public.country
          OWNER to postgres;


/* Charity Organization Account Table (Charity Info) */

          -- Table: public.org_account

          -- DROP TABLE public.org_account;

          CREATE TABLE public.org_account
          (
              "Organization Name" character varying COLLATE pg_catalog."default" NOT NULL,
              activebool boolean NOT NULL,
              category_id integer NOT NULL,
              create_date integer NOT NULL,
              "email address" character varying COLLATE pg_catalog."default" NOT NULL,
              password character varying COLLATE pg_catalog."default" NOT NULL,
              payment_id integer NOT NULL,
              verifiedbool boolean NOT NULL,
              last_update time without time zone NOT NULL,
              form_link character varying COLLATE pg_catalog."default" NOT NULL,
              org_id integer NOT NULL,
              CONSTRAINT org_account_pkey PRIMARY KEY (org_id)
          )

          TABLESPACE pg_default;

          ALTER TABLE public.org_account
              OWNER to postgres;

          GRANT ALL ON TABLE public.org_account TO postgres;

          COMMENT ON COLUMN public.org_account.form_link
              IS 'This is a reference to their Charity creation documents/forms. ';


    /* Payment Table ($$$) */

    -- Table: public.payment

-- DROP TABLE public.payment;

CREATE TABLE public.payment
(
    payment_id integer NOT NULL,
    account_id smallint NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL,
    transaction_id integer NOT NULL,
    CONSTRAINT payment_pkey PRIMARY KEY (payment_id)
)

TABLESPACE pg_default;

ALTER TABLE public.payment
    OWNER to postgres;
-- Index: idx_fk_customer_id

-- DROP INDEX public.idx_fk_customer_id;

CREATE INDEX idx_fk_customer_id
    ON public.payment USING btree
    (account_id ASC NULLS LAST)
    TABLESPACE pg_default;

/* User Account Table */

-- Table: public.user_account

-- DROP TABLE public.user_account;

CREATE TABLE public.user_account
(
    account_id integer NOT NULL,
    first_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    address_id smallint NOT NULL,
    activebool boolean NOT NULL DEFAULT true,
    create_date date NOT NULL DEFAULT ('now'::text)::date,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    active integer NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    username character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_account_pkey PRIMARY KEY (account_id)
)

TABLESPACE pg_default;

ALTER TABLE public.user_account
    OWNER to postgres;
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
    (last_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
