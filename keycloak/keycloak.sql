--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
8dc3a27c-b403-4984-82f0-2100358b8dab	\N	auth-cookie	master	73d38889-0f7b-4324-abea-a6053d1d596e	2	10	f	\N	\N
d22f2349-2b95-48be-bdf2-2cf3d63ad902	\N	auth-spnego	master	73d38889-0f7b-4324-abea-a6053d1d596e	3	20	f	\N	\N
c14657d4-57fd-4c08-a1e9-5a134e35816f	\N	identity-provider-redirector	master	73d38889-0f7b-4324-abea-a6053d1d596e	2	25	f	\N	\N
60d1d118-4ebf-418d-abae-c73cb5cee1b3	\N	\N	master	73d38889-0f7b-4324-abea-a6053d1d596e	2	30	t	aafd645c-05da-4a65-a862-c9f9f08a7d06	\N
cf1a269e-0f4f-4b62-b2cf-df4f0b60845c	\N	auth-username-password-form	master	aafd645c-05da-4a65-a862-c9f9f08a7d06	0	10	f	\N	\N
50129a1e-63ec-4d4b-ac43-0622a0ad3e70	\N	\N	master	aafd645c-05da-4a65-a862-c9f9f08a7d06	1	20	t	82978a1b-db3e-4c13-93e3-8255bb046cb6	\N
40db5fe0-ac88-45d3-baf8-368011deecc2	\N	conditional-user-configured	master	82978a1b-db3e-4c13-93e3-8255bb046cb6	0	10	f	\N	\N
2a53b68a-acb9-4901-a7d3-75b9f85303bd	\N	auth-otp-form	master	82978a1b-db3e-4c13-93e3-8255bb046cb6	0	20	f	\N	\N
32162667-ee48-4116-8e82-16b41f9de77c	\N	direct-grant-validate-username	master	e1bad2ef-4edd-45c0-9797-1b1dd441814b	0	10	f	\N	\N
b3b60b43-cc6f-4688-88fc-16e6df48b355	\N	direct-grant-validate-password	master	e1bad2ef-4edd-45c0-9797-1b1dd441814b	0	20	f	\N	\N
4d97b980-c7ce-4b17-8108-507f92918a25	\N	\N	master	e1bad2ef-4edd-45c0-9797-1b1dd441814b	1	30	t	1c3e9667-b2d6-49a1-892e-f9d4f6d9874b	\N
7541c8f1-d96d-41ca-8365-910097233158	\N	conditional-user-configured	master	1c3e9667-b2d6-49a1-892e-f9d4f6d9874b	0	10	f	\N	\N
e9fd8c78-709d-495d-921e-e3710364607d	\N	direct-grant-validate-otp	master	1c3e9667-b2d6-49a1-892e-f9d4f6d9874b	0	20	f	\N	\N
26e979da-b3b0-45ec-9799-1f500448f00e	\N	registration-page-form	master	24aff860-e239-4ce8-9e20-5527b719e733	0	10	t	86f69cbf-71a3-4f4f-8ed1-929046bbd37a	\N
21dad3d3-473f-4c9b-b3ab-7bb6c05d142c	\N	registration-user-creation	master	86f69cbf-71a3-4f4f-8ed1-929046bbd37a	0	20	f	\N	\N
95c24d6d-fa12-40e6-947a-cf0a8e73b032	\N	registration-profile-action	master	86f69cbf-71a3-4f4f-8ed1-929046bbd37a	0	40	f	\N	\N
ea934001-8f79-4871-80a5-50f43e49a571	\N	registration-password-action	master	86f69cbf-71a3-4f4f-8ed1-929046bbd37a	0	50	f	\N	\N
c4db194d-fcff-4aae-aa82-e46fd84a14bf	\N	registration-recaptcha-action	master	86f69cbf-71a3-4f4f-8ed1-929046bbd37a	3	60	f	\N	\N
1ad98aa2-881c-4cef-b6c4-9be569263781	\N	reset-credentials-choose-user	master	5374e76e-8163-43bd-a46d-9b1e6e9da6a3	0	10	f	\N	\N
c875bd7e-6531-483c-b07c-2f1c494323a3	\N	reset-credential-email	master	5374e76e-8163-43bd-a46d-9b1e6e9da6a3	0	20	f	\N	\N
121ad709-98c1-400f-8b9f-9710f83b5c38	\N	reset-password	master	5374e76e-8163-43bd-a46d-9b1e6e9da6a3	0	30	f	\N	\N
c323a6ec-50be-43f1-873f-8ed445575d6f	\N	\N	master	5374e76e-8163-43bd-a46d-9b1e6e9da6a3	1	40	t	b3478782-0e1a-44e0-8157-686091b35f44	\N
5d5e53bd-3822-4f09-9350-16ed36e04627	\N	conditional-user-configured	master	b3478782-0e1a-44e0-8157-686091b35f44	0	10	f	\N	\N
bbdcfdba-7d5d-4509-98e1-df2c842b3aad	\N	reset-otp	master	b3478782-0e1a-44e0-8157-686091b35f44	0	20	f	\N	\N
00feaef6-3885-45e3-abd7-b94b14e8c889	\N	client-secret	master	c417d79a-737c-4b35-9a0e-94d3778eec49	2	10	f	\N	\N
0eda3cc2-3628-4315-afae-822dd2de8596	\N	client-jwt	master	c417d79a-737c-4b35-9a0e-94d3778eec49	2	20	f	\N	\N
c8dc7a14-0238-42d9-81e4-1bb2ed975d3c	\N	client-secret-jwt	master	c417d79a-737c-4b35-9a0e-94d3778eec49	2	30	f	\N	\N
cfa25e2a-915d-4f5f-8a70-b558b8e83c8b	\N	client-x509	master	c417d79a-737c-4b35-9a0e-94d3778eec49	2	40	f	\N	\N
b984dbb2-b83b-46ce-aa63-7d838bd53239	\N	idp-review-profile	master	6a28ad0d-9ae2-46f3-aa89-3141438e0ae0	0	10	f	\N	6f0c3a6b-6010-4309-be41-2d3966ea4823
c4346587-4bc4-47ca-bc93-78d9077ffd44	\N	\N	master	6a28ad0d-9ae2-46f3-aa89-3141438e0ae0	0	20	t	ffb00297-de90-4f21-aca0-a06ff2cc0585	\N
c1d8d022-8d60-4678-b451-ddcd391c53c5	\N	idp-create-user-if-unique	master	ffb00297-de90-4f21-aca0-a06ff2cc0585	2	10	f	\N	01ebea64-d2c0-4475-b8a3-3d4b104de6f4
48622fc8-3b23-432d-9e75-e202300d74c2	\N	\N	master	ffb00297-de90-4f21-aca0-a06ff2cc0585	2	20	t	4bb477f2-05fa-4d2b-a485-5f5ed5f0598d	\N
c4ea7981-6371-4307-afb6-1357b36fe849	\N	idp-confirm-link	master	4bb477f2-05fa-4d2b-a485-5f5ed5f0598d	0	10	f	\N	\N
c6a7b7ed-8232-4885-a12e-08641737c4d7	\N	\N	master	4bb477f2-05fa-4d2b-a485-5f5ed5f0598d	0	20	t	cf201e64-6ac8-41d5-8ba6-c9fae507f725	\N
776f48e6-e1c3-4fed-b4b5-443684b97fd8	\N	idp-email-verification	master	cf201e64-6ac8-41d5-8ba6-c9fae507f725	2	10	f	\N	\N
6baf80a1-2714-409e-ae3b-bd8e1e25f986	\N	\N	master	cf201e64-6ac8-41d5-8ba6-c9fae507f725	2	20	t	6ad3ba1c-ff87-407d-93ff-cc6976f581f2	\N
c83f7a22-1064-45d8-a26a-fe28f80e50f0	\N	idp-username-password-form	master	6ad3ba1c-ff87-407d-93ff-cc6976f581f2	0	10	f	\N	\N
1fb4c913-a7df-465f-8cfc-231615635d1a	\N	\N	master	6ad3ba1c-ff87-407d-93ff-cc6976f581f2	1	20	t	8c5710b2-52ff-471f-9ec9-baf7ed8688f1	\N
f3f50963-6867-496d-be0a-41721aa1b3c4	\N	conditional-user-configured	master	8c5710b2-52ff-471f-9ec9-baf7ed8688f1	0	10	f	\N	\N
1caebe2e-1263-44ed-8a77-7b696f8e5180	\N	auth-otp-form	master	8c5710b2-52ff-471f-9ec9-baf7ed8688f1	0	20	f	\N	\N
2092e0ab-f090-4e1d-b2cb-f971a7e6085a	\N	http-basic-authenticator	master	b3575d4f-3371-4c45-9ebc-fdb5c1c56d29	0	10	f	\N	\N
6fac78d5-e4e4-4dd8-a33b-6e592d63e236	\N	docker-http-basic-authenticator	master	3486948f-ce74-4756-9064-447f25fc9bd3	0	10	f	\N	\N
b5c38e09-24c5-413d-b6e2-c64fbd400ab3	\N	no-cookie-redirect	master	0085a8da-2a3f-4140-8ed1-bf3c7f496583	0	10	f	\N	\N
7a3aab93-b365-4859-9678-70002656c567	\N	\N	master	0085a8da-2a3f-4140-8ed1-bf3c7f496583	0	20	t	76ef84d9-0ea7-4b8f-9e4e-53ffeeb47575	\N
14164370-e177-46f9-8bce-df2b51802544	\N	basic-auth	master	76ef84d9-0ea7-4b8f-9e4e-53ffeeb47575	0	10	f	\N	\N
881035c9-27ee-44fa-900b-d4122fad4444	\N	basic-auth-otp	master	76ef84d9-0ea7-4b8f-9e4e-53ffeeb47575	3	20	f	\N	\N
fd41cfc1-46cb-4dac-b743-0cb7d687cd81	\N	auth-spnego	master	76ef84d9-0ea7-4b8f-9e4e-53ffeeb47575	3	30	f	\N	\N
3fd8cbf4-360a-497f-97a8-32ffde5cc4f5	\N	auth-cookie	leari	c96f8b9d-62c7-4965-8e36-42324d575511	2	10	f	\N	\N
b23c0923-279c-45d3-8a23-f2fb6cf833dc	\N	auth-spnego	leari	c96f8b9d-62c7-4965-8e36-42324d575511	3	20	f	\N	\N
9f8ffaad-5022-4c45-a0cd-4cec0a80ce18	\N	identity-provider-redirector	leari	c96f8b9d-62c7-4965-8e36-42324d575511	2	25	f	\N	\N
b59f315a-a182-4850-8e8d-a30d695734dd	\N	\N	leari	c96f8b9d-62c7-4965-8e36-42324d575511	2	30	t	f0607025-4584-428c-9eec-ed28cacc2b29	\N
a300db0d-94b0-4ee5-a1a4-1da008516312	\N	auth-username-password-form	leari	f0607025-4584-428c-9eec-ed28cacc2b29	0	10	f	\N	\N
4e3e4de3-4cce-4251-94f4-c97712304427	\N	\N	leari	f0607025-4584-428c-9eec-ed28cacc2b29	1	20	t	b4c4b7f9-e7f6-4aae-8ed2-4544a6375464	\N
d8db2f74-3c52-444e-8eb1-337f5380d2bc	\N	conditional-user-configured	leari	b4c4b7f9-e7f6-4aae-8ed2-4544a6375464	0	10	f	\N	\N
9783911e-2f59-4a0e-919c-630d7e2424f3	\N	auth-otp-form	leari	b4c4b7f9-e7f6-4aae-8ed2-4544a6375464	0	20	f	\N	\N
1004757f-9eae-4c67-9273-60ab9970c6fb	\N	direct-grant-validate-username	leari	f7b76623-60af-41af-9010-a758c9400603	0	10	f	\N	\N
0b98df04-67c3-4c88-92f6-7f388486e596	\N	direct-grant-validate-password	leari	f7b76623-60af-41af-9010-a758c9400603	0	20	f	\N	\N
b79a6b6e-d582-4108-b1d0-8a0e19161635	\N	\N	leari	f7b76623-60af-41af-9010-a758c9400603	1	30	t	b0bacacc-fc61-4bb1-8bad-30c1898df151	\N
8e8d6e11-0a61-4d6f-bea4-74e1721249ff	\N	conditional-user-configured	leari	b0bacacc-fc61-4bb1-8bad-30c1898df151	0	10	f	\N	\N
8f68fdc5-2d29-4112-80d5-201f939b719f	\N	direct-grant-validate-otp	leari	b0bacacc-fc61-4bb1-8bad-30c1898df151	0	20	f	\N	\N
639d451c-b859-49ac-a713-cf67d2a2285d	\N	registration-page-form	leari	3d705586-818c-4427-9e06-ae7c5d9b6fb0	0	10	t	44c9127a-e2af-4d75-b471-5d371fba8bec	\N
499cebad-67ff-4c45-b161-d4c8750bb09c	\N	registration-user-creation	leari	44c9127a-e2af-4d75-b471-5d371fba8bec	0	20	f	\N	\N
e9696034-c300-4242-bc13-5f2947944930	\N	registration-profile-action	leari	44c9127a-e2af-4d75-b471-5d371fba8bec	0	40	f	\N	\N
69088e51-69dc-47af-bbb3-fb91f772a95b	\N	registration-password-action	leari	44c9127a-e2af-4d75-b471-5d371fba8bec	0	50	f	\N	\N
254dd13d-dab2-45a2-9e78-d9ad29f37374	\N	registration-recaptcha-action	leari	44c9127a-e2af-4d75-b471-5d371fba8bec	3	60	f	\N	\N
5cf99cfa-97f8-4e26-886c-b996a6238134	\N	reset-credentials-choose-user	leari	84360cb9-b48f-4ba2-864b-710688c42cec	0	10	f	\N	\N
553a3edf-8872-433d-a0ac-3648bbb5fdf1	\N	reset-credential-email	leari	84360cb9-b48f-4ba2-864b-710688c42cec	0	20	f	\N	\N
6cc3f222-cd7b-45db-aba5-0fcc49f56729	\N	reset-password	leari	84360cb9-b48f-4ba2-864b-710688c42cec	0	30	f	\N	\N
2d2fec3e-178b-4abf-9803-c912d25f9f5f	\N	\N	leari	84360cb9-b48f-4ba2-864b-710688c42cec	1	40	t	05687191-6d84-4ccf-95cc-118cf26bac89	\N
252bb087-f022-42ed-8741-e13474337771	\N	conditional-user-configured	leari	05687191-6d84-4ccf-95cc-118cf26bac89	0	10	f	\N	\N
0b814e31-19b4-417d-ae71-5fd8a5f31800	\N	reset-otp	leari	05687191-6d84-4ccf-95cc-118cf26bac89	0	20	f	\N	\N
735f7f4b-0707-4e4b-8439-3fadd34f5345	\N	client-secret	leari	67f86520-b707-4ed1-b514-c8f5a4c99317	2	10	f	\N	\N
86261444-80c8-4863-b68b-cc0fe9f7258e	\N	client-jwt	leari	67f86520-b707-4ed1-b514-c8f5a4c99317	2	20	f	\N	\N
7132cd3b-a2a4-46fc-9c0c-63d580ec8ffe	\N	client-secret-jwt	leari	67f86520-b707-4ed1-b514-c8f5a4c99317	2	30	f	\N	\N
b10f5316-1c39-4fc2-ab29-cd1e348ae8d8	\N	client-x509	leari	67f86520-b707-4ed1-b514-c8f5a4c99317	2	40	f	\N	\N
92f66731-361e-4045-80eb-5aed1fb49b12	\N	idp-review-profile	leari	6ed3ec3f-f49b-4aaa-83ab-721807aff5fd	0	10	f	\N	39cd8568-a9a7-4b1d-9a96-44f271b4a79e
54b7d9e0-1b5a-43f2-998b-0ff0258f4586	\N	\N	leari	6ed3ec3f-f49b-4aaa-83ab-721807aff5fd	0	20	t	a3479928-14a9-4747-abc1-ceecda30114f	\N
48eb6d89-42c0-4cfb-a1d6-df2091dc8d6a	\N	idp-create-user-if-unique	leari	a3479928-14a9-4747-abc1-ceecda30114f	2	10	f	\N	5ec86e61-8d00-48fc-a5d5-7d398f905727
4d4e1774-7aba-473e-8240-ea3ba8d8f5aa	\N	\N	leari	a3479928-14a9-4747-abc1-ceecda30114f	2	20	t	c3094da9-efbf-4131-8ea3-0636a51c9fb6	\N
9f66ca09-9c2f-445f-b68e-1128703436b5	\N	idp-confirm-link	leari	c3094da9-efbf-4131-8ea3-0636a51c9fb6	0	10	f	\N	\N
15f7fcc9-c9ef-4383-a8a7-50be625e62d4	\N	\N	leari	c3094da9-efbf-4131-8ea3-0636a51c9fb6	0	20	t	73de25fc-7f90-4c6e-90b1-b835693a482f	\N
a97aff46-5fc3-46ba-b2fa-ecea46ec2e5b	\N	idp-email-verification	leari	73de25fc-7f90-4c6e-90b1-b835693a482f	2	10	f	\N	\N
b1ec22b4-5063-4982-835d-6aadba918522	\N	\N	leari	73de25fc-7f90-4c6e-90b1-b835693a482f	2	20	t	9522d08b-c5c3-47d9-bf2a-ebe2fa4261b9	\N
5b66851c-5153-40ff-be46-5346f76e6fd4	\N	idp-username-password-form	leari	9522d08b-c5c3-47d9-bf2a-ebe2fa4261b9	0	10	f	\N	\N
6e21e056-dfdc-43c9-9acc-831804bc06ed	\N	\N	leari	9522d08b-c5c3-47d9-bf2a-ebe2fa4261b9	1	20	t	914a9872-8241-47fa-94f2-242ee0f8a5e8	\N
e1f1bb61-6f3b-4cad-ad4f-16d40413cb3a	\N	conditional-user-configured	leari	914a9872-8241-47fa-94f2-242ee0f8a5e8	0	10	f	\N	\N
de52d0bc-1af1-486c-94f8-be49eeddae6f	\N	auth-otp-form	leari	914a9872-8241-47fa-94f2-242ee0f8a5e8	0	20	f	\N	\N
c6bf50b9-b426-41db-821b-b6daf8322142	\N	http-basic-authenticator	leari	0458891a-03c2-471b-918c-c14cb312f1b3	0	10	f	\N	\N
59a5cb25-4830-4ee0-b822-48d728fd3c3e	\N	docker-http-basic-authenticator	leari	e0ee626b-ce7c-4885-830f-8bc71e2fa120	0	10	f	\N	\N
88ff7f2f-0479-4b28-a5da-e42be3039869	\N	no-cookie-redirect	leari	203bfdd5-87d2-4c1c-9568-cb842a37ef80	0	10	f	\N	\N
012a700f-22d5-4d0b-9f4a-34b209639c4c	\N	\N	leari	203bfdd5-87d2-4c1c-9568-cb842a37ef80	0	20	t	1fa0e663-f909-4644-88c1-02f8cb15fa11	\N
05e6ed66-c226-45b9-8073-d10f0d641e95	\N	basic-auth	leari	1fa0e663-f909-4644-88c1-02f8cb15fa11	0	10	f	\N	\N
f9a3df1e-a337-43d6-ba6a-6044ed0fe10c	\N	basic-auth-otp	leari	1fa0e663-f909-4644-88c1-02f8cb15fa11	3	20	f	\N	\N
af286d04-f1c7-486b-a7a0-81c56815ac96	\N	auth-spnego	leari	1fa0e663-f909-4644-88c1-02f8cb15fa11	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
73d38889-0f7b-4324-abea-a6053d1d596e	browser	browser based authentication	master	basic-flow	t	t
aafd645c-05da-4a65-a862-c9f9f08a7d06	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
82978a1b-db3e-4c13-93e3-8255bb046cb6	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
e1bad2ef-4edd-45c0-9797-1b1dd441814b	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
1c3e9667-b2d6-49a1-892e-f9d4f6d9874b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
24aff860-e239-4ce8-9e20-5527b719e733	registration	registration flow	master	basic-flow	t	t
86f69cbf-71a3-4f4f-8ed1-929046bbd37a	registration form	registration form	master	form-flow	f	t
5374e76e-8163-43bd-a46d-9b1e6e9da6a3	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
b3478782-0e1a-44e0-8157-686091b35f44	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
c417d79a-737c-4b35-9a0e-94d3778eec49	clients	Base authentication for clients	master	client-flow	t	t
6a28ad0d-9ae2-46f3-aa89-3141438e0ae0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
ffb00297-de90-4f21-aca0-a06ff2cc0585	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
4bb477f2-05fa-4d2b-a485-5f5ed5f0598d	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
cf201e64-6ac8-41d5-8ba6-c9fae507f725	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
6ad3ba1c-ff87-407d-93ff-cc6976f581f2	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
8c5710b2-52ff-471f-9ec9-baf7ed8688f1	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
b3575d4f-3371-4c45-9ebc-fdb5c1c56d29	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
3486948f-ce74-4756-9064-447f25fc9bd3	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
0085a8da-2a3f-4140-8ed1-bf3c7f496583	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
76ef84d9-0ea7-4b8f-9e4e-53ffeeb47575	Authentication Options	Authentication options.	master	basic-flow	f	t
c96f8b9d-62c7-4965-8e36-42324d575511	browser	browser based authentication	leari	basic-flow	t	t
f0607025-4584-428c-9eec-ed28cacc2b29	forms	Username, password, otp and other auth forms.	leari	basic-flow	f	t
b4c4b7f9-e7f6-4aae-8ed2-4544a6375464	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	leari	basic-flow	f	t
f7b76623-60af-41af-9010-a758c9400603	direct grant	OpenID Connect Resource Owner Grant	leari	basic-flow	t	t
b0bacacc-fc61-4bb1-8bad-30c1898df151	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	leari	basic-flow	f	t
3d705586-818c-4427-9e06-ae7c5d9b6fb0	registration	registration flow	leari	basic-flow	t	t
44c9127a-e2af-4d75-b471-5d371fba8bec	registration form	registration form	leari	form-flow	f	t
84360cb9-b48f-4ba2-864b-710688c42cec	reset credentials	Reset credentials for a user if they forgot their password or something	leari	basic-flow	t	t
05687191-6d84-4ccf-95cc-118cf26bac89	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	leari	basic-flow	f	t
67f86520-b707-4ed1-b514-c8f5a4c99317	clients	Base authentication for clients	leari	client-flow	t	t
6ed3ec3f-f49b-4aaa-83ab-721807aff5fd	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	leari	basic-flow	t	t
a3479928-14a9-4747-abc1-ceecda30114f	User creation or linking	Flow for the existing/non-existing user alternatives	leari	basic-flow	f	t
c3094da9-efbf-4131-8ea3-0636a51c9fb6	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	leari	basic-flow	f	t
73de25fc-7f90-4c6e-90b1-b835693a482f	Account verification options	Method with which to verity the existing account	leari	basic-flow	f	t
9522d08b-c5c3-47d9-bf2a-ebe2fa4261b9	Verify Existing Account by Re-authentication	Reauthentication of existing account	leari	basic-flow	f	t
914a9872-8241-47fa-94f2-242ee0f8a5e8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	leari	basic-flow	f	t
0458891a-03c2-471b-918c-c14cb312f1b3	saml ecp	SAML ECP Profile Authentication Flow	leari	basic-flow	t	t
e0ee626b-ce7c-4885-830f-8bc71e2fa120	docker auth	Used by Docker clients to authenticate against the IDP	leari	basic-flow	t	t
203bfdd5-87d2-4c1c-9568-cb842a37ef80	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	leari	basic-flow	t	t
1fa0e663-f909-4644-88c1-02f8cb15fa11	Authentication Options	Authentication options.	leari	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
6f0c3a6b-6010-4309-be41-2d3966ea4823	review profile config	master
01ebea64-d2c0-4475-b8a3-3d4b104de6f4	create unique user config	master
39cd8568-a9a7-4b1d-9a96-44f271b4a79e	review profile config	leari
5ec86e61-8d00-48fc-a5d5-7d398f905727	create unique user config	leari
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
6f0c3a6b-6010-4309-be41-2d3966ea4823	missing	update.profile.on.first.login
01ebea64-d2c0-4475-b8a3-3d4b104de6f4	false	require.password.update.after.registration
39cd8568-a9a7-4b1d-9a96-44f271b4a79e	missing	update.profile.on.first.login
5ec86e61-8d00-48fc-a5d5-7d398f905727	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ff5200ad-3564-463c-a9d0-51579bb86447	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
906d7634-ec61-4c3d-b074-0f89a060b6ce	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	f	leari-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	leari Realm	f	client-secret	\N	\N	\N	t	f	f	f
b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	f	realm-management	0	f	\N	\N	t	\N	f	leari	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
84733521-140e-4bc6-9c55-fb4a47090ab6	t	f	account	0	t	\N	/realms/leari/account/	f	\N	f	leari	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	t	f	account-console	0	t	\N	/realms/leari/account/	f	\N	f	leari	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
33706e11-8c10-4c17-a28d-87724970cc3b	t	f	broker	0	f	\N	\N	t	\N	f	leari	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
62285f94-1070-4ab7-ad3f-ae2978829f81	t	f	security-admin-console	0	t	\N	/admin/leari/console/	f	\N	f	leari	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	t	f	admin-cli	0	t	\N	\N	f	\N	f	leari	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
61316763-7a4a-4ac7-8cf4-cf60a11df001	t	t	frontend	0	t	\N	\N	f	http://localhost:3000	f	leari	openid-connect	-1	f	f	\N	f	client-secret	http://localhost:3000	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	S256	pkce.code.challenge.method
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	S256	pkce.code.challenge.method
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	S256	pkce.code.challenge.method
62285f94-1070-4ab7-ad3f-ae2978829f81	S256	pkce.code.challenge.method
61316763-7a4a-4ac7-8cf4-cf60a11df001	true	backchannel.logout.session.required
61316763-7a4a-4ac7-8cf4-cf60a11df001	false	backchannel.logout.revoke.offline.tokens
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
c3bff590-7ece-4877-a782-aa16c38a13c8	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
291b0f77-1b23-4547-bcf1-d296bf804bc3	role_list	master	SAML role list	saml
66c2ab87-a773-4d29-8a31-ffa16b9eeb54	profile	master	OpenID Connect built-in scope: profile	openid-connect
3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	email	master	OpenID Connect built-in scope: email	openid-connect
022ff3ec-e510-42e5-a5df-4a232a332e31	address	master	OpenID Connect built-in scope: address	openid-connect
4d2c59cf-fed2-437d-9893-04328f5cd138	phone	master	OpenID Connect built-in scope: phone	openid-connect
23f97b85-dde4-497f-bb6e-6e8a5444fed3	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
3534e970-da47-4f66-9955-55a3e10fb1a1	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
59d0342e-df7b-4816-aeb4-31e540cab4df	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
a8b1fdda-ffeb-4322-8abe-01cd28436b5b	offline_access	leari	OpenID Connect built-in scope: offline_access	openid-connect
d92b3f42-8120-4d8a-bad4-46f4bd47650c	role_list	leari	SAML role list	saml
92299e02-7fc9-4187-ad16-f0342f95ec50	profile	leari	OpenID Connect built-in scope: profile	openid-connect
969ed18f-a9d3-4d18-82c2-aedead1c4b25	email	leari	OpenID Connect built-in scope: email	openid-connect
00c31f4e-b441-4c5a-9496-1f01a148b597	address	leari	OpenID Connect built-in scope: address	openid-connect
97e92198-335b-4273-8653-343dec127a86	phone	leari	OpenID Connect built-in scope: phone	openid-connect
92dd278b-84ac-4ce3-840f-b5b80c8271ba	roles	leari	OpenID Connect scope for add user roles to the access token	openid-connect
e77e7460-2d2f-45eb-9086-ad2022f0be7c	web-origins	leari	OpenID Connect scope for add allowed web origins to the access token	openid-connect
07f9c575-5d66-4778-8954-55125f947542	microprofile-jwt	leari	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
c3bff590-7ece-4877-a782-aa16c38a13c8	true	display.on.consent.screen
c3bff590-7ece-4877-a782-aa16c38a13c8	${offlineAccessScopeConsentText}	consent.screen.text
291b0f77-1b23-4547-bcf1-d296bf804bc3	true	display.on.consent.screen
291b0f77-1b23-4547-bcf1-d296bf804bc3	${samlRoleListScopeConsentText}	consent.screen.text
66c2ab87-a773-4d29-8a31-ffa16b9eeb54	true	display.on.consent.screen
66c2ab87-a773-4d29-8a31-ffa16b9eeb54	${profileScopeConsentText}	consent.screen.text
66c2ab87-a773-4d29-8a31-ffa16b9eeb54	true	include.in.token.scope
3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	true	display.on.consent.screen
3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	${emailScopeConsentText}	consent.screen.text
3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	true	include.in.token.scope
022ff3ec-e510-42e5-a5df-4a232a332e31	true	display.on.consent.screen
022ff3ec-e510-42e5-a5df-4a232a332e31	${addressScopeConsentText}	consent.screen.text
022ff3ec-e510-42e5-a5df-4a232a332e31	true	include.in.token.scope
4d2c59cf-fed2-437d-9893-04328f5cd138	true	display.on.consent.screen
4d2c59cf-fed2-437d-9893-04328f5cd138	${phoneScopeConsentText}	consent.screen.text
4d2c59cf-fed2-437d-9893-04328f5cd138	true	include.in.token.scope
23f97b85-dde4-497f-bb6e-6e8a5444fed3	true	display.on.consent.screen
23f97b85-dde4-497f-bb6e-6e8a5444fed3	${rolesScopeConsentText}	consent.screen.text
23f97b85-dde4-497f-bb6e-6e8a5444fed3	false	include.in.token.scope
3534e970-da47-4f66-9955-55a3e10fb1a1	false	display.on.consent.screen
3534e970-da47-4f66-9955-55a3e10fb1a1		consent.screen.text
3534e970-da47-4f66-9955-55a3e10fb1a1	false	include.in.token.scope
59d0342e-df7b-4816-aeb4-31e540cab4df	false	display.on.consent.screen
59d0342e-df7b-4816-aeb4-31e540cab4df	true	include.in.token.scope
a8b1fdda-ffeb-4322-8abe-01cd28436b5b	true	display.on.consent.screen
a8b1fdda-ffeb-4322-8abe-01cd28436b5b	${offlineAccessScopeConsentText}	consent.screen.text
d92b3f42-8120-4d8a-bad4-46f4bd47650c	true	display.on.consent.screen
d92b3f42-8120-4d8a-bad4-46f4bd47650c	${samlRoleListScopeConsentText}	consent.screen.text
92299e02-7fc9-4187-ad16-f0342f95ec50	true	display.on.consent.screen
92299e02-7fc9-4187-ad16-f0342f95ec50	${profileScopeConsentText}	consent.screen.text
92299e02-7fc9-4187-ad16-f0342f95ec50	true	include.in.token.scope
969ed18f-a9d3-4d18-82c2-aedead1c4b25	true	display.on.consent.screen
969ed18f-a9d3-4d18-82c2-aedead1c4b25	${emailScopeConsentText}	consent.screen.text
969ed18f-a9d3-4d18-82c2-aedead1c4b25	true	include.in.token.scope
00c31f4e-b441-4c5a-9496-1f01a148b597	true	display.on.consent.screen
00c31f4e-b441-4c5a-9496-1f01a148b597	${addressScopeConsentText}	consent.screen.text
00c31f4e-b441-4c5a-9496-1f01a148b597	true	include.in.token.scope
97e92198-335b-4273-8653-343dec127a86	true	display.on.consent.screen
97e92198-335b-4273-8653-343dec127a86	${phoneScopeConsentText}	consent.screen.text
97e92198-335b-4273-8653-343dec127a86	true	include.in.token.scope
92dd278b-84ac-4ce3-840f-b5b80c8271ba	true	display.on.consent.screen
92dd278b-84ac-4ce3-840f-b5b80c8271ba	${rolesScopeConsentText}	consent.screen.text
92dd278b-84ac-4ce3-840f-b5b80c8271ba	false	include.in.token.scope
e77e7460-2d2f-45eb-9086-ad2022f0be7c	false	display.on.consent.screen
e77e7460-2d2f-45eb-9086-ad2022f0be7c		consent.screen.text
e77e7460-2d2f-45eb-9086-ad2022f0be7c	false	include.in.token.scope
07f9c575-5d66-4778-8954-55125f947542	false	display.on.consent.screen
07f9c575-5d66-4778-8954-55125f947542	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	3534e970-da47-4f66-9955-55a3e10fb1a1	t
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	022ff3ec-e510-42e5-a5df-4a232a332e31	f
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	c3bff590-7ece-4877-a782-aa16c38a13c8	f
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	4d2c59cf-fed2-437d-9893-04328f5cd138	f
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	59d0342e-df7b-4816-aeb4-31e540cab4df	f
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	3534e970-da47-4f66-9955-55a3e10fb1a1	t
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	022ff3ec-e510-42e5-a5df-4a232a332e31	f
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	c3bff590-7ece-4877-a782-aa16c38a13c8	f
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	4d2c59cf-fed2-437d-9893-04328f5cd138	f
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	59d0342e-df7b-4816-aeb4-31e540cab4df	f
906d7634-ec61-4c3d-b074-0f89a060b6ce	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
906d7634-ec61-4c3d-b074-0f89a060b6ce	3534e970-da47-4f66-9955-55a3e10fb1a1	t
906d7634-ec61-4c3d-b074-0f89a060b6ce	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
906d7634-ec61-4c3d-b074-0f89a060b6ce	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
906d7634-ec61-4c3d-b074-0f89a060b6ce	022ff3ec-e510-42e5-a5df-4a232a332e31	f
906d7634-ec61-4c3d-b074-0f89a060b6ce	c3bff590-7ece-4877-a782-aa16c38a13c8	f
906d7634-ec61-4c3d-b074-0f89a060b6ce	4d2c59cf-fed2-437d-9893-04328f5cd138	f
906d7634-ec61-4c3d-b074-0f89a060b6ce	59d0342e-df7b-4816-aeb4-31e540cab4df	f
ff5200ad-3564-463c-a9d0-51579bb86447	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
ff5200ad-3564-463c-a9d0-51579bb86447	3534e970-da47-4f66-9955-55a3e10fb1a1	t
ff5200ad-3564-463c-a9d0-51579bb86447	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
ff5200ad-3564-463c-a9d0-51579bb86447	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
ff5200ad-3564-463c-a9d0-51579bb86447	022ff3ec-e510-42e5-a5df-4a232a332e31	f
ff5200ad-3564-463c-a9d0-51579bb86447	c3bff590-7ece-4877-a782-aa16c38a13c8	f
ff5200ad-3564-463c-a9d0-51579bb86447	4d2c59cf-fed2-437d-9893-04328f5cd138	f
ff5200ad-3564-463c-a9d0-51579bb86447	59d0342e-df7b-4816-aeb4-31e540cab4df	f
c1c71074-a921-4167-a7ab-d0f3197bdd1f	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
c1c71074-a921-4167-a7ab-d0f3197bdd1f	3534e970-da47-4f66-9955-55a3e10fb1a1	t
c1c71074-a921-4167-a7ab-d0f3197bdd1f	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
c1c71074-a921-4167-a7ab-d0f3197bdd1f	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
c1c71074-a921-4167-a7ab-d0f3197bdd1f	022ff3ec-e510-42e5-a5df-4a232a332e31	f
c1c71074-a921-4167-a7ab-d0f3197bdd1f	c3bff590-7ece-4877-a782-aa16c38a13c8	f
c1c71074-a921-4167-a7ab-d0f3197bdd1f	4d2c59cf-fed2-437d-9893-04328f5cd138	f
c1c71074-a921-4167-a7ab-d0f3197bdd1f	59d0342e-df7b-4816-aeb4-31e540cab4df	f
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	3534e970-da47-4f66-9955-55a3e10fb1a1	t
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	022ff3ec-e510-42e5-a5df-4a232a332e31	f
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	c3bff590-7ece-4877-a782-aa16c38a13c8	f
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	4d2c59cf-fed2-437d-9893-04328f5cd138	f
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	59d0342e-df7b-4816-aeb4-31e540cab4df	f
84733521-140e-4bc6-9c55-fb4a47090ab6	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
84733521-140e-4bc6-9c55-fb4a47090ab6	92299e02-7fc9-4187-ad16-f0342f95ec50	t
84733521-140e-4bc6-9c55-fb4a47090ab6	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
84733521-140e-4bc6-9c55-fb4a47090ab6	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
84733521-140e-4bc6-9c55-fb4a47090ab6	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
84733521-140e-4bc6-9c55-fb4a47090ab6	07f9c575-5d66-4778-8954-55125f947542	f
84733521-140e-4bc6-9c55-fb4a47090ab6	97e92198-335b-4273-8653-343dec127a86	f
84733521-140e-4bc6-9c55-fb4a47090ab6	00c31f4e-b441-4c5a-9496-1f01a148b597	f
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	92299e02-7fc9-4187-ad16-f0342f95ec50	t
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	07f9c575-5d66-4778-8954-55125f947542	f
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	97e92198-335b-4273-8653-343dec127a86	f
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	00c31f4e-b441-4c5a-9496-1f01a148b597	f
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	92299e02-7fc9-4187-ad16-f0342f95ec50	t
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	07f9c575-5d66-4778-8954-55125f947542	f
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	97e92198-335b-4273-8653-343dec127a86	f
8c484be1-eba6-434d-b0e7-fc6875d0d6ab	00c31f4e-b441-4c5a-9496-1f01a148b597	f
33706e11-8c10-4c17-a28d-87724970cc3b	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
33706e11-8c10-4c17-a28d-87724970cc3b	92299e02-7fc9-4187-ad16-f0342f95ec50	t
33706e11-8c10-4c17-a28d-87724970cc3b	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
33706e11-8c10-4c17-a28d-87724970cc3b	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
33706e11-8c10-4c17-a28d-87724970cc3b	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
33706e11-8c10-4c17-a28d-87724970cc3b	07f9c575-5d66-4778-8954-55125f947542	f
33706e11-8c10-4c17-a28d-87724970cc3b	97e92198-335b-4273-8653-343dec127a86	f
33706e11-8c10-4c17-a28d-87724970cc3b	00c31f4e-b441-4c5a-9496-1f01a148b597	f
b4b01be6-c3d7-4bee-9b28-00a2c5523634	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
b4b01be6-c3d7-4bee-9b28-00a2c5523634	92299e02-7fc9-4187-ad16-f0342f95ec50	t
b4b01be6-c3d7-4bee-9b28-00a2c5523634	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
b4b01be6-c3d7-4bee-9b28-00a2c5523634	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
b4b01be6-c3d7-4bee-9b28-00a2c5523634	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
b4b01be6-c3d7-4bee-9b28-00a2c5523634	07f9c575-5d66-4778-8954-55125f947542	f
b4b01be6-c3d7-4bee-9b28-00a2c5523634	97e92198-335b-4273-8653-343dec127a86	f
b4b01be6-c3d7-4bee-9b28-00a2c5523634	00c31f4e-b441-4c5a-9496-1f01a148b597	f
62285f94-1070-4ab7-ad3f-ae2978829f81	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
62285f94-1070-4ab7-ad3f-ae2978829f81	92299e02-7fc9-4187-ad16-f0342f95ec50	t
62285f94-1070-4ab7-ad3f-ae2978829f81	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
62285f94-1070-4ab7-ad3f-ae2978829f81	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
62285f94-1070-4ab7-ad3f-ae2978829f81	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
62285f94-1070-4ab7-ad3f-ae2978829f81	07f9c575-5d66-4778-8954-55125f947542	f
62285f94-1070-4ab7-ad3f-ae2978829f81	97e92198-335b-4273-8653-343dec127a86	f
62285f94-1070-4ab7-ad3f-ae2978829f81	00c31f4e-b441-4c5a-9496-1f01a148b597	f
61316763-7a4a-4ac7-8cf4-cf60a11df001	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
61316763-7a4a-4ac7-8cf4-cf60a11df001	92299e02-7fc9-4187-ad16-f0342f95ec50	t
61316763-7a4a-4ac7-8cf4-cf60a11df001	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
61316763-7a4a-4ac7-8cf4-cf60a11df001	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
61316763-7a4a-4ac7-8cf4-cf60a11df001	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
61316763-7a4a-4ac7-8cf4-cf60a11df001	07f9c575-5d66-4778-8954-55125f947542	f
61316763-7a4a-4ac7-8cf4-cf60a11df001	97e92198-335b-4273-8653-343dec127a86	f
61316763-7a4a-4ac7-8cf4-cf60a11df001	00c31f4e-b441-4c5a-9496-1f01a148b597	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
c3bff590-7ece-4877-a782-aa16c38a13c8	0eddb216-b633-452d-9320-76ffe43ea0c5
a8b1fdda-ffeb-4322-8abe-01cd28436b5b	a643f8d9-82f8-4477-be80-e6a4b39f5e39
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7be51368-a1c0-4700-8245-6ea4927ab668	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cd8ae74c-ab8a-4ae9-b084-48778eea3d7c	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
685a502a-69d0-497e-a87c-6579afa13c65	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
c155a383-292c-4338-a51d-dbad4081d095	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
fc7bbd63-b260-41ba-82bf-ec9a7823fb98	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ae367d28-e555-4269-be91-da554c17fc3f	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5225e29c-7377-4e14-a330-37a0eedad611	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
b997ace6-d5bb-4a63-a99c-c600cb5b1e75	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
d50390ec-2f41-4e44-a354-e41de1ea025e	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
5021d404-96bd-403c-85f0-0271df09cb81	rsa-enc-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
53e349ad-4042-4b4f-879f-4a2022819775	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
7065cda8-ad66-4e0c-8d7c-aac715c12831	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
31cf59f0-6649-4a93-96b4-d9f285fab6a8	rsa-generated	leari	rsa-generated	org.keycloak.keys.KeyProvider	leari	\N
70f99dcf-4bc9-4d5b-901e-e8e0e291ab0b	rsa-enc-generated	leari	rsa-generated	org.keycloak.keys.KeyProvider	leari	\N
d221e324-299e-406f-ba06-28a38fd68c3e	hmac-generated	leari	hmac-generated	org.keycloak.keys.KeyProvider	leari	\N
88449ffd-8169-4d50-bf93-1153db2d8ede	aes-generated	leari	aes-generated	org.keycloak.keys.KeyProvider	leari	\N
9537b5cb-90fa-4781-9be1-0ad5d1ad01a4	Trusted Hosts	leari	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	anonymous
e63d1d02-23f7-4269-85c9-f6ee16922b9b	Consent Required	leari	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	anonymous
e7265907-3b2a-4afc-aea6-02b2b58e26bf	Full Scope Disabled	leari	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	anonymous
35c97878-b443-4273-ba14-b3979967dd9d	Max Clients Limit	leari	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	anonymous
05d6737a-2624-475f-8e10-1ae5ee9a28be	Allowed Protocol Mapper Types	leari	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	anonymous
a6e2212e-bb62-4e5a-b530-d1ecde5b0534	Allowed Client Scopes	leari	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	anonymous
e93f5999-0ad8-4a01-9782-5c75f4c831a3	Allowed Protocol Mapper Types	leari	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	authenticated
1560e4c5-b470-4442-a358-7c721b25115b	Allowed Client Scopes	leari	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	leari	authenticated
3541afad-fd25-4a7d-90f6-f53d44014060	\N	leari	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	leari	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
66fba139-0f5a-407f-ad22-b28068cba64e	ae367d28-e555-4269-be91-da554c17fc3f	allow-default-scopes	true
56faf450-2cde-46cc-93d1-67d87969e151	c155a383-292c-4338-a51d-dbad4081d095	max-clients	200
43d42757-40a4-4621-9a35-4195ab88f966	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	oidc-address-mapper
4d1f7d29-e0e2-4d8d-8cad-51f6ff91e3b2	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	saml-role-list-mapper
c2e78daa-448d-421c-9d1e-8e55c7618ccd	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	saml-user-attribute-mapper
16f0ae85-1445-4337-bda7-8d3f9fc119d4	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e3466fbf-697a-4e4b-9d3d-af8804908886	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3b85193b-9da0-477f-8764-9e950df47409	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	oidc-full-name-mapper
f56f3cda-d823-407a-8fd1-babb740150de	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1ca9ac06-12f1-4bf8-bfbe-9b2bb6c58c65	5225e29c-7377-4e14-a330-37a0eedad611	allowed-protocol-mapper-types	saml-user-property-mapper
5bf6c14a-bb06-4044-a6f9-08d188605e38	b997ace6-d5bb-4a63-a99c-c600cb5b1e75	allow-default-scopes	true
c17265ba-c8f8-4ff9-86cf-8fc3bfcdaf4b	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	saml-user-property-mapper
59232b31-47a0-4ea3-8f6a-d895a350e6b6	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
95a6bd89-dff6-486e-9ce8-7c8f8b44cd81	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	saml-user-attribute-mapper
80e6f02f-4a2d-40f0-8edd-d6adeee29270	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	oidc-address-mapper
0410e93b-cc2e-4742-a142-b5a69fd6b664	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	oidc-full-name-mapper
7e2f0afd-fb39-4006-85a5-a8fd108fc1e7	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	saml-role-list-mapper
7d1fe90a-6873-49a3-9305-f421280ab38a	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
be0c62fd-218f-4647-a84e-49a605fa88b2	fc7bbd63-b260-41ba-82bf-ec9a7823fb98	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
215b28d1-a9d1-450c-9b38-04e119231654	7be51368-a1c0-4700-8245-6ea4927ab668	host-sending-registration-request-must-match	true
99d88cb9-a25a-4e14-9579-2507e34a86b1	7be51368-a1c0-4700-8245-6ea4927ab668	client-uris-must-match	true
1bed283b-86ec-4e2c-b6f7-12a1fd625ff4	5021d404-96bd-403c-85f0-0271df09cb81	priority	100
e4e99e8b-75ef-4e7c-b507-bf79d91fb0b4	5021d404-96bd-403c-85f0-0271df09cb81	keyUse	enc
2f011bdc-fe59-49d8-b3aa-656688c7ab3d	5021d404-96bd-403c-85f0-0271df09cb81	privateKey	MIIEowIBAAKCAQEAih/N6ka76Sozv9w6zAsTebbcsVQnDXjEQIIgZPSGQj/IXst4VCBDAO6erbJPXv/s+ZCCiH6hR0i+G3Ct9r4WXOn1igshrtaVfASDIQjkogKgnN1AYHDwkcaA9i9XUwq4ZBjHO01g1x03ZtYcnsXRN5pcSDc8DzZAgFJ1wi6E7SS5H/DwmSLzHJceJGPma75a11ZXCy/B3kEWIW+keqGUQhOBAZ0iAAERmw+IqyvmpfgfrNSJiGe8CJB4SPZ0aIeauP1aE6R30/L8WvijhlPJHxSTeKa3wwUm6RLQVK0XM/bBrSTWrMoKBPk+iPghQXeU9uMiAD8upwvt2hARC7/dYQIDAQABAoIBAG5mKVGdo8gjwSUSw7QfDjv0msTpvCUaZ9IfsADBKSZ+kIqkGtMyzhtKnm263ZHTAPggNxUeEY5GaBzKnWFgYcN2BJmHeC6kuOpdOOoIj6Wmb/WxKilrW/1IKf+bqzJmmSb4XxXZLRQC+Csr68hD2IuWxze5XjnSZQ+r2Q+R2xEnYSFx6kvetbeSYu4+2aKP1UMSC6rdD8Y9w3yj6kdYJ51JDEWos7lSZo+stth6yTYACPeUDRYJrz934LAER7kqqCbF6mnxEFz8vTtXX4ptSqxeF/uVQnY0AykV/8bsidYIOq0Rl02RKK9EAfhV6Y8guA1t20j3vptYTwN25N4FMKECgYEAzmLclYUYNc0N8gxsE8MvFVWzHti9mzwIODyPF5IbXfZ301sCwlblhiw6U4iJVYFaD/2qPxWcAFTAHsglG2ynNFH7jDs1bhelUPb9aiOshxSWO/1OPdWdxdT4Ud3EOAqgEDHd38zj8m2f3jxHOymy6wK4Anj3t1W4CboXlAYfCoUCgYEAq1QPDLBlth2KHi5/vt5FteqyF6xgmlOH9k7ziZkxir+bW6F5/AfPh7VjPHDP5GMoS5BU+N8LAY3Vw4uunt+J8v/ZJZIoocP7C7xlrBuefCkzZmspubAlScVnj38l3CXv1ZdoDvj1Pb0JH2pvV75wZzk8BP8vlGQcCenjvt4INC0CgYEAm4sGk+lrBaE1EWcrTPmdUob0KBtRSt1DlJ6PeUQ0O+y1AiVlPvIeqbBLhQkx9681ITgcRs8Sc21sHcbZsIGCwnvHCTjWW9KWVR7Qfl3EeUmasDuH7DJCZgbL32czqsjXOV1byn+wi9Ty15q2VHBo15WE+NgSWanQugP2ISk728ECgYBh5Ges8mVLR1mRoTPwlQPzy6PyjtWrmCrJe5b/ef6qroxQMNWIQdY8TlHjSPogHt/5PQCwKpEZVDddwcQGluc1ZyZlpzt8IoSg0gat7iICA3CRBo4SwSitHBPuE9JIFY0R167nTyyhGA/MWX5A/lkvQa6flEdVXFYA/BjbB/ZcCQKBgBmcrWND1KcLHQb69w18fl4P3l76aaoj/9lc1NCT0DUceqmxuiV+E1GHv1jcn5yGohYJMXO5GP2SKil4QETUdjkDkQurg36JgTWrjR1Mb0hdRo1R/9NaBhAAt6hDq8OIkXpAlJtA46EX9w4Kmzb/6u40pNzWU76FLyHqvNogTGaw
4dec6970-2a1d-441a-896c-7b735c9baa30	5021d404-96bd-403c-85f0-0271df09cb81	certificate	MIICmzCCAYMCBgF8jev88DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDE3MTEwMjA1WhcNMzExMDE3MTEwMzQ1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCKH83qRrvpKjO/3DrMCxN5ttyxVCcNeMRAgiBk9IZCP8hey3hUIEMA7p6tsk9e/+z5kIKIfqFHSL4bcK32vhZc6fWKCyGu1pV8BIMhCOSiAqCc3UBgcPCRxoD2L1dTCrhkGMc7TWDXHTdm1hyexdE3mlxINzwPNkCAUnXCLoTtJLkf8PCZIvMclx4kY+ZrvlrXVlcLL8HeQRYhb6R6oZRCE4EBnSIAARGbD4irK+al+B+s1ImIZ7wIkHhI9nRoh5q4/VoTpHfT8vxa+KOGU8kfFJN4prfDBSbpEtBUrRcz9sGtJNasygoE+T6I+CFBd5T24yIAPy6nC+3aEBELv91hAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEdkyMWGY1XQLEhgyi2VUd8fOkByh2VmnSYqsYciJgRKXShatFh6fw5gJybvnWsgsPBGgMRleh0m9wmEW3anYcHtHmjF0nLZ87rksida4PTtydhTC/0uTKMzHKe5gOxtvWgBwafE2Ux5wc0bXS71z/Ud4hLl+vv+G8dHAVAPURp7MMUOV3PHT8x99Nyb//m8MHpe2OpJUCQUluoHwgrnb1/NAohLSzQvmmxFxbjp7eDjC8U2sJLmjRbvjFto6/8ry0ZQd6Nklb2XoAYAP6Mr5XhwKBuB2R75eMRLSmyGrh6MMlhBH25CcTLQ+dV9lgUui5C0RKZJPZF/ssQQYL1W8Dw=
51fab338-e035-4dab-83a6-1da83372845a	53e349ad-4042-4b4f-879f-4a2022819775	kid	a0425e51-2a11-4b6a-b40f-6fde1e715990
9d0c79b0-bae6-43c0-8869-9a7a3e3491bf	53e349ad-4042-4b4f-879f-4a2022819775	priority	100
b166b164-c5df-4f8c-8dc4-f88da3b9c197	53e349ad-4042-4b4f-879f-4a2022819775	algorithm	HS256
4053c078-4f55-44f0-a268-6d28f103f876	53e349ad-4042-4b4f-879f-4a2022819775	secret	pIWavjfmq2JBF8sjPGn0zOzVaB0LiGjVdZaxwy5LmhSUYD1-IOZN84OCbe22ZXUTJ0aZTv16apfZKH9pZhRxhw
452ca19c-d48a-4be8-9f19-8f302049234d	7065cda8-ad66-4e0c-8d7c-aac715c12831	secret	qT5iE-hyzjrphqXIH385tg
97a220ca-327b-4219-8514-8d50f5c62e2f	7065cda8-ad66-4e0c-8d7c-aac715c12831	priority	100
3b76dfd1-7206-4412-8e68-30c85d4364b2	7065cda8-ad66-4e0c-8d7c-aac715c12831	kid	03b8f690-35bd-4acd-a641-9a8cec0c0860
a0c570f1-d556-4256-9cd9-04906b3e6103	d50390ec-2f41-4e44-a354-e41de1ea025e	privateKey	MIIEpAIBAAKCAQEAjIov1s1TVJsvlX4OTEvtelgS4vp9QicYXBh+XMbzbejQBbdAQrNwL0UeboKbDHmZ/LKcFB3i/zJyowIX5rGSPGimKYUlbmcW3UAIoJZnkue1YLv0uH7y/FHzHBMZIUY8CAr5KkSZJ4G+Is6j3hQN9JraLOQzedUtHfcy0CXpZGnDlFn/D/xJd1qBoe122OkKsj+m+CfH4GOSNLOuL/9Ni/VCQMCqeQdn91g9sj3W0kDyeQn3pRCGm6DeoTWsPAZ+WOOj5o2FsGJf/3vnNWpmiOTLnR+KJNOmaD0HnLRiwWaR+/y5RddDrjcIubsqAyG9T1jeZtT/Cs6oZDroF1C4QQIDAQABAoIBABNjSOA4KSPF2NWlszFBVDyJg+l+JuOGYyzpUB1acOCbun7fXeUVvgc3YNBcAinBaMXcmf2IdfVAr2Hfew6fNo5Q3YNi09wcKqJRIB+PQDCa+IGkzEjbcofugjxAQjo95zAw21jCZ+J0WpeQrDiJybcR2cFRpexLxVKZ9I+Ue1MXse4D+U2BGVskZ6rMQ3Wfrf5Yy5gkVxFW7rhlOIKblow1E3wRLstZYlXfgEYnMus5tclW4KXjaLeG2oIfwfnw/nFGTOPaWasyDmeHHcRJDhbsOj68AC1jqx4E7WoKBGeMZeQ8j17SpuxE7UigPOaXPU1uTFsJtvxlf5yjLPAuBcUCgYEA9zaI+Sj4byVWFr9mKZCHNtKysmyL/8e4sr+v3G04AA/oW+y5Od4g95wwQE/fjdFXhunT+lILuKy9dSk5OZ7LoDTJEfhJczsNUVKXDFmMLNJ6loZi0qxpmpTxgrE/2p9ADh6BCO3y4OSurBM4w8HiDoq2Y3mLbQMXVAck9GDKPz8CgYEAkYkAEwb4yRHGuTpdccGYvfwR+6BAmZVIpRbz4WVVslmZ5B2WflKw0X/F0OHUwUaMzMsUS2WJE7uJSGzZwikqbxSJnltbySJY8qekD5IjwfBW3PjivzB/UzesCMknKVE3YO8q4z5hGCZiHtJ376V0Az4QCekQ/tfgq3yFnKIGqH8CgYEA9FTFGiVBLXDkXkU7btc2nJuwHCKmV94IkTpdUOntkDoouDoGc8g0IyYOlnGbDOqbrG8MoHpYtWSdN9/PfECTFrs1A3q29Zmmtvp+6ajTnzVEDeOyZnAbS7nr3PTcnHIK+Clz9ORgyZ+bd9zjnK7Sgvbb/wMRJ2QHuXf6MUI8gjcCgYBUae+GGcwh7FKky4q52b37rILNvbTaoHFDeJ26xelACqKtYtAQs2vmCEO4FdUuyfoPK1e5J8qrjGJjhOeFrBT12ya7mGgTsP2AueX6NhzRd9MaVq5GkR25Khh5/Brf50DE09S/fEYbGOBe2ltAwGobG1t4NBxshNDHBvIE2SIdhwKBgQDHDdSmw4ebQOOzCw9L6TCTT5YeolZw6zVswHJzr/eF9KNcQBUWjPZL3WBJ8u0FsDx3+lRs4T7HtC7vnddqzb6hLmZNvt7U6Ydy2J8xQac3NKrqWcIzDcrKnlkiOPI1a5enla9X4E5DY9kwPEfo1txvN8pc+/KxpW0JN7JDLdAFGA==
78c9de27-24ab-4bf7-8264-a5e5015a296b	d50390ec-2f41-4e44-a354-e41de1ea025e	keyUse	sig
09d7835d-2622-4ecf-a86a-ffc0b0da298b	d50390ec-2f41-4e44-a354-e41de1ea025e	priority	100
bcde0555-98ad-481d-b839-e3eab2eb14e4	d50390ec-2f41-4e44-a354-e41de1ea025e	certificate	MIICmzCCAYMCBgF8jev8WjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDE3MTEwMjA1WhcNMzExMDE3MTEwMzQ1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCMii/WzVNUmy+Vfg5MS+16WBLi+n1CJxhcGH5cxvNt6NAFt0BCs3AvRR5ugpsMeZn8spwUHeL/MnKjAhfmsZI8aKYphSVuZxbdQAiglmeS57Vgu/S4fvL8UfMcExkhRjwICvkqRJkngb4izqPeFA30mtos5DN51S0d9zLQJelkacOUWf8P/El3WoGh7XbY6QqyP6b4J8fgY5I0s64v/02L9UJAwKp5B2f3WD2yPdbSQPJ5CfelEIaboN6hNaw8Bn5Y46PmjYWwYl//e+c1amaI5MudH4ok06ZoPQectGLBZpH7/LlF10OuNwi5uyoDIb1PWN5m1P8KzqhkOugXULhBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADArkJ720HyPjA/MA7zTU9poaEUBXhezeuHDoJ/owWkTDAzdVNWdZSGzOEXZXPUBOLEkvjlXgOSTkkciA0bObf1cUDqb+ljpJJ4F+1bBMJMtzTev5Z7gAqpGAKphbu9rq7nhU0+ShamxYLAdghXQeO43mSCtSZOSVNotN3J1qgsQEnlbaVAFQx91nvQHpi/CdWykM+w/ozRRUOszGzbbdotYLJ0Ttx+tXMmZNkpdHByOWrpBKuBUAZjzU4Era2pltowL7C2LkpNUn5txP5/tlWXepT4lJNV+Y/TnFLJ5ydA7K6Zt11OdJv+BDxiZu24G00uH3X8eO5osZT23sfG0gYE=
15434555-ed6f-4c4d-bdd6-7d4e9e6e5695	31cf59f0-6649-4a93-96b4-d9f285fab6a8	priority	100
45041c83-2ede-496b-93c6-00939c2d5995	31cf59f0-6649-4a93-96b4-d9f285fab6a8	certificate	MIICmTCCAYECBgF8jeyJHDANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVsZWFyaTAeFw0yMTEwMTcxMTAyNDFaFw0zMTEwMTcxMTA0MjFaMBAxDjAMBgNVBAMMBWxlYXJpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAr3QHyCKWAIuLTh++7IXIaDqXCJ6ht8daqvO9cthberGmZ0URHdl80JICNy7HdBs9HqtiUqBxcp5VdeH4zufp1CJMtldXxsmc1ekpETEnV0r4rFDEF66kKuUL44cspBw0BkshOQveSGUWbHFYLfFrAYPoMeyftDt2gPKpyRpNYGElUttwLk+dBui8T7zVqYR0wd5m3bkShFL3i4nEupdBBgz4zV9yg2tfBfe0E6HtmUXUY6F/5SIEYNR7qGOLRkLT5y3IHHaxORgi917CCY9xiF5mFCophURvO6gdRGv8eaVRwuNQXbn9yb1dIo0eEnP8JQZVSOzM80a2Rz2G1l8UmQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBXg1Tm/mc3v5AwtRssO7XIz86TKdCqveXYOkn73IWTpIJBAe1PYHuf/zjXQGBRVSq+016lAVmXUnp/PoZ98jKVMAZD8m3tuVI9Lg3RU9hgPN4G2h6VpPLRCDychWlKvkJGNc4eY3+RcBB8j9+wjacirJ8/AMlcIQ9vy/SjImVY3vb6mkFRISsXY+qa5G6oGBOsuyh8wti4bKVGCYgFouuFZ4HzWWhGBfaW5NctQrZ1thivCNOMjyfJyhjhRVYxyLcRR1UQ5q/9+kLte4wKtSqetBGBvbaYnvgyZBu984igVSXZw25TsZtqS61Toh5NFBzOiGegeKH59+DRK5WfSm2B
e30bf854-82ba-4fc5-8b02-acdda5b15f78	31cf59f0-6649-4a93-96b4-d9f285fab6a8	keyUse	sig
7ce8b51e-0e99-4b08-aebe-06bbfc31c499	31cf59f0-6649-4a93-96b4-d9f285fab6a8	privateKey	MIIEowIBAAKCAQEAr3QHyCKWAIuLTh++7IXIaDqXCJ6ht8daqvO9cthberGmZ0URHdl80JICNy7HdBs9HqtiUqBxcp5VdeH4zufp1CJMtldXxsmc1ekpETEnV0r4rFDEF66kKuUL44cspBw0BkshOQveSGUWbHFYLfFrAYPoMeyftDt2gPKpyRpNYGElUttwLk+dBui8T7zVqYR0wd5m3bkShFL3i4nEupdBBgz4zV9yg2tfBfe0E6HtmUXUY6F/5SIEYNR7qGOLRkLT5y3IHHaxORgi917CCY9xiF5mFCophURvO6gdRGv8eaVRwuNQXbn9yb1dIo0eEnP8JQZVSOzM80a2Rz2G1l8UmQIDAQABAoIBAQCe+lz+vE/86HRucpd2C3be8o/d8JcKRinikv6LbH3fe88S7eMnj+TnvBUj2VBC5VeJTbPGuLhzKgK30Oy41izq2bV210eiyRZCQYXDnS1PjJAs2vYDm2wHrgkKvnX1sdR2C2dsIFPmdypNUpqa7pCOC+6+JfFDx0mGZ9rubNXFyF0ixP4T3DETKnsh14Dp69ibEfL5S6AmSYCEG7a5ZhijDIxW38GyMDym2dEHyHAn0gsPT6aCSu/l6Agtp8fQog1Ju3Pfi1rOut++Cpcg4fx9S8Ig2fjbIgBywwfafkxLnfAnH14ObwDpyrZVckGpIP0hadDy1P4qEIqJxmKNUnctAoGBAPIpBP2qEKH1VAo0IXF9EEC6Y4kDMLOfwfQE/JWnoBIbMYyAOXtwAVxuW5njHjfc7aSkkB2nAkZhMfULeJCFkjyLu+PT/LDRE639Haye4A/30S11BiUfB1SQV+/LTmtl3J9tTLy9++SFtGMpo7DybrDy0uahL7QgxRPaCB/UEM4/AoGBALl7CgHtSEaJFE3mz9BodbFMbpWaxTxZZEZryJTfnjeQjK5V3V6qQHy+dV5VzpIWQy31x7AiT9OD89++g4AmgwhvhJyd+cGp511CQU2DgvnqAy1H9X1mZzLVVsvyjAqPw1FGuLx50qFnVcsok3OaVFs35V38chpUtVrwtRI4uBcnAoGAfdorqdmUw1dI0fS93MluhPVZfX+W9AN3PWbKDs0LN93CJo8NUMWpL2x7VsLelZHQP9z2uTJu0Dz7RassgY+prKXChGlLzmkanTYLEgeP0zysDb/f7bLukFhkG0/B9bb+riyT0RO7scx7L34YgIG+XWAVk575t9fAFM0fo8sG4OkCgYAY7lHdCnDhkkFZa0HZqIDRUQ24LDKAtx9EW+59HEWfAF34fPAhbk72tX7/LBd1CWsEPXoW0bXbH2xjUa9JRWPteVfg2Vcd0eGYZnRyn8+2Gd9NcdOshFwwt/5PsY1jSgmd3hyssM9ABKzCfvS64C6giDXbWThZE7PAwoQEK/2KlwKBgGXDeN53CRZaydVu+jKYlwPNoFd90Tu74BnZSVpHlf8kqm3KrRj20ZHy2KKiJfYsPVSmQ43cvMNX5NNJxtX6Smgd9MIVCLRv6g0l2gBIXzhDliDqOEJpMg4zTGcv6Q4p3L+4Eo5BnKqLRiL2UOgyTmW4/9TTKoVff/uQs5+K+R+C
5a0f84ff-af54-4055-a8f3-d5e089f16814	d221e324-299e-406f-ba06-28a38fd68c3e	secret	i7pMrbeb2QM06P92qKGdViAbqiDBb2E_lD6HX_Kct7kjXpJBBaO2tvMHWGREHzYq7H0ui0KbmI0dk7PnHOoT-A
20f1fcc3-9627-48c3-a71e-2d28b475e3ec	d221e324-299e-406f-ba06-28a38fd68c3e	priority	100
993c23e4-31e3-4737-b677-13836b29394c	d221e324-299e-406f-ba06-28a38fd68c3e	algorithm	HS256
fec9151e-9a3c-45ce-89ff-26676fe9b41c	d221e324-299e-406f-ba06-28a38fd68c3e	kid	7f021620-416a-4987-8f64-dd251f310004
3e020880-d53b-4d2e-8a5c-10320f14e677	70f99dcf-4bc9-4d5b-901e-e8e0e291ab0b	privateKey	MIIEogIBAAKCAQEAhkHveGxcAG7a6CF0ZXcuv5iCbkb3qE+HnKkuEF2/SfVsbB5Y65jurdCTboPKddMQpkg8iG7IyVE/d8BB89fSUpClAM/vfMKv7fvmT2sv0MrCiCQUo6vlbjKykmjHWUOR1IQ3bxTozStafnN1Al0eQKm3IO/omQh5Dfo+Mmq82mmxTk3gjfTLkopk0PiUGY4Mf8qAR1wswPtFhxFi04c7iHBOE+DME6KmWfSk4HMFfvcV67NWcZyWpFkPflJP878pXvEazDoEWwbD7sziB7BaBrZJwBQ69WAsgGhnKGldiChRdIyu9Ysr+mnxKtnFgZv7G8JH44M+8ea6a0FXGvnHywIDAQABAoIBAA7g+cgPwjZuEqaNJpgkGDM1lKbiCIpHnhDXkvpPWWa54zUsO9CIV1M9/UjPJD3gkUTMVqEMHgZpka4UyXpbnbx2uUKYyMK71MF8HC8LAvaRsfNihEMLRtbqmW2uXQFggqXZrUcLOy2Zs2K2Ku6DIVorNNdanx1umfPZmtD9kUZnLQ0wVrbdG0VNARmDyyQbNB+R5zPrLmYxujSROCNq0fuY3wymLZVg+F8m4JHXjz5ENLCYCPUA2OKi+c+2iifIpBcA7tPveexN5FRvpMElZJj6wuu1JJ+NAGoqn7faKRljmKo5+4OL3DzFlf2bjDFdNjSYUAOXe0mJuYqbzdNbHaECgYEAxGTnMI8iPoCFYBpZPUfeQkmDc0x0qWzp44e8MmCENnIB/IDHU5YkkjY3+02lSHC2EfTd/CInCEIpQMTw5f8siRUgzm0Vw1Ppd6l9oXuVJplzKz/KK9SancP7EyiJG3sQ/pDNoFcIvXg2fCVRHqGz/MB3uVPD47qI2pmq26XqIvECgYEArwE/60YiPXfNvJ1anozxTmWUCdlw9zUv24Tni7eIoLBlRcihw17p6JHgIX5/K2utphKnMeFsrYZj9R6HBvhQ7g5Z1q+ip77mSkAGAHmzuWxeTFdUcgHNfUhkYSFCY0UTBZBLI259XRwGmIs+E3BeuJv8mp6Rribw7C2/NnAO3nsCgYBl3dSQul1PwAfuPhx1jbZ5+XmGL2z/iC+Uxg3Wr3tEZkQjfYRmFaWodRj6b17AwT2e+Ly/j9NhFDgjkUNGeOHXxK68g5ZbN0YMvEwem2RUnhk/oJmzvFXqaQHtAQSEzYOWFvOhLCOraxQPtqdp1QPvoME4znr3vwRHJpeZ0GgucQKBgGiHnY9BN+hxK8ESV/NGCkgiYjcz2sa9zRUYoFkSyhf45LS27vBMO/i/URmQfhMIYRNGJvmjRQ+sqv3ZOxvNrEFU7xJNnCEH5HPLJAqapuAFO5nru7PRIdVILTTa8dVrh74V/ttt/pFj0QjCetSPlPQ9r7cHKcrU1aisdn7kle0LAoGAMDHaichQZsWvFEL6SUvbrvZQtfEwy5wQ+tGiD8lBuG8vyD6F/DhELjTaG13FOAQhBAxfAKfrIGBS51iHWgNWKb/fjRjmpvA9LkzYyjxe421Jz9FLkM1AtT7IhIIuvXtVJ5ITwxEJ6dJmAlRerANa1ajWmSeXVktLmwEMUCfmI3w=
fbac07d7-1510-493d-9f81-856e943bd50a	70f99dcf-4bc9-4d5b-901e-e8e0e291ab0b	keyUse	enc
aa9f5d25-df95-407f-b5aa-d4688bd2e8ba	70f99dcf-4bc9-4d5b-901e-e8e0e291ab0b	certificate	MIICmTCCAYECBgF8jeyKCzANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVsZWFyaTAeFw0yMTEwMTcxMTAyNDFaFw0zMTEwMTcxMTA0MjFaMBAxDjAMBgNVBAMMBWxlYXJpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhkHveGxcAG7a6CF0ZXcuv5iCbkb3qE+HnKkuEF2/SfVsbB5Y65jurdCTboPKddMQpkg8iG7IyVE/d8BB89fSUpClAM/vfMKv7fvmT2sv0MrCiCQUo6vlbjKykmjHWUOR1IQ3bxTozStafnN1Al0eQKm3IO/omQh5Dfo+Mmq82mmxTk3gjfTLkopk0PiUGY4Mf8qAR1wswPtFhxFi04c7iHBOE+DME6KmWfSk4HMFfvcV67NWcZyWpFkPflJP878pXvEazDoEWwbD7sziB7BaBrZJwBQ69WAsgGhnKGldiChRdIyu9Ysr+mnxKtnFgZv7G8JH44M+8ea6a0FXGvnHywIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQB0mUf04LhSrTIpjGTO6hWDolMlNRKFUqc5Zsv6fKsm6FGZa4MFE1T7pIjlEDqRJigvC+Vo9IIS5jvf67680ZqlwgtV8Oqu8O8DViZ+N2ZwmrCXgF2KfKLSa/PDiXKDr7Jq9KaSS8Ab7vgcgb4MbFwfECbXq6WAwsvpr1py11wORwhLMlqs/i0nprGt6warrFPLtd2QYUNFYvcsYGyoo0sLZY/yZhBAN0ONzaNvj4A5BtEZMi5Fggb7Nwa7vf69etxtoWwW52F2wzyBlTPR0tbft1b1SnatyCnZeWrifPioTcDfoqEaEN86xoUuPfOBIslq1Q0Eqt4oUzfVJ90JsM1z
05cd2456-4b9c-40e6-9a59-49ba38099355	70f99dcf-4bc9-4d5b-901e-e8e0e291ab0b	priority	100
307304eb-53f4-4ef4-b1d2-3ec913595835	88449ffd-8169-4d50-bf93-1153db2d8ede	kid	be8ebcbe-4549-42a5-a6ec-f38425912454
c3331035-35ed-4cd8-8de5-beb51a3ebd89	88449ffd-8169-4d50-bf93-1153db2d8ede	priority	100
2bc2cdef-24c8-4dd8-ad3e-cf1ff967cbc1	88449ffd-8169-4d50-bf93-1153db2d8ede	secret	0zJOkMLMt58FpdALzT40dA
ab5e40fa-7f4e-49e6-a64d-4f1ca6c5ee3c	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	saml-user-attribute-mapper
03ded818-53f6-427d-977b-30e16176ef9b	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	oidc-address-mapper
224ffa39-ded0-44c6-a3a6-b425277a2342	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	saml-user-property-mapper
ac6b6307-58c5-4c55-b86d-57e5c3abf0f9	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
08dc76eb-ee3e-4f42-a2a6-71953473461e	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	oidc-full-name-mapper
058fb502-5948-4ac0-aa8a-a4307717b15d	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5ad83daa-ccbf-4b57-8362-4b1bf9530ac0	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	saml-role-list-mapper
dea88b09-b741-420e-a17b-8dd7d9633fc8	05d6737a-2624-475f-8e10-1ae5ee9a28be	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
45b3135c-91f8-4bd9-a843-80051b408f4e	35c97878-b443-4273-ba14-b3979967dd9d	max-clients	200
f5d07446-cb05-413a-9c56-cdc1cb844940	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	saml-role-list-mapper
9456efbb-36ea-4319-8383-eb68bb83a2c4	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	oidc-address-mapper
7428d5cb-1086-4815-844d-5287cb50592e	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c2c26f59-5bb0-482a-ba5f-590a8b79bd74	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
aa3c3ecd-6f6c-4b8a-a845-a2d11f828832	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	saml-user-property-mapper
07533c4f-29ff-4e5f-a132-661ac14e0f10	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8a0fc73f-9269-45d0-821f-daf3e496bfdd	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	saml-user-attribute-mapper
69406c24-dc98-4149-ac08-9439a6537fc5	e93f5999-0ad8-4a01-9782-5c75f4c831a3	allowed-protocol-mapper-types	oidc-full-name-mapper
2331c658-35e7-4c51-b57d-354e36a28a48	9537b5cb-90fa-4781-9be1-0ad5d1ad01a4	client-uris-must-match	true
4d9337bc-a0ff-4e07-a9e5-763b9819676a	9537b5cb-90fa-4781-9be1-0ad5d1ad01a4	host-sending-registration-request-must-match	true
4d577b23-ee1e-43de-8fbc-2aeb88a3cc11	1560e4c5-b470-4442-a358-7c721b25115b	allow-default-scopes	true
210ae40a-5213-4fcd-a409-83de867ef383	a6e2212e-bb62-4e5a-b530-d1ecde5b0534	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
1cfc41c6-770d-4966-8585-44ef7b8c95b8	855b5af4-72f0-4727-a7c3-92df63347715
1cfc41c6-770d-4966-8585-44ef7b8c95b8	9b73f8d0-1052-4374-b285-2e4d598ff8be
1cfc41c6-770d-4966-8585-44ef7b8c95b8	f3e3f1b3-0c08-49b5-a7ed-697d778cf206
1cfc41c6-770d-4966-8585-44ef7b8c95b8	fc227d94-73a5-4031-b268-b51e6c094d0e
1cfc41c6-770d-4966-8585-44ef7b8c95b8	b5647b09-8532-4a5a-b638-54aae275f8d7
1cfc41c6-770d-4966-8585-44ef7b8c95b8	46c657f4-cd9f-4fe8-8bdd-2cf3fec11f97
1cfc41c6-770d-4966-8585-44ef7b8c95b8	2df5d6a0-890c-4477-8479-95439cc895dc
1cfc41c6-770d-4966-8585-44ef7b8c95b8	2c61305f-4974-4cb7-a504-c09440f07594
1cfc41c6-770d-4966-8585-44ef7b8c95b8	3cbdeaa5-d50d-4b08-aa4e-63121ad2b334
1cfc41c6-770d-4966-8585-44ef7b8c95b8	aa360e7e-b7d4-4d49-badc-862005fdcc6b
1cfc41c6-770d-4966-8585-44ef7b8c95b8	ccbd4cdb-315b-4275-afc7-932b183cb9ed
1cfc41c6-770d-4966-8585-44ef7b8c95b8	884278da-0e81-43e9-bb7d-2096a15def36
1cfc41c6-770d-4966-8585-44ef7b8c95b8	1f8715cd-a3c5-4c71-9ce3-a8b68d2640de
1cfc41c6-770d-4966-8585-44ef7b8c95b8	4d7afcf2-ba7b-492a-ba01-09761cc1e40a
1cfc41c6-770d-4966-8585-44ef7b8c95b8	eb321d41-4dee-476b-9e21-e0ea53eded7b
1cfc41c6-770d-4966-8585-44ef7b8c95b8	4d99ad4d-b5bb-477e-81a8-2a1d7ad224d7
1cfc41c6-770d-4966-8585-44ef7b8c95b8	9f69cfb9-1791-42c3-bfdd-703b3f793d63
1cfc41c6-770d-4966-8585-44ef7b8c95b8	96d3ddeb-7ecd-4db0-8f8a-30593c83edeb
b5647b09-8532-4a5a-b638-54aae275f8d7	4d99ad4d-b5bb-477e-81a8-2a1d7ad224d7
fc227d94-73a5-4031-b268-b51e6c094d0e	96d3ddeb-7ecd-4db0-8f8a-30593c83edeb
fc227d94-73a5-4031-b268-b51e6c094d0e	eb321d41-4dee-476b-9e21-e0ea53eded7b
cbd46a7c-8379-46c0-a7ef-51db16a0c601	32b28f33-cf0e-4f5d-a633-d20852ac6190
cbd46a7c-8379-46c0-a7ef-51db16a0c601	0905bac3-20ff-40e1-9539-f92aac745837
0905bac3-20ff-40e1-9539-f92aac745837	be3c7f7c-8171-40b4-ab53-7744ee595dbb
cd02bc82-5211-4a2a-892a-ff9f82049a70	70cbea62-1f16-4ae1-8630-7ad329ed3bf6
1cfc41c6-770d-4966-8585-44ef7b8c95b8	fe064e17-9016-42a0-8222-6050701b0a22
cbd46a7c-8379-46c0-a7ef-51db16a0c601	0eddb216-b633-452d-9320-76ffe43ea0c5
cbd46a7c-8379-46c0-a7ef-51db16a0c601	17fa67f5-b7e7-40c7-acd8-ba0e2c4caa10
1cfc41c6-770d-4966-8585-44ef7b8c95b8	f408d392-5a24-44c5-9a1c-4d67abe3aa81
1cfc41c6-770d-4966-8585-44ef7b8c95b8	7642b1f5-a95a-401e-8a89-6912b19f2b4f
1cfc41c6-770d-4966-8585-44ef7b8c95b8	eb6c40b0-ffec-44ab-b034-0e1320bc1c56
1cfc41c6-770d-4966-8585-44ef7b8c95b8	0e959089-6fe9-4f42-866c-696455ae79ac
1cfc41c6-770d-4966-8585-44ef7b8c95b8	74869531-4ffd-4f17-9cb2-fb1938f9f340
1cfc41c6-770d-4966-8585-44ef7b8c95b8	413d14c9-f7ea-4ec0-b386-1f8e2bae893f
1cfc41c6-770d-4966-8585-44ef7b8c95b8	ae484a24-29b2-49d2-a21f-ab69cb4ad378
1cfc41c6-770d-4966-8585-44ef7b8c95b8	d574315d-f8f8-45ae-b691-39e2ef928a7a
1cfc41c6-770d-4966-8585-44ef7b8c95b8	3598cb1d-372d-488d-bc65-7d2b9f064b2f
1cfc41c6-770d-4966-8585-44ef7b8c95b8	7d7df8cb-8b46-4a91-9afa-5b87a9940fa6
1cfc41c6-770d-4966-8585-44ef7b8c95b8	f865a567-907e-40e0-b771-1cec20fc911a
1cfc41c6-770d-4966-8585-44ef7b8c95b8	fcf8c0a9-9997-4181-9072-a0f6fdf1fca5
1cfc41c6-770d-4966-8585-44ef7b8c95b8	41a2ba51-8444-4c32-a2db-590865e0536b
1cfc41c6-770d-4966-8585-44ef7b8c95b8	ff8a0fdd-bda0-4496-ac2c-042976d78988
1cfc41c6-770d-4966-8585-44ef7b8c95b8	0ba8bcf4-7f52-46eb-9f27-7fe62652b8b6
1cfc41c6-770d-4966-8585-44ef7b8c95b8	0c32d96b-e3f1-4900-99ec-ff60e8e572e0
1cfc41c6-770d-4966-8585-44ef7b8c95b8	8b0da360-055e-4e43-ba78-1dfa4a683d8b
0e959089-6fe9-4f42-866c-696455ae79ac	0ba8bcf4-7f52-46eb-9f27-7fe62652b8b6
eb6c40b0-ffec-44ab-b034-0e1320bc1c56	ff8a0fdd-bda0-4496-ac2c-042976d78988
eb6c40b0-ffec-44ab-b034-0e1320bc1c56	8b0da360-055e-4e43-ba78-1dfa4a683d8b
10209f6a-11d5-484c-b0b2-887acf173951	e1bc2a99-da88-481a-ba0c-8a2a4ffa83ab
10209f6a-11d5-484c-b0b2-887acf173951	96ef6972-1010-42ce-a454-af4e80ea1faa
10209f6a-11d5-484c-b0b2-887acf173951	4ba16ffa-c875-44e8-b409-0ef2fe810a02
10209f6a-11d5-484c-b0b2-887acf173951	aef9323c-5769-401b-8b83-6ba0ed9d0497
10209f6a-11d5-484c-b0b2-887acf173951	64c32cc0-4e32-4066-858e-354b1e505a96
10209f6a-11d5-484c-b0b2-887acf173951	cc960ed0-c64f-445e-b651-71bff54fa7a2
10209f6a-11d5-484c-b0b2-887acf173951	45a3a1ba-4f54-4380-bf74-a4337b6c909d
10209f6a-11d5-484c-b0b2-887acf173951	cd75a03d-5b54-48ff-9959-bb4af3a84b1c
10209f6a-11d5-484c-b0b2-887acf173951	97743d9c-a430-4e3f-8101-c5832f6d0584
10209f6a-11d5-484c-b0b2-887acf173951	99a7b45a-e5a2-4ce8-aded-344acf19c886
10209f6a-11d5-484c-b0b2-887acf173951	5f0e8279-6b51-4a5a-bb01-5d6ebf41e262
10209f6a-11d5-484c-b0b2-887acf173951	47baa005-9a9f-4c75-9c9d-0db5ac6d5ba1
10209f6a-11d5-484c-b0b2-887acf173951	58dac725-7db7-4d21-9037-332c914bd83c
10209f6a-11d5-484c-b0b2-887acf173951	6e6aca15-9c89-40fe-af81-9f622ab40fda
10209f6a-11d5-484c-b0b2-887acf173951	08c41980-52b3-4c6c-85cb-484517433c3d
10209f6a-11d5-484c-b0b2-887acf173951	3de882d1-ddc1-489d-8bdb-a6f1435b5203
10209f6a-11d5-484c-b0b2-887acf173951	786c97c8-2de4-4c8a-b50d-262668b79905
aef9323c-5769-401b-8b83-6ba0ed9d0497	08c41980-52b3-4c6c-85cb-484517433c3d
4ba16ffa-c875-44e8-b409-0ef2fe810a02	786c97c8-2de4-4c8a-b50d-262668b79905
4ba16ffa-c875-44e8-b409-0ef2fe810a02	6e6aca15-9c89-40fe-af81-9f622ab40fda
823a97e7-5965-4d28-96d5-632efc86a55c	40cb3831-ea0f-4bb5-9cbb-63fdd8728cdd
823a97e7-5965-4d28-96d5-632efc86a55c	04c89722-28d4-4502-bb34-83cbb6cfad9a
04c89722-28d4-4502-bb34-83cbb6cfad9a	3792c8da-9692-4852-96da-0416ec32688a
7e98e689-fcf7-47ff-92f0-8118ee57c34e	454b2117-5b49-42c7-9ab6-c05aa12cec1d
1cfc41c6-770d-4966-8585-44ef7b8c95b8	e9aa3ba9-92e6-43b9-9f61-fd753fbc1bc9
10209f6a-11d5-484c-b0b2-887acf173951	9598297f-ca27-45e7-8eb3-0d388e685822
823a97e7-5965-4d28-96d5-632efc86a55c	a643f8d9-82f8-4477-be80-e6a4b39f5e39
823a97e7-5965-4d28-96d5-632efc86a55c	53b76808-25c8-4066-a7fd-f01652a6116e
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
a74550c4-d2e9-4097-b0cc-d6a77c1e28f9	\N	password	271df2d9-eb96-42c6-9d2e-fb98c4ab4c7e	1634468626067	\N	{"value":"R/Hp84GkU0/MwAWZH5JA6n4G6qDQgg0D/CkWulkc4Z5NDUV3oBz3uuiqQzKkQDnWnrVd2aSmAROGTAZNxPKgAA==","salt":"epJpF//wm6GaS3WEZq0ojg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-10-17 11:03:37.222463	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4468616780
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-10-17 11:03:37.244235	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4468616780
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-10-17 11:03:37.289365	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	4468616780
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-10-17 11:03:37.293348	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4468616780
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-10-17 11:03:37.416343	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4468616780
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-10-17 11:03:37.419834	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4468616780
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-10-17 11:03:37.544409	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4468616780
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-10-17 11:03:37.548851	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4468616780
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-10-17 11:03:37.553547	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	4468616780
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-10-17 11:03:37.669831	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	4468616780
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-10-17 11:03:37.743953	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4468616780
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-10-17 11:03:37.748537	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4468616780
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-10-17 11:03:37.77272	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4468616780
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-17 11:03:37.795311	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	4468616780
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-17 11:03:37.798119	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4468616780
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-17 11:03:37.800974	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	4468616780
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-17 11:03:37.802844	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	4468616780
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-10-17 11:03:37.859006	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	4468616780
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-10-17 11:03:37.908276	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4468616780
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-10-17 11:03:37.913912	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4468616780
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-17 11:03:40.053305	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4468616780
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-17 11:03:37.917396	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4468616780
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-17 11:03:37.919964	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4468616780
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-10-17 11:03:38.001006	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	4468616780
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-10-17 11:03:38.013017	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4468616780
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-10-17 11:03:38.019323	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4468616780
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-10-17 11:03:38.411866	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	4468616780
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-10-17 11:03:38.553254	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	4468616780
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-10-17 11:03:38.556616	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4468616780
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-10-17 11:03:38.698857	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	4468616780
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-10-17 11:03:38.727875	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	4468616780
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-10-17 11:03:38.758566	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	4468616780
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-10-17 11:03:38.764954	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	4468616780
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-17 11:03:38.769784	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4468616780
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-17 11:03:38.772421	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4468616780
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-17 11:03:38.816607	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4468616780
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-10-17 11:03:38.823455	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	4468616780
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-17 11:03:38.833577	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4468616780
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-10-17 11:03:38.83751	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	4468616780
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-10-17 11:03:38.841524	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	4468616780
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-17 11:03:38.843865	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4468616780
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-17 11:03:38.846116	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4468616780
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-10-17 11:03:38.851197	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	4468616780
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-17 11:03:40.042375	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	4468616780
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-10-17 11:03:40.048466	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	4468616780
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-17 11:03:40.059127	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	4468616780
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-17 11:03:40.061367	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4468616780
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-17 11:03:40.232689	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	4468616780
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-17 11:03:40.237699	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	4468616780
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-10-17 11:03:40.331143	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	4468616780
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-10-17 11:03:40.587689	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	4468616780
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-10-17 11:03:40.591169	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4468616780
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-10-17 11:03:40.593838	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	4468616780
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-10-17 11:03:40.596276	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	4468616780
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-17 11:03:40.607161	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	4468616780
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-17 11:03:40.617149	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	4468616780
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-17 11:03:40.669191	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	4468616780
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-17 11:03:41.019512	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	4468616780
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-10-17 11:03:41.068426	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	4468616780
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-10-17 11:03:41.077362	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4468616780
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-17 11:03:41.088127	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	4468616780
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-17 11:03:41.100051	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	4468616780
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-10-17 11:03:41.104134	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	4468616780
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-10-17 11:03:41.110459	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	4468616780
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-17 11:03:41.113713	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	4468616780
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-10-17 11:03:41.165633	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	4468616780
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-17 11:03:41.198283	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	4468616780
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-10-17 11:03:41.204704	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	4468616780
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-10-17 11:03:41.251943	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	4468616780
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-10-17 11:03:41.263337	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	4468616780
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-10-17 11:03:41.274308	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	4468616780
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-17 11:03:41.288473	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4468616780
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-17 11:03:41.299112	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4468616780
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-17 11:03:41.305389	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4468616780
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-17 11:03:41.332469	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	4468616780
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-17 11:03:41.357924	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	4468616780
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-17 11:03:41.363776	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	4468616780
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-17 11:03:41.365698	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	4468616780
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-17 11:03:41.398351	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	4468616780
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-17 11:03:41.401395	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	4468616780
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-17 11:03:41.41925	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	4468616780
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-17 11:03:41.422384	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4468616780
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-17 11:03:41.427195	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4468616780
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-17 11:03:41.429685	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4468616780
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-17 11:03:41.453578	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4468616780
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-10-17 11:03:41.460952	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	4468616780
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-17 11:03:41.471876	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	4468616780
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-17 11:03:41.487777	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	4468616780
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.496447	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	4468616780
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.516372	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	4468616780
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.543229	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4468616780
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.563335	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	4468616780
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.56863	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	4468616780
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.595735	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	4468616780
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.602075	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	4468616780
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-17 11:03:41.610765	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	4468616780
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.743878	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4468616780
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.746774	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4468616780
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.759924	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4468616780
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.804278	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4468616780
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.806803	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4468616780
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.848312	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	4468616780
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-17 11:03:41.853774	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	4468616780
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2021-10-17 11:03:41.858286	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	4468616780
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	c3bff590-7ece-4877-a782-aa16c38a13c8	f
master	291b0f77-1b23-4547-bcf1-d296bf804bc3	t
master	66c2ab87-a773-4d29-8a31-ffa16b9eeb54	t
master	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4	t
master	022ff3ec-e510-42e5-a5df-4a232a332e31	f
master	4d2c59cf-fed2-437d-9893-04328f5cd138	f
master	23f97b85-dde4-497f-bb6e-6e8a5444fed3	t
master	3534e970-da47-4f66-9955-55a3e10fb1a1	t
master	59d0342e-df7b-4816-aeb4-31e540cab4df	f
leari	a8b1fdda-ffeb-4322-8abe-01cd28436b5b	f
leari	d92b3f42-8120-4d8a-bad4-46f4bd47650c	t
leari	92299e02-7fc9-4187-ad16-f0342f95ec50	t
leari	969ed18f-a9d3-4d18-82c2-aedead1c4b25	t
leari	00c31f4e-b441-4c5a-9496-1f01a148b597	f
leari	97e92198-335b-4273-8653-343dec127a86	f
leari	92dd278b-84ac-4ce3-840f-b5b80c8271ba	t
leari	e77e7460-2d2f-45eb-9086-ad2022f0be7c	t
leari	07f9c575-5d66-4778-8954-55125f947542	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
cbd46a7c-8379-46c0-a7ef-51db16a0c601	master	f	${role_default-roles}	default-roles-master	master	\N	\N
1cfc41c6-770d-4966-8585-44ef7b8c95b8	master	f	${role_admin}	admin	master	\N	\N
855b5af4-72f0-4727-a7c3-92df63347715	master	f	${role_create-realm}	create-realm	master	\N	\N
9b73f8d0-1052-4374-b285-2e4d598ff8be	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_create-client}	create-client	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
f3e3f1b3-0c08-49b5-a7ed-697d778cf206	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_view-realm}	view-realm	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
fc227d94-73a5-4031-b268-b51e6c094d0e	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_view-users}	view-users	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
b5647b09-8532-4a5a-b638-54aae275f8d7	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_view-clients}	view-clients	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
46c657f4-cd9f-4fe8-8bdd-2cf3fec11f97	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_view-events}	view-events	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
2df5d6a0-890c-4477-8479-95439cc895dc	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_view-identity-providers}	view-identity-providers	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
2c61305f-4974-4cb7-a504-c09440f07594	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_view-authorization}	view-authorization	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
3cbdeaa5-d50d-4b08-aa4e-63121ad2b334	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_manage-realm}	manage-realm	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
aa360e7e-b7d4-4d49-badc-862005fdcc6b	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_manage-users}	manage-users	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
ccbd4cdb-315b-4275-afc7-932b183cb9ed	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_manage-clients}	manage-clients	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
884278da-0e81-43e9-bb7d-2096a15def36	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_manage-events}	manage-events	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
1f8715cd-a3c5-4c71-9ce3-a8b68d2640de	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_manage-identity-providers}	manage-identity-providers	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
4d7afcf2-ba7b-492a-ba01-09761cc1e40a	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_manage-authorization}	manage-authorization	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
eb321d41-4dee-476b-9e21-e0ea53eded7b	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_query-users}	query-users	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
4d99ad4d-b5bb-477e-81a8-2a1d7ad224d7	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_query-clients}	query-clients	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
9f69cfb9-1791-42c3-bfdd-703b3f793d63	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_query-realms}	query-realms	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
96d3ddeb-7ecd-4db0-8f8a-30593c83edeb	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_query-groups}	query-groups	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
32b28f33-cf0e-4f5d-a633-d20852ac6190	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_view-profile}	view-profile	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
0905bac3-20ff-40e1-9539-f92aac745837	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_manage-account}	manage-account	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
be3c7f7c-8171-40b4-ab53-7744ee595dbb	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_manage-account-links}	manage-account-links	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
1cb6f212-36a6-4f37-a7a2-cabeaa04ce98	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_view-applications}	view-applications	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
70cbea62-1f16-4ae1-8630-7ad329ed3bf6	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_view-consent}	view-consent	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
cd02bc82-5211-4a2a-892a-ff9f82049a70	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_manage-consent}	manage-consent	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
98ebf855-b9c6-41f0-95dd-e004125d84f1	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	t	${role_delete-account}	delete-account	master	2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	\N
61a18609-968a-40ec-89b9-55e66c2adc3c	ff5200ad-3564-463c-a9d0-51579bb86447	t	${role_read-token}	read-token	master	ff5200ad-3564-463c-a9d0-51579bb86447	\N
fe064e17-9016-42a0-8222-6050701b0a22	c1c71074-a921-4167-a7ab-d0f3197bdd1f	t	${role_impersonation}	impersonation	master	c1c71074-a921-4167-a7ab-d0f3197bdd1f	\N
0eddb216-b633-452d-9320-76ffe43ea0c5	master	f	${role_offline-access}	offline_access	master	\N	\N
17fa67f5-b7e7-40c7-acd8-ba0e2c4caa10	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
823a97e7-5965-4d28-96d5-632efc86a55c	leari	f	${role_default-roles}	default-roles-leari	leari	\N	\N
f408d392-5a24-44c5-9a1c-4d67abe3aa81	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_create-client}	create-client	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
7642b1f5-a95a-401e-8a89-6912b19f2b4f	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_view-realm}	view-realm	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
eb6c40b0-ffec-44ab-b034-0e1320bc1c56	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_view-users}	view-users	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
0e959089-6fe9-4f42-866c-696455ae79ac	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_view-clients}	view-clients	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
74869531-4ffd-4f17-9cb2-fb1938f9f340	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_view-events}	view-events	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
413d14c9-f7ea-4ec0-b386-1f8e2bae893f	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_view-identity-providers}	view-identity-providers	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
ae484a24-29b2-49d2-a21f-ab69cb4ad378	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_view-authorization}	view-authorization	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
d574315d-f8f8-45ae-b691-39e2ef928a7a	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_manage-realm}	manage-realm	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
3598cb1d-372d-488d-bc65-7d2b9f064b2f	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_manage-users}	manage-users	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
7d7df8cb-8b46-4a91-9afa-5b87a9940fa6	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_manage-clients}	manage-clients	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
f865a567-907e-40e0-b771-1cec20fc911a	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_manage-events}	manage-events	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
fcf8c0a9-9997-4181-9072-a0f6fdf1fca5	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_manage-identity-providers}	manage-identity-providers	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
41a2ba51-8444-4c32-a2db-590865e0536b	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_manage-authorization}	manage-authorization	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
ff8a0fdd-bda0-4496-ac2c-042976d78988	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_query-users}	query-users	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
0ba8bcf4-7f52-46eb-9f27-7fe62652b8b6	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_query-clients}	query-clients	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
0c32d96b-e3f1-4900-99ec-ff60e8e572e0	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_query-realms}	query-realms	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
8b0da360-055e-4e43-ba78-1dfa4a683d8b	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_query-groups}	query-groups	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
10209f6a-11d5-484c-b0b2-887acf173951	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_realm-admin}	realm-admin	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
e1bc2a99-da88-481a-ba0c-8a2a4ffa83ab	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_create-client}	create-client	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
96ef6972-1010-42ce-a454-af4e80ea1faa	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_view-realm}	view-realm	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
4ba16ffa-c875-44e8-b409-0ef2fe810a02	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_view-users}	view-users	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
aef9323c-5769-401b-8b83-6ba0ed9d0497	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_view-clients}	view-clients	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
64c32cc0-4e32-4066-858e-354b1e505a96	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_view-events}	view-events	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
cc960ed0-c64f-445e-b651-71bff54fa7a2	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_view-identity-providers}	view-identity-providers	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
45a3a1ba-4f54-4380-bf74-a4337b6c909d	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_view-authorization}	view-authorization	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
cd75a03d-5b54-48ff-9959-bb4af3a84b1c	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_manage-realm}	manage-realm	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
97743d9c-a430-4e3f-8101-c5832f6d0584	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_manage-users}	manage-users	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
99a7b45a-e5a2-4ce8-aded-344acf19c886	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_manage-clients}	manage-clients	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
5f0e8279-6b51-4a5a-bb01-5d6ebf41e262	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_manage-events}	manage-events	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
47baa005-9a9f-4c75-9c9d-0db5ac6d5ba1	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_manage-identity-providers}	manage-identity-providers	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
58dac725-7db7-4d21-9037-332c914bd83c	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_manage-authorization}	manage-authorization	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
6e6aca15-9c89-40fe-af81-9f622ab40fda	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_query-users}	query-users	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
08c41980-52b3-4c6c-85cb-484517433c3d	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_query-clients}	query-clients	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
3de882d1-ddc1-489d-8bdb-a6f1435b5203	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_query-realms}	query-realms	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
786c97c8-2de4-4c8a-b50d-262668b79905	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_query-groups}	query-groups	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
40cb3831-ea0f-4bb5-9cbb-63fdd8728cdd	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_view-profile}	view-profile	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
04c89722-28d4-4502-bb34-83cbb6cfad9a	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_manage-account}	manage-account	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
3792c8da-9692-4852-96da-0416ec32688a	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_manage-account-links}	manage-account-links	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
e4414cdf-70c4-4bbd-8502-1c83e7c3c4c5	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_view-applications}	view-applications	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
454b2117-5b49-42c7-9ab6-c05aa12cec1d	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_view-consent}	view-consent	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
7e98e689-fcf7-47ff-92f0-8118ee57c34e	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_manage-consent}	manage-consent	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
423d48f0-621e-4125-810c-ceb30d0f9599	84733521-140e-4bc6-9c55-fb4a47090ab6	t	${role_delete-account}	delete-account	leari	84733521-140e-4bc6-9c55-fb4a47090ab6	\N
e9aa3ba9-92e6-43b9-9f61-fd753fbc1bc9	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	t	${role_impersonation}	impersonation	master	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	\N
9598297f-ca27-45e7-8eb3-0d388e685822	b4b01be6-c3d7-4bee-9b28-00a2c5523634	t	${role_impersonation}	impersonation	leari	b4b01be6-c3d7-4bee-9b28-00a2c5523634	\N
9cb2d378-1a66-408d-87bf-d4bd6ff5d26a	33706e11-8c10-4c17-a28d-87724970cc3b	t	${role_read-token}	read-token	leari	33706e11-8c10-4c17-a28d-87724970cc3b	\N
a643f8d9-82f8-4477-be80-e6a4b39f5e39	leari	f	${role_offline-access}	offline_access	leari	\N	\N
53b76808-25c8-4066-a7fd-f01652a6116e	leari	f	${role_uma_authorization}	uma_authorization	leari	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
9xzqo	15.0.2	1634468624
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
0b6e75fb-9acc-42b2-b320-85ea390cd859	audience resolve	openid-connect	oidc-audience-resolve-mapper	a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	\N
c367675b-d86b-4604-835f-5238477ff8dc	locale	openid-connect	oidc-usermodel-attribute-mapper	a600fb8f-18e2-4cad-ac9e-ff16c01e294b	\N
46c360f6-40df-432f-ad17-8aca5004d6a9	role list	saml	saml-role-list-mapper	\N	291b0f77-1b23-4547-bcf1-d296bf804bc3
bcc8fba4-24ca-452f-800e-4b480cd38219	full name	openid-connect	oidc-full-name-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
144c5fac-dac8-4401-b795-9af3824c26fe	family name	openid-connect	oidc-usermodel-property-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
090ffea7-350f-4a8a-81bf-3285c5f09762	given name	openid-connect	oidc-usermodel-property-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
db103ba5-8b79-4b53-b5e8-6ba16d39968d	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
d52331ed-3565-4a09-a6ee-bd5d3882634e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	username	openid-connect	oidc-usermodel-property-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
f05b2795-36ee-4055-9c93-6e2074c1763d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
736e682e-9d81-4866-9660-aafb2a2cacab	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
a5ad64b1-9aae-408a-8623-abfed5d5de41	website	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
c5099d35-f903-49a2-ae09-8fd766515ba4	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
46f49088-41de-4e58-810b-67a9f7165024	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
413a0889-6213-440d-844c-75f578b24576	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
de07d277-afe5-4e46-a1c7-53956bb95609	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	66c2ab87-a773-4d29-8a31-ffa16b9eeb54
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	email	openid-connect	oidc-usermodel-property-mapper	\N	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4
8e642b66-8afb-4cf5-b249-1eb013312965	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3a502fcf-3f6b-41c0-a9d5-858bf2e99df4
52380162-2dbd-4d14-889f-93b15d9a49f0	address	openid-connect	oidc-address-mapper	\N	022ff3ec-e510-42e5-a5df-4a232a332e31
da6c5d98-92ae-412f-95fb-689fb3ff4100	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4d2c59cf-fed2-437d-9893-04328f5cd138
ee71317f-69b2-4be0-8dc4-753cc1528d99	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4d2c59cf-fed2-437d-9893-04328f5cd138
fcece3b2-fb3e-4fab-922e-b13154599010	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	23f97b85-dde4-497f-bb6e-6e8a5444fed3
a292df8d-adb3-40ed-a49c-bdd6cd51f4c7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	23f97b85-dde4-497f-bb6e-6e8a5444fed3
654c8cc9-7add-445c-9d97-4b9b3870ebb2	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	23f97b85-dde4-497f-bb6e-6e8a5444fed3
0b2b78f1-a711-41f6-a2dd-4c49cf42efd5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	3534e970-da47-4f66-9955-55a3e10fb1a1
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	upn	openid-connect	oidc-usermodel-property-mapper	\N	59d0342e-df7b-4816-aeb4-31e540cab4df
c94a781f-2d8d-4ecd-91de-4a172cd43f46	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	59d0342e-df7b-4816-aeb4-31e540cab4df
1206fc9b-168c-466f-9b9f-f38416b636c6	audience resolve	openid-connect	oidc-audience-resolve-mapper	3bd4f39d-4c95-4feb-b0b9-1e19b668d941	\N
c03903f2-0e8b-4aeb-b8b5-81b63dc4f4e4	role list	saml	saml-role-list-mapper	\N	d92b3f42-8120-4d8a-bad4-46f4bd47650c
892c0351-67c8-4ca3-a501-1d3f04222da9	full name	openid-connect	oidc-full-name-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	family name	openid-connect	oidc-usermodel-property-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	given name	openid-connect	oidc-usermodel-property-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
6cd42601-24ec-40f8-a7a7-705b5589ba87	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
dd10933e-4e53-4afb-a580-9c29b2947dd7	username	openid-connect	oidc-usermodel-property-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
c9465c33-1548-4487-9223-4529cfbc0546	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
f7f4ec13-3415-4d7d-bf10-608e4264a93a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
9d7a6a78-70d5-4282-9e5e-b0270201f24d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
76757eeb-7a5d-45c5-8b54-838407343f2e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
19c4401e-d521-4273-b775-a906a78aa4eb	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
d3156151-80a1-4f6c-b353-ca92435861e9	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	92299e02-7fc9-4187-ad16-f0342f95ec50
2a8197ed-f408-4712-a04d-4683fd66c028	email	openid-connect	oidc-usermodel-property-mapper	\N	969ed18f-a9d3-4d18-82c2-aedead1c4b25
56f25df6-c027-4594-a07e-d8f231ce3523	email verified	openid-connect	oidc-usermodel-property-mapper	\N	969ed18f-a9d3-4d18-82c2-aedead1c4b25
220ad875-a927-47ea-bef8-ea3483bb3154	address	openid-connect	oidc-address-mapper	\N	00c31f4e-b441-4c5a-9496-1f01a148b597
0f02d404-b0dc-4c50-90d7-bc3e36dae378	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	97e92198-335b-4273-8653-343dec127a86
891a8080-14e9-45ac-b48c-07643217b540	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	97e92198-335b-4273-8653-343dec127a86
9659c3dd-6b66-4ffa-b5c0-9c65518036c5	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	92dd278b-84ac-4ce3-840f-b5b80c8271ba
4ab64bd1-45ce-47a2-8ba5-0fd317f33395	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	92dd278b-84ac-4ce3-840f-b5b80c8271ba
0843e116-445c-4257-b043-be260a23d689	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	92dd278b-84ac-4ce3-840f-b5b80c8271ba
bfba83f9-4c6d-45c5-8015-12d33b569f17	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e77e7460-2d2f-45eb-9086-ad2022f0be7c
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	upn	openid-connect	oidc-usermodel-property-mapper	\N	07f9c575-5d66-4778-8954-55125f947542
97a5f18c-ecdc-40c0-994f-ccc394b1455a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	07f9c575-5d66-4778-8954-55125f947542
e3ccf777-39de-44a8-ad15-798641a38146	locale	openid-connect	oidc-usermodel-attribute-mapper	62285f94-1070-4ab7-ad3f-ae2978829f81	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
c367675b-d86b-4604-835f-5238477ff8dc	true	userinfo.token.claim
c367675b-d86b-4604-835f-5238477ff8dc	locale	user.attribute
c367675b-d86b-4604-835f-5238477ff8dc	true	id.token.claim
c367675b-d86b-4604-835f-5238477ff8dc	true	access.token.claim
c367675b-d86b-4604-835f-5238477ff8dc	locale	claim.name
c367675b-d86b-4604-835f-5238477ff8dc	String	jsonType.label
46c360f6-40df-432f-ad17-8aca5004d6a9	false	single
46c360f6-40df-432f-ad17-8aca5004d6a9	Basic	attribute.nameformat
46c360f6-40df-432f-ad17-8aca5004d6a9	Role	attribute.name
bcc8fba4-24ca-452f-800e-4b480cd38219	true	userinfo.token.claim
bcc8fba4-24ca-452f-800e-4b480cd38219	true	id.token.claim
bcc8fba4-24ca-452f-800e-4b480cd38219	true	access.token.claim
144c5fac-dac8-4401-b795-9af3824c26fe	true	userinfo.token.claim
144c5fac-dac8-4401-b795-9af3824c26fe	lastName	user.attribute
144c5fac-dac8-4401-b795-9af3824c26fe	true	id.token.claim
144c5fac-dac8-4401-b795-9af3824c26fe	true	access.token.claim
144c5fac-dac8-4401-b795-9af3824c26fe	family_name	claim.name
144c5fac-dac8-4401-b795-9af3824c26fe	String	jsonType.label
090ffea7-350f-4a8a-81bf-3285c5f09762	true	userinfo.token.claim
090ffea7-350f-4a8a-81bf-3285c5f09762	firstName	user.attribute
090ffea7-350f-4a8a-81bf-3285c5f09762	true	id.token.claim
090ffea7-350f-4a8a-81bf-3285c5f09762	true	access.token.claim
090ffea7-350f-4a8a-81bf-3285c5f09762	given_name	claim.name
090ffea7-350f-4a8a-81bf-3285c5f09762	String	jsonType.label
db103ba5-8b79-4b53-b5e8-6ba16d39968d	true	userinfo.token.claim
db103ba5-8b79-4b53-b5e8-6ba16d39968d	middleName	user.attribute
db103ba5-8b79-4b53-b5e8-6ba16d39968d	true	id.token.claim
db103ba5-8b79-4b53-b5e8-6ba16d39968d	true	access.token.claim
db103ba5-8b79-4b53-b5e8-6ba16d39968d	middle_name	claim.name
db103ba5-8b79-4b53-b5e8-6ba16d39968d	String	jsonType.label
d52331ed-3565-4a09-a6ee-bd5d3882634e	true	userinfo.token.claim
d52331ed-3565-4a09-a6ee-bd5d3882634e	nickname	user.attribute
d52331ed-3565-4a09-a6ee-bd5d3882634e	true	id.token.claim
d52331ed-3565-4a09-a6ee-bd5d3882634e	true	access.token.claim
d52331ed-3565-4a09-a6ee-bd5d3882634e	nickname	claim.name
d52331ed-3565-4a09-a6ee-bd5d3882634e	String	jsonType.label
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	true	userinfo.token.claim
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	username	user.attribute
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	true	id.token.claim
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	true	access.token.claim
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	preferred_username	claim.name
1d4f1c9b-2941-4956-8d1c-5565f77c9b96	String	jsonType.label
f05b2795-36ee-4055-9c93-6e2074c1763d	true	userinfo.token.claim
f05b2795-36ee-4055-9c93-6e2074c1763d	profile	user.attribute
f05b2795-36ee-4055-9c93-6e2074c1763d	true	id.token.claim
f05b2795-36ee-4055-9c93-6e2074c1763d	true	access.token.claim
f05b2795-36ee-4055-9c93-6e2074c1763d	profile	claim.name
f05b2795-36ee-4055-9c93-6e2074c1763d	String	jsonType.label
736e682e-9d81-4866-9660-aafb2a2cacab	true	userinfo.token.claim
736e682e-9d81-4866-9660-aafb2a2cacab	picture	user.attribute
736e682e-9d81-4866-9660-aafb2a2cacab	true	id.token.claim
736e682e-9d81-4866-9660-aafb2a2cacab	true	access.token.claim
736e682e-9d81-4866-9660-aafb2a2cacab	picture	claim.name
736e682e-9d81-4866-9660-aafb2a2cacab	String	jsonType.label
a5ad64b1-9aae-408a-8623-abfed5d5de41	true	userinfo.token.claim
a5ad64b1-9aae-408a-8623-abfed5d5de41	website	user.attribute
a5ad64b1-9aae-408a-8623-abfed5d5de41	true	id.token.claim
a5ad64b1-9aae-408a-8623-abfed5d5de41	true	access.token.claim
a5ad64b1-9aae-408a-8623-abfed5d5de41	website	claim.name
a5ad64b1-9aae-408a-8623-abfed5d5de41	String	jsonType.label
c5099d35-f903-49a2-ae09-8fd766515ba4	true	userinfo.token.claim
c5099d35-f903-49a2-ae09-8fd766515ba4	gender	user.attribute
c5099d35-f903-49a2-ae09-8fd766515ba4	true	id.token.claim
c5099d35-f903-49a2-ae09-8fd766515ba4	true	access.token.claim
c5099d35-f903-49a2-ae09-8fd766515ba4	gender	claim.name
c5099d35-f903-49a2-ae09-8fd766515ba4	String	jsonType.label
46f49088-41de-4e58-810b-67a9f7165024	true	userinfo.token.claim
46f49088-41de-4e58-810b-67a9f7165024	birthdate	user.attribute
46f49088-41de-4e58-810b-67a9f7165024	true	id.token.claim
46f49088-41de-4e58-810b-67a9f7165024	true	access.token.claim
46f49088-41de-4e58-810b-67a9f7165024	birthdate	claim.name
46f49088-41de-4e58-810b-67a9f7165024	String	jsonType.label
413a0889-6213-440d-844c-75f578b24576	true	userinfo.token.claim
413a0889-6213-440d-844c-75f578b24576	zoneinfo	user.attribute
413a0889-6213-440d-844c-75f578b24576	true	id.token.claim
413a0889-6213-440d-844c-75f578b24576	true	access.token.claim
413a0889-6213-440d-844c-75f578b24576	zoneinfo	claim.name
413a0889-6213-440d-844c-75f578b24576	String	jsonType.label
de07d277-afe5-4e46-a1c7-53956bb95609	true	userinfo.token.claim
de07d277-afe5-4e46-a1c7-53956bb95609	locale	user.attribute
de07d277-afe5-4e46-a1c7-53956bb95609	true	id.token.claim
de07d277-afe5-4e46-a1c7-53956bb95609	true	access.token.claim
de07d277-afe5-4e46-a1c7-53956bb95609	locale	claim.name
de07d277-afe5-4e46-a1c7-53956bb95609	String	jsonType.label
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	true	userinfo.token.claim
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	updatedAt	user.attribute
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	true	id.token.claim
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	true	access.token.claim
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	updated_at	claim.name
50d922a7-eee1-40b7-8c69-f8ce9bfe8eaf	String	jsonType.label
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	true	userinfo.token.claim
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	email	user.attribute
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	true	id.token.claim
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	true	access.token.claim
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	email	claim.name
b0a4cc8d-2a9e-4182-89f7-387a118b8b98	String	jsonType.label
8e642b66-8afb-4cf5-b249-1eb013312965	true	userinfo.token.claim
8e642b66-8afb-4cf5-b249-1eb013312965	emailVerified	user.attribute
8e642b66-8afb-4cf5-b249-1eb013312965	true	id.token.claim
8e642b66-8afb-4cf5-b249-1eb013312965	true	access.token.claim
8e642b66-8afb-4cf5-b249-1eb013312965	email_verified	claim.name
8e642b66-8afb-4cf5-b249-1eb013312965	boolean	jsonType.label
52380162-2dbd-4d14-889f-93b15d9a49f0	formatted	user.attribute.formatted
52380162-2dbd-4d14-889f-93b15d9a49f0	country	user.attribute.country
52380162-2dbd-4d14-889f-93b15d9a49f0	postal_code	user.attribute.postal_code
52380162-2dbd-4d14-889f-93b15d9a49f0	true	userinfo.token.claim
52380162-2dbd-4d14-889f-93b15d9a49f0	street	user.attribute.street
52380162-2dbd-4d14-889f-93b15d9a49f0	true	id.token.claim
52380162-2dbd-4d14-889f-93b15d9a49f0	region	user.attribute.region
52380162-2dbd-4d14-889f-93b15d9a49f0	true	access.token.claim
52380162-2dbd-4d14-889f-93b15d9a49f0	locality	user.attribute.locality
da6c5d98-92ae-412f-95fb-689fb3ff4100	true	userinfo.token.claim
da6c5d98-92ae-412f-95fb-689fb3ff4100	phoneNumber	user.attribute
da6c5d98-92ae-412f-95fb-689fb3ff4100	true	id.token.claim
da6c5d98-92ae-412f-95fb-689fb3ff4100	true	access.token.claim
da6c5d98-92ae-412f-95fb-689fb3ff4100	phone_number	claim.name
da6c5d98-92ae-412f-95fb-689fb3ff4100	String	jsonType.label
ee71317f-69b2-4be0-8dc4-753cc1528d99	true	userinfo.token.claim
ee71317f-69b2-4be0-8dc4-753cc1528d99	phoneNumberVerified	user.attribute
ee71317f-69b2-4be0-8dc4-753cc1528d99	true	id.token.claim
ee71317f-69b2-4be0-8dc4-753cc1528d99	true	access.token.claim
ee71317f-69b2-4be0-8dc4-753cc1528d99	phone_number_verified	claim.name
ee71317f-69b2-4be0-8dc4-753cc1528d99	boolean	jsonType.label
fcece3b2-fb3e-4fab-922e-b13154599010	true	multivalued
fcece3b2-fb3e-4fab-922e-b13154599010	foo	user.attribute
fcece3b2-fb3e-4fab-922e-b13154599010	true	access.token.claim
fcece3b2-fb3e-4fab-922e-b13154599010	realm_access.roles	claim.name
fcece3b2-fb3e-4fab-922e-b13154599010	String	jsonType.label
a292df8d-adb3-40ed-a49c-bdd6cd51f4c7	true	multivalued
a292df8d-adb3-40ed-a49c-bdd6cd51f4c7	foo	user.attribute
a292df8d-adb3-40ed-a49c-bdd6cd51f4c7	true	access.token.claim
a292df8d-adb3-40ed-a49c-bdd6cd51f4c7	resource_access.${client_id}.roles	claim.name
a292df8d-adb3-40ed-a49c-bdd6cd51f4c7	String	jsonType.label
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	true	userinfo.token.claim
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	username	user.attribute
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	true	id.token.claim
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	true	access.token.claim
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	upn	claim.name
428848ab-36b6-4f7a-b1e8-7ee064cf7b45	String	jsonType.label
c94a781f-2d8d-4ecd-91de-4a172cd43f46	true	multivalued
c94a781f-2d8d-4ecd-91de-4a172cd43f46	foo	user.attribute
c94a781f-2d8d-4ecd-91de-4a172cd43f46	true	id.token.claim
c94a781f-2d8d-4ecd-91de-4a172cd43f46	true	access.token.claim
c94a781f-2d8d-4ecd-91de-4a172cd43f46	groups	claim.name
c94a781f-2d8d-4ecd-91de-4a172cd43f46	String	jsonType.label
c03903f2-0e8b-4aeb-b8b5-81b63dc4f4e4	false	single
c03903f2-0e8b-4aeb-b8b5-81b63dc4f4e4	Basic	attribute.nameformat
c03903f2-0e8b-4aeb-b8b5-81b63dc4f4e4	Role	attribute.name
892c0351-67c8-4ca3-a501-1d3f04222da9	true	userinfo.token.claim
892c0351-67c8-4ca3-a501-1d3f04222da9	true	id.token.claim
892c0351-67c8-4ca3-a501-1d3f04222da9	true	access.token.claim
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	true	userinfo.token.claim
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	lastName	user.attribute
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	true	id.token.claim
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	true	access.token.claim
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	family_name	claim.name
a2a53a48-f921-49a3-a7ca-d2d3fafad1d7	String	jsonType.label
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	true	userinfo.token.claim
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	firstName	user.attribute
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	true	id.token.claim
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	true	access.token.claim
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	given_name	claim.name
bdb75bd1-7c70-40e6-a27b-6bc29e49b19f	String	jsonType.label
6cd42601-24ec-40f8-a7a7-705b5589ba87	true	userinfo.token.claim
6cd42601-24ec-40f8-a7a7-705b5589ba87	middleName	user.attribute
6cd42601-24ec-40f8-a7a7-705b5589ba87	true	id.token.claim
6cd42601-24ec-40f8-a7a7-705b5589ba87	true	access.token.claim
6cd42601-24ec-40f8-a7a7-705b5589ba87	middle_name	claim.name
6cd42601-24ec-40f8-a7a7-705b5589ba87	String	jsonType.label
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	true	userinfo.token.claim
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	nickname	user.attribute
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	true	id.token.claim
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	true	access.token.claim
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	nickname	claim.name
2e42d33c-f354-44e2-9722-a6f0abbfc6cb	String	jsonType.label
dd10933e-4e53-4afb-a580-9c29b2947dd7	true	userinfo.token.claim
dd10933e-4e53-4afb-a580-9c29b2947dd7	username	user.attribute
dd10933e-4e53-4afb-a580-9c29b2947dd7	true	id.token.claim
dd10933e-4e53-4afb-a580-9c29b2947dd7	true	access.token.claim
dd10933e-4e53-4afb-a580-9c29b2947dd7	preferred_username	claim.name
dd10933e-4e53-4afb-a580-9c29b2947dd7	String	jsonType.label
c9465c33-1548-4487-9223-4529cfbc0546	true	userinfo.token.claim
c9465c33-1548-4487-9223-4529cfbc0546	profile	user.attribute
c9465c33-1548-4487-9223-4529cfbc0546	true	id.token.claim
c9465c33-1548-4487-9223-4529cfbc0546	true	access.token.claim
c9465c33-1548-4487-9223-4529cfbc0546	profile	claim.name
c9465c33-1548-4487-9223-4529cfbc0546	String	jsonType.label
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	true	userinfo.token.claim
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	picture	user.attribute
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	true	id.token.claim
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	true	access.token.claim
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	picture	claim.name
089e2fe4-8be5-447d-bdfb-0fcebe04d70a	String	jsonType.label
f7f4ec13-3415-4d7d-bf10-608e4264a93a	true	userinfo.token.claim
f7f4ec13-3415-4d7d-bf10-608e4264a93a	website	user.attribute
f7f4ec13-3415-4d7d-bf10-608e4264a93a	true	id.token.claim
f7f4ec13-3415-4d7d-bf10-608e4264a93a	true	access.token.claim
f7f4ec13-3415-4d7d-bf10-608e4264a93a	website	claim.name
f7f4ec13-3415-4d7d-bf10-608e4264a93a	String	jsonType.label
9d7a6a78-70d5-4282-9e5e-b0270201f24d	true	userinfo.token.claim
9d7a6a78-70d5-4282-9e5e-b0270201f24d	gender	user.attribute
9d7a6a78-70d5-4282-9e5e-b0270201f24d	true	id.token.claim
9d7a6a78-70d5-4282-9e5e-b0270201f24d	true	access.token.claim
9d7a6a78-70d5-4282-9e5e-b0270201f24d	gender	claim.name
9d7a6a78-70d5-4282-9e5e-b0270201f24d	String	jsonType.label
76757eeb-7a5d-45c5-8b54-838407343f2e	true	userinfo.token.claim
76757eeb-7a5d-45c5-8b54-838407343f2e	birthdate	user.attribute
76757eeb-7a5d-45c5-8b54-838407343f2e	true	id.token.claim
76757eeb-7a5d-45c5-8b54-838407343f2e	true	access.token.claim
76757eeb-7a5d-45c5-8b54-838407343f2e	birthdate	claim.name
76757eeb-7a5d-45c5-8b54-838407343f2e	String	jsonType.label
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	true	userinfo.token.claim
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	zoneinfo	user.attribute
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	true	id.token.claim
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	true	access.token.claim
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	zoneinfo	claim.name
a0a96a48-b0ed-40b2-a7f2-310a385f6d7c	String	jsonType.label
19c4401e-d521-4273-b775-a906a78aa4eb	true	userinfo.token.claim
19c4401e-d521-4273-b775-a906a78aa4eb	locale	user.attribute
19c4401e-d521-4273-b775-a906a78aa4eb	true	id.token.claim
19c4401e-d521-4273-b775-a906a78aa4eb	true	access.token.claim
19c4401e-d521-4273-b775-a906a78aa4eb	locale	claim.name
19c4401e-d521-4273-b775-a906a78aa4eb	String	jsonType.label
d3156151-80a1-4f6c-b353-ca92435861e9	true	userinfo.token.claim
d3156151-80a1-4f6c-b353-ca92435861e9	updatedAt	user.attribute
d3156151-80a1-4f6c-b353-ca92435861e9	true	id.token.claim
d3156151-80a1-4f6c-b353-ca92435861e9	true	access.token.claim
d3156151-80a1-4f6c-b353-ca92435861e9	updated_at	claim.name
d3156151-80a1-4f6c-b353-ca92435861e9	String	jsonType.label
2a8197ed-f408-4712-a04d-4683fd66c028	true	userinfo.token.claim
2a8197ed-f408-4712-a04d-4683fd66c028	email	user.attribute
2a8197ed-f408-4712-a04d-4683fd66c028	true	id.token.claim
2a8197ed-f408-4712-a04d-4683fd66c028	true	access.token.claim
2a8197ed-f408-4712-a04d-4683fd66c028	email	claim.name
2a8197ed-f408-4712-a04d-4683fd66c028	String	jsonType.label
56f25df6-c027-4594-a07e-d8f231ce3523	true	userinfo.token.claim
56f25df6-c027-4594-a07e-d8f231ce3523	emailVerified	user.attribute
56f25df6-c027-4594-a07e-d8f231ce3523	true	id.token.claim
56f25df6-c027-4594-a07e-d8f231ce3523	true	access.token.claim
56f25df6-c027-4594-a07e-d8f231ce3523	email_verified	claim.name
56f25df6-c027-4594-a07e-d8f231ce3523	boolean	jsonType.label
220ad875-a927-47ea-bef8-ea3483bb3154	formatted	user.attribute.formatted
220ad875-a927-47ea-bef8-ea3483bb3154	country	user.attribute.country
220ad875-a927-47ea-bef8-ea3483bb3154	postal_code	user.attribute.postal_code
220ad875-a927-47ea-bef8-ea3483bb3154	true	userinfo.token.claim
220ad875-a927-47ea-bef8-ea3483bb3154	street	user.attribute.street
220ad875-a927-47ea-bef8-ea3483bb3154	true	id.token.claim
220ad875-a927-47ea-bef8-ea3483bb3154	region	user.attribute.region
220ad875-a927-47ea-bef8-ea3483bb3154	true	access.token.claim
220ad875-a927-47ea-bef8-ea3483bb3154	locality	user.attribute.locality
0f02d404-b0dc-4c50-90d7-bc3e36dae378	true	userinfo.token.claim
0f02d404-b0dc-4c50-90d7-bc3e36dae378	phoneNumber	user.attribute
0f02d404-b0dc-4c50-90d7-bc3e36dae378	true	id.token.claim
0f02d404-b0dc-4c50-90d7-bc3e36dae378	true	access.token.claim
0f02d404-b0dc-4c50-90d7-bc3e36dae378	phone_number	claim.name
0f02d404-b0dc-4c50-90d7-bc3e36dae378	String	jsonType.label
891a8080-14e9-45ac-b48c-07643217b540	true	userinfo.token.claim
891a8080-14e9-45ac-b48c-07643217b540	phoneNumberVerified	user.attribute
891a8080-14e9-45ac-b48c-07643217b540	true	id.token.claim
891a8080-14e9-45ac-b48c-07643217b540	true	access.token.claim
891a8080-14e9-45ac-b48c-07643217b540	phone_number_verified	claim.name
891a8080-14e9-45ac-b48c-07643217b540	boolean	jsonType.label
9659c3dd-6b66-4ffa-b5c0-9c65518036c5	true	multivalued
9659c3dd-6b66-4ffa-b5c0-9c65518036c5	foo	user.attribute
9659c3dd-6b66-4ffa-b5c0-9c65518036c5	true	access.token.claim
9659c3dd-6b66-4ffa-b5c0-9c65518036c5	realm_access.roles	claim.name
9659c3dd-6b66-4ffa-b5c0-9c65518036c5	String	jsonType.label
4ab64bd1-45ce-47a2-8ba5-0fd317f33395	true	multivalued
4ab64bd1-45ce-47a2-8ba5-0fd317f33395	foo	user.attribute
4ab64bd1-45ce-47a2-8ba5-0fd317f33395	true	access.token.claim
4ab64bd1-45ce-47a2-8ba5-0fd317f33395	resource_access.${client_id}.roles	claim.name
4ab64bd1-45ce-47a2-8ba5-0fd317f33395	String	jsonType.label
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	true	userinfo.token.claim
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	username	user.attribute
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	true	id.token.claim
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	true	access.token.claim
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	upn	claim.name
fd1f45d5-3b7a-4198-a8fb-91e25ef9a488	String	jsonType.label
97a5f18c-ecdc-40c0-994f-ccc394b1455a	true	multivalued
97a5f18c-ecdc-40c0-994f-ccc394b1455a	foo	user.attribute
97a5f18c-ecdc-40c0-994f-ccc394b1455a	true	id.token.claim
97a5f18c-ecdc-40c0-994f-ccc394b1455a	true	access.token.claim
97a5f18c-ecdc-40c0-994f-ccc394b1455a	groups	claim.name
97a5f18c-ecdc-40c0-994f-ccc394b1455a	String	jsonType.label
e3ccf777-39de-44a8-ad15-798641a38146	true	userinfo.token.claim
e3ccf777-39de-44a8-ad15-798641a38146	locale	user.attribute
e3ccf777-39de-44a8-ad15-798641a38146	true	id.token.claim
e3ccf777-39de-44a8-ad15-798641a38146	true	access.token.claim
e3ccf777-39de-44a8-ad15-798641a38146	locale	claim.name
e3ccf777-39de-44a8-ad15-798641a38146	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
leari	60	300	300	\N	\N	\N	t	f	0	\N	leari	0	\N	t	f	t	f	EXTERNAL	1800	36000	f	f	c7af5cc3-6d9c-46a6-bd68-d6b425cf4dff	1800	f	\N	t	f	f	f	0	1	30	6	HmacSHA1	totp	c96f8b9d-62c7-4965-8e36-42324d575511	3d705586-818c-4427-9e06-ae7c5d9b6fb0	f7b76623-60af-41af-9010-a758c9400603	84360cb9-b48f-4ba2-864b-710688c42cec	67f86520-b707-4ed1-b514-c8f5a4c99317	2592000	f	900	t	f	e0ee626b-ce7c-4885-830f-8bc71e2fa120	0	f	0	0	823a97e7-5965-4d28-96d5-632efc86a55c
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c1c71074-a921-4167-a7ab-d0f3197bdd1f	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	73d38889-0f7b-4324-abea-a6053d1d596e	24aff860-e239-4ce8-9e20-5527b719e733	e1bad2ef-4edd-45c0-9797-1b1dd441814b	5374e76e-8163-43bd-a46d-9b1e6e9da6a3	c417d79a-737c-4b35-9a0e-94d3778eec49	2592000	f	900	t	f	3486948f-ce74-4756-9064-447f25fc9bd3	0	f	0	0	cbd46a7c-8379-46c0-a7ef-51db16a0c601
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
oauth2DeviceCodeLifespan	leari	600
oauth2DevicePollingInterval	leari	5
cibaBackchannelTokenDeliveryMode	leari	poll
cibaExpiresIn	leari	120
cibaInterval	leari	5
cibaAuthRequestedUserHint	leari	login_hint
parRequestUriLifespan	leari	60
bruteForceProtected	leari	false
permanentLockout	leari	false
maxFailureWaitSeconds	leari	900
minimumQuickLoginWaitSeconds	leari	60
waitIncrementSeconds	leari	60
quickLoginCheckMilliSeconds	leari	1000
maxDeltaTimeSeconds	leari	43200
failureFactor	leari	30
actionTokenGeneratedByAdminLifespan	leari	43200
actionTokenGeneratedByUserLifespan	leari	300
defaultSignatureAlgorithm	leari	RS256
offlineSessionMaxLifespanEnabled	leari	false
offlineSessionMaxLifespan	leari	5184000
clientSessionIdleTimeout	leari	0
clientSessionMaxLifespan	leari	0
clientOfflineSessionIdleTimeout	leari	0
clientOfflineSessionMaxLifespan	leari	0
webAuthnPolicyRpEntityName	leari	keycloak
webAuthnPolicySignatureAlgorithms	leari	ES256
webAuthnPolicyRpId	leari	
webAuthnPolicyAttestationConveyancePreference	leari	not specified
webAuthnPolicyAuthenticatorAttachment	leari	not specified
webAuthnPolicyRequireResidentKey	leari	not specified
webAuthnPolicyUserVerificationRequirement	leari	not specified
webAuthnPolicyCreateTimeout	leari	0
webAuthnPolicyAvoidSameAuthenticatorRegister	leari	false
webAuthnPolicyRpEntityNamePasswordless	leari	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	leari	ES256
webAuthnPolicyRpIdPasswordless	leari	
webAuthnPolicyAttestationConveyancePreferencePasswordless	leari	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	leari	not specified
webAuthnPolicyRequireResidentKeyPasswordless	leari	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	leari	not specified
webAuthnPolicyCreateTimeoutPasswordless	leari	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	leari	false
client-policies.profiles	leari	{"profiles":[]}
client-policies.policies	leari	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	leari	
_browser_header.xContentTypeOptions	leari	nosniff
_browser_header.xRobotsTag	leari	none
_browser_header.xFrameOptions	leari	SAMEORIGIN
_browser_header.contentSecurityPolicy	leari	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	leari	1; mode=block
_browser_header.strictTransportSecurity	leari	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
leari	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	leari
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
2eb7e682-da37-433c-bcc4-e5e7a5acb9e6	/realms/master/account/*
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	/realms/master/account/*
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	/admin/master/console/*
84733521-140e-4bc6-9c55-fb4a47090ab6	/realms/leari/account/*
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	/realms/leari/account/*
62285f94-1070-4ab7-ad3f-ae2978829f81	/admin/leari/console/*
61316763-7a4a-4ac7-8cf4-cf60a11df001	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
94c251a4-6c3d-4d2e-9ba1-53131469e5a0	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
1c87c05d-9d9c-4cf9-8196-d3ee474ff6f8	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
1ef09e8a-0f2a-4f0f-b999-ec09d3b69d90	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
9074abab-7e12-4ec1-96bd-f134e6ac3efd	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
c7025f59-6c66-4af0-84ab-0f996a451e12	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
b44da0f0-d2ae-4be6-929e-41a57ba52ca0	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
bb255118-f652-432d-802e-280988749997	delete_account	Delete Account	master	f	f	delete_account	60
7a66d55e-389e-489b-b7f8-d325ba54ee7a	VERIFY_EMAIL	Verify Email	leari	t	f	VERIFY_EMAIL	50
bd2f182e-084e-4513-88ed-b20afa342e5e	UPDATE_PROFILE	Update Profile	leari	t	f	UPDATE_PROFILE	40
b9761753-59c6-49aa-abd6-251f7e1f09a7	CONFIGURE_TOTP	Configure OTP	leari	t	f	CONFIGURE_TOTP	10
424dea90-f1aa-404d-add7-60f246f95d39	UPDATE_PASSWORD	Update Password	leari	t	f	UPDATE_PASSWORD	30
6c613627-24bb-45e9-a694-4454fc6ede2c	terms_and_conditions	Terms and Conditions	leari	f	f	terms_and_conditions	20
cd7dfb51-f5ef-4802-aef9-5c702513d636	update_user_locale	Update User Locale	leari	t	f	update_user_locale	1000
1eff45a0-764c-4a1d-810c-c436803ea634	delete_account	Delete Account	leari	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
a8520c8d-b729-4fb9-85cc-0d13f5cfacb0	0905bac3-20ff-40e1-9539-f92aac745837
3bd4f39d-4c95-4feb-b0b9-1e19b668d941	04c89722-28d4-4502-bb34-83cbb6cfad9a
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
271df2d9-eb96-42c6-9d2e-fb98c4ab4c7e	\N	c10e2eb8-b79d-4e50-a4e5-25465bf50b83	f	t	\N	\N	\N	master	admin	1634468626004	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
cbd46a7c-8379-46c0-a7ef-51db16a0c601	271df2d9-eb96-42c6-9d2e-fb98c4ab4c7e
1cfc41c6-770d-4966-8585-44ef7b8c95b8	271df2d9-eb96-42c6-9d2e-fb98c4ab4c7e
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
a600fb8f-18e2-4cad-ac9e-ff16c01e294b	+
62285f94-1070-4ab7-ad3f-ae2978829f81	+
61316763-7a4a-4ac7-8cf4-cf60a11df001	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

