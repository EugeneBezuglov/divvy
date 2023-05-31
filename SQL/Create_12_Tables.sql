-- DROP TABLE IF EXISTS public.feb2022;
-- DROP TABLE IF EXISTS public.mar2022;

CREATE TABLE IF NOT EXISTS public.feb2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT feb2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.mar2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT mar2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.apr2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT apr2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.may2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT may2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.jun2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT jun2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.jul2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT jul2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.aug2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT aug2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.sep2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT sep2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.oct2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT oct2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.nov2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT nov2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.dec2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT dec2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.jan2023
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT jan2023_pkey PRIMARY KEY (ride_id)
);