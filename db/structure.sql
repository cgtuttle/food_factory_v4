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
-- Name: application; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA application;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: inventory_item_classes; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_item_classes (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL,
    lot_format character varying,
    product boolean DEFAULT false NOT NULL
);


--
-- Name: inventory_item_classes_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_item_classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_item_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_item_classes_id_seq OWNED BY application.inventory_item_classes.id;


--
-- Name: inventory_item_locations; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_item_locations (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    location_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_item_locations_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_item_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_item_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_item_locations_id_seq OWNED BY application.inventory_item_locations.id;


--
-- Name: inventory_item_lots; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_item_lots (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    lot_code character varying,
    expire_date date,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_item_lots_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_item_lots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_item_lots_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_item_lots_id_seq OWNED BY application.inventory_item_lots.id;


--
-- Name: inventory_items; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_items (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    item_class_id bigint,
    base_unit_id bigint,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_items_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_items_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_items_id_seq OWNED BY application.inventory_items.id;


--
-- Name: inventory_locations; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_locations (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_locations_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_locations_id_seq OWNED BY application.inventory_locations.id;


--
-- Name: inventory_products; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_products (
    id bigint NOT NULL,
    item_id integer,
    code character varying,
    name character varying,
    unit_qty integer,
    gtin_14 character varying,
    unit_upc character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    height double precision,
    length double precision,
    width double precision,
    weight double precision,
    layer_qty integer,
    pallet_layers integer,
    company_id integer DEFAULT 1 NOT NULL,
    channel_id bigint,
    category_id bigint,
    dim_unit_id integer,
    wt_unit_id integer
);


--
-- Name: inventory_products_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_products_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_products_id_seq OWNED BY application.inventory_products.id;


--
-- Name: inventory_receipt_items; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_receipt_items (
    id bigint NOT NULL,
    receipt_id bigint NOT NULL,
    number integer,
    description character varying,
    qty double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_receipts; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_receipts (
    id bigint NOT NULL,
    received_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_shipment_items; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_shipment_items (
    id bigint NOT NULL,
    number integer,
    shipment_id bigint NOT NULL,
    description character varying,
    qty double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_shipment_items_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_shipment_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_shipment_items_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_shipment_items_id_seq OWNED BY application.inventory_shipment_items.id;


--
-- Name: inventory_shipments; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_shipments (
    id bigint NOT NULL,
    requested_ship_at timestamp without time zone,
    requested_pickup_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_shipments_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_shipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_shipments_id_seq OWNED BY application.inventory_shipments.id;


--
-- Name: inventory_transaction_types; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_transaction_types (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    default_direction character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: inventory_transaction_types_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_transaction_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_transaction_types_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_transaction_types_id_seq OWNED BY application.inventory_transaction_types.id;


--
-- Name: inventory_transactions; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.inventory_transactions (
    id bigint NOT NULL,
    transaction_date timestamp without time zone,
    base_qty_increase double precision DEFAULT 0.0,
    base_qty_decrease double precision DEFAULT 0.0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    item_lot_id bigint,
    location_id bigint,
    transaction_type_id bigint,
    source_type character varying,
    source_id bigint,
    company_id integer DEFAULT 1 NOT NULL,
    item_id integer
);


--
-- Name: inventory_transactions_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.inventory_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.inventory_transactions_id_seq OWNED BY application.inventory_transactions.id;


--
-- Name: purchases_order_lines; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.purchases_order_lines (
    id bigint NOT NULL,
    order_id bigint,
    number integer,
    description character varying,
    qty double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: purchases_order_lines_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.purchases_order_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchases_order_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.purchases_order_lines_id_seq OWNED BY application.purchases_order_lines.id;


--
-- Name: purchases_orders; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.purchases_orders (
    id bigint NOT NULL,
    po_number integer,
    order_date timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ship_date character varying,
    pickup_date character varying,
    vendor_account_id integer,
    company_id integer DEFAULT 1 NOT NULL,
    bill_to_address_id integer,
    ship_from_address_id integer,
    ship_to_address_id integer
);


--
-- Name: purchases_orders_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.purchases_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchases_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.purchases_orders_id_seq OWNED BY application.purchases_orders.id;


--
-- Name: purchases_vendors; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.purchases_vendors (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: purchases_vendors_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.purchases_vendors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchases_vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.purchases_vendors_id_seq OWNED BY application.purchases_vendors.id;


--
-- Name: receipt_items_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.receipt_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipt_items_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.receipt_items_id_seq OWNED BY application.inventory_receipt_items.id;


--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.receipts_id_seq OWNED BY application.inventory_receipts.id;


--
-- Name: sales_categories; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_categories (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id bigint
);


--
-- Name: sales_categories_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_categories_id_seq OWNED BY application.sales_categories.id;


--
-- Name: sales_channels; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_channels (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id bigint
);


--
-- Name: sales_channels_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_channels_id_seq OWNED BY application.sales_channels.id;


--
-- Name: sales_customers; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_customers (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: sales_customers_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_customers_id_seq OWNED BY application.sales_customers.id;


--
-- Name: sales_distributors; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_distributors (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id bigint
);


--
-- Name: sales_distributors_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_distributors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_distributors_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_distributors_id_seq OWNED BY application.sales_distributors.id;


--
-- Name: sales_forecast_worksheets; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_forecast_worksheets (
    id bigint NOT NULL,
    inventory_product_id bigint NOT NULL,
    sales_forecast_id bigint NOT NULL,
    velocity double precision,
    store_distribution character varying,
    "integer" character varying,
    starting_on date,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: sales_forecast_worksheets_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_forecast_worksheets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_forecast_worksheets_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_forecast_worksheets_id_seq OWNED BY application.sales_forecast_worksheets.id;


--
-- Name: sales_forecasts; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_forecasts (
    id bigint NOT NULL,
    version_on character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: sales_forecasts_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_forecasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_forecasts_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_forecasts_id_seq OWNED BY application.sales_forecasts.id;


--
-- Name: sales_order_lines; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_order_lines (
    id bigint NOT NULL,
    line_number integer,
    description character varying,
    po_qty bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    order_id bigint,
    unit_id bigint,
    po_price money,
    item_id bigint,
    line_total money,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: sales_order_lines_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_order_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_order_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_order_lines_id_seq OWNED BY application.sales_order_lines.id;


--
-- Name: sales_orders; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_orders (
    id bigint NOT NULL,
    order_number integer,
    order_date timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    po_number character varying,
    po_ship_date timestamp without time zone,
    po_pickup_date timestamp without time zone,
    customer_account_id integer,
    acknowledged boolean DEFAULT false,
    inventory_status character varying,
    dc_notified boolean DEFAULT false,
    shipped boolean DEFAULT false,
    invoiced boolean DEFAULT false,
    company_id integer DEFAULT 1 NOT NULL,
    bill_to_address_id integer,
    ship_from_address_id integer,
    ship_to_address_id integer
);


--
-- Name: sales_orders_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_orders_id_seq OWNED BY application.sales_orders.id;


--
-- Name: sales_retail_chains; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.sales_retail_chains (
    id bigint NOT NULL,
    name character varying,
    sales_distributor_id bigint NOT NULL,
    stores integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: sales_retail_chains_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.sales_retail_chains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_retail_chains_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.sales_retail_chains_id_seq OWNED BY application.sales_retail_chains.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: security_companies; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.security_companies (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    subdomain character varying
);


--
-- Name: security_companies_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.security_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: security_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.security_companies_id_seq OWNED BY application.security_companies.id;


--
-- Name: security_user_companies; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.security_user_companies (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL
);


--
-- Name: security_user_companies_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.security_user_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: security_user_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.security_user_companies_id_seq OWNED BY application.security_user_companies.id;


--
-- Name: security_users; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.security_users (
    id bigint NOT NULL,
    email character varying,
    crypted_password character varying,
    password_salt character varying,
    persistence_token character varying,
    single_access_token character varying,
    perishable_token character varying,
    login_count integer DEFAULT 0 NOT NULL,
    failed_login_count integer DEFAULT 0 NOT NULL,
    last_request_at timestamp without time zone,
    current_login_at timestamp without time zone,
    last_login_at timestamp without time zone,
    current_login_ip character varying,
    last_login_ip character varying,
    active boolean DEFAULT false,
    approved boolean DEFAULT false,
    confirmed boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL,
    admin boolean DEFAULT false NOT NULL
);


--
-- Name: security_users_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.security_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: security_users_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.security_users_id_seq OWNED BY application.security_users.id;


--
-- Name: settings_account_addresses; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_account_addresses (
    id bigint NOT NULL,
    account_id integer,
    address_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: settings_account_addresses_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_account_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_account_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_account_addresses_id_seq OWNED BY application.settings_account_addresses.id;


--
-- Name: settings_account_relationships; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_account_relationships (
    id bigint NOT NULL,
    parent_id bigint,
    child_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: settings_account_relationships_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_account_relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_account_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_account_relationships_id_seq OWNED BY application.settings_account_relationships.id;


--
-- Name: settings_accounts; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_accounts (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    default_address_id bigint,
    owner_id integer,
    owner_type character varying,
    company_id integer DEFAULT 1 NOT NULL
);


--
-- Name: settings_accounts_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_accounts_id_seq OWNED BY application.settings_accounts.id;


--
-- Name: settings_addresses; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_addresses (
    id bigint NOT NULL,
    line_1 character varying,
    city character varying,
    state character varying,
    postal_code character varying,
    country character varying,
    line_2 character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying,
    code character varying,
    company_id integer,
    country_code character varying
);


--
-- Name: settings_addresses_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_addresses_id_seq OWNED BY application.settings_addresses.id;


--
-- Name: settings_columns; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_columns (
    id bigint NOT NULL,
    filter_id bigint NOT NULL,
    attribute_name character varying,
    sort_direction character varying,
    search_string character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id integer,
    company_id integer,
    operator character varying
);


--
-- Name: settings_columns_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_columns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_columns_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_columns_id_seq OWNED BY application.settings_columns.id;


--
-- Name: settings_companies; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_companies (
    id bigint NOT NULL,
    name character varying,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer
);


--
-- Name: settings_companies_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_companies_id_seq OWNED BY application.settings_companies.id;


--
-- Name: settings_filters; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_filters (
    id bigint NOT NULL,
    user_id bigint,
    company_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    pathname character varying,
    model_name character varying
);


--
-- Name: settings_filters_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_filters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_filters_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_filters_id_seq OWNED BY application.settings_filters.id;


--
-- Name: settings_units; Type: TABLE; Schema: application; Owner: -
--

CREATE TABLE application.settings_units (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    abbrev character varying,
    company_id integer DEFAULT 1 NOT NULL,
    unit_type character varying
);


--
-- Name: settings_units_id_seq; Type: SEQUENCE; Schema: application; Owner: -
--

CREATE SEQUENCE application.settings_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_units_id_seq; Type: SEQUENCE OWNED BY; Schema: application; Owner: -
--

ALTER SEQUENCE application.settings_units_id_seq OWNED BY application.settings_units.id;


--
-- Name: inventory_item_classes id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_classes ALTER COLUMN id SET DEFAULT nextval('application.inventory_item_classes_id_seq'::regclass);


--
-- Name: inventory_item_locations id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_locations ALTER COLUMN id SET DEFAULT nextval('application.inventory_item_locations_id_seq'::regclass);


--
-- Name: inventory_item_lots id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_lots ALTER COLUMN id SET DEFAULT nextval('application.inventory_item_lots_id_seq'::regclass);


--
-- Name: inventory_items id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_items ALTER COLUMN id SET DEFAULT nextval('application.inventory_items_id_seq'::regclass);


--
-- Name: inventory_locations id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_locations ALTER COLUMN id SET DEFAULT nextval('application.inventory_locations_id_seq'::regclass);


--
-- Name: inventory_products id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_products ALTER COLUMN id SET DEFAULT nextval('application.inventory_products_id_seq'::regclass);


--
-- Name: inventory_receipt_items id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_receipt_items ALTER COLUMN id SET DEFAULT nextval('application.receipt_items_id_seq'::regclass);


--
-- Name: inventory_receipts id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_receipts ALTER COLUMN id SET DEFAULT nextval('application.receipts_id_seq'::regclass);


--
-- Name: inventory_shipment_items id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_shipment_items ALTER COLUMN id SET DEFAULT nextval('application.inventory_shipment_items_id_seq'::regclass);


--
-- Name: inventory_shipments id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_shipments ALTER COLUMN id SET DEFAULT nextval('application.inventory_shipments_id_seq'::regclass);


--
-- Name: inventory_transaction_types id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transaction_types ALTER COLUMN id SET DEFAULT nextval('application.inventory_transaction_types_id_seq'::regclass);


--
-- Name: inventory_transactions id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transactions ALTER COLUMN id SET DEFAULT nextval('application.inventory_transactions_id_seq'::regclass);


--
-- Name: purchases_order_lines id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.purchases_order_lines ALTER COLUMN id SET DEFAULT nextval('application.purchases_order_lines_id_seq'::regclass);


--
-- Name: purchases_orders id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.purchases_orders ALTER COLUMN id SET DEFAULT nextval('application.purchases_orders_id_seq'::regclass);


--
-- Name: purchases_vendors id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.purchases_vendors ALTER COLUMN id SET DEFAULT nextval('application.purchases_vendors_id_seq'::regclass);


--
-- Name: sales_categories id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_categories ALTER COLUMN id SET DEFAULT nextval('application.sales_categories_id_seq'::regclass);


--
-- Name: sales_channels id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_channels ALTER COLUMN id SET DEFAULT nextval('application.sales_channels_id_seq'::regclass);


--
-- Name: sales_customers id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_customers ALTER COLUMN id SET DEFAULT nextval('application.sales_customers_id_seq'::regclass);


--
-- Name: sales_distributors id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_distributors ALTER COLUMN id SET DEFAULT nextval('application.sales_distributors_id_seq'::regclass);


--
-- Name: sales_forecast_worksheets id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_forecast_worksheets ALTER COLUMN id SET DEFAULT nextval('application.sales_forecast_worksheets_id_seq'::regclass);


--
-- Name: sales_forecasts id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_forecasts ALTER COLUMN id SET DEFAULT nextval('application.sales_forecasts_id_seq'::regclass);


--
-- Name: sales_order_lines id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_order_lines ALTER COLUMN id SET DEFAULT nextval('application.sales_order_lines_id_seq'::regclass);


--
-- Name: sales_orders id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_orders ALTER COLUMN id SET DEFAULT nextval('application.sales_orders_id_seq'::regclass);


--
-- Name: sales_retail_chains id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_retail_chains ALTER COLUMN id SET DEFAULT nextval('application.sales_retail_chains_id_seq'::regclass);


--
-- Name: security_companies id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_companies ALTER COLUMN id SET DEFAULT nextval('application.security_companies_id_seq'::regclass);


--
-- Name: security_user_companies id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_user_companies ALTER COLUMN id SET DEFAULT nextval('application.security_user_companies_id_seq'::regclass);


--
-- Name: security_users id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_users ALTER COLUMN id SET DEFAULT nextval('application.security_users_id_seq'::regclass);


--
-- Name: settings_account_addresses id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_account_addresses ALTER COLUMN id SET DEFAULT nextval('application.settings_account_addresses_id_seq'::regclass);


--
-- Name: settings_account_relationships id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_account_relationships ALTER COLUMN id SET DEFAULT nextval('application.settings_account_relationships_id_seq'::regclass);


--
-- Name: settings_accounts id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_accounts ALTER COLUMN id SET DEFAULT nextval('application.settings_accounts_id_seq'::regclass);


--
-- Name: settings_addresses id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_addresses ALTER COLUMN id SET DEFAULT nextval('application.settings_addresses_id_seq'::regclass);


--
-- Name: settings_columns id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_columns ALTER COLUMN id SET DEFAULT nextval('application.settings_columns_id_seq'::regclass);


--
-- Name: settings_companies id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_companies ALTER COLUMN id SET DEFAULT nextval('application.settings_companies_id_seq'::regclass);


--
-- Name: settings_filters id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_filters ALTER COLUMN id SET DEFAULT nextval('application.settings_filters_id_seq'::regclass);


--
-- Name: settings_units id; Type: DEFAULT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_units ALTER COLUMN id SET DEFAULT nextval('application.settings_units_id_seq'::regclass);


--
-- Name: settings_account_relationships account_relationships_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_account_relationships
    ADD CONSTRAINT account_relationships_pkey PRIMARY KEY (id);


--
-- Name: settings_accounts accounts_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: settings_addresses addresses_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: sales_customers customers_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: inventory_item_classes inventory_item_classes_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_classes
    ADD CONSTRAINT inventory_item_classes_pkey PRIMARY KEY (id);


--
-- Name: inventory_item_locations inventory_item_locations_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_locations
    ADD CONSTRAINT inventory_item_locations_pkey PRIMARY KEY (id);


--
-- Name: inventory_item_lots inventory_item_lots_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_lots
    ADD CONSTRAINT inventory_item_lots_pkey PRIMARY KEY (id);


--
-- Name: inventory_items inventory_items_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (id);


--
-- Name: inventory_locations inventory_locations_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_locations
    ADD CONSTRAINT inventory_locations_pkey PRIMARY KEY (id);


--
-- Name: inventory_products inventory_products_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_products
    ADD CONSTRAINT inventory_products_pkey PRIMARY KEY (id);


--
-- Name: inventory_receipt_items inventory_receipt_items_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_receipt_items
    ADD CONSTRAINT inventory_receipt_items_pkey PRIMARY KEY (id);


--
-- Name: inventory_receipts inventory_receipts_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_receipts
    ADD CONSTRAINT inventory_receipts_pkey PRIMARY KEY (id);


--
-- Name: inventory_shipment_items inventory_shipment_items_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_shipment_items
    ADD CONSTRAINT inventory_shipment_items_pkey PRIMARY KEY (id);


--
-- Name: inventory_shipments inventory_shipments_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_shipments
    ADD CONSTRAINT inventory_shipments_pkey PRIMARY KEY (id);


--
-- Name: inventory_transaction_types inventory_transaction_types_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transaction_types
    ADD CONSTRAINT inventory_transaction_types_pkey PRIMARY KEY (id);


--
-- Name: inventory_transactions inventory_transactions_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transactions
    ADD CONSTRAINT inventory_transactions_pkey PRIMARY KEY (id);


--
-- Name: purchases_order_lines purchases_order_lines_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.purchases_order_lines
    ADD CONSTRAINT purchases_order_lines_pkey PRIMARY KEY (id);


--
-- Name: purchases_orders purchases_orders_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.purchases_orders
    ADD CONSTRAINT purchases_orders_pkey PRIMARY KEY (id);


--
-- Name: purchases_vendors purchases_vendors_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.purchases_vendors
    ADD CONSTRAINT purchases_vendors_pkey PRIMARY KEY (id);


--
-- Name: sales_categories sales_categories_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_categories
    ADD CONSTRAINT sales_categories_pkey PRIMARY KEY (id);


--
-- Name: sales_channels sales_channels_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_channels
    ADD CONSTRAINT sales_channels_pkey PRIMARY KEY (id);


--
-- Name: sales_distributors sales_distributors_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_distributors
    ADD CONSTRAINT sales_distributors_pkey PRIMARY KEY (id);


--
-- Name: sales_forecast_worksheets sales_forecast_worksheets_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_forecast_worksheets
    ADD CONSTRAINT sales_forecast_worksheets_pkey PRIMARY KEY (id);


--
-- Name: sales_forecasts sales_forecasts_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_forecasts
    ADD CONSTRAINT sales_forecasts_pkey PRIMARY KEY (id);


--
-- Name: sales_order_lines sales_order_lines_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_order_lines
    ADD CONSTRAINT sales_order_lines_pkey PRIMARY KEY (id);


--
-- Name: sales_orders sales_orders_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_orders
    ADD CONSTRAINT sales_orders_pkey PRIMARY KEY (id);


--
-- Name: sales_retail_chains sales_retail_chains_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_retail_chains
    ADD CONSTRAINT sales_retail_chains_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: security_companies security_companies_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_companies
    ADD CONSTRAINT security_companies_pkey PRIMARY KEY (id);


--
-- Name: security_user_companies security_user_companies_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_user_companies
    ADD CONSTRAINT security_user_companies_pkey PRIMARY KEY (id);


--
-- Name: security_users security_users_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_users
    ADD CONSTRAINT security_users_pkey PRIMARY KEY (id);


--
-- Name: settings_account_addresses settings_account_addresses_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_account_addresses
    ADD CONSTRAINT settings_account_addresses_pkey PRIMARY KEY (id);


--
-- Name: settings_columns settings_columns_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_columns
    ADD CONSTRAINT settings_columns_pkey PRIMARY KEY (id);


--
-- Name: settings_companies settings_companies_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_companies
    ADD CONSTRAINT settings_companies_pkey PRIMARY KEY (id);


--
-- Name: settings_filters settings_filters_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_filters
    ADD CONSTRAINT settings_filters_pkey PRIMARY KEY (id);


--
-- Name: settings_units units_pkey; Type: CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: index_inventory/item_lots_on_item_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_inventory/item_lots_on_item_id" ON application.inventory_item_lots USING btree (item_id);


--
-- Name: index_inventory_item_locations_on_item_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_inventory_item_locations_on_item_id ON application.inventory_item_locations USING btree (item_id);


--
-- Name: index_inventory_item_locations_on_location_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_inventory_item_locations_on_location_id ON application.inventory_item_locations USING btree (location_id);


--
-- Name: index_inventory_products_on_category_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_inventory_products_on_category_id ON application.inventory_products USING btree (category_id);


--
-- Name: index_inventory_products_on_channel_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_inventory_products_on_channel_id ON application.inventory_products USING btree (channel_id);


--
-- Name: index_items_on_base_unit_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_items_on_base_unit_id ON application.inventory_items USING btree (base_unit_id);


--
-- Name: index_items_on_item_class_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_items_on_item_class_id ON application.inventory_items USING btree (item_class_id);


--
-- Name: index_receipt_items_on_receipt_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_receipt_items_on_receipt_id ON application.inventory_receipt_items USING btree (receipt_id);


--
-- Name: index_sales.order_lines_on_inventory.item_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_sales.order_lines_on_inventory.item_id" ON application.sales_order_lines USING btree (item_id);


--
-- Name: index_sales.order_lines_on_sales.order_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_sales.order_lines_on_sales.order_id" ON application.sales_order_lines USING btree (order_id);


--
-- Name: index_sales.order_lines_on_settings.unit_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_sales.order_lines_on_settings.unit_id" ON application.sales_order_lines USING btree (unit_id);


--
-- Name: index_sales_categories_on_company_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_sales_categories_on_company_id ON application.sales_categories USING btree (company_id);


--
-- Name: index_sales_channels_on_company_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_sales_channels_on_company_id ON application.sales_channels USING btree (company_id);


--
-- Name: index_sales_distributors_on_company_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_sales_distributors_on_company_id ON application.sales_distributors USING btree (company_id);


--
-- Name: index_sales_forecast_worksheets_on_inventory_product_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_sales_forecast_worksheets_on_inventory_product_id ON application.sales_forecast_worksheets USING btree (inventory_product_id);


--
-- Name: index_sales_forecast_worksheets_on_sales_forecast_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_sales_forecast_worksheets_on_sales_forecast_id ON application.sales_forecast_worksheets USING btree (sales_forecast_id);


--
-- Name: index_sales_retail_chains_on_sales_distributor_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_sales_retail_chains_on_sales_distributor_id ON application.sales_retail_chains USING btree (sales_distributor_id);


--
-- Name: index_security_user_companies_on_company_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_security_user_companies_on_company_id ON application.security_user_companies USING btree (company_id);


--
-- Name: index_security_user_companies_on_user_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_security_user_companies_on_user_id ON application.security_user_companies USING btree (user_id);


--
-- Name: index_settings.account_relationships_on_child_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_settings.account_relationships_on_child_id" ON application.settings_account_relationships USING btree (child_id);


--
-- Name: index_settings.account_relationships_on_parent_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_settings.account_relationships_on_parent_id" ON application.settings_account_relationships USING btree (parent_id);


--
-- Name: index_settings.accounts_on_address_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX "index_settings.accounts_on_address_id" ON application.settings_accounts USING btree (default_address_id);


--
-- Name: index_settings.users_on_email; Type: INDEX; Schema: application; Owner: -
--

CREATE UNIQUE INDEX "index_settings.users_on_email" ON application.security_users USING btree (email);


--
-- Name: index_settings.users_on_perishable_token; Type: INDEX; Schema: application; Owner: -
--

CREATE UNIQUE INDEX "index_settings.users_on_perishable_token" ON application.security_users USING btree (perishable_token);


--
-- Name: index_settings.users_on_persistence_token; Type: INDEX; Schema: application; Owner: -
--

CREATE UNIQUE INDEX "index_settings.users_on_persistence_token" ON application.security_users USING btree (persistence_token);


--
-- Name: index_settings.users_on_single_access_token; Type: INDEX; Schema: application; Owner: -
--

CREATE UNIQUE INDEX "index_settings.users_on_single_access_token" ON application.security_users USING btree (single_access_token);


--
-- Name: index_settings_columns_on_filter_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_settings_columns_on_filter_id ON application.settings_columns USING btree (filter_id);


--
-- Name: index_settings_filters_on_company_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_settings_filters_on_company_id ON application.settings_filters USING btree (company_id);


--
-- Name: index_settings_filters_on_user_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_settings_filters_on_user_id ON application.settings_filters USING btree (user_id);


--
-- Name: index_shipment_items_on_shipment_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_shipment_items_on_shipment_id ON application.inventory_shipment_items USING btree (shipment_id);


--
-- Name: index_transactions_on_item_lot_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_transactions_on_item_lot_id ON application.inventory_transactions USING btree (item_lot_id);


--
-- Name: index_transactions_on_location_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_transactions_on_location_id ON application.inventory_transactions USING btree (location_id);


--
-- Name: index_transactions_on_source_type_and_source_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_transactions_on_source_type_and_source_id ON application.inventory_transactions USING btree (source_type, source_id);


--
-- Name: index_transactions_on_transaction_type_id; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX index_transactions_on_transaction_type_id ON application.inventory_transactions USING btree (transaction_type_id);


--
-- Name: order_id_index; Type: INDEX; Schema: application; Owner: -
--

CREATE INDEX order_id_index ON application.purchases_order_lines USING btree (order_id);


--
-- Name: settings_account_relationships fk_rails_116289c974; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_account_relationships
    ADD CONSTRAINT fk_rails_116289c974 FOREIGN KEY (child_id) REFERENCES application.settings_accounts(id);


--
-- Name: settings_account_relationships fk_rails_139f3718cd; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_account_relationships
    ADD CONSTRAINT fk_rails_139f3718cd FOREIGN KEY (parent_id) REFERENCES application.settings_accounts(id);


--
-- Name: security_user_companies fk_rails_25cc023f43; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_user_companies
    ADD CONSTRAINT fk_rails_25cc023f43 FOREIGN KEY (company_id) REFERENCES application.security_companies(id);


--
-- Name: inventory_shipment_items fk_rails_2dd356468c; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_shipment_items
    ADD CONSTRAINT fk_rails_2dd356468c FOREIGN KEY (shipment_id) REFERENCES application.inventory_shipments(id);


--
-- Name: inventory_item_locations fk_rails_36d0459296; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_locations
    ADD CONSTRAINT fk_rails_36d0459296 FOREIGN KEY (location_id) REFERENCES application.inventory_locations(id);


--
-- Name: sales_forecast_worksheets fk_rails_40fb173aa2; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_forecast_worksheets
    ADD CONSTRAINT fk_rails_40fb173aa2 FOREIGN KEY (sales_forecast_id) REFERENCES application.sales_forecasts(id);


--
-- Name: sales_forecast_worksheets fk_rails_6259f7d42d; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_forecast_worksheets
    ADD CONSTRAINT fk_rails_6259f7d42d FOREIGN KEY (inventory_product_id) REFERENCES application.inventory_products(id);


--
-- Name: inventory_transactions fk_rails_63d2d7b1f8; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transactions
    ADD CONSTRAINT fk_rails_63d2d7b1f8 FOREIGN KEY (transaction_type_id) REFERENCES application.inventory_transaction_types(id);


--
-- Name: inventory_products fk_rails_64c56c123c; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_products
    ADD CONSTRAINT fk_rails_64c56c123c FOREIGN KEY (channel_id) REFERENCES application.sales_channels(id);


--
-- Name: security_user_companies fk_rails_77c4b3d22e; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.security_user_companies
    ADD CONSTRAINT fk_rails_77c4b3d22e FOREIGN KEY (user_id) REFERENCES application.security_users(id);


--
-- Name: inventory_products fk_rails_7df7bf81d7; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_products
    ADD CONSTRAINT fk_rails_7df7bf81d7 FOREIGN KEY (category_id) REFERENCES application.sales_categories(id);


--
-- Name: settings_columns fk_rails_820ad5ffa7; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_columns
    ADD CONSTRAINT fk_rails_820ad5ffa7 FOREIGN KEY (filter_id) REFERENCES application.settings_filters(id);


--
-- Name: inventory_item_locations fk_rails_89adb803ce; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_locations
    ADD CONSTRAINT fk_rails_89adb803ce FOREIGN KEY (item_id) REFERENCES application.inventory_items(id);


--
-- Name: inventory_transactions fk_rails_8e61e7825d; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transactions
    ADD CONSTRAINT fk_rails_8e61e7825d FOREIGN KEY (location_id) REFERENCES application.inventory_locations(id);


--
-- Name: inventory_receipt_items fk_rails_99570cac63; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_receipt_items
    ADD CONSTRAINT fk_rails_99570cac63 FOREIGN KEY (receipt_id) REFERENCES application.inventory_receipts(id);


--
-- Name: settings_accounts fk_rails_a62da0d99d; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_accounts
    ADD CONSTRAINT fk_rails_a62da0d99d FOREIGN KEY (default_address_id) REFERENCES application.settings_addresses(id);


--
-- Name: sales_order_lines fk_rails_a9b32ef1d3; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_order_lines
    ADD CONSTRAINT fk_rails_a9b32ef1d3 FOREIGN KEY (order_id) REFERENCES application.sales_orders(id);


--
-- Name: settings_filters fk_rails_ad4cad087d; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_filters
    ADD CONSTRAINT fk_rails_ad4cad087d FOREIGN KEY (company_id) REFERENCES application.security_companies(id);


--
-- Name: inventory_items fk_rails_b5cf8bde49; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_items
    ADD CONSTRAINT fk_rails_b5cf8bde49 FOREIGN KEY (base_unit_id) REFERENCES application.settings_units(id);


--
-- Name: inventory_item_lots fk_rails_c2ae295315; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_item_lots
    ADD CONSTRAINT fk_rails_c2ae295315 FOREIGN KEY (item_id) REFERENCES application.inventory_items(id);


--
-- Name: inventory_transactions fk_rails_db379c7fd4; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.inventory_transactions
    ADD CONSTRAINT fk_rails_db379c7fd4 FOREIGN KEY (item_lot_id) REFERENCES application.inventory_item_lots(id);


--
-- Name: sales_retail_chains fk_rails_e0c736ddbe; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.sales_retail_chains
    ADD CONSTRAINT fk_rails_e0c736ddbe FOREIGN KEY (sales_distributor_id) REFERENCES application.sales_distributors(id);


--
-- Name: settings_filters fk_rails_ee3de997f8; Type: FK CONSTRAINT; Schema: application; Owner: -
--

ALTER TABLE ONLY application.settings_filters
    ADD CONSTRAINT fk_rails_ee3de997f8 FOREIGN KEY (user_id) REFERENCES application.security_users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO application;

INSERT INTO "schema_migrations" (version) VALUES
('20200329185051'),
('20200404153350'),
('20200405180329'),
('20200405180536'),
('20200425145822'),
('20200503182631'),
('20200503183843'),
('20200503211135'),
('20200509203055'),
('20200509203119'),
('20200510143405'),
('20200510144254'),
('20200516162747'),
('20200516184301'),
('20200523160701'),
('20200531215808'),
('20200614223448'),
('20200614224310'),
('20200617215003'),
('20200618124208'),
('20200618124428'),
('20200618125313'),
('20200618210046'),
('20200621175335'),
('20200621180342'),
('20200621203546'),
('20200621203913'),
('20200622160311'),
('20200626130307'),
('20200705160622'),
('20200705194509'),
('20200730203313'),
('20200802175935'),
('20200802181850'),
('20200812130125'),
('20200814012507'),
('20200814125839'),
('20200814210157'),
('20200814221553'),
('20200816151057'),
('20200820130014'),
('20200820232408'),
('20200821124514'),
('20200821124743'),
('20200821125225'),
('20200822145703'),
('20200823141438'),
('20200823143725'),
('20200910164622'),
('20200913184321'),
('20200918213555'),
('20201228221332'),
('20201228225120'),
('20201228225524'),
('20210103215339'),
('20210124211849'),
('20210124212125'),
('20210124231940'),
('20210130184252'),
('20210130203224'),
('20210130203610'),
('20210201135255'),
('20210219214251'),
('20210502145201'),
('20210502150152'),
('20210502160539'),
('20210620204345'),
('20210620204441'),
('20210620204528'),
('20210620205218'),
('20210620212459'),
('20210620212514'),
('20210620221833'),
('20210625125529'),
('20210625223530'),
('20210628125729'),
('20210628202245'),
('20210919193140');


