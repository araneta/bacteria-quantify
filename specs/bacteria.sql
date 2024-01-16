--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

-- Started on 2024-01-16 07:30:33 WIB

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 320041)
-- Name: bacteria; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA bacteria;


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA bacteria; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA bacteria IS 'NGS generated';


--
-- TOC entry 707 (class 1247 OID 320110)
-- Name: -ngs_HistoryDetail_type-; Type: TYPE; Schema: bacteria; Owner: -
--

CREATE TYPE bacteria."-ngs_HistoryDetail_type-" AS (
	"ID" integer,
	"HistoryURI" text,
	"HistoryID" integer,
	species character varying,
	"totalColony" integer,
	"createdAt" timestamp with time zone,
	"updatedAt" timestamp with time zone,
	"deletedAt" timestamp with time zone
);


--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 707
-- Name: TYPE "-ngs_HistoryDetail_type-"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON TYPE bacteria."-ngs_HistoryDetail_type-" IS 'NGS generated';


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."ID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."ID" IS 'NGS generated';


--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."HistoryURI"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."HistoryURI" IS 'NGS generated';


--
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."HistoryID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."HistoryID" IS 'NGS generated';


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-".species; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-".species IS 'NGS generated';


--
-- TOC entry 3125 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."totalColony"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."totalColony" IS 'NGS generated';


--
-- TOC entry 3126 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."createdAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."createdAt" IS 'NGS generated';


--
-- TOC entry 3127 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."updatedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."updatedAt" IS 'NGS generated';


--
-- TOC entry 3128 (class 0 OID 0)
-- Dependencies: 707
-- Name: COLUMN "-ngs_HistoryDetail_type-"."deletedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_HistoryDetail_type-"."deletedAt" IS 'NGS generated';


--
-- TOC entry 700 (class 1247 OID 320102)
-- Name: -ngs_History_type-; Type: TYPE; Schema: bacteria; Owner: -
--

CREATE TYPE bacteria."-ngs_History_type-" AS (
	"ID" integer,
	"sampleName" character varying,
	"UserURI" text,
	"UserID" integer,
	"localFileImage" character varying,
	"createdAt" timestamp with time zone,
	"updatedAt" timestamp with time zone,
	"deletedAt" timestamp with time zone
);


--
-- TOC entry 3129 (class 0 OID 0)
-- Dependencies: 700
-- Name: TYPE "-ngs_History_type-"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON TYPE bacteria."-ngs_History_type-" IS 'NGS generated';


--
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."ID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."ID" IS 'NGS generated';


--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."sampleName"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."sampleName" IS 'NGS generated';


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."UserURI"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."UserURI" IS 'NGS generated';


--
-- TOC entry 3133 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."UserID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."UserID" IS 'NGS generated';


--
-- TOC entry 3134 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."localFileImage"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."localFileImage" IS 'NGS generated';


--
-- TOC entry 3135 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."createdAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."createdAt" IS 'NGS generated';


--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."updatedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."updatedAt" IS 'NGS generated';


--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 700
-- Name: COLUMN "-ngs_History_type-"."deletedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_History_type-"."deletedAt" IS 'NGS generated';


--
-- TOC entry 693 (class 1247 OID 320094)
-- Name: -ngs_User_type-; Type: TYPE; Schema: bacteria; Owner: -
--

CREATE TYPE bacteria."-ngs_User_type-" AS (
	"ID" integer,
	email character varying,
	password character varying,
	"forgottenPasswordTime" timestamp with time zone,
	"forgottenPasswordCode" character varying,
	"lastAccess" timestamp with time zone,
	"fullName" character varying,
	"createdAt" timestamp with time zone,
	"updatedAt" timestamp with time zone,
	"deletedAt" timestamp with time zone
);


--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 693
-- Name: TYPE "-ngs_User_type-"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON TYPE bacteria."-ngs_User_type-" IS 'NGS generated';


--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."ID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."ID" IS 'NGS generated';


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-".email; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-".email IS 'NGS generated';


--
-- TOC entry 3141 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-".password; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-".password IS 'NGS generated';


--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."forgottenPasswordTime"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."forgottenPasswordTime" IS 'NGS generated';


--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."forgottenPasswordCode"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."forgottenPasswordCode" IS 'NGS generated';


--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."lastAccess"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."lastAccess" IS 'NGS generated';


--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."fullName"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."fullName" IS 'NGS generated';


--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."createdAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."createdAt" IS 'NGS generated';


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."updatedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."updatedAt" IS 'NGS generated';


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 693
-- Name: COLUMN "-ngs_User_type-"."deletedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."-ngs_User_type-"."deletedAt" IS 'NGS generated';


--
-- TOC entry 219 (class 1259 OID 320188)
-- Name: History_ID_seq; Type: SEQUENCE; Schema: bacteria; Owner: -
--

CREATE SEQUENCE bacteria."History_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 213 (class 1259 OID 320103)
-- Name: History; Type: TABLE; Schema: bacteria; Owner: -
--

CREATE TABLE bacteria."History" (
    "ID" integer DEFAULT nextval('bacteria."History_ID_seq"'::regclass) NOT NULL,
    "sampleName" character varying DEFAULT ''::character varying NOT NULL,
    "UserID" integer NOT NULL,
    "localFileImage" character varying DEFAULT ''::character varying NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone
);


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE "History"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON TABLE bacteria."History" IS 'NGS generated';


--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."ID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."ID" IS 'NGS generated';


--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."sampleName"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."sampleName" IS 'NGS generated';


--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."UserID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."UserID" IS 'NGS generated';


--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."localFileImage"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."localFileImage" IS 'NGS generated';


--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."createdAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."createdAt" IS 'NGS generated';


--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."updatedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."updatedAt" IS 'NGS generated';


--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN "History"."deletedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."History"."deletedAt" IS 'NGS generated';


--
-- TOC entry 220 (class 1259 OID 320191)
-- Name: HistoryDetail_ID_seq; Type: SEQUENCE; Schema: bacteria; Owner: -
--

CREATE SEQUENCE bacteria."HistoryDetail_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 320111)
-- Name: HistoryDetail; Type: TABLE; Schema: bacteria; Owner: -
--

CREATE TABLE bacteria."HistoryDetail" (
    "ID" integer DEFAULT nextval('bacteria."HistoryDetail_ID_seq"'::regclass) NOT NULL,
    "HistoryID" integer NOT NULL,
    species character varying DEFAULT ''::character varying NOT NULL,
    "totalColony" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone
);


--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE "HistoryDetail"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON TABLE bacteria."HistoryDetail" IS 'NGS generated';


--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail"."ID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail"."ID" IS 'NGS generated';


--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail"."HistoryID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail"."HistoryID" IS 'NGS generated';


--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail".species; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail".species IS 'NGS generated';


--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail"."totalColony"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail"."totalColony" IS 'NGS generated';


--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail"."createdAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail"."createdAt" IS 'NGS generated';


--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail"."updatedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail"."updatedAt" IS 'NGS generated';


--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN "HistoryDetail"."deletedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."HistoryDetail"."deletedAt" IS 'NGS generated';


--
-- TOC entry 223 (class 1259 OID 320265)
-- Name: HistoryDetail_entity; Type: VIEW; Schema: bacteria; Owner: -
--

CREATE VIEW bacteria."HistoryDetail_entity" AS
 SELECT _entity."ID",
    (_entity."HistoryID")::text AS "HistoryURI",
    _entity."HistoryID",
    _entity.species,
    _entity."totalColony",
    _entity."createdAt",
    _entity."updatedAt",
    _entity."deletedAt"
   FROM bacteria."HistoryDetail" _entity;


--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 223
-- Name: VIEW "HistoryDetail_entity"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON VIEW bacteria."HistoryDetail_entity" IS 'NGS volatile';


--
-- TOC entry 222 (class 1259 OID 320260)
-- Name: History_entity; Type: VIEW; Schema: bacteria; Owner: -
--

CREATE VIEW bacteria."History_entity" AS
 SELECT _entity."ID",
    (_entity."UserID")::text AS "UserURI",
    _entity."UserID",
    _entity."localFileImage",
    _entity."sampleName",
    _entity."createdAt",
    _entity."updatedAt",
    _entity."deletedAt"
   FROM bacteria."History" _entity;


--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 222
-- Name: VIEW "History_entity"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON VIEW bacteria."History_entity" IS 'NGS volatile';


--
-- TOC entry 270 (class 1255 OID 320304)
-- Name: History(bacteria."HistoryDetail_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."History"(bacteria."HistoryDetail_entity") RETURNS bacteria."History_entity"
    LANGUAGE sql
    AS $_$ 
SELECT _r FROM "bacteria"."History_entity" _r WHERE _r."ID" = $1."HistoryID"
$_$;


--
-- TOC entry 258 (class 1255 OID 320269)
-- Name: URI(bacteria."HistoryDetail_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."URI"(bacteria."HistoryDetail_entity") RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CAST($1."ID" as TEXT)
$_$;


--
-- TOC entry 257 (class 1255 OID 320264)
-- Name: URI(bacteria."History_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."URI"(bacteria."History_entity") RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CAST($1."ID" as TEXT)
$_$;


--
-- TOC entry 218 (class 1259 OID 320185)
-- Name: User_ID_seq; Type: SEQUENCE; Schema: bacteria; Owner: -
--

CREATE SEQUENCE bacteria."User_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 210 (class 1259 OID 320095)
-- Name: User; Type: TABLE; Schema: bacteria; Owner: -
--

CREATE TABLE bacteria."User" (
    "ID" integer DEFAULT nextval('bacteria."User_ID_seq"'::regclass) NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    password character varying DEFAULT ''::character varying NOT NULL,
    "forgottenPasswordTime" timestamp with time zone,
    "forgottenPasswordCode" character varying,
    "lastAccess" timestamp with time zone,
    "fullName" character varying DEFAULT ''::character varying NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone
);


--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE "User"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON TABLE bacteria."User" IS 'NGS generated';


--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."ID"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."ID" IS 'NGS generated';


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User".email; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User".email IS 'NGS generated';


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User".password; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User".password IS 'NGS generated';


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."forgottenPasswordTime"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."forgottenPasswordTime" IS 'NGS generated';


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."forgottenPasswordCode"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."forgottenPasswordCode" IS 'NGS generated';


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."lastAccess"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."lastAccess" IS 'NGS generated';


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."fullName"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."fullName" IS 'NGS generated';


--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."createdAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."createdAt" IS 'NGS generated';


--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."updatedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."updatedAt" IS 'NGS generated';


--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN "User"."deletedAt"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON COLUMN bacteria."User"."deletedAt" IS 'NGS generated';


--
-- TOC entry 221 (class 1259 OID 320255)
-- Name: User_entity; Type: VIEW; Schema: bacteria; Owner: -
--

CREATE VIEW bacteria."User_entity" AS
 SELECT _entity."ID",
    _entity.email,
    _entity.password,
    _entity."forgottenPasswordTime",
    _entity."forgottenPasswordCode",
    _entity."lastAccess",
    _entity."fullName",
    _entity."createdAt",
    _entity."updatedAt",
    _entity."deletedAt"
   FROM bacteria."User" _entity;


--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 221
-- Name: VIEW "User_entity"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON VIEW bacteria."User_entity" IS 'NGS volatile';


--
-- TOC entry 256 (class 1255 OID 320259)
-- Name: URI(bacteria."User_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."URI"(bacteria."User_entity") RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CAST($1."ID" as TEXT)
$_$;


--
-- TOC entry 266 (class 1255 OID 320292)
-- Name: User(bacteria."History_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."User"(bacteria."History_entity") RETURNS bacteria."User_entity"
    LANGUAGE sql
    AS $_$ 
SELECT _r FROM "bacteria"."User_entity" _r WHERE _r."ID" = $1."UserID"
$_$;


--
-- TOC entry 274 (class 1255 OID 320293)
-- Name: cast_HistoryDetail_to_type(bacteria."-ngs_HistoryDetail_type-"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."cast_HistoryDetail_to_type"(bacteria."-ngs_HistoryDetail_type-") RETURNS bacteria."HistoryDetail_entity"
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ROW($1."ID", $1."HistoryURI", $1."HistoryID", $1."species", $1."totalColony", $1."createdAt", $1."updatedAt", $1."deletedAt")::"bacteria"."HistoryDetail_entity"
$_$;


--
-- TOC entry 275 (class 1255 OID 320294)
-- Name: cast_HistoryDetail_to_type(bacteria."HistoryDetail_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."cast_HistoryDetail_to_type"(bacteria."HistoryDetail_entity") RETURNS bacteria."-ngs_HistoryDetail_type-"
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ROW($1."ID", $1."HistoryURI", $1."HistoryID", $1."species", $1."totalColony", $1."createdAt", $1."updatedAt", $1."deletedAt")::"bacteria"."-ngs_HistoryDetail_type-"
$_$;


--
-- TOC entry 272 (class 1255 OID 320281)
-- Name: cast_History_to_type(bacteria."-ngs_History_type-"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."cast_History_to_type"(bacteria."-ngs_History_type-") RETURNS bacteria."History_entity"
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ROW($1."ID", $1."UserURI", $1."UserID", $1."localFileImage", $1."sampleName", $1."createdAt", $1."updatedAt", $1."deletedAt")::"bacteria"."History_entity"
$_$;


--
-- TOC entry 273 (class 1255 OID 320282)
-- Name: cast_History_to_type(bacteria."History_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."cast_History_to_type"(bacteria."History_entity") RETURNS bacteria."-ngs_History_type-"
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ROW($1."ID", $1."sampleName", $1."UserURI", $1."UserID", $1."localFileImage", $1."createdAt", $1."updatedAt", $1."deletedAt")::"bacteria"."-ngs_History_type-"
$_$;


--
-- TOC entry 264 (class 1255 OID 320270)
-- Name: cast_User_to_type(bacteria."-ngs_User_type-"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."cast_User_to_type"(bacteria."-ngs_User_type-") RETURNS bacteria."User_entity"
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ROW($1."ID", $1."email", $1."password", $1."forgottenPasswordTime", $1."forgottenPasswordCode", $1."lastAccess", $1."fullName", $1."createdAt", $1."updatedAt", $1."deletedAt")::"bacteria"."User_entity"
$_$;


--
-- TOC entry 271 (class 1255 OID 320271)
-- Name: cast_User_to_type(bacteria."User_entity"); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."cast_User_to_type"(bacteria."User_entity") RETURNS bacteria."-ngs_User_type-"
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ROW($1."ID", $1."email", $1."password", $1."forgottenPasswordTime", $1."forgottenPasswordCode", $1."lastAccess", $1."fullName", $1."createdAt", $1."updatedAt", $1."deletedAt")::"bacteria"."-ngs_User_type-"
$_$;


--
-- TOC entry 262 (class 1255 OID 320289)
-- Name: insert_History(bacteria."History_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."insert_History"(_inserted bacteria."History_entity"[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
	
	INSERT INTO "bacteria"."History" ("ID", "UserID", "localFileImage", "sampleName", "createdAt", "updatedAt", "deletedAt") VALUES(_inserted[1]."ID", _inserted[1]."UserID", _inserted[1]."localFileImage", _inserted[1]."sampleName", _inserted[1]."createdAt", _inserted[1]."updatedAt", _inserted[1]."deletedAt");
	
	PERFORM pg_notify('aggregate_roots', 'bacteria.History:Insert:' || array["URI"(_inserted[1])]::TEXT);
END
$$;


--
-- TOC entry 267 (class 1255 OID 320301)
-- Name: insert_HistoryDetail(bacteria."HistoryDetail_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."insert_HistoryDetail"(_inserted bacteria."HistoryDetail_entity"[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
	
	INSERT INTO "bacteria"."HistoryDetail" ("ID", "HistoryID", "species", "totalColony", "createdAt", "updatedAt", "deletedAt") VALUES(_inserted[1]."ID", _inserted[1]."HistoryID", _inserted[1]."species", _inserted[1]."totalColony", _inserted[1]."createdAt", _inserted[1]."updatedAt", _inserted[1]."deletedAt");
	
	PERFORM pg_notify('aggregate_roots', 'bacteria.HistoryDetail:Insert:' || array["URI"(_inserted[1])]::TEXT);
END
$$;


--
-- TOC entry 259 (class 1255 OID 320278)
-- Name: insert_User(bacteria."User_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."insert_User"(_inserted bacteria."User_entity"[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
	
	INSERT INTO "bacteria"."User" ("ID", "email", "password", "forgottenPasswordTime", "forgottenPasswordCode", "lastAccess", "fullName", "createdAt", "updatedAt", "deletedAt") VALUES(_inserted[1]."ID", _inserted[1]."email", _inserted[1]."password", _inserted[1]."forgottenPasswordTime", _inserted[1]."forgottenPasswordCode", _inserted[1]."lastAccess", _inserted[1]."fullName", _inserted[1]."createdAt", _inserted[1]."updatedAt", _inserted[1]."deletedAt");
	
	PERFORM pg_notify('aggregate_roots', 'bacteria.User:Insert:' || array["URI"(_inserted[1])]::TEXT);
END
$$;


--
-- TOC entry 263 (class 1255 OID 320290)
-- Name: persist_History(bacteria."History_entity"[], bacteria."History_entity"[], bacteria."History_entity"[], bacteria."History_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."persist_History"(_inserted bacteria."History_entity"[], _updated_original bacteria."History_entity"[], _updated_new bacteria."History_entity"[], _deleted bacteria."History_entity"[]) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE cnt int;
DECLARE uri VARCHAR;
DECLARE tmp record;
DECLARE msg TEXT;
DECLARE _update_count int = array_upper(_updated_original, 1);
DECLARE _delete_count int = array_upper(_deleted, 1);

BEGIN

	

	SET CONSTRAINTS ALL DEFERRED;

	

	INSERT INTO "bacteria"."History" ("ID", "UserID", "localFileImage", "sampleName", "createdAt", "updatedAt", "deletedAt")
	SELECT _i."ID", _i."UserID", _i."localFileImage", _i."sampleName", _i."createdAt", _i."updatedAt", _i."deletedAt" 
	FROM unnest(_inserted) _i;

	

	IF _update_count > 0 THEN
		UPDATE "bacteria"."History" AS _tbl SET "ID" = (_u.changed)."ID", "UserID" = (_u.changed)."UserID", "localFileImage" = (_u.changed)."localFileImage", "sampleName" = (_u.changed)."sampleName", "createdAt" = (_u.changed)."createdAt", "updatedAt" = (_u.changed)."updatedAt", "deletedAt" = (_u.changed)."deletedAt"
		FROM (SELECT unnest(_updated_original) as original, unnest(_updated_new) as changed) _u
		WHERE _tbl."ID" = (_u.original)."ID";

		GET DIAGNOSTICS cnt = ROW_COUNT;
		IF cnt != _update_count THEN 
			RETURN 'Updated ' || cnt || ' row(s). Expected to update ' || _update_count || ' row(s).';
		END IF;
	END IF;

	

	IF _delete_count > 0 THEN
		DELETE FROM "bacteria"."History" AS _tbl
		WHERE (_tbl."ID") IN (SELECT _d."ID" FROM unnest(_deleted) _d);

		GET DIAGNOSTICS cnt = ROW_COUNT;
		IF cnt != _delete_count THEN 
			RETURN 'Deleted ' || cnt || ' row(s). Expected to delete ' || _delete_count || ' row(s).';
		END IF;
	END IF;

	
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.History', 'Insert', (SELECT array_agg(_i."URI") FROM unnest(_inserted) _i));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.History', 'Update', (SELECT array_agg(_u."URI") FROM unnest(_updated_original) _u));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.History', 'Change', (SELECT array_agg((_u.changed)."URI") FROM (SELECT unnest(_updated_original) as original, unnest(_updated_new) as changed) _u WHERE (_u.changed)."ID" != (_u.original)."ID"));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.History', 'Delete', (SELECT array_agg(_d."URI") FROM unnest(_deleted) _d));

	SET CONSTRAINTS ALL IMMEDIATE;

	RETURN NULL;
END
$$;


--
-- TOC entry 268 (class 1255 OID 320302)
-- Name: persist_HistoryDetail(bacteria."HistoryDetail_entity"[], bacteria."HistoryDetail_entity"[], bacteria."HistoryDetail_entity"[], bacteria."HistoryDetail_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."persist_HistoryDetail"(_inserted bacteria."HistoryDetail_entity"[], _updated_original bacteria."HistoryDetail_entity"[], _updated_new bacteria."HistoryDetail_entity"[], _deleted bacteria."HistoryDetail_entity"[]) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE cnt int;
DECLARE uri VARCHAR;
DECLARE tmp record;
DECLARE msg TEXT;
DECLARE _update_count int = array_upper(_updated_original, 1);
DECLARE _delete_count int = array_upper(_deleted, 1);

BEGIN

	

	SET CONSTRAINTS ALL DEFERRED;

	

	INSERT INTO "bacteria"."HistoryDetail" ("ID", "HistoryID", "species", "totalColony", "createdAt", "updatedAt", "deletedAt")
	SELECT _i."ID", _i."HistoryID", _i."species", _i."totalColony", _i."createdAt", _i."updatedAt", _i."deletedAt" 
	FROM unnest(_inserted) _i;

	

	IF _update_count > 0 THEN
		UPDATE "bacteria"."HistoryDetail" AS _tbl SET "ID" = (_u.changed)."ID", "HistoryID" = (_u.changed)."HistoryID", "species" = (_u.changed)."species", "totalColony" = (_u.changed)."totalColony", "createdAt" = (_u.changed)."createdAt", "updatedAt" = (_u.changed)."updatedAt", "deletedAt" = (_u.changed)."deletedAt"
		FROM (SELECT unnest(_updated_original) as original, unnest(_updated_new) as changed) _u
		WHERE _tbl."ID" = (_u.original)."ID";

		GET DIAGNOSTICS cnt = ROW_COUNT;
		IF cnt != _update_count THEN 
			RETURN 'Updated ' || cnt || ' row(s). Expected to update ' || _update_count || ' row(s).';
		END IF;
	END IF;

	

	IF _delete_count > 0 THEN
		DELETE FROM "bacteria"."HistoryDetail" AS _tbl
		WHERE (_tbl."ID") IN (SELECT _d."ID" FROM unnest(_deleted) _d);

		GET DIAGNOSTICS cnt = ROW_COUNT;
		IF cnt != _delete_count THEN 
			RETURN 'Deleted ' || cnt || ' row(s). Expected to delete ' || _delete_count || ' row(s).';
		END IF;
	END IF;

	
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.HistoryDetail', 'Insert', (SELECT array_agg(_i."URI") FROM unnest(_inserted) _i));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.HistoryDetail', 'Update', (SELECT array_agg(_u."URI") FROM unnest(_updated_original) _u));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.HistoryDetail', 'Change', (SELECT array_agg((_u.changed)."URI") FROM (SELECT unnest(_updated_original) as original, unnest(_updated_new) as changed) _u WHERE (_u.changed)."ID" != (_u.original)."ID"));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.HistoryDetail', 'Delete', (SELECT array_agg(_d."URI") FROM unnest(_deleted) _d));

	SET CONSTRAINTS ALL IMMEDIATE;

	RETURN NULL;
END
$$;


--
-- TOC entry 260 (class 1255 OID 320279)
-- Name: persist_User(bacteria."User_entity"[], bacteria."User_entity"[], bacteria."User_entity"[], bacteria."User_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."persist_User"(_inserted bacteria."User_entity"[], _updated_original bacteria."User_entity"[], _updated_new bacteria."User_entity"[], _deleted bacteria."User_entity"[]) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE cnt int;
DECLARE uri VARCHAR;
DECLARE tmp record;
DECLARE msg TEXT;
DECLARE _update_count int = array_upper(_updated_original, 1);
DECLARE _delete_count int = array_upper(_deleted, 1);

BEGIN

	

	SET CONSTRAINTS ALL DEFERRED;

	

	INSERT INTO "bacteria"."User" ("ID", "email", "password", "forgottenPasswordTime", "forgottenPasswordCode", "lastAccess", "fullName", "createdAt", "updatedAt", "deletedAt")
	SELECT _i."ID", _i."email", _i."password", _i."forgottenPasswordTime", _i."forgottenPasswordCode", _i."lastAccess", _i."fullName", _i."createdAt", _i."updatedAt", _i."deletedAt" 
	FROM unnest(_inserted) _i;

	

	IF _update_count > 0 THEN
		UPDATE "bacteria"."User" AS _tbl SET "ID" = (_u.changed)."ID", "email" = (_u.changed)."email", "password" = (_u.changed)."password", "forgottenPasswordTime" = (_u.changed)."forgottenPasswordTime", "forgottenPasswordCode" = (_u.changed)."forgottenPasswordCode", "lastAccess" = (_u.changed)."lastAccess", "fullName" = (_u.changed)."fullName", "createdAt" = (_u.changed)."createdAt", "updatedAt" = (_u.changed)."updatedAt", "deletedAt" = (_u.changed)."deletedAt"
		FROM (SELECT unnest(_updated_original) as original, unnest(_updated_new) as changed) _u
		WHERE _tbl."ID" = (_u.original)."ID";

		GET DIAGNOSTICS cnt = ROW_COUNT;
		IF cnt != _update_count THEN 
			RETURN 'Updated ' || cnt || ' row(s). Expected to update ' || _update_count || ' row(s).';
		END IF;
	END IF;

	

	IF _delete_count > 0 THEN
		DELETE FROM "bacteria"."User" AS _tbl
		WHERE (_tbl."ID") IN (SELECT _d."ID" FROM unnest(_deleted) _d);

		GET DIAGNOSTICS cnt = ROW_COUNT;
		IF cnt != _delete_count THEN 
			RETURN 'Deleted ' || cnt || ' row(s). Expected to delete ' || _delete_count || ' row(s).';
		END IF;
	END IF;

	
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.User', 'Insert', (SELECT array_agg(_i."URI") FROM unnest(_inserted) _i));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.User', 'Update', (SELECT array_agg(_u."URI") FROM unnest(_updated_original) _u));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.User', 'Change', (SELECT array_agg((_u.changed)."URI") FROM (SELECT unnest(_updated_original) as original, unnest(_updated_new) as changed) _u WHERE (_u.changed)."ID" != (_u.original)."ID"));
	PERFORM "-DSL-".Safe_Notify('aggregate_roots', 'bacteria.User', 'Delete', (SELECT array_agg(_d."URI") FROM unnest(_deleted) _d));

	SET CONSTRAINTS ALL IMMEDIATE;

	RETURN NULL;
END
$$;


--
-- TOC entry 265 (class 1255 OID 320291)
-- Name: update_History(bacteria."History_entity"[], bacteria."History_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."update_History"(_original bacteria."History_entity"[], _updated bacteria."History_entity"[]) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE cnt int;
BEGIN
	
	UPDATE "bacteria"."History" AS _tab SET "ID" = _updated[1]."ID", "UserID" = _updated[1]."UserID", "localFileImage" = _updated[1]."localFileImage", "sampleName" = _updated[1]."sampleName", "createdAt" = _updated[1]."createdAt", "updatedAt" = _updated[1]."updatedAt", "deletedAt" = _updated[1]."deletedAt" WHERE _tab."ID" = _original[1]."ID";
	GET DIAGNOSTICS cnt = ROW_COUNT;
	
	PERFORM pg_notify('aggregate_roots', 'bacteria.History:Update:' || array["URI"(_original[1])]::TEXT);
	IF (_original[1]."ID" != _updated[1]."ID") THEN
		PERFORM pg_notify('aggregate_roots', 'bacteria.History:Change:' || array["URI"(_updated[1])]::TEXT);
	END IF;
	RETURN CASE WHEN cnt = 0 THEN 'No rows updated' ELSE NULL END;
END
$$;


--
-- TOC entry 269 (class 1255 OID 320303)
-- Name: update_HistoryDetail(bacteria."HistoryDetail_entity"[], bacteria."HistoryDetail_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."update_HistoryDetail"(_original bacteria."HistoryDetail_entity"[], _updated bacteria."HistoryDetail_entity"[]) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE cnt int;
BEGIN
	
	UPDATE "bacteria"."HistoryDetail" AS _tab SET "ID" = _updated[1]."ID", "HistoryID" = _updated[1]."HistoryID", "species" = _updated[1]."species", "totalColony" = _updated[1]."totalColony", "createdAt" = _updated[1]."createdAt", "updatedAt" = _updated[1]."updatedAt", "deletedAt" = _updated[1]."deletedAt" WHERE _tab."ID" = _original[1]."ID";
	GET DIAGNOSTICS cnt = ROW_COUNT;
	
	PERFORM pg_notify('aggregate_roots', 'bacteria.HistoryDetail:Update:' || array["URI"(_original[1])]::TEXT);
	IF (_original[1]."ID" != _updated[1]."ID") THEN
		PERFORM pg_notify('aggregate_roots', 'bacteria.HistoryDetail:Change:' || array["URI"(_updated[1])]::TEXT);
	END IF;
	RETURN CASE WHEN cnt = 0 THEN 'No rows updated' ELSE NULL END;
END
$$;


--
-- TOC entry 261 (class 1255 OID 320280)
-- Name: update_User(bacteria."User_entity"[], bacteria."User_entity"[]); Type: FUNCTION; Schema: bacteria; Owner: -
--

CREATE FUNCTION bacteria."update_User"(_original bacteria."User_entity"[], _updated bacteria."User_entity"[]) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE cnt int;
BEGIN
	
	UPDATE "bacteria"."User" AS _tab SET "ID" = _updated[1]."ID", "email" = _updated[1]."email", "password" = _updated[1]."password", "forgottenPasswordTime" = _updated[1]."forgottenPasswordTime", "forgottenPasswordCode" = _updated[1]."forgottenPasswordCode", "lastAccess" = _updated[1]."lastAccess", "fullName" = _updated[1]."fullName", "createdAt" = _updated[1]."createdAt", "updatedAt" = _updated[1]."updatedAt", "deletedAt" = _updated[1]."deletedAt" WHERE _tab."ID" = _original[1]."ID";
	GET DIAGNOSTICS cnt = ROW_COUNT;
	
	PERFORM pg_notify('aggregate_roots', 'bacteria.User:Update:' || array["URI"(_original[1])]::TEXT);
	IF (_original[1]."ID" != _updated[1]."ID") THEN
		PERFORM pg_notify('aggregate_roots', 'bacteria.User:Change:' || array["URI"(_updated[1])]::TEXT);
	END IF;
	RETURN CASE WHEN cnt = 0 THEN 'No rows updated' ELSE NULL END;
END
$$;


--
-- TOC entry 217 (class 1259 OID 320114)
-- Name: HistoryDetail_sequence; Type: SEQUENCE; Schema: bacteria; Owner: -
--

CREATE SEQUENCE bacteria."HistoryDetail_sequence"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE "HistoryDetail_sequence"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON SEQUENCE bacteria."HistoryDetail_sequence" IS 'NGS generated';


--
-- TOC entry 226 (class 1259 OID 320297)
-- Name: HistoryDetail_unprocessed_events; Type: VIEW; Schema: bacteria; Owner: -
--

CREATE VIEW bacteria."HistoryDetail_unprocessed_events" AS
 SELECT _aggregate."ID"
   FROM bacteria."HistoryDetail_entity" _aggregate;


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 226
-- Name: VIEW "HistoryDetail_unprocessed_events"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON VIEW bacteria."HistoryDetail_unprocessed_events" IS 'NGS volatile';


--
-- TOC entry 214 (class 1259 OID 320106)
-- Name: History_sequence; Type: SEQUENCE; Schema: bacteria; Owner: -
--

CREATE SEQUENCE bacteria."History_sequence"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 214
-- Name: SEQUENCE "History_sequence"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON SEQUENCE bacteria."History_sequence" IS 'NGS generated';


--
-- TOC entry 225 (class 1259 OID 320285)
-- Name: History_unprocessed_events; Type: VIEW; Schema: bacteria; Owner: -
--

CREATE VIEW bacteria."History_unprocessed_events" AS
 SELECT _aggregate."ID"
   FROM bacteria."History_entity" _aggregate;


--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 225
-- Name: VIEW "History_unprocessed_events"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON VIEW bacteria."History_unprocessed_events" IS 'NGS volatile';


--
-- TOC entry 211 (class 1259 OID 320098)
-- Name: User_sequence; Type: SEQUENCE; Schema: bacteria; Owner: -
--

CREATE SEQUENCE bacteria."User_sequence"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 211
-- Name: SEQUENCE "User_sequence"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON SEQUENCE bacteria."User_sequence" IS 'NGS generated';


--
-- TOC entry 224 (class 1259 OID 320274)
-- Name: User_unprocessed_events; Type: VIEW; Schema: bacteria; Owner: -
--

CREATE VIEW bacteria."User_unprocessed_events" AS
 SELECT _aggregate."ID"
   FROM bacteria."User_entity" _aggregate;


--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 224
-- Name: VIEW "User_unprocessed_events"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON VIEW bacteria."User_unprocessed_events" IS 'NGS volatile';


--
-- TOC entry 3107 (class 0 OID 320103)
-- Dependencies: 213
-- Data for Name: History; Type: TABLE DATA; Schema: bacteria; Owner: -
--

INSERT INTO bacteria."History" VALUES (1003, 'teloxx', 1001, 'c5081573-48b8-45cd-9cae-0f696301001e', '2024-01-07 16:03:59.509123+07', '2024-01-07 16:03:59.509123+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1004, 'uuh', 1001, '02a035e7-9aca-4c8a-8b0a-9608a4ac5f96', '2024-01-08 07:36:37.59564+07', '2024-01-08 07:36:37.59564+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1005, 't3323', 1001, '94e6ef99-c1c6-4df2-ac20-681952ec35b1', '2024-01-08 14:14:10.71821+07', '2024-01-08 14:14:10.71821+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1006, 'te84384394', 1001, '022977b1-6388-428d-9746-1cfe0a0c5212', '2024-01-08 15:28:00.683663+07', '2024-01-08 15:28:00.683663+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1007, 'fsdfd55', 1001, 'a2707686-9b17-4655-9dbd-911d022de19e', '2024-01-08 15:28:55.0007+07', '2024-01-08 15:28:55.0007+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1008, 'hahshs', 1001, 'ccceb89c-8b3a-4bb5-a90e-2a282c10c20c', '2024-01-08 16:11:00.586356+07', '2024-01-08 16:11:00.586356+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1009, 'mantab', 1001, '5082d1c7-b33e-41d2-bccd-5500f401a272', '2024-01-10 06:27:27.004294+07', '2024-01-10 06:27:27.004294+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1010, 'teesddd', 1001, 'be09dbc2-f368-4e2e-819c-471e74875f1f', '2024-01-10 10:08:26.659101+07', '2024-01-10 10:08:26.659101+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1011, 'esst', 1001, 'f7e0d575-2e6d-4f44-82a5-6cfad9b6d048', '2024-01-10 11:30:37.293714+07', '2024-01-10 11:30:37.293714+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1012, 'manteb', 1001, '97604b96-984c-4894-a264-b1100296720b', '2024-01-10 12:01:17.021918+07', '2024-01-10 12:01:17.021918+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1014, 'uuhewe', 1001, '05b7b779-c01d-4d83-aad4-aab2af2f015b', '2024-01-10 12:28:55.712042+07', '2024-01-10 12:28:55.712042+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1015, 'lot', 1001, '0b2e27c3-8c7f-4a3f-9b41-982fd4810e06', '2024-01-10 12:31:51.285993+07', '2024-01-10 12:31:51.285993+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1016, 'tert ert ret ert r', 1001, '1a9570d2-42db-44b2-920b-5f378f092ffc', '2024-01-10 14:17:00.055922+07', '2024-01-10 14:17:00.055922+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1017, 'gdfgfg', 1001, '72293be0-620e-406d-88bf-404c9fb0c2c1', '2024-01-10 15:21:53.649541+07', '2024-01-10 15:21:53.649541+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1018, 'test', 1001, '8e1e73bc-b3c5-4fcb-8efc-a26c6affbac4', '2024-01-10 15:47:24.957652+07', '2024-01-10 15:47:24.957652+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."History" VALUES (1019, 'sample abc', 1001, '9327a23a-5782-44df-8faf-3d949c9e5982', '2024-01-10 16:05:38.144575+07', '2024-01-10 16:05:38.144575+07', '0001-01-01 07:07:12+07:07:12');


--
-- TOC entry 3109 (class 0 OID 320111)
-- Dependencies: 216
-- Data for Name: HistoryDetail; Type: TABLE DATA; Schema: bacteria; Owner: -
--

INSERT INTO bacteria."HistoryDetail" VALUES (1001, 1005, 'Alien2', 122, '2024-01-08 14:14:10.725964+07', '2024-01-08 14:14:10.725964+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1002, 1005, 'Alie32', 142, '2024-01-08 14:14:10.728326+07', '2024-01-08 14:14:10.728326+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1003, 1006, 'Alien2', 122, '2024-01-08 15:28:00.698281+07', '2024-01-08 15:28:00.698281+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1004, 1006, 'Alie32', 142, '2024-01-08 15:28:00.700151+07', '2024-01-08 15:28:00.700151+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1005, 1007, 'Alien2', 122, '2024-01-08 15:28:55.040109+07', '2024-01-08 15:28:55.040109+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1006, 1007, 'Alie32', 142, '2024-01-08 15:28:55.041607+07', '2024-01-08 15:28:55.041607+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1007, 1008, 'Alien2', 122, '2024-01-08 16:11:00.590418+07', '2024-01-08 16:11:00.590418+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1008, 1008, 'Alie32', 142, '2024-01-08 16:11:00.591618+07', '2024-01-08 16:11:00.591618+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1009, 1009, 'Alien2', 122, '2024-01-10 06:27:27.012779+07', '2024-01-10 06:27:27.012779+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1010, 1009, 'Alie32', 142, '2024-01-10 06:27:27.015627+07', '2024-01-10 06:27:27.015627+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1011, 1010, 'Alien2', 122, '2024-01-10 10:08:26.662519+07', '2024-01-10 10:08:26.662519+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1012, 1010, 'Alie32', 142, '2024-01-10 10:08:26.663876+07', '2024-01-10 10:08:26.663876+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1013, 1011, 'Alien2', 122, '2024-01-10 11:30:37.294986+07', '2024-01-10 11:30:37.294986+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1014, 1011, 'Alie32', 142, '2024-01-10 11:30:37.295897+07', '2024-01-10 11:30:37.295897+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1015, 1012, 'Alien2', 122, '2024-01-10 12:01:17.023966+07', '2024-01-10 12:01:17.023966+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1016, 1012, 'Alie32', 142, '2024-01-10 12:01:17.025039+07', '2024-01-10 12:01:17.025039+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1017, 1014, 'Alien2', 122, '2024-01-10 12:28:55.723534+07', '2024-01-10 12:28:55.723534+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1018, 1014, 'Alie32', 142, '2024-01-10 12:28:55.725046+07', '2024-01-10 12:28:55.725046+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1019, 1015, 'Alien2', 122, '2024-01-10 12:31:51.297229+07', '2024-01-10 12:31:51.297229+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1020, 1015, 'Alie32', 142, '2024-01-10 12:31:51.2988+07', '2024-01-10 12:31:51.2988+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1021, 1016, 'B subtilis', 0, '2024-01-10 14:17:00.060231+07', '2024-01-10 14:17:00.060231+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1022, 1016, 'E coli', 0, '2024-01-10 14:17:00.06131+07', '2024-01-10 14:17:00.06131+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1023, 1016, 'P aeruginosa', 0, '2024-01-10 14:17:00.062566+07', '2024-01-10 14:17:00.062566+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1024, 1016, 'S aureus', 1, '2024-01-10 14:17:00.063529+07', '2024-01-10 14:17:00.063529+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1025, 1017, 'B subtilis', 0, '2024-01-10 15:21:53.650917+07', '2024-01-10 15:21:53.650917+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1026, 1017, 'E coli', 0, '2024-01-10 15:21:53.651994+07', '2024-01-10 15:21:53.651994+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1027, 1017, 'P aeruginosa', 0, '2024-01-10 15:21:53.653489+07', '2024-01-10 15:21:53.653489+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1028, 1017, 'S aureus', 1, '2024-01-10 15:21:53.654676+07', '2024-01-10 15:21:53.654676+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1029, 1018, 'B subtilis', 0, '2024-01-10 15:47:24.961697+07', '2024-01-10 15:47:24.961697+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1030, 1018, 'E coli', 0, '2024-01-10 15:47:24.962791+07', '2024-01-10 15:47:24.962791+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1031, 1018, 'P aeruginosa', 0, '2024-01-10 15:47:24.96381+07', '2024-01-10 15:47:24.96381+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1032, 1018, 'S aureus', 0, '2024-01-10 15:47:24.964823+07', '2024-01-10 15:47:24.964823+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1033, 1019, 'B subtilis', 0, '2024-01-10 16:05:38.149253+07', '2024-01-10 16:05:38.149253+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1034, 1019, 'E coli', 0, '2024-01-10 16:05:38.150537+07', '2024-01-10 16:05:38.150537+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1035, 1019, 'P aeruginosa', 9, '2024-01-10 16:05:38.152583+07', '2024-01-10 16:05:38.152583+07', '0001-01-01 07:07:12+07:07:12');
INSERT INTO bacteria."HistoryDetail" VALUES (1036, 1019, 'S aureus', 1, '2024-01-10 16:05:38.153841+07', '2024-01-10 16:05:38.153841+07', '0001-01-01 07:07:12+07:07:12');


--
-- TOC entry 3105 (class 0 OID 320095)
-- Dependencies: 210
-- Data for Name: User; Type: TABLE DATA; Schema: bacteria; Owner: -
--

INSERT INTO bacteria."User" VALUES (1001, 'bejo@mailnesia.com', '$2a$10$VZM4wcQAcehcvB5eTREswe5Yr9YiJkHyiRdXmt2FlCqdwj4p8yGPC', '0001-01-01 07:07:12+07:07:12', '', '2024-01-08 10:25:10.204698+07', 'bejo', '2024-01-03 10:41:43.250844+07', '2024-01-08 10:25:10.205065+07', '0001-01-01 07:07:12+07:07:12');


--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 220
-- Name: HistoryDetail_ID_seq; Type: SEQUENCE SET; Schema: bacteria; Owner: -
--

SELECT pg_catalog.setval('bacteria."HistoryDetail_ID_seq"', 1036, true);


--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 217
-- Name: HistoryDetail_sequence; Type: SEQUENCE SET; Schema: bacteria; Owner: -
--

SELECT pg_catalog.setval('bacteria."HistoryDetail_sequence"', 1, false);


--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 219
-- Name: History_ID_seq; Type: SEQUENCE SET; Schema: bacteria; Owner: -
--

SELECT pg_catalog.setval('bacteria."History_ID_seq"', 1019, true);


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 214
-- Name: History_sequence; Type: SEQUENCE SET; Schema: bacteria; Owner: -
--

SELECT pg_catalog.setval('bacteria."History_sequence"', 1, false);


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 218
-- Name: User_ID_seq; Type: SEQUENCE SET; Schema: bacteria; Owner: -
--

SELECT pg_catalog.setval('bacteria."User_ID_seq"', 1001, true);


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 211
-- Name: User_sequence; Type: SEQUENCE SET; Schema: bacteria; Owner: -
--

SELECT pg_catalog.setval('bacteria."User_sequence"', 1, false);


--
-- TOC entry 2966 (class 2606 OID 320198)
-- Name: History pk_History; Type: CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."History"
    ADD CONSTRAINT "pk_History" PRIMARY KEY ("ID");


--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 2966
-- Name: CONSTRAINT "pk_History" ON "History"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "pk_History" ON bacteria."History" IS 'NGS generated';


--
-- TOC entry 2970 (class 2606 OID 320200)
-- Name: HistoryDetail pk_HistoryDetail; Type: CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."HistoryDetail"
    ADD CONSTRAINT "pk_HistoryDetail" PRIMARY KEY ("ID");


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 2970
-- Name: CONSTRAINT "pk_HistoryDetail" ON "HistoryDetail"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "pk_HistoryDetail" ON bacteria."HistoryDetail" IS 'NGS generated';


--
-- TOC entry 2962 (class 2606 OID 320196)
-- Name: User pk_User; Type: CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."User"
    ADD CONSTRAINT "pk_User" PRIMARY KEY ("ID");


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 2962
-- Name: CONSTRAINT "pk_User" ON "User"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "pk_User" ON bacteria."User" IS 'NGS generated';


--
-- TOC entry 2968 (class 2606 OID 320306)
-- Name: History uq_History_sampleName; Type: CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."History"
    ADD CONSTRAINT "uq_History_sampleName" UNIQUE ("sampleName") DEFERRABLE;


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 2968
-- Name: CONSTRAINT "uq_History_sampleName" ON "History"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "uq_History_sampleName" ON bacteria."History" IS 'NGS generated';


--
-- TOC entry 2964 (class 2606 OID 320202)
-- Name: User uq_User_email; Type: CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."User"
    ADD CONSTRAINT "uq_User_email" UNIQUE (email) DEFERRABLE;


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 2964
-- Name: CONSTRAINT "uq_User_email" ON "User"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "uq_User_email" ON bacteria."User" IS 'NGS generated';


--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 2968
-- Name: INDEX "uq_History_sampleName"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON INDEX bacteria."uq_History_sampleName" IS 'NGS generated';


--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 2964
-- Name: INDEX "uq_User_email"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON INDEX bacteria."uq_User_email" IS 'NGS generated';


--
-- TOC entry 2972 (class 2606 OID 320212)
-- Name: HistoryDetail fk_History; Type: FK CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."HistoryDetail"
    ADD CONSTRAINT "fk_History" FOREIGN KEY ("HistoryID") REFERENCES bacteria."History"("ID") ON UPDATE CASCADE;


--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 2972
-- Name: CONSTRAINT "fk_History" ON "HistoryDetail"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "fk_History" ON bacteria."HistoryDetail" IS 'NGS generated';


--
-- TOC entry 2971 (class 2606 OID 320207)
-- Name: History fk_User; Type: FK CONSTRAINT; Schema: bacteria; Owner: -
--

ALTER TABLE ONLY bacteria."History"
    ADD CONSTRAINT "fk_User" FOREIGN KEY ("UserID") REFERENCES bacteria."User"("ID") ON UPDATE CASCADE;


--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 2971
-- Name: CONSTRAINT "fk_User" ON "History"; Type: COMMENT; Schema: bacteria; Owner: -
--

COMMENT ON CONSTRAINT "fk_User" ON bacteria."History" IS 'NGS generated';


-- Completed on 2024-01-16 07:30:33 WIB

--
-- PostgreSQL database dump complete
--

