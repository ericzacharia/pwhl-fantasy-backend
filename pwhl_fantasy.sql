--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.13 (Homebrew)

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO eric;

--
-- Name: analytics_events; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.analytics_events (
    id integer NOT NULL,
    user_id integer,
    event_type character varying(64),
    endpoint character varying(256),
    screen character varying(128),
    properties text,
    ip_address character varying(64),
    user_agent character varying(512),
    app_version character varying(32),
    os_version character varying(32),
    device_model character varying(128),
    device_id character varying(256),
    locale character varying(32),
    timezone character varying(64),
    network_type character varying(32),
    session_id character varying(64),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.analytics_events OWNER TO eric;

--
-- Name: analytics_events_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.analytics_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analytics_events_id_seq OWNER TO eric;

--
-- Name: analytics_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.analytics_events_id_seq OWNED BY public.analytics_events.id;


--
-- Name: device_profiles; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.device_profiles (
    id integer NOT NULL,
    user_id integer,
    device_id character varying(256),
    device_model character varying(128),
    os_version character varying(32),
    app_version character varying(32),
    locale character varying(32),
    timezone character varying(64),
    carrier character varying(128),
    screen_width integer,
    screen_height integer,
    push_token character varying(512),
    last_seen timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.device_profiles OWNER TO eric;

--
-- Name: device_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.device_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_profiles_id_seq OWNER TO eric;

--
-- Name: device_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.device_profiles_id_seq OWNED BY public.device_profiles.id;


--
-- Name: draft_picks; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.draft_picks (
    id integer NOT NULL,
    league_id integer,
    fantasy_team_id integer,
    player_id integer,
    pick_number integer NOT NULL,
    round_number integer NOT NULL,
    pick_in_round integer NOT NULL,
    is_made boolean,
    made_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.draft_picks OWNER TO eric;

--
-- Name: draft_picks_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.draft_picks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.draft_picks_id_seq OWNER TO eric;

--
-- Name: draft_picks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.draft_picks_id_seq OWNED BY public.draft_picks.id;


--
-- Name: draft_sessions; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.draft_sessions (
    id integer NOT NULL,
    league_id integer,
    status character varying(20),
    current_pick_number integer,
    total_picks integer,
    pick_time_limit integer,
    current_pick_started_at timestamp with time zone,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.draft_sessions OWNER TO eric;

--
-- Name: draft_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.draft_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.draft_sessions_id_seq OWNER TO eric;

--
-- Name: draft_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.draft_sessions_id_seq OWNED BY public.draft_sessions.id;


--
-- Name: fantasy_rosters; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.fantasy_rosters (
    id integer NOT NULL,
    fantasy_team_id integer,
    player_id integer,
    slot character varying(20),
    position_slot character varying(5),
    acquired_via character varying(20),
    acquired_at timestamp with time zone DEFAULT now(),
    is_active boolean
);


ALTER TABLE public.fantasy_rosters OWNER TO eric;

--
-- Name: fantasy_rosters_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.fantasy_rosters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fantasy_rosters_id_seq OWNER TO eric;

--
-- Name: fantasy_rosters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.fantasy_rosters_id_seq OWNED BY public.fantasy_rosters.id;


--
-- Name: fantasy_teams; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.fantasy_teams (
    id integer NOT NULL,
    name character varying NOT NULL,
    owner_id integer,
    league_id integer,
    total_points double precision,
    wins integer,
    losses integer,
    ties integer,
    waiver_priority integer,
    faab_budget double precision,
    logo_url character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.fantasy_teams OWNER TO eric;

--
-- Name: fantasy_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.fantasy_teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fantasy_teams_id_seq OWNER TO eric;

--
-- Name: fantasy_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.fantasy_teams_id_seq OWNED BY public.fantasy_teams.id;


--
-- Name: game_events; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.game_events (
    id integer NOT NULL,
    game_id integer,
    event_type character varying(20),
    period integer,
    time_in_period character varying(10),
    player_id integer,
    team_id integer,
    description character varying,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.game_events OWNER TO eric;

--
-- Name: game_events_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.game_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_events_id_seq OWNER TO eric;

--
-- Name: game_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.game_events_id_seq OWNED BY public.game_events.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.games (
    id integer NOT NULL,
    pwhl_game_id character varying,
    season character varying(9) NOT NULL,
    game_date date NOT NULL,
    game_time timestamp with time zone,
    home_team_id integer,
    away_team_id integer,
    home_score integer,
    away_score integer,
    status character varying(20),
    period integer,
    time_remaining character varying(10),
    is_overtime boolean,
    is_shootout boolean,
    venue character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.games OWNER TO eric;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO eric;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: league_invites; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.league_invites (
    id integer NOT NULL,
    league_id integer,
    email character varying,
    invite_code character varying(20),
    is_used boolean,
    created_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone
);


ALTER TABLE public.league_invites OWNER TO eric;

--
-- Name: league_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.league_invites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.league_invites_id_seq OWNER TO eric;

--
-- Name: league_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.league_invites_id_seq OWNED BY public.league_invites.id;


--
-- Name: league_members; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.league_members (
    id integer NOT NULL,
    league_id integer,
    user_id integer,
    role character varying(20),
    joined_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.league_members OWNER TO eric;

--
-- Name: league_members_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.league_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.league_members_id_seq OWNER TO eric;

--
-- Name: league_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.league_members_id_seq OWNED BY public.league_members.id;


--
-- Name: leagues; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.leagues (
    id integer NOT NULL,
    name character varying NOT NULL,
    commissioner_id integer,
    invite_code character varying(12),
    max_teams integer,
    is_public boolean,
    draft_type character varying(20),
    draft_status character varying(20),
    draft_order json,
    current_draft_pick integer,
    season character varying(9),
    roster_size integer,
    active_roster_size integer,
    ir_slots integer,
    waiver_type character varying(20),
    trade_deadline timestamp with time zone,
    is_active boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.leagues OWNER TO eric;

--
-- Name: leagues_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.leagues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leagues_id_seq OWNER TO eric;

--
-- Name: leagues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.leagues_id_seq OWNED BY public.leagues.id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.news_articles (
    id integer NOT NULL,
    title character varying NOT NULL,
    url character varying NOT NULL,
    thumbnail character varying,
    fallback_image character varying,
    date_str character varying,
    summary text,
    scraped_at timestamp with time zone DEFAULT now(),
    team_logos text,
    player_image_url character varying
);


ALTER TABLE public.news_articles OWNER TO eric;

--
-- Name: news_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.news_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_id_seq OWNER TO eric;

--
-- Name: news_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.news_articles_id_seq OWNED BY public.news_articles.id;


--
-- Name: player_stats; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.player_stats (
    id integer NOT NULL,
    player_id integer,
    season character varying(20) NOT NULL,
    game_id integer,
    games_played integer,
    goals integer,
    assists integer,
    points integer,
    plus_minus integer,
    penalty_minutes integer,
    shots integer,
    hits integer,
    blocks integer,
    faceoffs_won integer,
    faceoffs_total integer,
    time_on_ice double precision,
    wins integer,
    losses integer,
    overtime_losses integer,
    saves integer,
    shots_against integer,
    goals_against integer,
    shutouts integer,
    save_percentage double precision,
    goals_against_average double precision,
    fantasy_points double precision,
    is_season_total boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.player_stats OWNER TO eric;

--
-- Name: player_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.player_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_stats_id_seq OWNER TO eric;

--
-- Name: player_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.player_stats_id_seq OWNED BY public.player_stats.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.players (
    id integer NOT NULL,
    pwhl_player_id character varying,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    "position" character varying(2) NOT NULL,
    jersey_number integer,
    pwhl_team_id integer,
    nationality character varying,
    birthdate date,
    height_cm integer,
    weight_kg integer,
    shoots character varying(1),
    is_active boolean,
    headshot_url character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.players OWNER TO eric;

--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_id_seq OWNER TO eric;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: pwhl_teams; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.pwhl_teams (
    id integer NOT NULL,
    name character varying NOT NULL,
    city character varying NOT NULL,
    abbreviation character varying(5) NOT NULL,
    logo_url character varying,
    primary_color character varying(7),
    secondary_color character varying(7),
    arena character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.pwhl_teams OWNER TO eric;

--
-- Name: pwhl_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.pwhl_teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pwhl_teams_id_seq OWNER TO eric;

--
-- Name: pwhl_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.pwhl_teams_id_seq OWNED BY public.pwhl_teams.id;


--
-- Name: scoring_settings; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.scoring_settings (
    id integer NOT NULL,
    league_id integer,
    goal_pts double precision,
    assist_pts double precision,
    plus_minus_pts double precision,
    pim_pts double precision,
    shot_pts double precision,
    hit_pts double precision,
    block_pts double precision,
    goalie_win_pts double precision,
    goalie_save_pts double precision,
    goals_against_pts double precision,
    shutout_pts double precision,
    goalie_loss_pts double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.scoring_settings OWNER TO eric;

--
-- Name: scoring_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.scoring_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scoring_settings_id_seq OWNER TO eric;

--
-- Name: scoring_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.scoring_settings_id_seq OWNED BY public.scoring_settings.id;


--
-- Name: trade_items; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.trade_items (
    id integer NOT NULL,
    trade_id integer,
    player_id integer,
    from_team_id integer,
    to_team_id integer
);


ALTER TABLE public.trade_items OWNER TO eric;

--
-- Name: trade_items_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.trade_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trade_items_id_seq OWNER TO eric;

--
-- Name: trade_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.trade_items_id_seq OWNED BY public.trade_items.id;


--
-- Name: trades; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.trades (
    id integer NOT NULL,
    league_id integer,
    proposing_team_id integer,
    receiving_team_id integer,
    status character varying(20),
    message character varying,
    proposed_at timestamp with time zone DEFAULT now(),
    responded_at timestamp with time zone
);


ALTER TABLE public.trades OWNER TO eric;

--
-- Name: trades_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.trades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trades_id_seq OWNER TO eric;

--
-- Name: trades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.trades_id_seq OWNED BY public.trades.id;


--
-- Name: two_factor_setups; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.two_factor_setups (
    id integer NOT NULL,
    user_id integer,
    secret character varying NOT NULL,
    is_confirmed boolean,
    backup_codes character varying,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.two_factor_setups OWNER TO eric;

--
-- Name: two_factor_setups_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.two_factor_setups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.two_factor_setups_id_seq OWNER TO eric;

--
-- Name: two_factor_setups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.two_factor_setups_id_seq OWNED BY public.two_factor_setups.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying NOT NULL,
    username character varying NOT NULL,
    hashed_password character varying NOT NULL,
    is_active boolean,
    is_verified boolean,
    two_factor_enabled boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO eric;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO eric;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: waivers; Type: TABLE; Schema: public; Owner: eric
--

CREATE TABLE public.waivers (
    id integer NOT NULL,
    league_id integer,
    fantasy_team_id integer,
    player_add_id integer,
    player_drop_id integer,
    status character varying(20),
    priority integer,
    bid_amount double precision,
    requested_at timestamp with time zone DEFAULT now(),
    processed_at timestamp with time zone
);


ALTER TABLE public.waivers OWNER TO eric;

--
-- Name: waivers_id_seq; Type: SEQUENCE; Schema: public; Owner: eric
--

CREATE SEQUENCE public.waivers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waivers_id_seq OWNER TO eric;

--
-- Name: waivers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eric
--

ALTER SEQUENCE public.waivers_id_seq OWNED BY public.waivers.id;


--
-- Name: analytics_events id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.analytics_events ALTER COLUMN id SET DEFAULT nextval('public.analytics_events_id_seq'::regclass);


--
-- Name: device_profiles id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.device_profiles ALTER COLUMN id SET DEFAULT nextval('public.device_profiles_id_seq'::regclass);


--
-- Name: draft_picks id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_picks ALTER COLUMN id SET DEFAULT nextval('public.draft_picks_id_seq'::regclass);


--
-- Name: draft_sessions id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_sessions ALTER COLUMN id SET DEFAULT nextval('public.draft_sessions_id_seq'::regclass);


--
-- Name: fantasy_rosters id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_rosters ALTER COLUMN id SET DEFAULT nextval('public.fantasy_rosters_id_seq'::regclass);


--
-- Name: fantasy_teams id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_teams ALTER COLUMN id SET DEFAULT nextval('public.fantasy_teams_id_seq'::regclass);


--
-- Name: game_events id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.game_events ALTER COLUMN id SET DEFAULT nextval('public.game_events_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: league_invites id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_invites ALTER COLUMN id SET DEFAULT nextval('public.league_invites_id_seq'::regclass);


--
-- Name: league_members id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_members ALTER COLUMN id SET DEFAULT nextval('public.league_members_id_seq'::regclass);


--
-- Name: leagues id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.leagues ALTER COLUMN id SET DEFAULT nextval('public.leagues_id_seq'::regclass);


--
-- Name: news_articles id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.news_articles ALTER COLUMN id SET DEFAULT nextval('public.news_articles_id_seq'::regclass);


--
-- Name: player_stats id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.player_stats ALTER COLUMN id SET DEFAULT nextval('public.player_stats_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: pwhl_teams id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.pwhl_teams ALTER COLUMN id SET DEFAULT nextval('public.pwhl_teams_id_seq'::regclass);


--
-- Name: scoring_settings id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.scoring_settings ALTER COLUMN id SET DEFAULT nextval('public.scoring_settings_id_seq'::regclass);


--
-- Name: trade_items id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trade_items ALTER COLUMN id SET DEFAULT nextval('public.trade_items_id_seq'::regclass);


--
-- Name: trades id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trades ALTER COLUMN id SET DEFAULT nextval('public.trades_id_seq'::regclass);


--
-- Name: two_factor_setups id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.two_factor_setups ALTER COLUMN id SET DEFAULT nextval('public.two_factor_setups_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: waivers id; Type: DEFAULT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.waivers ALTER COLUMN id SET DEFAULT nextval('public.waivers_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.alembic_version (version_num) FROM stdin;
5a207d9d1f5a
\.


--
-- Data for Name: analytics_events; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.analytics_events (id, user_id, event_type, endpoint, screen, properties, ip_address, user_agent, app_version, os_version, device_model, device_id, locale, timezone, network_type, session_id, created_at) FROM stdin;
1	\N	test	\N	\N	{}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:18:51.266506-05
2	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	BEC7B5CF-29EA-40FE-8357-5867B4CCA02D	2026-03-05 15:43:25.623936-05
3	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:25.919272-05
4	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	BEC7B5CF-29EA-40FE-8357-5867B4CCA02D	2026-03-05 15:43:29.060724-05
5	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:31.516305-05
6	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:31.938439-05
7	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:31.94019-05
8	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:31.942433-05
9	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:33.034086-05
10	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:33.04772-05
11	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:33.05326-05
12	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 34}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:33.054147-05
13	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:36.561844-05
14	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:39.077996-05
15	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:39.880617-05
16	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 41}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:43:40.623714-05
17	\N	api_call	GET /api/v1/games	\N	{"status": 403, "duration_ms": 1}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:52:00.09286-05
18	\N	api_call	GET /api/v1/games	\N	{"status": 403, "duration_ms": 0}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:52:01.974052-05
19	\N	api_call	POST /api/v1/auth/login	\N	{"status": 422, "duration_ms": 2}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:52:05.521605-05
20	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 0}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 15:52:05.543019-05
21	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0950DF51-10B8-4F3E-BFC9-90B21B724781	2026-03-05 16:15:30.057289-05
22	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:15:32.915973-05
23	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0950DF51-10B8-4F3E-BFC9-90B21B724781	2026-03-05 16:15:44.424001-05
24	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:15:45.578202-05
25	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:15:45.580021-05
26	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:15:45.581567-05
27	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:15:46.641127-05
28	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0950DF51-10B8-4F3E-BFC9-90B21B724781	2026-03-05 16:16:26.27853-05
29	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 31}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:16:28.513499-05
30	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0950DF51-10B8-4F3E-BFC9-90B21B724781	2026-03-05 16:23:53.956892-05
31	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:23:53.986464-05
32	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 36}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:23:54.035621-05
33	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:26:15.775664-05
34	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:26:17.882878-05
35	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0950DF51-10B8-4F3E-BFC9-90B21B724781	2026-03-05 16:26:17.886487-05
36	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:26:17.920474-05
37	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:26:23.810097-05
38	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:32:25.410044-05
39	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:32:26.441909-05
40	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B63EC3CE-E063-481C-8BB7-B974F8C41F68	2026-03-05 16:33:25.715902-05
41	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:33:25.737343-05
42	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B63EC3CE-E063-481C-8BB7-B974F8C41F68	2026-03-05 16:33:29.413569-05
43	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:33:35.922979-05
44	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 49}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:33:35.939542-05
45	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 54}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:33:35.943474-05
46	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 55}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:33:35.945405-05
47	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 40}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:36:36.419419-05
48	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:36:37.418731-05
49	\N	news_read	\N	\N	{"title": "Opinion: The Time Has Come For All PWHL Venues To Share The Ice And Put Down Team Logos - The Hockey News"}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B63EC3CE-E063-481C-8BB7-B974F8C41F68	2026-03-05 16:41:32.473897-05
50	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B63EC3CE-E063-481C-8BB7-B974F8C41F68	2026-03-05 16:42:15.176963-05
51	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1007D1E4-0BB9-4BCB-954A-1C0E15F3536B	2026-03-05 16:46:19.97115-05
52	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 41}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:19.977345-05
53	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1007D1E4-0BB9-4BCB-954A-1C0E15F3536B	2026-03-05 16:46:21.996821-05
54	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:24.070474-05
55	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:24.072427-05
56	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:24.073454-05
57	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:24.074198-05
58	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:25.464577-05
59	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:25.469124-05
60	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:25.469914-05
61	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:25.471194-05
62	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:28.334748-05
63	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:28.338611-05
64	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:28.339604-05
65	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:46:28.340317-05
66	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1007D1E4-0BB9-4BCB-954A-1C0E15F3536B	2026-03-05 16:47:37.56159-05
67	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:47:42.125594-05
68	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:47:48.508459-05
69	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1007D1E4-0BB9-4BCB-954A-1C0E15F3536B	2026-03-05 16:47:49.594166-05
70	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:47:49.608691-05
71	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:49:46.826999-05
72	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1007D1E4-0BB9-4BCB-954A-1C0E15F3536B	2026-03-05 16:49:50.409104-05
73	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:49:50.426856-05
74	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:49:50.468104-05
75	\N	api_call	GET /api/v1/players/17/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:49:54.385211-05
76	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:49:55.440137-05
77	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:49:55.471401-05
78	\N	api_call	GET /api/v1/players/4/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:50.818641-05
79	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:52.180102-05
80	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:52.218212-05
81	\N	api_call	GET /api/v1/players/4/news	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:52.841403-05
82	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:53.785873-05
83	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:53.819268-05
84	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:55.336942-05
85	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:56.720139-05
86	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:50:56.728703-05
89	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:53:45.077351-05
95	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:55:40.38863-05
99	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:55:46.199191-05
102	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:56:17.656072-05
104	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:56:24.914081-05
118	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:59:39.093515-05
120	\N	api_call	GET /api/v1/players/24/news	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:59:48.028011-05
122	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:59:48.969946-05
87	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1007D1E4-0BB9-4BCB-954A-1C0E15F3536B	2026-03-05 16:50:59.519653-05
90	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	143A7CB9-C3B3-456C-BD70-7583EE6FEFED	2026-03-05 16:53:52.665788-05
93	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:53:56.489694-05
96	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:55:40.396535-05
103	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:56:21.793093-05
108	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:57:54.434174-05
110	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:57:59.218184-05
112	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:58:02.465238-05
114	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:58:03.154495-05
117	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:59:38.991947-05
119	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:59:39.13906-05
121	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:59:48.93524-05
88	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	143A7CB9-C3B3-456C-BD70-7583EE6FEFED	2026-03-05 16:53:44.99356-05
94	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:53:56.490803-05
97	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:55:42.383302-05
98	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:55:46.182167-05
100	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:55:46.200064-05
105	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:56:54.364778-05
107	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:56:57.097437-05
109	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:57:59.214384-05
113	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:58:03.153412-05
116	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:58:03.159624-05
91	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:53:55.584463-05
92	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:53:56.487217-05
101	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:55:46.917283-05
106	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:56:55.229035-05
111	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 16:58:02.463215-05
115	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	A19D7BF0-C0D6-44B8-881B-C68FEEDCD9D6	2026-03-05 16:58:03.157361-05
123	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:01:57.183633-05
124	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:01:57.204857-05
125	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:02:00.528401-05
126	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:02:02.984513-05
127	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:02:03.636472-05
128	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:02:03.637518-05
129	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:02:03.638499-05
130	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:04:18.781431-05
131	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:18.785147-05
132	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:18.837396-05
133	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:04:19.894926-05
134	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:19.926471-05
135	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:19.928223-05
136	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:19.931488-05
137	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:04:20.651457-05
138	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:20.660672-05
139	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:04:20.699304-05
140	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:08:01.472062-05
141	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:01.572543-05
142	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:01.574751-05
143	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:01.57609-05
144	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 26}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:03.614949-05
145	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:03.616971-05
146	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:03.618422-05
147	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	372CD93F-6B6F-4B20-A038-55497064F471	2026-03-05 17:08:07.253447-05
148	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:07.273773-05
149	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:07.311245-05
150	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	81A296B6-9868-4DB7-9AF2-AA0C813951E5	2026-03-05 17:08:41.503783-05
151	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:41.526253-05
152	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	81A296B6-9868-4DB7-9AF2-AA0C813951E5	2026-03-05 17:08:44.27196-05
153	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:44.948008-05
154	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:45.734286-05
155	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:46.293846-05
156	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:08:46.816987-05
157	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	6C08895E-DB38-4CCC-A5CA-4FC5E51756D9	2026-03-05 17:09:10.933106-05
158	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:10.938146-05
162	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 26}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:11.043775-05
164	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:25.818615-05
166	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:27.373485-05
171	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:10:01.542859-05
173	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:10:36.959283-05
175	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:11:06.042506-05
179	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:11:43.994951-05
183	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:30.752693-05
188	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:51.145299-05
190	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:51.683567-05
159	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	6C08895E-DB38-4CCC-A5CA-4FC5E51756D9	2026-03-05 17:09:10.977259-05
163	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 27}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:11.045288-05
165	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:25.822816-05
170	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	6C08895E-DB38-4CCC-A5CA-4FC5E51756D9	2026-03-05 17:10:01.530126-05
172	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:10:01.576491-05
174	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:10:38.05705-05
176	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:11:07.562-05
181	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	6C08895E-DB38-4CCC-A5CA-4FC5E51756D9	2026-03-05 17:13:30.682507-05
186	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:45.067046-05
191	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:52.34347-05
160	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:11.014848-05
161	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:11.041594-05
167	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	6C08895E-DB38-4CCC-A5CA-4FC5E51756D9	2026-03-05 17:09:27.390639-05
169	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:10:00.422426-05
178	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:11:10.697092-05
180	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:11:43.998001-05
182	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:30.749913-05
184	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:30.761029-05
187	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	775AEC2F-B9CC-447B-BA2E-4BF6250717B1	2026-03-05 17:13:48.466058-05
168	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:09:27.412685-05
177	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	6C08895E-DB38-4CCC-A5CA-4FC5E51756D9	2026-03-05 17:11:08.110285-05
185	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	775AEC2F-B9CC-447B-BA2E-4BF6250717B1	2026-03-05 17:13:44.86136-05
189	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:13:51.682509-05
192	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	AC23FF4F-A70F-4E54-979A-3D98737B6C98	2026-03-05 17:18:10.662012-05
193	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:18:10.790352-05
194	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	AC23FF4F-A70F-4E54-979A-3D98737B6C98	2026-03-05 17:18:13.52686-05
195	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:18:14.950483-05
196	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:18:15.542328-05
197	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:18:15.543341-05
198	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:18:15.544506-05
199	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	28AC750E-F185-4577-BE6E-4DCDB3C6E72B	2026-03-05 17:22:30.970736-05
200	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:22:30.97556-05
201	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	28AC750E-F185-4577-BE6E-4DCDB3C6E72B	2026-03-05 17:22:32.649278-05
202	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:22:34.349629-05
203	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:22:34.358287-05
204	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:22:34.374099-05
205	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:22:34.375539-05
206	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:28:12.507549-05
207	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:28:12.532812-05
208	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:28:15.530546-05
209	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:28:17.047501-05
210	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:28:18.272732-05
211	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:28:18.273837-05
212	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:28:18.853969-05
213	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:29:46.002496-05
214	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:29:46.005067-05
215	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:29:46.872303-05
216	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:29:46.881477-05
217	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 27}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:29:46.91229-05
218	\N	api_call	GET /api/v1/players/1/news	\N	{"status": 200, "duration_ms": 36}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:29:58.823912-05
219	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:30:04.724456-05
220	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:30:04.762344-05
221	\N	api_call	GET /api/v1/players/179/news	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:36.830779-05
222	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:47.153221-05
223	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:47.203281-05
224	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:47.866428-05
225	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:47.874322-05
226	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:54.027881-05
227	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:34:54.59039-05
228	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:54.606034-05
229	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 26}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:54.650332-05
234	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:34:57.466155-05
239	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:00.747747-05
241	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:01.797133-05
246	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:04.672508-05
248	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:08.249715-05
250	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:45.666011-05
256	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:49.675721-05
230	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:56.05992-05
243	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:03.889274-05
252	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:49.271249-05
257	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:49.68556-05
259	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:50.655159-05
263	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:52.581774-05
265	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:37:01.124901-05
231	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:34:56.838091-05
233	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:56.885604-05
235	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:57.606726-05
237	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:57.612938-05
242	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:35:02.833839-05
244	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:03.895502-05
251	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:36:46.780408-05
253	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:49.28126-05
258	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:50.650158-05
262	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:52.581022-05
264	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:37:01.119722-05
232	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:56.851118-05
236	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:34:57.610095-05
238	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:35:00.743701-05
240	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 32}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:00.796396-05
245	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:35:04.662013-05
247	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 31}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:04.713118-05
249	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:35:13.048037-05
254	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:36:49.612277-05
255	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:49.674619-05
260	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:36:52.529491-05
261	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:36:52.579928-05
266	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:37:11.157047-05
267	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:37:11.214163-05
268	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:37:11.21552-05
269	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:37:11.216762-05
270	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:37:11.870085-05
271	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:39:13.196132-05
272	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:13.201663-05
273	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 105}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:13.319349-05
274	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:24.132173-05
275	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:24.13729-05
276	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:24.870559-05
277	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:39:26.039335-05
278	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5D72D647-50BC-4051-B49C-D17514CC79C5	2026-03-05 17:39:31.517311-05
279	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:31.576702-05
280	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:31.577824-05
281	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:39:31.592186-05
282	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:46:58.873385-05
283	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:46:58.93954-05
284	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:47:02.934952-05
285	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:05.049228-05
286	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:05.521607-05
287	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:05.523231-05
288	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 765}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:06.991121-05
289	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 768}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:06.992607-05
290	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:06.993478-05
291	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:10.752692-05
292	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:10.755669-05
293	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:10.770605-05
294	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:47:27.174319-05
295	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:42.737399-05
296	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:47:42.740207-05
298	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:48:43.371713-05
300	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:48:44.784628-05
301	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:48:44.946193-05
304	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:10.709306-05
307	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:14.81982-05
309	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:14.864295-05
312	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:48.561631-05
318	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:52.707771-05
319	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:49:54.834899-05
320	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:54.83926-05
324	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:55.246335-05
326	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:50:02.953609-05
328	\N	screen_view	\N	Map	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:50:07.251199-05
330	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:50:16.437709-05
331	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:50:16.45397-05
338	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:29.678141-05
342	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:33.698505-05
343	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:33.709853-05
345	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:34.403156-05
352	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:36.706933-05
353	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:37.003631-05
354	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:37.007626-05
358	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:37.332957-05
297	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:48:43.234628-05
302	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:48:44.950422-05
305	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:12.749608-05
313	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:49:52.041411-05
314	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:52.053978-05
316	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:49:52.654688-05
322	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:49:55.195085-05
323	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:55.245486-05
332	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:50:16.454978-05
333	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:50:17.874464-05
334	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:50:17.888351-05
339	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:30.888548-05
340	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:30.937114-05
344	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:33.711293-05
346	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:34.405375-05
348	\N	screen_view	\N	Map	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:36.098893-05
350	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:36.659238-05
355	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:37.008761-05
299	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:48:43.413705-05
303	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:09.230499-05
306	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:12.775801-05
308	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:49:14.828451-05
310	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:49:48.506292-05
311	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:48.559762-05
315	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:52.055796-05
317	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:52.67588-05
321	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:49:54.840235-05
325	\N	screen_view	\N	Map	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:50:02.872357-05
327	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 17:50:04.625937-05
329	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:50:07.256016-05
335	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 17:50:17.889343-05
336	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:29.671423-05
337	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:29.676729-05
341	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:30.938169-05
347	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:34.44283-05
349	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:36.116085-05
351	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:36.673589-05
356	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	EBB8D1EC-2D7D-4641-926C-A600A22BBBF5	2026-03-05 18:11:37.280706-05
357	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:11:37.331879-05
359	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:27:19.510925-05
360	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:27:19.527767-05
361	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:27:23.01752-05
362	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:27:24.993211-05
363	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:27:25.479566-05
364	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:31:33.327319-05
365	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:31:35.37827-05
366	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:31:35.413884-05
367	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:32:37.26392-05
368	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:32:37.289647-05
369	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:32:37.3217-05
370	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:32:40.671236-05
371	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:32:40.747313-05
372	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:32:40.751857-05
373	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:32:45.610623-05
374	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:32:46.739029-05
375	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:32:46.858631-05
376	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:32:46.859677-05
377	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:33:28.870013-05
378	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:33:34.882226-05
379	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:33:34.966192-05
382	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	361F488C-B605-4F11-8366-8CDD11A96309	2026-03-05 18:35:00.718631-05
384	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	361F488C-B605-4F11-8366-8CDD11A96309	2026-03-05 18:35:03.147579-05
390	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:29.912045-05
393	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:29.974121-05
395	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:32.124933-05
397	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:32.994726-05
399	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:36.150966-05
404	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:37.629082-05
405	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:41.267286-05
407	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:44.024725-05
415	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:47.32435-05
417	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:48.322173-05
419	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:49.544672-05
421	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:09:14.776727-05
423	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:09:20.30726-05
425	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:09:31.004771-05
430	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:11:47.042512-05
436	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:12:20.101802-05
438	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:12:24.601628-05
380	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:33:34.968158-05
386	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:35:05.340445-05
388	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:29.773827-05
392	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:29.947575-05
394	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:32.092088-05
401	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:36.200586-05
410	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:45.624823-05
412	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:46.293816-05
414	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:47.289407-05
416	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:48.302944-05
422	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:09:16.471913-05
427	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:09:51.129184-05
433	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:11:49.508811-05
435	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:11:50.61318-05
437	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:22.197376-05
439	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:24.615762-05
443	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:26.098753-05
445	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:12:29.574999-05
381	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	44D77DA7-0763-42D6-9C06-3068F697F3BF	2026-03-05 18:33:38.80359-05
383	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:35:00.746375-05
385	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 18:35:04.915591-05
387	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:29.769036-05
389	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:29.860516-05
391	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:29.921629-05
396	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:32.161557-05
398	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:33.019243-05
400	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:36.167206-05
402	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:37.575354-05
403	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:37.617605-05
406	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:41.269238-05
408	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:45.578056-05
409	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:08:45.620462-05
411	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:46.27217-05
413	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:47.267904-05
418	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C373FE3-9B7F-419B-9F4C-0C1543F47E06	2026-03-05 19:08:49.543092-05
420	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:09:14.774925-05
424	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:09:21.698674-05
426	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:09:50.614816-05
428	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:11:46.962593-05
429	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:11:47.040816-05
431	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:11:49.46846-05
432	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:11:49.507892-05
434	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:11:50.611948-05
440	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:24.624945-05
441	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	D7E55D49-DC90-4584-997E-754695D9A5AA	2026-03-05 19:12:26.074306-05
442	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:26.097506-05
444	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:28.04445-05
446	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 19:12:29.604813-05
447	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B27DFAC1-035A-44A3-98E7-75DC16904C93	2026-03-05 20:35:29.309603-05
448	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:29.316587-05
449	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B27DFAC1-035A-44A3-98E7-75DC16904C93	2026-03-05 20:35:29.428862-05
450	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:29.50094-05
451	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:29.515469-05
452	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:29.517606-05
453	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:29.539852-05
454	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B27DFAC1-035A-44A3-98E7-75DC16904C93	2026-03-05 20:35:32.018421-05
455	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:32.08931-05
456	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:32.090461-05
458	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:32.485971-05
457	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B27DFAC1-035A-44A3-98E7-75DC16904C93	2026-03-05 20:35:32.423816-05
460	\N	api_call	GET /api/v1/players/35/news	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:38.811751-05
459	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 20:35:32.527972-05
461	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	FCC6292C-2EDA-439F-A4FB-298986A93855	2026-03-05 21:37:07.251705-05
462	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 121}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:07.344576-05
463	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	FCC6292C-2EDA-439F-A4FB-298986A93855	2026-03-05 21:37:10.861215-05
464	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:16.520704-05
465	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:16.522261-05
466	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:16.523218-05
467	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:18.529308-05
468	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:18.532758-05
469	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:20.951097-05
470	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:20.952523-05
471	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	CC93AFED-DFCF-4429-9476-935D92DC51BF	2026-03-05 21:37:43.522159-05
472	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:43.526215-05
473	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	CC93AFED-DFCF-4429-9476-935D92DC51BF	2026-03-05 21:37:43.569449-05
474	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:43.627812-05
475	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:43.628844-05
476	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 21:37:43.63484-05
477	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:07:41.048438-05
478	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:07:41.175895-05
479	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:07:44.696056-05
480	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:07:47.841844-05
481	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:07:47.846633-05
482	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:07:47.848124-05
483	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:08:48.059485-05
484	\N	news_read	\N	\N	{"title": "PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - News-Times"}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:09:01.609285-05
485	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:30:56.265579-05
486	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 49}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:30:56.332368-05
487	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 51}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:30:56.333905-05
488	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:30:58.053178-05
489	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:31:01.755327-05
490	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:01.827519-05
491	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:01.829692-05
492	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:31:02.674553-05
493	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:02.691865-05
494	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:31:03.703846-05
495	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:31:05.005382-05
496	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:05.063249-05
497	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 91}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:05.256714-05
498	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:31:16.540175-05
499	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:16.583424-05
501	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7C61E227-DF67-48C1-9ACA-99C6150F989A	2026-03-05 22:31:18.508155-05
504	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:34:59.116358-05
506	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:03.606168-05
510	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:05.721741-05
511	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:09.299558-05
518	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:59.256324-05
524	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:03.240226-05
528	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:36:05.067259-05
529	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:05.100512-05
535	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:01.052802-05
537	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:01.84888-05
538	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:03.486456-05
541	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:06.980186-05
543	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:32:44.194525-05
547	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:32:49.64743-05
500	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:16.586252-05
502	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-05 22:31:18.558463-05
508	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:03.608147-05
509	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:05.720087-05
512	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:09.302161-05
515	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:57.814358-05
519	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:36:01.195276-05
520	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:01.214267-05
522	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:36:03.201055-05
527	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:04.660574-05
531	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:41:20.412181-05
533	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:29:53.952476-05
536	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:01.054439-05
539	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:03.487938-05
540	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:30:06.978633-05
542	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	2218AF3C-AE3B-4A47-8066-27B8E1485FF7	2026-03-06 13:32:44.181369-05
544	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	2218AF3C-AE3B-4A47-8066-27B8E1485FF7	2026-03-06 13:32:46.17023-05
503	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:34:59.041532-05
505	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:35:01.57524-05
507	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:03.607186-05
513	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:35:57.735843-05
514	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:57.811317-05
516	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:35:59.179793-05
517	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:35:59.255037-05
521	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:01.216223-05
523	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:03.204143-05
525	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	C1D2A274-F274-43C4-8EB7-B5A5D28A8D03	2026-03-06 09:36:04.606846-05
526	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:04.659254-05
530	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 09:36:05.103692-05
532	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B5FE14D2-9C47-4860-807A-7DA8E1164074	2026-03-06 13:29:52.004984-05
534	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B5FE14D2-9C47-4860-807A-7DA8E1164074	2026-03-06 13:29:57.202603-05
545	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:32:49.644136-05
546	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:32:49.646191-05
548	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	2218AF3C-AE3B-4A47-8066-27B8E1485FF7	2026-03-06 13:33:02.101831-05
549	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:33:22.222887-05
550	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:33:22.2385-05
551	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	2218AF3C-AE3B-4A47-8066-27B8E1485FF7	2026-03-06 13:33:29.69632-05
552	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	F92ADF3B-D6B9-4B56-B1AF-6BEAFD2C5B37	2026-03-06 13:43:18.402091-05
553	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:43:18.424408-05
554	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	F92ADF3B-D6B9-4B56-B1AF-6BEAFD2C5B37	2026-03-06 13:43:21.528562-05
555	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:43:24.832739-05
556	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:43:25.502175-05
557	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 13:43:25.506464-05
558	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:01:51.695994-05
559	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:01:53.089937-05
560	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:01:54.615741-05
561	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:11:25.085556-05
562	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 34}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:11:25.087632-05
563	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:11:26.540186-05
564	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:11:30.272708-05
565	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 28}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:11:30.275462-05
566	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 32}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:11:30.279748-05
567	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:14:44.978717-05
568	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:15:59.851132-05
569	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:16:00.004369-05
570	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:16:00.006411-05
572	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:38.850035-05
571	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:43:38.839378-05
573	\N	api_call	GET /api/v1/players	\N	{"status": 401, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:38.866326-05
576	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:43:40.773756-05
577	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:40.799461-05
579	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:44.781683-05
583	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:43:47.956822-05
587	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:48.201671-05
591	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:46:29.596867-05
597	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:46:36.262918-05
600	\N	api_call	GET /api/v1/players/11/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:38.527984-05
605	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:25.521144-05
607	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:38.474863-05
614	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:42.059825-05
616	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 32}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:44.202569-05
618	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:47.347613-05
620	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:50.455183-05
623	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:57.502502-05
626	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:04.602651-05
629	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:10.267859-05
631	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:21.61904-05
633	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:48:22.905187-05
637	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:24.975854-05
639	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:25.895246-05
641	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:55:40.649585-05
643	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:55:46.697416-05
649	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:13.656116-05
651	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:15.803922-05
574	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:38.885656-05
580	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:46.821421-05
582	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:46.833869-05
584	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:47.958648-05
586	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:48.166406-05
588	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:46:28.625452-05
589	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:28.634196-05
593	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:46:31.718363-05
594	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:46:33.263878-05
595	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:33.269408-05
599	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 34}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:36.341679-05
602	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 33}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:21.72169-05
604	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:24.255096-05
609	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 61}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:38.583129-05
611	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:40.099522-05
613	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:42.013943-05
619	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 80}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:47.454053-05
621	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:50.496895-05
624	\N	api_call	GET /api/v1/players/1/news	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:58.967543-05
627	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:06.788064-05
632	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:21.650926-05
634	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:22.945182-05
636	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:24.939931-05
638	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:48:25.862572-05
640	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	58CE0DA2-34CC-4813-8EA8-F6C9B8B25D6E	2026-03-06 14:55:40.523811-05
642	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	58CE0DA2-34CC-4813-8EA8-F6C9B8B25D6E	2026-03-06 14:55:43.799722-05
645	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:55:48.123622-05
647	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:05.974366-05
653	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:17.355089-05
654	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:23.098289-05
575	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 40}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:38.942327-05
578	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:43:40.800574-05
581	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:43:46.827042-05
585	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:43:48.153566-05
590	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:28.635522-05
592	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:29.598409-05
596	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:33.273036-05
598	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:46:36.291915-05
601	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:21.675185-05
603	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:24.234847-05
606	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:26.372601-05
608	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:38.508644-05
610	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:40.079365-05
612	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:41.997323-05
615	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:44.187775-05
617	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:47:47.327935-05
622	\N	api_call	GET /api/v1/players/1/news	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:56.497189-05
625	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:47:59.788445-05
628	\N	api_call	GET /api/v1/players/20/news	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:48:08.980019-05
630	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:48:21.584012-05
635	\N	screen_view	\N	Players	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	E1AE07A8-5E40-4CED-A341-24C0505A933E	2026-03-06 14:48:24.938158-05
644	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 14:55:47.241538-05
646	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	73375538-E79A-4EDD-A764-5EA0776008AC	2026-03-06 16:10:05.819877-05
648	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	73375538-E79A-4EDD-A764-5EA0776008AC	2026-03-06 16:10:09.51581-05
650	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:15.142071-05
652	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 569}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:17.349165-05
655	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:10:23.10027-05
656	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7B5C1C4E-84EC-437A-9F85-508B8D374821	2026-03-06 16:18:17.358738-05
657	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:17.364803-05
658	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	7B5C1C4E-84EC-437A-9F85-508B8D374821	2026-03-06 16:18:17.605152-05
659	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:17.648263-05
660	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:17.649405-05
661	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:17.651241-05
662	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 16:18:45.657028-05
663	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:45.828568-05
664	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 16:18:49.591489-05
665	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:54.674631-05
666	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:54.677524-05
667	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:18:54.679977-05
668	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 16:19:29.81674-05
669	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:19:35.5286-05
670	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:19:35.55037-05
671	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 16:19:53.696583-05
672	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 34}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:19:53.760186-05
673	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 35}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:19:53.761358-05
674	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 16:29:45.183021-05
675	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:29:45.200891-05
676	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:29:45.202621-05
677	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 16:29:45.860326-05
678	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:29:45.901772-05
679	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 16:29:45.903165-05
680	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:33:19.76086-05
681	\N	api_call	GET /api/v1/games	\N	{"status": 401, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:33:19.76434-05
682	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 17:39:06.348311-05
683	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 401, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:39:06.350907-05
684	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:39:06.354451-05
685	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:39:06.392929-05
686	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:39:06.394451-05
687	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:39:06.430575-05
688	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:39:06.432587-05
689	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 17:49:51.447324-05
690	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 27}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:49:51.479723-05
691	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:49:51.481559-05
692	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:49:52.974257-05
693	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:49:52.975263-05
694	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 17:49:55.479952-05
695	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:49:55.635107-05
696	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:49:55.637911-05
697	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	38C5A253-A353-48DE-8C4B-2B85509D6A1B	2026-03-06 17:52:08.737664-05
698	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:52:08.774146-05
699	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 17:52:08.775867-05
700	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	CFA883AF-F473-48A2-9981-29DF18959F67	2026-03-06 18:34:26.062235-05
701	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:34:26.211271-05
702	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	CFA883AF-F473-48A2-9981-29DF18959F67	2026-03-06 18:34:29.192418-05
703	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:34:31.653081-05
704	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:34:32.403417-05
705	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:34:32.407829-05
706	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	53845BD7-FB52-40EF-AFC8-A31D62C707FD	2026-03-06 18:37:47.166684-05
707	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:37:47.173382-05
708	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	53845BD7-FB52-40EF-AFC8-A31D62C707FD	2026-03-06 18:37:48.565236-05
709	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:37:51.400691-05
710	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:37:51.406205-05
711	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:37:51.407569-05
715	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5AE25A26-991C-409B-A309-FDFD4FD64B24	2026-03-06 18:39:30.476157-05
716	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:39:32.40586-05
720	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:12.648876-05
721	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:12.658169-05
724	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:12.908703-05
726	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:13.934425-05
727	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:13.998698-05
731	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 50}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:14.404774-05
739	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:21.167531-05
742	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:24.860757-05
744	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:29.070095-05
746	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:31.703698-05
753	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:09.953515-05
755	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:51:15.970572-05
756	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:15.991185-05
758	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:51:16.949066-05
760	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:17.596955-05
763	\N	api_call	GET /api/v1/pwhl/teams/2/roster	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:20.278266-05
766	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:35.639021-05
769	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:23.576985-05
772	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:25.223304-05
778	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:29.091037-05
780	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:31.04436-05
782	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:52:31.731769-05
783	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:31.77224-05
785	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:52:35.389831-05
788	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:52.407433-05
712	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	5AE25A26-991C-409B-A309-FDFD4FD64B24	2026-03-06 18:38:59.409137-05
713	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:38:59.416113-05
714	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:39:01.666093-05
717	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:39:32.4077-05
718	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:39:33.88367-05
719	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:39:35.057542-05
722	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:12.814196-05
723	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:12.907164-05
725	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:12.916579-05
728	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:14.000981-05
729	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:14.216294-05
730	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:14.340102-05
732	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:16.070905-05
733	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:16.876493-05
734	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:16.87795-05
735	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:18.021028-05
736	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:19.391255-05
737	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:19.392465-05
738	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:21.166429-05
740	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:23.827771-05
741	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:24.825559-05
743	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:26.6746-05
745	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:31.691157-05
747	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:31.709837-05
748	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:50:48.081812-05
749	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:50:48.085825-05
750	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:05.005907-05
751	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:05.008271-05
752	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:08.924035-05
754	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:10.012747-05
757	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:15.994555-05
759	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:51:17.57262-05
761	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 33}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:17.639402-05
762	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:19.384254-05
764	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:28.311646-05
765	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:35.606008-05
767	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:51:36.323889-05
768	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:22.860198-05
770	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:23.592389-05
771	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:24.456741-05
773	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:26.023552-05
774	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:26.059244-05
775	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:52:28.561042-05
776	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:52:29.078076-05
781	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:31.078317-05
784	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:31.773206-05
786	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:35.392491-05
777	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:29.083591-05
779	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 18:52:31.016176-05
787	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 27}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:35.444568-05
789	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:53.437565-05
790	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:53.442957-05
791	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:54.239703-05
792	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 18:52:54.270068-05
793	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:02.516493-05
794	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:02.555442-05
795	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:02.556932-05
796	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:03.049472-05
797	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:03.071364-05
798	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:03.073004-05
799	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:03.746661-05
800	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:04.365602-05
801	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:04.370859-05
802	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:04.372066-05
803	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:05.692305-05
804	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:05.694495-05
805	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:05.734-05
806	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:05.925376-05
807	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:05.950538-05
808	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:05.952794-05
809	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:22.385676-05
810	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:22.389471-05
811	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:22.428807-05
812	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:31.51345-05
813	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:31.517842-05
814	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:31.518775-05
815	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:34.964996-05
816	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:35.697191-05
817	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:35.701481-05
818	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:35.702749-05
819	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:36.32699-05
820	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:36.354538-05
821	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:36.387531-05
822	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:21:42.879183-05
823	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:42.923556-05
824	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:21:42.925348-05
825	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:22:17.468312-05
826	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:17.48911-05
831	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:25.456076-05
834	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:32.737826-05
836	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:32.743637-05
838	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:34.781365-05
840	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 20:15:10.185066-05
842	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.491265-05
848	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.797769-05
849	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.823638-05
851	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C8D160C-0A44-4D69-A200-5C66678B3F44	2026-03-07 01:27:42.40853-05
858	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:14.263018-05
860	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1BCA36A0-C0A8-4BB3-9B13-A627534F5021	2026-03-07 01:42:28.827655-05
861	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:28.947091-05
865	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:32.355288-05
868	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:51.039132-05
827	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:17.522264-05
830	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:23.953574-05
833	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:28.87493-05
837	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:22:34.779143-05
841	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C8D160C-0A44-4D69-A200-5C66678B3F44	2026-03-07 01:27:18.483924-05
843	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	9C8D160C-0A44-4D69-A200-5C66678B3F44	2026-03-07 01:27:18.610137-05
845	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.779972-05
850	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.825431-05
852	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:42.495467-05
854	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1BCA36A0-C0A8-4BB3-9B13-A627534F5021	2026-03-07 01:42:14.063006-05
856	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1BCA36A0-C0A8-4BB3-9B13-A627534F5021	2026-03-07 01:42:14.167055-05
862	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:28.949493-05
864	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:32.321234-05
866	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1BCA36A0-C0A8-4BB3-9B13-A627534F5021	2026-03-07 01:42:51.031005-05
867	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:51.038242-05
828	\N	api_call	GET /api/v1/pwhl/standings	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:20.660664-05
829	\N	api_call	GET /api/v1/games	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:23.94832-05
832	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:28.841397-05
835	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	0C4939D5-5CF9-4725-9733-2E9DC624A49B	2026-03-06 19:22:32.741503-05
839	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 33}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-06 19:22:34.837186-05
844	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 1}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.772193-05
846	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.781774-05
847	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:18.79636-05
853	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 32}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:27:42.549808-05
855	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:14.068311-05
857	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:14.261785-05
859	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 01:42:14.264219-05
863	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	1BCA36A0-C0A8-4BB3-9B13-A627534F5021	2026-03-07 01:42:32.240023-05
869	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 401, "duration_ms": 0}	10.0.0.77	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 02:13:36.75502-05
870	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:14:30.009985-05
871	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:30.097799-05
872	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:14:33.88334-05
873	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:36.857182-05
874	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 401, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:37.607295-05
875	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:39.175075-05
876	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 19}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:39.177423-05
877	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 703}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:40.381091-05
878	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:40.382347-05
879	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:40.384593-05
880	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:44.132562-05
881	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:44.135261-05
882	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 29}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:14:44.150895-05
883	\N	api_call	GET /api/v1/fantasy/teams/374/roster	\N	{"status": 200, "duration_ms": 109}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:18:42.862955-05
884	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:01.627091-05
885	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:01.6287-05
886	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:01.644217-05
887	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:19:05.616387-05
888	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:05.685951-05
889	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:05.687321-05
890	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:14.138243-05
891	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:14.139553-05
892	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:25.296263-05
893	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:25.298069-05
894	\N	api_call	GET /api/v1/leagues/34/teams	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:40.141149-05
895	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:49.139448-05
896	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:49.140553-05
897	\N	api_call	GET /api/v1/leagues/33/teams	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:53.211366-05
898	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:57.236224-05
899	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:57.240246-05
902	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:02.690046-05
904	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:04.896133-05
906	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:20:06.891061-05
907	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:06.906417-05
911	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 20}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:15.408361-05
915	\N	api_call	GET /api/v1/leagues/19/teams	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:17.851824-05
920	\N	api_call	GET /api/v1/fantasy/leagues/19/draft	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:27.956629-05
900	\N	api_call	GET /api/v1/leagues/22/teams	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:19:59.497206-05
905	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 34}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:04.943205-05
908	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:06.908729-05
910	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:15.372034-05
912	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:20:16.103168-05
913	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:16.122854-05
916	\N	api_call	GET /api/v1/leagues/19/teams/179/roster	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:21.397279-05
918	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:27.95357-05
919	\N	api_call	GET /api/v1/leagues/19/teams	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:27.955611-05
901	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:02.686477-05
903	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:20:04.84825-05
909	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:20:15.34376-05
914	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:16.131065-05
917	\N	api_call	GET /api/v1/leagues/19/teams/179/roster	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:27.394105-05
921	\N	api_call	GET /api/v1/leagues/19/trades	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:30.117583-05
922	\N	api_call	GET /api/v1/leagues/19/teams	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:31.578007-05
923	\N	api_call	GET /api/v1/fantasy/leagues/19/draft	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:31.582254-05
924	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:31.58322-05
925	\N	api_call	GET /api/v1/leagues/19/teams/179/roster	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:31.989129-05
926	\N	api_call	GET /api/v1/leagues/19/trades	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:32.691255-05
927	\N	api_call	GET /api/v1/leagues/19/teams	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:33.350578-05
928	\N	api_call	GET /api/v1/leagues/19/teams/177/roster	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:38.130012-05
929	\N	api_call	GET /api/v1/leagues/19/teams/179/roster	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:38.138735-05
930	\N	api_call	POST /api/v1/leagues/19/trades	\N	{"status": 201, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:46.171345-05
931	\N	api_call	GET /api/v1/leagues/19/trades	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:46.876802-05
932	\N	api_call	GET /api/v1/fantasy/leagues/19/draft	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:49.053163-05
933	\N	api_call	GET /api/v1/leagues/19/teams	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:49.062184-05
934	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:49.068789-05
935	\N	api_call	GET /api/v1/leagues/19/teams/179/roster	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:20:49.809006-05
936	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:02.622379-05
937	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:02.623348-05
938	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:21:04.09877-05
939	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:04.11524-05
940	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:04.150278-05
941	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:21:05.635366-05
942	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:05.678327-05
943	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:05.68287-05
944	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:21:05.694473-05
945	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:23:17.877312-05
946	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:17.888111-05
947	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:17.889524-05
948	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:25.578489-05
949	\N	api_call	GET /api/v1/fantasy/leagues/1/draft	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:27.841954-05
950	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:27.865105-05
951	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:27.871076-05
952	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:32.861715-05
953	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:32.871803-05
954	\N	api_call	GET /api/v1/fantasy/leagues/1/draft	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:32.877547-05
955	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:37.847583-05
956	\N	api_call	GET /api/v1/fantasy/leagues/1/draft	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:37.849166-05
957	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:37.850048-05
958	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:42.829938-05
959	\N	api_call	GET /api/v1/fantasy/leagues/1/draft	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:42.837316-05
961	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:23:46.767311-05
968	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:26.511764-05
970	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:33.556973-05
972	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:24:34.195353-05
979	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:26:54.775864-05
981	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:03.830712-05
989	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:08.172125-05
991	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:35.437634-05
995	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:40.543714-05
1000	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:45.354425-05
1001	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:45.376538-05
1003	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:45.379601-05
1005	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:48.526451-05
1011	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:52.019168-05
1013	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:52.051368-05
960	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:42.839124-05
964	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:46.830573-05
966	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:26.509094-05
967	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:26.510825-05
969	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:24:33.55452-05
976	\N	api_call	GET /api/v1/fantasy/leagues/1/draft	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:34.23882-05
978	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:37.942531-05
984	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:05.318736-05
986	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:05.370595-05
994	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:40.540027-05
996	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:40.548193-05
998	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:43.474568-05
1002	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:45.378436-05
1009	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:49.109676-05
1015	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:54.560918-05
1017	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:54.570015-05
962	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:46.826204-05
963	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:46.829639-05
965	\N	api_call	GET /api/v1/fantasy/teams/170/roster	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:23:49.27642-05
971	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:33.596254-05
973	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:34.233062-05
974	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:34.23726-05
975	\N	api_call	GET /api/v1/leagues/1/teams	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:34.238025-05
977	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:24:37.940479-05
980	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:03.810464-05
982	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:03.832628-05
983	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:04.55239-05
985	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:05.326569-05
987	\N	api_call	GET /api/v1/pwhl/games/upcoming	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:06.393084-05
988	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:07.158796-05
990	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:35.409637-05
992	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:35.439988-05
993	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:40.494915-05
997	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:43.471436-05
999	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:43.475515-05
1004	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:48.522784-05
1006	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:48.527645-05
1007	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	54DEA374-D0ED-43DF-8704-BFDACDEDAB6B	2026-03-07 09:27:49.073206-05
1008	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:49.107674-05
1010	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:49.111087-05
1012	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:52.050108-05
1014	\N	api_call	GET /api/v1/leagues/17/teams	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:52.728923-05
1016	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:54.567201-05
1018	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:27:54.576778-05
1019	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B9E5F4F6-21D7-453D-90E9-5AB24E6D732D	2026-03-07 09:33:34.596986-05
1020	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:33:34.746318-05
1021	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B9E5F4F6-21D7-453D-90E9-5AB24E6D732D	2026-03-07 09:33:39.286195-05
1022	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 31}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:33:42.681211-05
1023	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 38}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:33:42.687658-05
1024	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:33:42.697624-05
1025	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 27}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:33:42.699192-05
1026	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B9E5F4F6-21D7-453D-90E9-5AB24E6D732D	2026-03-07 09:34:30.914667-05
1027	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:34:31.050674-05
1028	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 38}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:34:31.109633-05
1029	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B9E5F4F6-21D7-453D-90E9-5AB24E6D732D	2026-03-07 09:34:32.618567-05
1030	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:34:32.688779-05
1031	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:34:32.699657-05
1033	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:34:34.223852-05
1035	\N	screen_view	\N	More	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B9E5F4F6-21D7-453D-90E9-5AB24E6D732D	2026-03-07 09:34:38.518446-05
1037	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:31.583607-05
1042	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:31.849367-05
1044	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:39.166414-05
1049	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:49.182424-05
1051	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:49.21213-05
1056	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:56.069501-05
1061	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:49:05.136959-05
1063	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:49:05.159054-05
1032	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B9E5F4F6-21D7-453D-90E9-5AB24E6D732D	2026-03-07 09:34:34.199062-05
1036	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:31.578364-05
1038	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:31.818026-05
1041	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:31.844996-05
1046	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:47.911368-05
1048	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 52}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:48.14832-05
1050	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:49.208488-05
1052	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:55.847729-05
1054	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:55.980529-05
1059	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:57.725627-05
1034	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 25}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:34:34.258426-05
1039	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:31.842416-05
1040	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:31.844162-05
1043	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:39.050982-05
1045	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:39.168734-05
1047	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:48.075434-05
1053	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:55.850775-05
1055	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:56.062379-05
1057	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:56.076545-05
1058	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	12982488-877C-4C55-A95B-A9EAD8EC9D5B	2026-03-07 09:48:57.709749-05
1060	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 27}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:48:57.765205-05
1062	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 09:49:05.157455-05
1064	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B1DDDB44-5D33-43CC-95AD-22E9D286A9D2	2026-03-07 10:03:35.19937-05
1065	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:03:35.204996-05
1066	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B1DDDB44-5D33-43CC-95AD-22E9D286A9D2	2026-03-07 10:03:35.488284-05
1067	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:03:35.516275-05
1068	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:03:35.520996-05
1069	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 13}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:03:35.522419-05
1070	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 14}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:03:35.523702-05
1071	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	B1DDDB44-5D33-43CC-95AD-22E9D286A9D2	2026-03-07 10:04:06.834301-05
1072	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:04:06.964615-05
1073	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:04:06.965673-05
1074	\N	api_call	GET /api/v1/leagues/17/teams	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:04:08.73932-05
1075	\N	api_call	GET /api/v1/leagues/17/teams/170/roster	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:04:14.71263-05
1076	\N	api_call	GET /api/v1/fantasy/leagues/17/draft	\N	{"status": 200, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:00.024136-05
1077	\N	api_call	GET /api/v1/leagues/17/teams	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:00.025524-05
1078	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:00.02937-05
1079	\N	api_call	GET /api/v1/leagues/17/trades	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:01.559049-05
1080	\N	api_call	GET /api/v1/leagues/17/teams/170/roster	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:02.126815-05
1081	\N	api_call	POST /api/v1/auth/login	\N	{"status": 422, "duration_ms": 1}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:05.327121-05
1082	\N	api_call	GET /api/v1/fantasy/teams/170/roster	\N	{"status": 403, "duration_ms": 0}	127.0.0.1	curl/8.7.1	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:05:05.359172-05
1083	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	AE5C7B52-13DF-4A2F-8BD4-35B287B7CB2E	2026-03-07 10:42:36.575301-05
1084	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 15}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.588328-05
1085	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	AE5C7B52-13DF-4A2F-8BD4-35B287B7CB2E	2026-03-07 10:42:36.589577-05
1086	\N	api_call	GET /api/v1/auth/me	\N	{"status": 401, "duration_ms": 11}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.590372-05
1087	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.591134-05
1088	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 401, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.591913-05
1089	\N	api_call	GET /api/v1/leagues	\N	{"status": 401, "duration_ms": 12}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.592661-05
1090	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.603047-05
1091	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.609246-05
1092	\N	api_call	POST /api/v1/auth/refresh	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.610922-05
1093	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 3}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.620883-05
1094	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.628899-05
1097	\N	api_call	GET /api/v1/players/seasons	\N	{"status": 200, "duration_ms": 2}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:20.747632-05
1103	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 7}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:27.392481-05
1105	\N	api_call	GET /api/v1/leagues/17/teams	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:31.825758-05
1095	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:42:36.630104-05
1100	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:22.481465-05
1102	\N	api_call	GET /api/v1/leagues/17/teams	\N	{"status": 200, "duration_ms": 6}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:26.285212-05
1104	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 8}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:27.393854-05
1106	\N	api_call	GET /api/v1/leagues/17/teams/170/roster	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:33.069923-05
1096	\N	screen_view	\N	PWHL	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	AE5C7B52-13DF-4A2F-8BD4-35B287B7CB2E	2026-03-07 10:43:20.683505-05
1098	\N	api_call	GET /api/v1/players	\N	{"status": 200, "duration_ms": 23}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:20.782395-05
1099	\N	screen_view	\N	Leagues	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	AE5C7B52-13DF-4A2F-8BD4-35B287B7CB2E	2026-03-07 10:43:22.40474-05
1101	\N	api_call	GET /api/v1/leagues/public	\N	{"status": 200, "duration_ms": 5}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 10:43:22.579023-05
1107	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	844C3A85-497A-4D84-9FF2-A657D25BB28D	2026-03-07 11:01:47.363773-05
1108	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 9}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:01:47.474948-05
1109	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	844C3A85-497A-4D84-9FF2-A657D25BB28D	2026-03-07 11:01:50.274166-05
1110	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 24}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:01:52.639619-05
1111	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 30}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:01:52.644471-05
1112	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 21}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:01:52.654344-05
1113	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 22}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:01:52.65558-05
1114	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	FE29E428-9943-4C8D-A530-DA5C1784AF4A	2026-03-07 11:11:23.682573-05
1115	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:11:23.706623-05
1116	\N	screen_view	\N	Home	{}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	FE29E428-9943-4C8D-A530-DA5C1784AF4A	2026-03-07 11:11:28.150154-05
1117	\N	api_call	GET /api/v1/pwhl/news	\N	{"status": 200, "duration_ms": 10}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:11:30.390428-05
1118	\N	api_call	GET /api/v1/auth/me	\N	{"status": 200, "duration_ms": 16}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:11:30.393463-05
1119	\N	api_call	GET /api/v1/leagues	\N	{"status": 200, "duration_ms": 18}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:11:30.396235-05
1120	\N	api_call	GET /api/v1/fantasy/my-teams	\N	{"status": 200, "duration_ms": 17}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:11:30.400714-05
1121	\N	app_open	\N	\N	{"cold_start": true}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	1.0	iOS 26.3.1	iPhone17,1	E6770D60-3C51-41CD-9F48-6396EF891B1C	en_US	America/New_York	\N	8DE390BC-F1F0-408C-ADBC-62A772FB28A8	2026-03-07 11:25:29.28987-05
1122	\N	api_call	POST /api/v1/analytics/device	\N	{"status": 200, "duration_ms": 4}	10.0.0.85	PWHLFantasy/1 CFNetwork/3860.400.51 Darwin/25.3.0	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-07 11:25:29.420961-05
\.


--
-- Data for Name: device_profiles; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.device_profiles (id, user_id, device_id, device_model, os_version, app_version, locale, timezone, carrier, screen_width, screen_height, push_token, last_seen, created_at) FROM stdin;
1	\N	E6770D60-3C51-41CD-9F48-6396EF891B1C	iPhone17,1	iOS 26.3.1	1.0	en_US	America/New_York	\N	402	874	\N	2026-03-07 10:42:36.58136-05	2026-03-05 15:43:25.914256-05
\.


--
-- Data for Name: draft_picks; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.draft_picks (id, league_id, fantasy_team_id, player_id, pick_number, round_number, pick_in_round, is_made, made_at, created_at) FROM stdin;
1	1	1	\N	1	1	1	f	\N	2026-03-05 00:18:02.677474-05
2	1	2	\N	2	1	2	f	\N	2026-03-05 00:18:02.677474-05
3	1	2	\N	3	2	1	f	\N	2026-03-05 00:18:02.677474-05
4	1	1	\N	4	2	2	f	\N	2026-03-05 00:18:02.677474-05
5	1	1	\N	5	3	1	f	\N	2026-03-05 00:18:02.677474-05
6	1	2	\N	6	3	2	f	\N	2026-03-05 00:18:02.677474-05
7	1	2	\N	7	4	1	f	\N	2026-03-05 00:18:02.677474-05
8	1	1	\N	8	4	2	f	\N	2026-03-05 00:18:02.677474-05
9	1	1	\N	9	5	1	f	\N	2026-03-05 00:18:02.677474-05
10	1	2	\N	10	5	2	f	\N	2026-03-05 00:18:02.677474-05
11	1	2	\N	11	6	1	f	\N	2026-03-05 00:18:02.677474-05
12	1	1	\N	12	6	2	f	\N	2026-03-05 00:18:02.677474-05
13	1	1	\N	13	7	1	f	\N	2026-03-05 00:18:02.677474-05
14	1	2	\N	14	7	2	f	\N	2026-03-05 00:18:02.677474-05
15	1	2	\N	15	8	1	f	\N	2026-03-05 00:18:02.677474-05
16	1	1	\N	16	8	2	f	\N	2026-03-05 00:18:02.677474-05
17	1	1	\N	17	9	1	f	\N	2026-03-05 00:18:02.677474-05
18	1	2	\N	18	9	2	f	\N	2026-03-05 00:18:02.677474-05
19	1	2	\N	19	10	1	f	\N	2026-03-05 00:18:02.677474-05
20	1	1	\N	20	10	2	f	\N	2026-03-05 00:18:02.677474-05
21	1	1	\N	21	11	1	f	\N	2026-03-05 00:18:02.677474-05
22	1	2	\N	22	11	2	f	\N	2026-03-05 00:18:02.677474-05
23	1	2	\N	23	12	1	f	\N	2026-03-05 00:18:02.677474-05
24	1	1	\N	24	12	2	f	\N	2026-03-05 00:18:02.677474-05
25	1	1	\N	25	13	1	f	\N	2026-03-05 00:18:02.677474-05
26	1	2	\N	26	13	2	f	\N	2026-03-05 00:18:02.677474-05
27	1	2	\N	27	14	1	f	\N	2026-03-05 00:18:02.677474-05
28	1	1	\N	28	14	2	f	\N	2026-03-05 00:18:02.677474-05
29	1	1	\N	29	15	1	f	\N	2026-03-05 00:18:02.677474-05
30	1	2	\N	30	15	2	f	\N	2026-03-05 00:18:02.677474-05
31	1	2	\N	31	16	1	f	\N	2026-03-05 00:18:02.677474-05
32	1	1	\N	32	16	2	f	\N	2026-03-05 00:18:02.677474-05
33	1	1	\N	33	17	1	f	\N	2026-03-05 00:18:02.677474-05
34	1	2	\N	34	17	2	f	\N	2026-03-05 00:18:02.677474-05
35	1	2	\N	35	18	1	f	\N	2026-03-05 00:18:02.677474-05
36	1	1	\N	36	18	2	f	\N	2026-03-05 00:18:02.677474-05
37	1	1	\N	37	19	1	f	\N	2026-03-05 00:18:02.677474-05
38	1	2	\N	38	19	2	f	\N	2026-03-05 00:18:02.677474-05
39	1	2	\N	39	20	1	f	\N	2026-03-05 00:18:02.677474-05
40	1	1	\N	40	20	2	f	\N	2026-03-05 00:18:02.677474-05
\.


--
-- Data for Name: draft_sessions; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.draft_sessions (id, league_id, status, current_pick_number, total_picks, pick_time_limit, current_pick_started_at, started_at, completed_at, created_at) FROM stdin;
1	1	in_progress	1	40	90	\N	\N	\N	2026-03-05 00:18:02.677474-05
\.


--
-- Data for Name: fantasy_rosters; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.fantasy_rosters (id, fantasy_team_id, player_id, slot, position_slot, acquired_via, acquired_at, is_active) FROM stdin;
2215	169	2	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2216	169	3	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2217	169	8	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2218	169	14	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2219	169	34	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2220	169	24	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2221	169	44	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2222	169	27	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2223	169	56	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2224	169	31	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2225	169	29	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2226	169	62	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2227	169	43	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2228	169	103	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2229	169	60	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2230	169	46	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2231	169	93	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2232	169	59	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2233	169	113	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2234	169	73	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2235	169	179	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2236	169	183	bench	\N	draft	2026-03-07 02:22:59.157574-05	t
2237	169	201	bench	\N	draft	2026-03-07 02:22:59.157574-05	t
2238	170	7	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2239	170	5	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2240	170	11	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2241	170	12	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2242	170	41	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2243	170	40	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2244	170	22	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2245	170	36	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2246	170	25	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2247	170	67	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2248	170	49	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2249	170	54	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2250	170	39	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2251	170	21	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2252	170	83	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2253	170	38	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2254	170	65	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2255	170	75	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2256	170	81	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2257	170	107	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2258	170	192	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2259	170	194	bench	\N	draft	2026-03-07 02:22:59.157574-05	t
2260	170	195	bench	\N	draft	2026-03-07 02:22:59.157574-05	t
2261	171	6	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2262	171	4	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2263	171	13	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2264	171	9	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2265	171	32	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2266	171	20	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2267	171	15	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2268	171	35	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2269	171	52	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2270	171	55	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2271	171	28	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2272	171	61	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2273	171	58	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2274	171	57	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2275	171	84	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2276	171	69	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2277	171	48	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2278	171	70	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2279	171	74	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2280	171	144	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2281	171	190	active	\N	draft	2026-03-07 02:22:59.157574-05	t
2282	171	198	bench	\N	draft	2026-03-07 02:22:59.157574-05	t
2283	171	199	bench	\N	draft	2026-03-07 02:22:59.157574-05	t
2284	172	1	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2285	172	8	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2286	172	11	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2287	172	32	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2288	172	20	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2289	172	36	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2290	172	27	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2291	172	33	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2292	172	37	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2293	172	43	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2294	172	39	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2295	172	84	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2296	172	69	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2297	172	75	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2298	172	59	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2299	172	91	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2300	172	80	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2301	172	77	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2302	172	82	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2303	172	124	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2304	172	187	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2305	172	201	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2306	172	195	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2307	173	2	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2308	173	17	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2309	173	13	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2310	173	41	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2311	173	40	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2312	173	35	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2313	173	47	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2314	173	31	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2315	173	29	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2316	173	64	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2317	173	58	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2318	173	83	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2319	173	38	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2320	173	70	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2321	173	87	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2322	173	73	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2323	173	88	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2324	173	123	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2325	173	100	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2326	173	120	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2327	173	179	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2328	173	200	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2329	173	199	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2353	175	6	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2354	175	3	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2355	175	12	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2356	175	30	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2357	175	19	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2358	175	22	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2359	175	56	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2360	175	55	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2361	175	28	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2362	175	62	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2363	175	21	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2364	175	53	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2365	175	99	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2366	175	65	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2367	175	113	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2368	175	144	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2369	175	86	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2370	175	97	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2371	175	96	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2372	175	104	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2373	175	190	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2374	175	183	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2375	175	191	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2376	176	4	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2377	176	5	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2378	176	14	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2379	176	18	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2380	176	23	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2381	176	44	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2382	176	25	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2383	176	52	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2384	176	61	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2385	176	54	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2386	176	103	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2387	176	63	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2388	176	71	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2389	176	93	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2390	176	81	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2391	176	74	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2392	176	122	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2393	176	121	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2394	176	76	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2395	176	92	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2396	176	198	active	\N	draft	2026-03-07 02:22:59.295063-05	t
2397	176	194	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2398	176	178	bench	\N	draft	2026-03-07 02:22:59.295063-05	t
2399	177	1	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2400	177	13	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2401	177	9	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2402	177	19	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2403	177	23	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2404	177	52	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2405	177	55	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2406	177	68	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2407	177	64	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2408	177	84	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2409	177	69	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2410	177	87	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2411	177	50	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2412	177	86	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2413	177	122	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2414	177	92	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2415	177	104	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2416	177	138	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2417	177	112	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2418	177	117	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2419	177	187	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2420	177	199	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2421	178	2	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2422	178	11	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2423	178	12	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2424	178	24	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2425	178	44	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2426	178	25	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2427	178	67	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2428	178	62	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2429	178	43	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2430	178	83	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2431	178	38	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2432	178	59	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2433	178	113	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2434	178	101	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2435	178	121	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2436	178	76	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2437	178	134	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2438	178	79	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2439	178	128	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2440	178	114	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2441	178	179	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2442	178	195	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2465	180	6	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2466	180	17	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2467	180	18	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2468	180	20	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2469	180	15	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2470	180	45	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2471	180	33	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2472	180	61	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2473	180	58	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2474	180	53	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2475	180	99	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2476	180	70	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2477	180	74	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2478	180	80	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2479	180	111	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2480	180	106	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2481	180	124	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2482	180	110	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2483	180	98	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2484	180	147	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2485	180	190	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2486	180	200	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2487	181	4	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2488	181	10	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2489	181	30	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2490	181	32	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2491	181	35	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2492	181	47	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2493	181	37	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2494	181	28	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2495	181	57	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2496	181	63	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2497	181	71	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2498	181	48	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2499	181	144	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2500	181	91	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2501	181	123	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2502	181	100	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2503	181	136	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2504	181	129	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2505	181	119	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2506	181	115	active	\N	draft	2026-03-07 02:22:59.386319-05	t
2507	181	198	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2508	181	184	bench	\N	draft	2026-03-07 02:22:59.386319-05	t
2531	183	1	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2532	183	12	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2533	183	14	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2534	183	15	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2535	183	35	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2536	183	29	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2537	183	49	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2538	183	63	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2539	183	53	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2540	183	75	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2541	183	59	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2542	183	86	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2543	183	122	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2544	183	134	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2545	183	120	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2546	183	98	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2547	183	119	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2548	183	127	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2549	183	166	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2550	183	159	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2551	183	187	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2552	183	191	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2553	184	2	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2554	184	9	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2555	184	18	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2556	184	22	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2557	184	36	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2558	184	37	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2559	184	28	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2560	184	103	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2561	184	60	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2562	184	70	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2563	184	87	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2564	184	101	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2565	184	121	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2566	184	104	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2567	184	124	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2568	184	108	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2569	184	126	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2570	184	167	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2571	184	142	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2572	184	171	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2573	184	179	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2574	184	186	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2597	186	6	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2598	186	11	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2599	186	34	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2600	186	23	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2601	186	47	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2602	186	31	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2603	186	54	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2604	186	57	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2605	186	84	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2606	186	65	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2607	186	113	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2608	186	80	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2609	186	111	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2610	186	76	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2611	186	85	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2612	186	112	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2613	186	115	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2614	186	151	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2615	186	145	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2616	186	158	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2617	186	190	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2618	186	195	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2619	187	4	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2620	187	8	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2621	187	41	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2622	187	19	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2623	187	45	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2624	187	67	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2625	187	62	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2626	187	58	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2627	187	69	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2628	187	93	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2629	187	81	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2630	187	91	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2631	187	123	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2632	187	96	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2633	187	116	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2634	187	138	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2635	187	147	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2636	187	94	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2637	187	162	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2638	187	109	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2639	187	198	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2640	187	201	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2663	189	3	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2664	189	10	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2665	189	20	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2666	189	40	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2667	189	25	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2668	189	52	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2669	189	64	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2670	189	43	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2671	189	46	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2672	189	99	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2673	189	144	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2674	189	107	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2675	189	82	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2676	189	100	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2677	189	110	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2678	189	131	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2679	189	114	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2680	189	117	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2681	189	140	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2682	189	118	active	\N	draft	2026-03-07 02:22:59.493075-05	t
2683	189	183	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2684	189	184	bench	\N	draft	2026-03-07 02:22:59.493075-05	t
2685	190	1	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2686	190	18	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2687	190	30	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2688	190	47	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2689	190	45	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2690	190	68	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2691	190	64	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2692	190	99	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2693	190	71	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2694	190	91	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2695	190	80	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2696	190	92	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2697	190	104	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2698	190	98	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2699	190	119	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2700	190	142	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2701	190	125	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2702	190	135	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2703	190	150	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2704	190	154	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2705	190	187	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2706	190	188	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2707	191	2	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2708	191	14	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2709	191	34	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2710	191	27	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2711	191	56	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2712	191	62	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2713	191	43	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2714	191	46	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2715	191	93	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2716	191	73	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2717	191	88	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2718	191	76	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2719	191	134	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2720	191	108	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2721	191	126	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2722	191	166	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2723	191	145	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2724	191	157	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2725	191	130	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2726	191	105	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2727	191	179	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2728	191	178	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2751	193	6	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2752	193	9	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2753	193	32	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2754	193	35	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2755	193	52	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2756	193	61	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2757	193	58	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2758	193	69	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2759	193	48	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2760	193	144	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2761	193	86	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2762	193	106	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2763	193	124	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2764	193	112	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2765	193	115	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2766	193	167	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2767	193	148	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2768	193	152	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2769	193	161	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2770	193	172	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2771	193	190	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2772	193	186	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2773	194	4	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2774	194	13	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2775	194	20	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2776	194	15	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2777	194	55	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2778	194	28	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2779	194	57	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2780	194	84	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2781	194	70	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2782	194	74	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2783	194	122	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2784	194	100	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2785	194	136	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2786	194	138	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2787	194	147	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2788	194	160	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2789	194	140	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2790	194	159	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2791	194	163	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2792	194	173	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2793	194	198	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2794	194	199	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2817	196	3	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2818	196	8	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2819	196	24	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2820	196	44	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2821	196	31	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2822	196	29	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2823	196	103	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2824	196	60	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2825	196	59	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2826	196	113	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2827	196	97	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2828	196	77	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2829	196	116	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2830	196	131	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2831	196	114	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2832	196	94	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2833	196	169	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2834	196	146	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2835	196	170	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2836	196	168	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2837	196	183	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2838	196	201	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2839	197	10	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2840	197	17	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2841	197	19	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2842	197	23	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2843	197	33	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2844	197	37	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2845	197	63	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2846	197	53	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2847	197	87	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2848	197	50	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2849	197	111	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2850	197	123	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2851	197	129	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2852	197	110	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2853	197	117	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2854	197	143	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2855	197	109	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2856	197	158	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2857	197	155	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2858	197	177	active	\N	draft	2026-03-07 02:22:59.612623-05	t
2859	197	184	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2860	197	200	bench	\N	draft	2026-03-07 02:22:59.612623-05	t
2861	198	1	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2862	198	34	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2863	198	41	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2864	198	52	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2865	198	55	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2866	198	21	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2867	198	103	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2868	198	87	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2869	198	50	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2870	198	77	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2871	198	82	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2872	198	138	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2873	198	112	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2874	198	127	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2875	198	166	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2876	198	135	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2877	198	150	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2878	198	176	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2879	198	187	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2880	199	2	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2881	199	30	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2882	199	32	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2883	199	25	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2884	199	67	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2885	199	57	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2886	199	63	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2887	199	59	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2888	199	113	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2889	199	123	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2890	199	100	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2891	199	79	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2892	199	128	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2893	199	167	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2894	199	142	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2895	199	157	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2896	199	130	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2897	199	175	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2898	199	179	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2918	201	6	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2919	201	14	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2920	201	40	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2921	201	45	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2922	201	33	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2923	201	39	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2924	201	60	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2925	201	70	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2926	201	74	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2927	201	97	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2928	201	96	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2929	201	110	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2930	201	98	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2931	201	151	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2932	201	145	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2933	201	152	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2934	201	161	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2935	201	105	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2936	201	190	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2937	202	4	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2938	202	12	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2939	202	24	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2940	202	47	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2941	202	37	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2942	202	43	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2943	202	83	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2944	202	48	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2945	202	144	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2946	202	121	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2947	202	76	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2948	202	129	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2949	202	119	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2950	202	94	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2951	202	162	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2952	202	159	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2953	202	163	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2954	202	174	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2955	202	198	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2975	204	3	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2976	204	13	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2977	204	23	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2978	204	36	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2979	204	49	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2980	204	68	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2981	204	69	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2982	204	93	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2983	204	73	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2984	204	86	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2985	204	104	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2986	204	85	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2987	204	133	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2988	204	117	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2989	204	140	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2990	204	146	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2991	204	170	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2992	204	173	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2993	204	183	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
2994	205	10	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2995	205	11	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2996	205	44	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2997	205	35	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2998	205	28	active	\N	draft	2026-03-07 02:22:59.75089-05	t
2999	205	62	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3000	205	38	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3001	205	71	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3002	205	91	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3003	205	101	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3004	205	134	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3005	205	136	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3006	205	115	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3007	205	114	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3008	205	118	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3009	205	158	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3010	205	155	active	\N	draft	2026-03-07 02:22:59.75089-05	t
3011	205	165	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
3012	205	184	bench	\N	draft	2026-03-07 02:22:59.75089-05	t
3032	207	1	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3033	207	32	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3034	207	20	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3035	207	33	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3036	207	37	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3037	207	84	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3038	207	69	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3039	207	91	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3040	207	80	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3041	207	124	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3042	207	136	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3043	207	117	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3044	207	143	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3045	207	159	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3046	207	152	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3047	207	154	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3048	207	187	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3049	208	2	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3050	208	41	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3051	208	40	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3052	208	31	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3053	208	29	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3054	208	83	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3055	208	38	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3056	208	73	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3057	208	88	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3058	208	120	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3059	208	85	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3060	208	114	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3061	208	94	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3062	208	171	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3063	208	156	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3064	208	105	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3065	208	179	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3083	210	6	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3084	210	30	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3085	210	19	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3086	210	55	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3087	210	28	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3088	210	53	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3089	210	99	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3090	210	144	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3091	210	86	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3092	210	104	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3093	210	129	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3094	210	147	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3095	210	160	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3096	210	158	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3097	210	135	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3098	210	172	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3099	210	190	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3100	211	4	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3101	211	18	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3102	211	23	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3103	211	52	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3104	211	61	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3105	211	63	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3106	211	71	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3107	211	74	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3108	211	122	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3109	211	92	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3110	211	110	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3111	211	115	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3112	211	167	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3113	211	109	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3114	211	150	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3115	211	173	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3116	211	198	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3134	213	3	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3135	213	12	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3136	213	22	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3137	213	56	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3138	213	62	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3139	213	21	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3140	213	65	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3141	213	113	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3142	213	97	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3143	213	96	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3144	213	79	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3145	213	126	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3146	213	166	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3147	213	118	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3148	213	132	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3149	213	168	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3150	213	183	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3151	214	10	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3152	214	9	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3153	214	15	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3154	214	45	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3155	214	68	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3156	214	57	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3157	214	48	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3158	214	50	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3159	214	111	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3160	214	106	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3161	214	138	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3162	214	119	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3163	214	142	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3164	214	140	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3165	214	161	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3166	214	177	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3167	214	184	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3185	216	8	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3186	216	11	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3187	216	36	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3188	216	27	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3189	216	43	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3190	216	39	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3191	216	75	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3192	216	59	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3193	216	77	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3194	216	82	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3195	216	128	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3196	216	108	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3197	216	145	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3198	216	162	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3199	216	164	active	\N	draft	2026-03-07 02:22:59.900004-05	t
3200	216	170	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3201	216	201	bench	\N	draft	2026-03-07 02:22:59.900004-05	t
3202	217	1	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3203	217	40	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3204	217	24	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3205	217	28	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3206	217	61	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3207	217	93	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3208	217	65	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3209	217	111	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3210	217	123	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3211	217	128	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3212	217	108	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3213	217	148	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3214	217	140	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3215	217	168	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3216	217	187	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3217	218	2	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3218	218	20	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3219	218	19	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3220	218	49	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3221	218	54	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3222	218	71	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3223	218	48	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3224	218	97	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3225	218	77	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3226	218	112	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3227	218	98	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3228	218	162	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3229	218	118	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3230	218	177	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3231	218	179	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3247	220	6	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3248	220	41	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3249	220	44	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3250	220	37	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3251	220	68	active	\N	draft	2026-03-07 02:23:00.038423-05	t
4014	279	186	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3252	220	46	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3253	220	75	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3254	220	122	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3255	220	100	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3256	220	79	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3257	220	126	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3258	220	125	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3259	220	109	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3260	220	170	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3261	220	190	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3262	221	4	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3263	221	34	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3264	221	22	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3265	221	33	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3266	221	64	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3267	221	38	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3268	221	59	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3269	221	86	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3270	221	106	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3271	221	131	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3272	221	133	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3273	221	142	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3274	221	158	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3275	221	164	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3276	221	198	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3292	223	3	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3293	223	18	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3294	223	35	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3295	223	67	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3296	223	39	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3297	223	84	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3298	223	50	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3299	223	88	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3300	223	76	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3301	223	129	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3302	223	147	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3303	223	127	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3304	223	171	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3305	223	161	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3306	223	183	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3307	224	10	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3308	224	14	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3309	224	36	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3310	224	55	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3311	224	58	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3312	224	83	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3313	224	113	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3314	224	80	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3315	224	92	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3316	224	116	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3317	224	137	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3318	224	167	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3319	224	159	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3320	224	132	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3321	224	184	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3337	226	8	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3338	226	9	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3339	226	47	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3340	226	25	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3341	226	21	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3342	226	53	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3343	226	74	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3344	226	73	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3345	226	134	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3346	226	136	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3347	226	117	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3348	226	151	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3349	226	156	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3350	226	150	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3351	226	201	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3352	227	11	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3353	227	13	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3354	227	45	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3355	227	56	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3356	227	103	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3357	227	63	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3358	227	144	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3359	227	107	active	\N	draft	2026-03-07 02:23:00.038423-05	t
4124	289	184	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
3360	227	120	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3361	227	124	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3362	227	143	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3363	227	94	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3364	227	157	active	\N	draft	2026-03-07 02:23:00.038423-05	t
3365	227	135	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3366	227	195	bench	\N	draft	2026-03-07 02:23:00.038423-05	t
3367	228	1	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3368	228	19	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3369	228	23	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3370	228	68	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3371	228	64	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3372	228	87	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3373	228	50	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3374	228	92	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3375	228	104	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3376	228	117	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3377	228	143	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3378	228	135	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3379	228	150	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3380	228	199	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3381	229	2	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3382	229	24	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3383	229	44	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3384	229	62	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3385	229	43	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3386	229	59	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3387	229	113	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3388	229	76	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3389	229	134	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3390	229	114	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3391	229	94	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3392	229	157	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3393	229	130	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3394	229	195	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3409	231	6	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3410	231	20	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3411	231	15	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3412	231	61	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3413	231	58	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3414	231	70	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3415	231	74	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3416	231	106	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3417	231	124	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3418	231	147	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3419	231	160	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3420	231	152	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3421	231	161	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3422	231	200	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3423	232	4	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3424	232	32	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3425	232	35	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3426	232	28	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3427	232	57	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3428	232	48	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3429	232	144	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3430	232	100	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3431	232	136	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3432	232	115	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3433	232	167	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3434	232	159	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3435	232	163	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3436	232	184	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3451	234	3	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3452	234	34	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3453	234	27	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3454	234	29	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3455	234	103	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3456	234	93	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3457	234	73	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3458	234	77	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3459	234	116	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3460	234	126	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3461	234	166	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3462	234	146	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3463	234	170	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3464	234	194	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3465	235	10	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3466	235	30	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3467	235	47	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3468	235	37	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3469	235	63	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3470	235	71	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3471	235	91	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3472	235	123	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3473	235	129	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3474	235	119	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3475	235	142	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3476	235	158	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3477	235	155	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3478	235	198	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3493	237	8	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3494	237	14	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3495	237	56	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3496	237	31	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3497	237	60	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3498	237	46	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3499	237	88	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3500	237	97	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3501	237	131	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3502	237	108	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3503	237	145	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3504	237	169	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3505	237	168	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3506	237	192	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3507	238	11	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3508	238	12	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3509	238	25	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3510	238	67	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3511	238	83	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3512	238	38	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3513	238	101	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3514	238	121	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3515	238	79	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3516	238	128	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3517	238	162	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3518	238	118	active	\N	draft	2026-03-07 02:23:00.171028-05	t
3519	238	165	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3520	238	179	bench	\N	draft	2026-03-07 02:23:00.171028-05	t
3535	240	1	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3536	240	44	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3537	240	22	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3538	240	58	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3539	240	57	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3540	240	107	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3541	240	73	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3542	240	129	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3543	240	110	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3544	240	145	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3545	240	162	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3546	240	173	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3547	240	187	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3548	241	2	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3549	241	23	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3550	241	15	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3551	241	39	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3552	241	21	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3553	241	144	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3554	241	91	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3555	241	116	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3556	241	131	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3557	241	125	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3558	241	148	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3559	241	165	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3560	241	179	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3574	243	6	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3575	243	24	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3576	243	36	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3577	243	64	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3578	243	63	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3579	243	81	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3580	243	88	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3581	243	136	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3582	243	138	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3583	243	166	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3584	243	118	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3585	243	177	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3586	243	190	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3587	244	4	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3588	244	40	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3589	244	27	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3590	244	68	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3591	244	53	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3592	244	113	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3593	244	101	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3594	244	124	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3595	244	112	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3596	244	127	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3597	244	169	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3598	244	155	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3599	244	198	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3613	246	3	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3614	246	32	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3615	246	45	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3616	246	54	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3617	246	83	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3618	246	87	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3619	246	122	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3620	246	134	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3621	246	108	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3622	246	160	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3623	246	158	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3624	246	164	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3625	246	183	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3626	247	10	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3627	247	41	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3628	247	56	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3629	247	61	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3630	247	84	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3631	247	59	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3632	247	121	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3633	247	104	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3634	247	98	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3635	247	151	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3636	247	146	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3637	247	163	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3638	247	184	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3652	249	8	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3653	249	30	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3654	249	52	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3655	249	49	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3656	249	38	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3657	249	70	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3658	249	111	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3659	249	76	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3660	249	126	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3661	249	143	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3662	249	159	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3663	249	132	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3664	249	201	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3665	250	11	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3666	250	18	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3667	250	55	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3668	250	29	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3669	250	46	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3670	250	48	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3671	250	123	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3672	250	96	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3673	250	133	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3674	250	117	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3675	250	152	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3676	250	130	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3677	250	195	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3691	252	9	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3692	252	12	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3693	252	31	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3694	252	33	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3695	252	71	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3696	252	93	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3697	252	82	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3698	252	100	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3699	252	147	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3700	252	137	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3701	252	157	active	\N	draft	2026-03-07 02:23:00.305721-05	t
3702	252	135	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3703	252	186	bench	\N	draft	2026-03-07 02:23:00.305721-05	t
3704	253	1	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3705	253	15	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3706	253	35	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3707	253	63	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3708	253	53	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3709	253	86	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3710	253	122	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3711	253	98	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3712	253	119	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3713	253	159	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3714	253	152	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3715	253	191	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3716	254	2	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3717	254	22	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3718	254	36	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3719	254	103	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3720	254	60	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3721	254	101	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3722	254	121	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3723	254	108	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3724	254	126	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3725	254	171	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3726	254	156	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3727	254	186	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3740	256	6	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3741	256	23	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3742	256	47	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3743	256	57	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3744	256	84	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3745	256	80	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3746	256	111	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3747	256	112	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3748	256	115	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3749	256	158	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3750	256	135	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3751	256	195	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3752	257	4	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3753	257	19	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3754	257	45	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3755	257	58	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3756	257	69	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3757	257	91	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3758	257	123	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3759	257	138	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3760	257	147	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3761	257	109	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3762	257	150	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3763	257	201	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3776	259	3	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3777	259	40	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3778	259	25	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3779	259	43	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3780	259	46	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3781	259	107	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3782	259	82	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3783	259	131	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3784	259	114	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3785	259	118	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3786	259	132	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3787	259	184	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3788	260	10	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3789	260	20	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3790	260	52	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3791	260	64	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3792	260	99	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3793	260	144	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3794	260	100	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3795	260	110	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3796	260	117	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3797	260	140	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3798	260	161	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3799	260	183	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3812	262	8	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3813	262	41	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3814	262	67	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3815	262	62	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3816	262	93	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3817	262	81	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3818	262	96	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3819	262	116	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3820	262	94	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3821	262	162	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3822	262	164	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3823	262	198	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3824	263	11	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3825	263	34	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3826	263	31	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3827	263	54	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3828	263	65	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3829	263	113	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3830	263	76	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3831	263	85	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3832	263	151	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3833	263	145	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3834	263	170	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3835	263	190	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3848	265	9	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3849	265	18	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3850	265	37	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3851	265	28	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3852	265	70	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3853	265	87	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3854	265	104	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3855	265	124	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3856	265	167	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3857	265	142	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3858	265	177	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3859	265	179	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3860	266	12	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3861	266	14	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3862	266	29	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3863	266	49	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3864	266	75	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3865	266	59	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3866	266	134	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3867	266	120	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3868	266	127	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3869	266	166	active	\N	draft	2026-03-07 02:23:00.448045-05	t
3870	266	168	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3871	266	187	bench	\N	draft	2026-03-07 02:23:00.448045-05	t
3872	267	1	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3873	267	36	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3874	267	27	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3875	267	84	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3876	267	69	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3877	267	77	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3878	267	82	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3879	267	117	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3880	267	143	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3881	267	164	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3882	267	187	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3883	268	2	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3884	268	35	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3885	268	47	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3886	268	83	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3887	268	38	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3888	268	123	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3889	268	100	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3890	268	114	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3891	268	94	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3892	268	163	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3893	268	179	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3905	270	6	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3906	270	22	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3907	270	56	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3908	270	53	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3909	270	99	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3910	270	97	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3911	270	96	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3912	270	147	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3913	270	160	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3914	270	132	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3915	270	190	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3916	271	4	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3917	271	44	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3918	271	25	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3919	271	63	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3920	271	71	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3921	271	121	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3922	271	76	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3923	271	115	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3924	271	167	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3925	271	130	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3926	271	198	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3938	273	3	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3939	273	19	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3940	273	55	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3941	273	21	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3942	273	65	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3943	273	86	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3944	273	104	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3945	273	126	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3946	273	166	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3947	273	135	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3948	273	183	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3949	274	10	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3950	274	24	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3951	274	67	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3952	274	57	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3953	274	48	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3954	274	101	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3955	274	134	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3956	274	119	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3957	274	142	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3958	274	157	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3959	274	184	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3971	276	8	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3972	276	20	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3973	276	33	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3974	276	39	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3975	276	75	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3976	276	80	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3977	276	124	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3978	276	108	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3979	276	145	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3980	276	152	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3981	276	201	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3982	277	11	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3983	277	32	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3984	277	37	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3985	277	43	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3986	277	59	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3987	277	91	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3988	277	136	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3989	277	128	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3990	277	162	active	\N	draft	2026-03-07 02:23:00.584013-05	t
3991	277	159	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
3992	277	195	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
4004	279	9	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4005	279	34	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4006	279	49	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4007	279	68	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4008	279	50	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4009	279	107	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4010	279	116	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4011	279	138	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4012	279	140	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4013	279	146	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
4015	280	12	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4016	280	30	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4017	280	28	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4018	280	62	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4019	280	113	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4020	280	144	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4021	280	129	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4022	280	79	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4023	280	118	active	\N	draft	2026-03-07 02:23:00.584013-05	t
4024	280	158	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
4025	280	191	bench	\N	draft	2026-03-07 02:23:00.584013-05	t
4037	282	1	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4038	282	47	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4039	282	45	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4040	282	99	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4041	282	71	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4042	282	92	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4043	282	104	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4044	282	142	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4045	282	125	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4046	282	154	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4047	282	187	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4048	283	2	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4049	283	27	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4050	283	56	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4051	283	46	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4052	283	93	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4053	283	76	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4054	283	134	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4055	283	166	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4056	283	145	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4057	283	105	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4058	283	179	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4070	285	6	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4071	285	35	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4072	285	52	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4073	285	69	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4074	285	48	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4075	285	106	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4076	285	124	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4077	285	167	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4078	285	148	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4079	285	172	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4080	285	190	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4081	286	4	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4082	286	15	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4083	286	55	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4084	286	84	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4085	286	70	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4086	286	100	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4087	286	136	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4088	286	160	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4089	286	140	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4090	286	173	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4091	286	198	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4103	288	3	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4104	288	44	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4105	288	31	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4106	288	60	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4107	288	59	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4108	288	77	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4109	288	116	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4110	288	94	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4111	288	169	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4112	288	168	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4113	288	183	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4114	289	10	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4115	289	23	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4116	289	33	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4117	289	53	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4118	289	87	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4119	289	123	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4120	289	129	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4121	289	143	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4122	289	109	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4123	289	177	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4136	291	8	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4137	291	24	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4138	291	29	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4139	291	103	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4140	291	113	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4141	291	97	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4142	291	131	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4143	291	114	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4144	291	146	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4145	291	170	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4146	291	201	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4147	292	11	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4148	292	40	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4149	292	49	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4150	292	21	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4151	292	81	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4152	292	121	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4153	292	79	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4154	292	137	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4155	292	171	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4156	292	164	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4157	292	195	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4169	294	9	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4170	294	32	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4171	294	61	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4172	294	58	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4173	294	144	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4174	294	86	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4175	294	112	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4176	294	115	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4177	294	152	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4178	294	161	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4179	294	186	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4180	295	12	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4181	295	41	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4182	295	54	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4183	295	39	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4184	295	107	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4185	295	101	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4186	295	128	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4187	295	133	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4188	295	156	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4189	295	132	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4190	295	191	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4202	297	18	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4203	297	30	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4204	297	68	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4205	297	64	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4206	297	91	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4207	297	80	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4208	297	98	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4209	297	119	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4210	297	135	active	\N	draft	2026-03-07 02:23:00.71014-05	t
4211	297	150	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4212	297	188	bench	\N	draft	2026-03-07 02:23:00.71014-05	t
4213	298	1	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4214	298	56	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4215	298	25	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4216	298	48	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4217	298	70	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4218	298	85	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4219	298	116	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4220	298	109	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4221	298	158	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4222	298	168	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4223	299	2	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4224	299	45	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4225	299	52	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4226	299	65	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4227	299	75	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4228	299	136	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4229	299	129	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4230	299	169	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4231	299	146	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4232	299	188	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4243	301	6	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4244	301	27	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4245	301	67	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4246	301	71	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4247	301	87	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4248	301	120	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4249	301	131	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4250	301	140	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4251	301	159	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4252	301	191	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4253	302	4	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4254	302	36	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4255	302	31	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4256	302	99	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4257	302	50	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4258	302	134	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4259	302	79	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4260	302	148	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4261	302	152	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4262	302	186	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4273	304	3	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4274	304	15	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4275	304	37	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4276	304	38	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4277	304	81	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4278	304	92	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4279	304	112	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4280	304	145	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4281	304	157	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4282	304	195	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4283	305	10	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4284	305	22	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4285	305	29	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4286	305	69	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4287	305	74	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4288	305	76	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4289	305	128	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4290	305	125	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4291	305	135	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4292	305	201	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4303	307	8	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4304	307	23	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4305	307	28	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4306	307	83	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4307	307	107	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4308	307	106	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4309	307	98	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4310	307	166	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4311	307	130	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4312	307	184	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4313	308	11	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4314	308	19	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4315	308	61	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4316	308	60	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4317	308	73	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4318	308	100	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4319	308	119	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4320	308	127	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4321	308	132	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4322	308	183	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4333	310	9	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4334	310	40	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4335	310	62	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4336	310	63	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4337	310	80	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4338	310	77	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4339	310	133	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4340	310	160	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4341	310	163	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4342	310	198	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4343	311	12	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4344	311	20	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4345	311	68	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4346	311	103	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4347	311	88	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4348	311	123	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4349	311	115	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4350	311	151	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4351	311	164	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4352	311	190	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4363	313	18	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4364	313	41	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4365	313	43	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4366	313	57	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4367	313	86	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4368	313	97	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4369	313	137	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4370	313	143	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4371	313	155	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4372	313	179	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4373	314	30	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4374	314	34	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4375	314	39	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4376	314	58	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4377	314	122	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4378	314	121	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4379	314	114	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4380	314	117	active	\N	draft	2026-03-07 02:23:00.836232-05	t
4381	314	177	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4382	314	187	bench	\N	draft	2026-03-07 02:23:00.836232-05	t
4383	315	1	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4384	315	52	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4385	315	55	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4386	315	87	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4387	315	50	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4388	315	138	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4389	315	112	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4390	315	135	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4391	315	150	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4392	316	2	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4393	316	25	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4394	316	67	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4395	316	59	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4396	316	113	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4397	316	79	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4398	316	128	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4399	316	157	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4400	316	130	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4401	316	149	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4412	318	6	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4413	318	45	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4414	318	33	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4415	318	70	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4416	318	74	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4417	318	110	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4418	318	98	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4419	318	152	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4420	318	161	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4421	318	178	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4422	319	4	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4423	319	47	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4424	319	37	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4425	319	48	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4426	319	144	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4427	319	129	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4428	319	119	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4429	319	159	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4430	319	163	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4431	319	191	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4442	321	3	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4443	321	36	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4444	321	49	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4445	321	93	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4446	321	73	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4447	321	85	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4448	321	133	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4449	321	146	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4450	321	170	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4451	321	199	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4452	322	10	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4453	322	35	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4454	322	28	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4455	322	71	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4456	322	91	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4457	322	136	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4458	322	115	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4459	322	158	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4460	322	155	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4461	322	195	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4472	324	8	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4473	324	22	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4474	324	54	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4475	324	46	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4476	324	88	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4477	324	120	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4478	324	137	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4479	324	169	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4480	324	168	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4481	324	200	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4482	325	11	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4483	325	44	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4484	325	62	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4485	325	38	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4486	325	101	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4487	325	134	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4488	325	114	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4489	325	118	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4490	325	165	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4491	325	184	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4502	327	9	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4503	327	19	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4504	327	64	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4505	327	84	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4506	327	122	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4507	327	92	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4508	327	143	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4509	327	148	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4510	327	172	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4511	327	194	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4512	328	12	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4513	328	24	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4514	328	43	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4515	328	83	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4516	328	121	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4517	328	76	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4518	328	94	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4519	328	162	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4520	328	174	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4521	328	198	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4532	330	18	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4533	330	20	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4534	330	58	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4535	330	53	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4536	330	111	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4537	330	106	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4538	330	160	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4539	330	125	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4540	330	154	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4541	330	192	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4542	331	30	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4543	331	32	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4544	331	57	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4545	331	63	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4546	331	123	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4547	331	100	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4548	331	167	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4549	331	142	active	\N	draft	2026-03-07 02:23:00.949847-05	t
4550	331	175	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4551	331	179	bench	\N	draft	2026-03-07 02:23:00.949847-05	t
4562	333	1	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4563	333	67	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4564	333	31	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4565	333	74	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4566	333	144	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4567	333	126	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4568	333	133	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4569	333	155	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4570	333	187	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4571	334	2	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4572	334	55	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4573	334	33	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4574	334	81	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4575	334	107	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4576	334	119	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4577	334	115	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4578	334	170	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4579	334	179	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4589	336	6	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4590	336	25	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4591	336	29	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4592	336	50	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4593	336	91	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4594	336	108	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4595	336	137	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4596	336	163	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4597	336	190	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4598	337	4	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4599	337	56	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4600	337	49	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4601	337	87	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4602	337	80	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4603	337	128	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4604	337	114	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4605	337	161	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4606	337	198	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4616	339	3	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4617	339	47	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4618	339	61	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4619	339	75	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4620	339	101	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4621	339	138	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4622	339	143	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4623	339	130	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4624	339	183	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4625	340	10	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4626	340	27	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4627	340	54	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4628	340	70	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4629	340	86	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4630	340	79	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4631	340	94	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4632	340	150	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4633	340	184	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4643	342	8	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4644	342	35	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4645	342	68	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4646	342	65	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4647	342	121	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4648	342	110	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4649	342	160	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4650	342	157	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4651	342	201	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4652	343	11	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4653	343	15	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4654	343	64	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4655	343	93	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4656	343	97	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4657	343	129	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4658	343	167	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4659	343	156	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4660	343	195	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4670	345	9	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4671	345	44	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4672	345	39	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4673	345	99	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4674	345	123	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4675	345	85	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4676	345	166	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4677	345	159	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4678	345	186	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4679	346	12	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4680	346	23	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4681	346	58	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4682	346	46	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4683	346	77	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4684	346	136	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4685	346	142	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4686	346	171	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4687	346	191	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4697	348	18	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4698	348	24	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4699	348	21	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4700	348	69	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4701	348	100	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4702	348	120	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4703	348	145	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4704	348	158	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4705	348	188	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4706	349	30	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4707	349	40	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4708	349	103	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4709	349	84	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4710	349	106	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4711	349	134	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4712	349	162	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4713	349	109	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4714	349	177	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4724	351	41	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4725	351	32	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4726	351	53	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4727	351	60	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4728	351	76	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4729	351	92	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4730	351	140	active	\N	draft	2026-03-07 02:23:01.095697-05	t
4731	351	118	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4732	351	165	bench	\N	draft	2026-03-07 02:23:01.095697-05	t
4733	352	1	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4734	352	33	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4735	352	37	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4736	352	91	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4737	352	80	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4738	352	117	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4739	352	143	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4740	352	154	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4741	352	187	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4742	353	2	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4743	353	31	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4744	353	29	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4745	353	73	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4746	353	88	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4747	353	114	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4748	353	94	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4749	353	105	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4750	353	179	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4760	355	6	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4761	355	55	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4762	355	28	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4763	355	144	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4764	355	86	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4765	355	147	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4766	355	160	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4767	355	172	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4768	355	190	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4769	356	4	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4770	356	52	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4771	356	61	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4772	356	74	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4773	356	122	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4774	356	115	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4775	356	167	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4776	356	173	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4777	356	198	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4787	358	3	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4788	358	56	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4789	358	62	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4790	358	113	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4791	358	97	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4792	358	126	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4793	358	166	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4794	358	168	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4795	358	183	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4796	359	10	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4797	359	45	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4798	359	68	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4799	359	50	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4800	359	111	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4801	359	119	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4802	359	142	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4803	359	177	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4804	359	184	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4814	361	8	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4815	361	27	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4816	361	43	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4817	361	59	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4818	361	77	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4819	361	108	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4820	361	145	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4821	361	170	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4822	361	201	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4823	362	11	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4824	362	36	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4825	362	39	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4826	362	75	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4827	362	82	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4828	362	128	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4829	362	162	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4830	362	164	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4831	362	195	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4841	364	9	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4842	364	15	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4843	364	57	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4844	364	48	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4845	364	106	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4846	364	138	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4847	364	140	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4848	364	161	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4849	364	186	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4850	365	12	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4851	365	22	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4852	365	21	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4853	365	65	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4854	365	96	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4855	365	79	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4856	365	118	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4857	365	132	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4858	365	191	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4868	367	18	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4869	367	23	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4870	367	63	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4871	367	71	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4872	367	92	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4873	367	110	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4874	367	109	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4875	367	150	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4876	367	188	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4877	368	30	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4878	368	19	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4879	368	53	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4880	368	99	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4881	368	104	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4882	368	129	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4883	368	158	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4884	368	135	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4885	368	175	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4895	370	41	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4896	370	40	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4897	370	83	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4898	370	38	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4899	370	120	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4900	370	85	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4901	370	171	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4902	370	156	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4903	370	149	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4904	371	32	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4905	371	20	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4906	371	84	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4907	371	69	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4908	371	124	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4909	371	136	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4910	371	159	active	\N	draft	2026-03-07 02:23:01.229375-05	t
4911	371	152	bench	\N	draft	2026-03-07 02:23:01.229375-05	t
4912	372	1	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4913	372	29	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4914	372	49	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4915	372	86	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4916	372	122	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4917	372	127	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4918	372	166	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4919	372	198	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4920	372	194	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4921	373	2	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4922	373	37	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4923	373	28	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4924	373	101	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4925	373	121	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4926	373	167	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4927	373	142	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4928	373	190	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4929	373	183	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4939	375	6	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4940	375	31	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4941	375	54	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4942	375	80	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4943	375	111	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4944	375	151	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4945	375	145	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4946	375	179	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4947	375	200	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4948	376	4	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4949	376	67	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4950	376	62	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4951	376	91	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4952	376	123	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4953	376	94	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4954	376	162	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4955	376	187	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4956	376	201	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4966	378	3	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4967	378	52	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4968	378	64	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4969	378	107	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4970	378	82	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4971	378	117	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4972	378	140	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4973	378	176	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4974	378	199	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4975	379	10	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4976	379	25	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4977	379	43	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4978	379	144	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4979	379	100	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4980	379	114	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4981	379	118	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4982	379	175	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4983	379	186	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
4993	381	8	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4994	381	45	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4995	381	58	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4996	381	81	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4997	381	96	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4998	381	147	active	\N	draft	2026-03-07 02:23:01.341114-05	t
4999	381	109	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5000	381	105	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5001	381	178	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5002	382	11	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5003	382	47	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5004	382	57	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5005	382	113	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5006	382	76	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5007	382	115	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5008	382	158	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5009	382	174	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5010	382	188	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5019	384	9	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5020	384	36	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5021	384	103	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5022	384	87	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5023	384	104	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5024	384	126	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5025	384	171	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5026	384	173	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5027	385	12	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5028	385	35	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5029	385	63	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5030	385	59	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5031	385	134	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5032	385	119	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5033	385	159	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5034	385	165	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5043	387	18	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5044	387	22	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5045	387	60	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5046	387	70	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5047	387	124	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5048	387	108	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5049	387	156	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5050	387	177	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5051	388	30	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5052	388	44	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5053	388	83	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5054	388	48	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5055	388	136	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5056	388	128	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5057	388	157	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5058	388	155	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5067	390	41	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5068	390	19	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5069	390	69	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5070	390	93	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5071	390	116	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5072	390	138	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5073	390	150	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5074	390	164	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
5075	391	32	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5076	391	24	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5077	391	38	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5078	391	71	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5079	391	129	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5080	391	79	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5081	391	130	active	\N	draft	2026-03-07 02:23:01.341114-05	t
5082	391	163	bench	\N	draft	2026-03-07 02:23:01.341114-05	t
\.


--
-- Data for Name: fantasy_teams; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.fantasy_teams (id, name, owner_id, league_id, total_points, wins, losses, ties, waiver_priority, faab_budget, logo_url, created_at, updated_at) FROM stdin;
1	Test Warriors	1	1	0	0	0	0	1	100	\N	2026-03-05 00:18:02.011135-05	\N
2	Fan2 Rockets	2	1	0	0	0	0	1	100	\N	2026-03-05 00:18:02.653183-05	\N
169	Frozen Pucks	2	17	195.7	6	6	0	2	100	\N	2026-03-07 02:22:59.157574-05	2026-03-07 02:22:59.157574-05
170	Ice Queens	3	17	201.1	8	4	0	3	100	\N	2026-03-07 02:22:59.157574-05	2026-03-07 02:22:59.157574-05
171	Slapshot Sisters	1	17	192.6	5	7	0	4	100	\N	2026-03-07 02:22:59.157574-05	2026-03-07 02:22:59.157574-05
172	Five Hole Legends	1	18	154.1	6	5	0	1	100	\N	2026-03-07 02:22:59.295063-05	2026-03-07 02:22:59.295063-05
173	Wrist Shot Wizards	2	18	153.6	2	7	0	2	100	\N	2026-03-07 02:22:59.295063-05	2026-03-07 02:22:59.295063-05
175	Storm Chasers	1	18	206.8	6	3	0	4	100	\N	2026-03-07 02:22:59.295063-05	2026-03-07 02:22:59.295063-05
176	Hat Trick Heroes	2	18	189.9	6	5	0	5	100	\N	2026-03-07 02:22:59.295063-05	2026-03-07 02:22:59.295063-05
177	Blizzard Queens	1	19	138.2	5	7	0	1	100	\N	2026-03-07 02:22:59.386319-05	2026-03-07 02:22:59.386319-05
178	Frozen Fire	2	19	133.9	8	4	0	2	100	\N	2026-03-07 02:22:59.386319-05	2026-03-07 02:22:59.386319-05
180	Blue Line Babes	1	19	123.5	4	8	0	4	100	\N	2026-03-07 02:22:59.386319-05	2026-03-07 02:22:59.386319-05
181	Power Play Pros	2	19	152.2	5	7	0	5	100	\N	2026-03-07 02:22:59.386319-05	2026-03-07 02:22:59.386319-05
183	Arctic Aces	1	20	155.6	8	4	0	1	100	\N	2026-03-07 02:22:59.493075-05	2026-03-07 02:22:59.493075-05
184	Glove Side Glory	2	20	141.5	5	6	0	2	100	\N	2026-03-07 02:22:59.493075-05	2026-03-07 02:22:59.493075-05
186	Puck Legends	1	20	138.8	5	6	0	4	100	\N	2026-03-07 02:22:59.493075-05	2026-03-07 02:22:59.493075-05
187	Crease Crushers	2	20	83.3	2	6	0	5	100	\N	2026-03-07 02:22:59.493075-05	2026-03-07 02:22:59.493075-05
189	Top Shelf Elite	1	20	143.2	5	6	0	7	100	\N	2026-03-07 02:22:59.493075-05	2026-03-07 02:22:59.493075-05
190	Dekes & Dangles	1	21	109	5	7	0	1	100	\N	2026-03-07 02:22:59.612623-05	2026-03-07 02:22:59.612623-05
191	Crease Crushers	2	21	148.6	7	5	0	2	100	\N	2026-03-07 02:22:59.612623-05	2026-03-07 02:22:59.612623-05
193	Power Play Pros	1	21	113.7	6	6	0	4	100	\N	2026-03-07 02:22:59.612623-05	2026-03-07 02:22:59.612623-05
194	One-Timer Queens	2	21	117.3	5	7	0	5	100	\N	2026-03-07 02:22:59.612623-05	2026-03-07 02:22:59.612623-05
196	Top Shelf Elite	1	21	105.7	6	6	0	7	100	\N	2026-03-07 02:22:59.612623-05	2026-03-07 02:22:59.612623-05
197	Net Breakers	2	21	89.8	4	8	0	8	100	\N	2026-03-07 02:22:59.612623-05	2026-03-07 02:22:59.612623-05
198	Top Shelf Elite	1	22	130.7	10	2	0	1	100	\N	2026-03-07 02:22:59.75089-05	2026-03-07 02:22:59.75089-05
199	Butterfly Blockers	2	22	94.1	6	3	0	2	100	\N	2026-03-07 02:22:59.75089-05	2026-03-07 02:22:59.75089-05
201	Snow Leopards	1	22	89.4	6	5	0	4	100	\N	2026-03-07 02:22:59.75089-05	2026-03-07 02:22:59.75089-05
202	Blizzard Queens	2	22	75.7	4	8	0	5	100	\N	2026-03-07 02:22:59.75089-05	2026-03-07 02:22:59.75089-05
204	Crease Crushers	1	22	89	3	8	0	7	100	\N	2026-03-07 02:22:59.75089-05	2026-03-07 02:22:59.75089-05
205	Wrist Shot Wizards	2	22	95.6	6	3	0	8	100	\N	2026-03-07 02:22:59.75089-05	2026-03-07 02:22:59.75089-05
207	Arctic Aces	1	23	79.6	7	5	0	1	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
208	One-Timer Queens	2	23	89.2	6	6	0	2	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
210	Slapshot Six	1	23	89.1	8	4	0	4	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
211	Storm Chasers	2	23	85.9	5	7	0	5	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
213	Top Shelf Elite	1	23	100	9	3	0	7	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
214	Butterfly Blockers	2	23	76.4	6	6	0	8	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
216	Puck Legends	1	23	48.9	4	8	0	10	100	\N	2026-03-07 02:22:59.900004-05	2026-03-07 02:22:59.900004-05
217	Ice Wolves	1	24	96.7	2	6	0	1	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
218	Net Breakers	2	24	82.6	4	7	0	2	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
220	Dekes & Dangles	1	24	94.7	7	4	0	4	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
221	Crease Crushers	2	24	77.1	7	4	0	5	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
223	Butterfly Blockers	1	24	93.8	7	5	0	7	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
224	Five Hole Legends	2	24	78.6	9	2	0	8	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
226	Wrist Shot Wizards	1	24	26.3	1	9	0	10	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
227	Blizzard Queens	2	24	72.2	5	6	0	11	100	\N	2026-03-07 02:23:00.038423-05	2026-03-07 02:23:00.038423-05
228	Blizzard Queens	1	25	67.2	9	3	0	1	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
229	Frozen Fury	2	25	78.2	3	9	0	2	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
231	Hat Trick Heroes	1	25	52.6	7	5	0	4	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
232	Dekes & Dangles	2	25	81.7	6	6	0	5	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
234	Storm Chasers	1	25	83.9	9	3	0	7	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
235	Crease Crushers	2	25	68.5	7	5	0	8	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
237	Penalty Box Rebels	1	25	84.1	4	8	0	10	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
238	Five Hole Legends	2	25	56.7	3	9	0	11	100	\N	2026-03-07 02:23:00.171028-05	2026-03-07 02:23:00.171028-05
240	Wrist Shot Wizards	1	26	94.4	8	3	0	1	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
241	Slapshot Six	2	26	80.5	7	5	0	2	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
243	Five Hole Legends	1	26	78.5	7	5	0	4	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
244	Penalty Box Rebels	2	26	62.4	4	5	0	5	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
246	Glove Side Glory	1	26	84.4	7	5	0	7	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
247	Frozen Fury	2	26	75.8	9	2	0	8	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
249	Blizzard Queens	1	26	55.2	4	6	0	10	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
250	Power Play Pros	2	26	64.8	3	9	0	11	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
252	One-Timer Queens	1	26	45	4	7	0	13	100	\N	2026-03-07 02:23:00.305721-05	2026-03-07 02:23:00.305721-05
253	Dekes & Dangles	1	27	79.4	10	2	0	1	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
254	Puck Legends	2	27	79.1	4	8	0	2	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
256	Butterfly Blockers	1	27	63.8	5	7	0	4	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
257	Crease Crushers	2	27	33.3	4	8	0	5	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
259	Wrist Shot Wizards	1	27	58.3	5	7	0	7	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
260	Slapshot Six	2	27	82.3	6	6	0	8	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
262	Storm Chasers	1	27	48.5	4	8	0	10	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
263	Power Play Pros	2	27	74.4	7	5	0	11	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
265	Blizzard Queens	1	27	57.8	7	5	0	13	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
266	Top Shelf Elite	2	27	71.5	5	7	0	14	100	\N	2026-03-07 02:23:00.448045-05	2026-03-07 02:23:00.448045-05
267	Puck Legends	1	28	75	8	3	0	1	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
268	Five Hole Legends	2	28	68.4	5	6	0	2	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
270	Frozen Fire	1	28	80.4	4	6	0	4	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
271	Glove Side Glory	2	28	60.6	6	5	0	5	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
273	Storm Chasers	1	28	81.4	7	5	0	7	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
274	Blue Line Babes	2	28	65.1	7	4	0	8	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
276	Arctic Aces	1	28	25.2	1	11	0	10	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
277	Crease Crushers	2	28	62.4	4	6	0	11	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
279	Frozen Fury	1	28	54.5	8	4	0	13	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
280	Top Shelf Elite	2	28	63.5	4	8	0	14	100	\N	2026-03-07 02:23:00.584013-05	2026-03-07 02:23:00.584013-05
282	Blizzard Queens	1	29	72.1	6	6	0	1	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
283	Crease Crushers	2	29	70.5	6	6	0	2	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
285	Top Shelf Elite	1	29	71.7	9	3	0	4	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
286	Dekes & Dangles	2	29	62.7	8	4	0	5	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
288	Storm Chasers	1	29	85.1	7	5	0	7	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
289	Hat Trick Heroes	2	29	62	8	4	0	8	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
291	One-Timer Queens	1	29	23.9	2	10	0	10	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
292	Glove Side Glory	2	29	54.9	6	6	0	11	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
294	Frozen Fire	1	29	42.1	4	8	0	13	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
295	Puck Legends	2	29	59.2	7	5	0	14	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
297	Wrist Shot Wizards	1	29	38.6	8	4	0	16	100	\N	2026-03-07 02:23:00.71014-05	2026-03-07 02:23:00.71014-05
298	One-Timer Queens	1	30	42.6	3	9	0	1	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
299	Snow Leopards	2	30	55.7	6	5	0	2	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
301	Top Shelf Elite	1	30	75.7	8	2	0	4	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
302	Slapshot Six	2	30	64.1	4	7	0	5	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
304	Blue Line Babes	1	30	56	6	6	0	7	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
305	Power Play Pros	2	30	34.8	5	5	0	8	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
307	Ice Wolves	1	30	49.3	6	4	0	10	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
308	Arctic Aces	2	30	63.2	7	4	0	11	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
310	Frozen Fury	1	30	37.8	5	6	0	13	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
311	Puck Legends	2	30	57.4	4	8	0	14	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
313	Glove Side Glory	1	30	56.1	8	4	0	16	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
314	Crease Crushers	2	30	65.6	5	7	0	17	100	\N	2026-03-07 02:23:00.836232-05	2026-03-07 02:23:00.836232-05
315	Dekes & Dangles	1	31	57.1	8	4	0	1	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
316	Storm Chasers	2	31	33.6	4	8	0	2	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
318	Penalty Box Rebels	1	31	59.9	7	5	0	4	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
319	Five Hole Legends	2	31	73.6	7	5	0	5	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
321	One-Timer Queens	1	31	47.6	8	4	0	7	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
322	Crease Crushers	2	31	52.3	5	7	0	8	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
324	Glove Side Glory	1	31	26.5	4	8	0	10	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
325	Snow Leopards	2	31	61.4	6	6	0	11	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
327	Puck Legends	1	31	27.1	5	7	0	13	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
328	Ice Wolves	2	31	35.7	6	6	0	14	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
330	Power Play Pros	1	31	61.2	7	5	0	16	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
331	Arctic Aces	2	31	58.3	6	6	0	17	100	\N	2026-03-07 02:23:00.949847-05	2026-03-07 02:23:00.949847-05
333	Snow Leopards	1	32	88.4	8	3	0	1	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
334	Net Breakers	2	32	62.3	7	5	0	2	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
336	Frozen Fire	1	32	59.7	8	4	0	4	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
337	Butterfly Blockers	2	32	60.1	9	2	0	5	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
339	Frozen Fury	1	32	68.9	10	2	0	7	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
340	Blue Line Babes	2	32	54.8	6	5	0	8	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
342	Puck Legends	1	32	19.4	2	9	0	10	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
343	Slapshot Six	2	32	50.1	5	6	0	11	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
345	Storm Chasers	1	32	43.5	6	6	0	13	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
346	Crease Crushers	2	32	51.7	5	6	0	14	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
348	Glove Side Glory	1	32	32.3	2	10	0	16	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
349	Ice Wolves	2	32	33.3	3	8	0	17	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
351	Five Hole Legends	1	32	27.4	4	8	0	19	100	\N	2026-03-07 02:23:01.095697-05	2026-03-07 02:23:01.095697-05
352	Butterfly Blockers	1	33	56.4	6	6	0	1	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
353	Frozen Fury	2	33	66.2	8	4	0	2	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
355	Blizzard Queens	1	33	64.2	8	4	0	4	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
356	Glove Side Glory	2	33	57.4	8	4	0	5	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
358	Arctic Aces	1	33	79.7	9	3	0	7	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
359	Blue Line Babes	2	33	54.2	7	5	0	8	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
361	Top Shelf Elite	1	33	18	2	10	0	10	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
362	Power Play Pros	2	33	50.7	7	5	0	11	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
364	Slapshot Six	1	33	38.8	6	6	0	13	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
365	Puck Legends	2	33	56.8	6	6	0	14	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
367	Snow Leopards	1	33	32.3	6	6	0	16	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
368	Storm Chasers	2	33	23.9	4	8	0	17	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
370	One-Timer Queens	1	33	21	3	9	0	19	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
371	Frozen Fire	2	33	25.9	5	7	0	20	100	\N	2026-03-07 02:23:01.229375-05	2026-03-07 02:23:01.229375-05
372	Blizzard Queens	1	34	76	10	2	0	1	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
373	Slapshot Six	2	34	100.4	8	2	0	2	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
375	Ice Wolves	1	34	59.8	8	2	0	4	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
376	Glove Side Glory	2	34	69.5	10	2	0	5	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
378	Arctic Aces	1	34	49.5	5	6	0	7	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
379	Storm Chasers	2	34	39.7	4	7	0	8	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
381	Crease Crushers	1	34	44.3	6	6	0	10	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
382	Net Breakers	2	34	33.1	3	8	0	11	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
384	Five Hole Legends	1	34	29.5	5	7	0	13	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
385	Top Shelf Elite	2	34	14.1	2	10	0	14	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
387	Puck Legends	1	34	30.5	3	7	0	16	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
388	Snow Leopards	2	34	35.5	6	5	0	17	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
390	Butterfly Blockers	1	34	14.6	5	7	0	19	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
391	Frozen Fury	2	34	26.3	2	9	0	20	100	\N	2026-03-07 02:23:01.341114-05	2026-03-07 02:23:01.341114-05
\.


--
-- Data for Name: game_events; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.game_events (id, game_id, event_type, period, time_in_period, player_id, team_id, description, created_at) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.games (id, pwhl_game_id, season, game_date, game_time, home_team_id, away_team_id, home_score, away_score, status, period, time_remaining, is_overtime, is_shootout, venue, created_at, updated_at) FROM stdin;
1	74	2024-2025	2023-12-04	2023-12-04 13:00:00-05	1	6	2	5	final	4	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
2	75	2024-2025	2023-12-04	2023-12-04 16:15:00-05	2	5	8	4	final	4	00:00	f	t	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
3	76	2024-2025	2023-12-04	2023-12-04 19:30:00-05	4	\N	4	0	final	4	00:00	f	t	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
4	77	2024-2025	2023-12-05	2023-12-05 12:00:00-05	6	2	4	5	final	4	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
5	78	2024-2025	2023-12-05	2023-12-05 15:15:00-05	\N	1	3	1	final	4	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
6	79	2024-2025	2023-12-05	2023-12-05 19:30:00-05	5	4	1	2	final	4	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
7	80	2024-2025	2023-12-07	2023-12-07 09:00:00-05	2	\N	4	3	final	3	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
8	81	2024-2025	2023-12-07	2023-12-07 12:15:00-05	6	4	4	6	final	4	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
9	82	2024-2025	2023-12-07	2023-12-07 15:30:00-05	1	5	3	1	final	4	00:00	f	f	Utica University Nexus Center - Mastrovito Hyundai	2026-03-05 08:03:26.439115-05	\N
10	2	2024-2025	2024-01-01	2024-01-01 12:30:00-05	6	4	0	4	final	3	13:33	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
11	3	2024-2025	2024-01-02	2024-01-02 19:00:00-05	5	3	2	3	final	4	03:56	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
12	4	2024-2025	2024-01-03	2024-01-03 19:00:00-05	1	2	2	3	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
13	5	2024-2025	2024-01-05	2024-01-05 19:00:00-05	4	6	2	3	final	3	00:00	f	f	Total Mortgage Arena | Bridgeport	2026-03-05 08:03:26.439115-05	\N
14	6	2024-2025	2024-01-06	2024-01-06 15:30:00-05	2	3	3	0	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
15	9	2024-2025	2024-01-10	2024-01-10 19:00:00-05	4	3	2	5	final	3	00:00	f	f	UBS Arena | Elmont	2026-03-05 08:03:26.439115-05	\N
16	8	2024-2025	2024-01-10	2024-01-10 20:00:00-05	2	6	3	1	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
17	10	2024-2025	2024-01-13	2024-01-13 13:00:00-05	6	5	1	5	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
18	11	2024-2025	2024-01-13	2024-01-13 15:30:00-05	3	1	2	3	final	4	02:43	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
19	12	2024-2025	2024-01-14	2024-01-14 16:00:00-05	2	4	2	3	final	4	00:59	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
20	13	2024-2025	2024-01-16	2024-01-16 19:00:00-05	3	4	3	2	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
21	14	2024-2025	2024-01-17	2024-01-17 19:00:00-05	6	1	2	3	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
22	15	2024-2025	2024-01-17	2024-01-17 19:00:00-05	5	2	2	3	final	4	03:03	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
23	16	2024-2025	2024-01-20	2024-01-20 12:30:00-05	1	4	1	4	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
24	17	2024-2025	2024-01-20	2024-01-20 20:00:00-05	3	6	3	4	final	4	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
25	18	2024-2025	2024-01-23	2024-01-23 19:00:00-05	5	6	3	1	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
26	19	2024-2025	2024-01-24	2024-01-24 19:00:00-05	5	1	2	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
27	20	2024-2025	2024-01-24	2024-01-24 20:00:00-05	2	3	1	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
28	21	2024-2025	2024-01-26	2024-01-26 19:00:00-05	6	4	2	0	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
29	22	2024-2025	2024-01-27	2024-01-27 15:30:00-05	3	5	2	1	final	4	01:30	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
30	23	2024-2025	2024-01-27	2024-01-27 16:00:00-05	1	2	4	3	final	4	04:08	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
31	24	2024-2025	2024-01-28	2024-01-28 13:00:00-05	4	2	1	2	final	4	02:04	f	f	Total Mortgage Arena | Bridgeport	2026-03-05 08:03:26.439115-05	\N
32	25	2024-2025	2024-02-03	2024-02-03 12:00:00-05	6	2	4	1	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
33	26	2024-2025	2024-02-04	2024-02-04 13:00:00-05	5	4	3	4	final	4	02:48	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
34	27	2024-2025	2024-02-04	2024-02-04 15:30:00-05	1	3	1	2	final	4	02:24	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
35	29	2024-2025	2024-02-14	2024-02-14 19:00:00-05	1	6	3	5	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
36	28	2024-2025	2024-02-14	2024-02-14 20:00:00-05	2	5	2	1	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
37	30	2024-2025	2024-02-16	2024-02-16 19:00:00-05	6	3	3	0	final	3	00:00	f	f	Scotiabank Arena | Toronto	2026-03-05 08:03:26.439115-05	\N
38	31	2024-2025	2024-02-17	2024-02-17 14:00:00-05	5	2	1	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
39	32	2024-2025	2024-02-17	2024-02-17 16:00:00-05	1	4	1	2	final	4	02:32	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
40	33	2024-2025	2024-02-18	2024-02-18 13:00:00-05	3	2	2	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
41	83	2024-2025	2024-02-19	2024-02-19 16:30:00-05	1	5	2	4	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
42	34	2024-2025	2024-02-21	2024-02-21 19:00:00-05	1	5	3	1	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
43	35	2024-2025	2024-02-21	2024-02-21 19:00:00-05	4	3	3	2	final	4	00:00	f	t	UBS Arena | Elmont	2026-03-05 08:03:26.439115-05	\N
44	36	2024-2025	2024-02-23	2024-02-23 19:00:00-05	6	4	2	1	final	4	00:00	f	t	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
45	37	2024-2025	2024-02-24	2024-02-24 14:30:00-05	3	5	6	3	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
46	38	2024-2025	2024-02-25	2024-02-25 16:00:00-05	2	1	0	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
47	40	2024-2025	2024-02-27	2024-02-27 20:00:00-05	2	6	3	4	final	4	01:14	f	f	3M Arena at Mariucci | Minneapolis	2026-03-05 08:03:26.439115-05	\N
48	39	2024-2025	2024-02-28	2024-02-28 19:00:00-05	5	4	4	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
49	41	2024-2025	2024-03-02	2024-03-02 15:30:00-05	5	6	2	5	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
50	42	2024-2025	2024-03-02	2024-03-02 16:00:00-05	3	1	3	1	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
51	43	2024-2025	2024-03-03	2024-03-03 12:30:00-05	4	2	0	2	final	3	00:00	f	f	UBS Arena | Elmont	2026-03-05 08:03:26.439115-05	\N
52	44	2024-2025	2024-03-05	2024-03-05 20:00:00-05	2	5	4	3	final	4	00:00	f	t	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
53	45	2024-2025	2024-03-06	2024-03-06 19:00:00-05	6	1	3	1	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
54	46	2024-2025	2024-03-06	2024-03-06 19:00:00-05	4	3	3	4	final	3	00:00	f	f	Total Mortgage Arena | Bridgeport	2026-03-05 08:03:26.439115-05	\N
55	47	2024-2025	2024-03-08	2024-03-08 19:00:00-05	6	3	3	0	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
56	48	2024-2025	2024-03-10	2024-03-10 15:00:00-04	1	4	3	2	final	4	03:12	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
57	49	2024-2025	2024-03-10	2024-03-10 16:00:00-04	3	5	2	4	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
58	50	2024-2025	2024-03-13	2024-03-13 20:00:00-04	2	1	4	0	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
59	51	2024-2025	2024-03-16	2024-03-16 15:30:00-04	2	4	5	1	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
60	65	2024-2025	2024-03-16	2024-03-16 18:00:00-04	1	5	2	1	final	4	00:00	f	t	Little Caesars Arena | Detroit	2026-03-05 08:03:26.439115-05	\N
61	66	2024-2025	2024-03-17	2024-03-17 12:30:00-04	3	6	1	2	final	3	00:00	f	f	PPG Paints Arena | Pittsburgh	2026-03-05 08:03:26.439115-05	\N
62	52	2024-2025	2024-03-20	2024-03-20 19:00:00-04	6	1	2	1	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
63	53	2024-2025	2024-03-20	2024-03-20 19:00:00-04	4	5	0	3	final	3	00:00	f	f	Total Mortgage Arena | Bridgeport	2026-03-05 08:03:26.439115-05	\N
64	54	2024-2025	2024-03-23	2024-03-23 13:00:00-04	5	6	5	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
65	55	2024-2025	2024-03-24	2024-03-24 16:00:00-04	2	3	3	2	final	4	00:00	f	t	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
66	56	2024-2025	2024-03-25	2024-03-25 19:00:00-04	4	1	3	2	final	3	00:00	f	f	UBS Arena | Elmont	2026-03-05 08:03:26.439115-05	\N
67	57	2024-2025	2024-04-18	2024-04-18 19:00:00-04	1	6	2	1	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
68	58	2024-2025	2024-04-18	2024-04-18 19:00:00-04	3	2	4	3	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
69	67	2024-2025	2024-04-20	2024-04-20 13:00:00-04	3	6	2	3	final	4	00:00	f	f	Bell Centre | Montréal	2026-03-05 08:03:26.439115-05	\N
70	68	2024-2025	2024-04-20	2024-04-20 15:30:00-04	4	1	1	2	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
71	59	2024-2025	2024-04-20	2024-04-20 19:00:00-04	5	2	4	0	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
72	60	2024-2025	2024-04-24	2024-04-24 19:00:00-04	3	4	5	2	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
73	69	2024-2025	2024-04-24	2024-04-24 19:00:00-04	5	1	3	2	final	4	00:00	f	t	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
74	62	2024-2025	2024-04-27	2024-04-27 12:30:00-04	5	3	0	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
75	70	2024-2025	2024-04-27	2024-04-27 14:00:00-04	2	1	1	2	final	3	05:30	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
76	61	2024-2025	2024-04-28	2024-04-28 13:00:00-04	4	6	2	6	final	3	00:00	f	f	UBS Arena | Elmont	2026-03-05 08:03:26.439115-05	\N
77	71	2024-2025	2024-04-30	2024-04-30 19:00:00-04	4	5	4	3	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
78	63	2024-2025	2024-05-01	2024-05-01 19:00:00-04	6	2	4	1	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
79	73	2024-2025	2024-05-04	2024-05-04 13:00:00-04	4	2	5	2	final	3	00:00	f	f	UBS Arena | Elmont	2026-03-05 08:03:26.439115-05	\N
80	64	2024-2025	2024-05-04	2024-05-04 15:30:00-04	1	3	4	3	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
81	72	2024-2025	2024-05-05	2024-05-05 19:00:00-04	6	5	5	2	final	3	00:00	f	f	Mattamy Athletic Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
82	84	2024-2025	2024-05-08	2024-05-08 19:00:00-04	6	2	4	0	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
83	85	2024-2025	2024-05-09	2024-05-09 19:00:00-04	3	1	1	2	final	4	05:35	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
84	86	2024-2025	2024-05-10	2024-05-10 19:00:00-04	6	2	2	0	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
85	87	2024-2025	2024-05-11	2024-05-11 19:00:00-04	3	1	1	2	final	6	08:16	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
86	88	2024-2025	2024-05-13	2024-05-13 20:00:00-04	2	6	2	0	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
87	89	2024-2025	2024-05-14	2024-05-14 19:00:00-04	1	3	3	2	final	4	18:58	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
88	90	2024-2025	2024-05-15	2024-05-15 20:00:00-04	2	6	1	0	final	5	15:33	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
89	92	2024-2025	2024-05-17	2024-05-17 19:00:00-04	6	2	1	4	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
90	94	2024-2025	2024-05-19	2024-05-19 17:00:00-04	1	2	4	3	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
91	95	2024-2025	2024-05-21	2024-05-21 19:00:00-04	1	2	0	3	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
92	96	2024-2025	2024-05-24	2024-05-24 19:00:00-04	2	1	4	1	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
93	97	2024-2025	2024-05-26	2024-05-26 18:00:00-04	2	1	0	1	final	5	01:24	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
94	98	2024-2025	2024-05-29	2024-05-29 19:00:00-04	1	2	0	3	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
95	99	2024-2025	2024-11-20	2024-11-20 14:00:00-05	1	3	3	1	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
96	100	2024-2025	2024-11-20	2024-11-20 14:15:00-05	2	6	3	1	final	3	00:00	f	f	Ford Performance Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
97	101	2024-2025	2024-11-21	2024-11-21 14:00:00-05	5	1	6	1	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
98	102	2024-2025	2024-11-21	2024-11-21 14:30:00-05	4	2	3	4	final	4	03:15	f	f	Ford Performance Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
99	103	2024-2025	2024-11-22	2024-11-22 14:00:00-05	3	5	6	3	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
100	104	2024-2025	2024-11-22	2024-11-22 14:30:00-05	6	4	2	5	final	3	00:00	f	f	Ford Performance Centre | Toronto	2026-03-05 08:03:26.439115-05	\N
101	105	2024-2025	2024-11-30	2024-11-30 14:00:00-05	6	1	3	1	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
102	106	2024-2025	2024-11-30	2024-11-30 17:00:00-05	3	5	4	3	final	4	00:00	f	t	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
103	107	2024-2025	2024-12-01	2024-12-01 18:00:00-05	2	4	3	4	final	4	04:41	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
104	108	2024-2025	2024-12-03	2024-12-03 19:00:00-05	5	6	3	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
105	109	2024-2025	2024-12-04	2024-12-04 19:00:00-05	1	2	1	2	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
106	110	2024-2025	2024-12-04	2024-12-04 19:00:00-05	3	4	1	4	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
107	172	2024-2025	2024-12-06	2024-12-06 19:00:00-05	5	3	1	2	final	3	00:00	f	f	Canadian Tire Centre | Ottawa	2026-03-05 08:03:26.439115-05	\N
108	111	2024-2025	2024-12-07	2024-12-07 14:00:00-05	6	2	3	6	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
109	112	2024-2025	2024-12-08	2024-12-08 16:00:00-05	1	4	4	2	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
110	113	2024-2025	2024-12-17	2024-12-17 19:00:00-05	1	5	3	2	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
111	114	2024-2025	2024-12-18	2024-12-18 19:00:00-05	4	6	4	2	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
112	115	2024-2025	2024-12-19	2024-12-19 20:00:00-05	2	5	5	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
113	116	2024-2025	2024-12-21	2024-12-21 14:00:00-05	6	3	3	4	final	4	04:45	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
114	117	2024-2025	2024-12-22	2024-12-22 12:00:00-05	4	2	3	4	final	4	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
115	118	2024-2025	2024-12-27	2024-12-27 19:00:00-05	6	1	4	2	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
116	119	2024-2025	2024-12-28	2024-12-28 14:00:00-05	2	3	2	3	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
117	120	2024-2025	2024-12-29	2024-12-29 13:00:00-05	4	5	1	3	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
118	121	2024-2025	2024-12-30	2024-12-30 19:00:00-05	3	1	3	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
119	122	2024-2025	2024-12-31	2024-12-31 19:00:00-05	6	5	1	2	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
120	123	2024-2025	2025-01-02	2025-01-02 19:30:00-05	2	1	4	3	final	4	00:13	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
121	124	2024-2025	2025-01-04	2025-01-04 14:00:00-05	2	4	0	5	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
122	173	2024-2025	2025-01-05	2025-01-05 16:00:00-05	1	3	3	2	final	4	00:00	f	t	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	\N
123	125	2024-2025	2025-01-07	2025-01-07 19:00:00-05	4	5	2	3	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
124	126	2024-2025	2025-01-08	2025-01-08 19:30:00-05	2	1	2	1	final	4	01:40	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
125	174	2024-2025	2025-01-08	2025-01-08 22:00:00-05	6	3	2	4	final	3	00:00	f	f	Rogers Arena | Vancouver	2026-03-05 08:03:26.439115-05	\N
126	127	2024-2025	2025-01-11	2025-01-11 14:00:00-05	5	1	1	2	final	4	03:15	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
127	128	2024-2025	2025-01-12	2025-01-12 12:00:00-05	4	6	1	0	final	4	01:23	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
128	175	2024-2025	2025-01-12	2025-01-12 15:00:00-05	2	3	4	2	final	3	00:00	f	f	Ball Arena | Denver	2026-03-05 08:03:26.439115-05	\N
129	129	2024-2025	2025-01-14	2025-01-14 19:00:00-05	5	6	2	4	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
130	130	2024-2025	2025-01-15	2025-01-15 19:00:00-05	4	2	3	2	final	4	00:00	f	t	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
131	131	2024-2025	2025-01-17	2025-01-17 19:00:00-05	3	2	4	2	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
132	176	2024-2025	2025-01-19	2025-01-19 13:00:00-05	3	5	2	1	final	3	00:00	f	f	Videotron Centre | Quebec City	2026-03-05 08:03:26.439115-05	\N
133	132	2024-2025	2025-01-21	2025-01-21 19:00:00-05	2	5	0	1	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
134	133	2024-2025	2025-01-22	2025-01-22 19:00:00-05	1	6	4	1	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
135	177	2024-2025	2025-01-25	2025-01-25 14:00:00-05	6	4	4	2	final	3	00:00	f	f	Scotiabank Arena | Toronto	2026-03-05 08:03:26.439115-05	\N
136	134	2024-2025	2025-01-26	2025-01-26 15:00:00-05	2	1	5	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
137	135	2024-2025	2025-01-27	2025-01-27 19:00:00-05	5	4	0	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
138	136	2024-2025	2025-01-28	2025-01-28 19:00:00-05	2	6	4	3	final	4	00:00	f	t	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
139	137	2024-2025	2025-01-29	2025-01-29 19:00:00-05	3	5	4	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
140	138	2024-2025	2025-01-30	2025-01-30 19:00:00-05	3	6	4	3	final	4	00:00	f	t	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
141	139	2024-2025	2025-01-31	2025-01-31 19:00:00-05	1	4	3	2	final	4	00:00	f	t	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
142	140	2024-2025	2025-02-01	2025-02-01 14:00:00-05	6	5	4	2	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
143	141	2024-2025	2025-02-02	2025-02-02 13:00:00-05	4	3	1	2	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
144	142	2024-2025	2025-02-11	2025-02-11 19:00:00-05	6	2	3	2	final	4	00:04	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
145	143	2024-2025	2025-02-12	2025-02-12 19:00:00-05	4	1	0	4	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
146	144	2024-2025	2025-02-13	2025-02-13 19:00:00-05	5	2	8	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
147	145	2024-2025	2025-02-14	2025-02-14 19:00:00-05	6	1	3	1	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
148	146	2024-2025	2025-02-15	2025-02-15 14:00:00-05	3	4	6	2	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
149	147	2024-2025	2025-02-16	2025-02-16 13:00:00-05	1	2	4	2	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
150	178	2024-2025	2025-02-16	2025-02-16 16:00:00-05	5	6	2	3	final	4	04:09	f	f	Rogers Place | Edmonton	2026-03-05 08:03:26.439115-05	\N
151	148	2024-2025	2025-02-17	2025-02-17 16:00:00-05	4	1	1	4	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
152	149	2024-2025	2025-02-18	2025-02-18 19:00:00-05	3	2	0	4	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
153	150	2024-2025	2025-02-19	2025-02-19 19:00:00-05	4	6	1	4	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
154	151	2024-2025	2025-02-20	2025-02-20 19:00:00-05	5	1	2	3	final	4	00:48	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
155	152	2024-2025	2025-02-22	2025-02-22 14:00:00-05	5	3	3	1	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
156	153	2024-2025	2025-02-23	2025-02-23 13:30:00-05	2	6	1	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
157	179	2024-2025	2025-02-23	2025-02-23 16:00:00-05	4	1	2	3	final	4	00:00	f	f	KeyBank Center | Buffalo	2026-03-05 08:03:26.439115-05	\N
158	154	2024-2025	2025-02-25	2025-02-25 19:00:00-05	3	6	3	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
159	155	2024-2025	2025-02-26	2025-02-26 19:00:00-05	5	4	5	4	final	4	04:24	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
160	180	2024-2025	2025-03-01	2025-03-01 14:00:00-05	3	1	3	2	final	4	00:17	f	f	Bell Centre | Montréal	2026-03-05 08:03:26.439115-05	\N
161	156	2024-2025	2025-03-04	2025-03-04 19:00:00-05	3	2	2	1	final	4	00:00	f	t	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
162	157	2024-2025	2025-03-05	2025-03-05 19:00:00-05	1	4	5	2	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
163	158	2024-2025	2025-03-06	2025-03-06 19:00:00-05	6	3	4	1	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
164	181	2024-2025	2025-03-07	2025-03-07 19:00:00-05	2	5	5	0	final	3	00:00	f	f	Lenovo Center | Raleigh	2026-03-05 08:03:26.439115-05	\N
165	182	2024-2025	2025-03-08	2025-03-08 14:00:00-05	1	3	2	3	final	4	04:39	f	f	Agganis Arena | Boston	2026-03-05 08:03:26.439115-05	\N
166	159	2024-2025	2025-03-09	2025-03-09 13:00:00-04	6	2	1	2	final	4	02:21	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
167	160	2024-2025	2025-03-11	2025-03-11 19:00:00-04	5	2	3	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
168	161	2024-2025	2025-03-12	2025-03-12 19:00:00-04	4	3	3	2	final	4	03:06	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
169	162	2024-2025	2025-03-15	2025-03-15 14:00:00-04	5	1	2	5	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
170	183	2024-2025	2025-03-16	2025-03-16 19:30:00-04	4	2	4	1	final	3	00:00	f	f	Little Caesars Arena | Detroit	2026-03-05 08:03:26.439115-05	\N
171	163	2024-2025	2025-03-18	2025-03-18 19:00:00-04	1	3	3	2	final	4	00:00	f	t	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
172	164	2024-2025	2025-03-19	2025-03-19 19:00:00-04	6	4	2	1	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
173	165	2024-2025	2025-03-22	2025-03-22 12:00:00-04	4	5	2	5	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
174	166	2024-2025	2025-03-23	2025-03-23 12:00:00-04	3	6	1	2	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
175	167	2024-2025	2025-03-25	2025-03-25 19:00:00-04	5	4	3	6	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
176	184	2024-2025	2025-03-26	2025-03-26 19:00:00-04	1	6	2	4	final	3	00:00	f	f	Agganis Arena | Boston	2026-03-05 08:03:26.439115-05	\N
177	168	2024-2025	2025-03-26	2025-03-26 20:00:00-04	2	3	1	4	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
178	185	2024-2025	2025-03-29	2025-03-29 14:00:00-04	1	5	1	2	final	3	00:00	f	f	Enterprise Center | St. Louis	2026-03-05 08:03:26.439115-05	\N
179	169	2024-2025	2025-03-30	2025-03-30 13:00:00-04	2	6	5	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
180	170	2024-2025	2025-04-01	2025-04-01 19:00:00-04	3	4	0	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
181	171	2024-2025	2025-04-02	2025-04-02 19:00:00-04	1	5	0	4	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
182	188	2024-2025	2025-04-26	2025-04-26 12:00:00-04	5	3	3	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
183	187	2024-2025	2025-04-26	2025-04-26 14:00:00-04	1	6	3	0	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
184	186	2024-2025	2025-04-27	2025-04-27 14:00:00-04	2	4	0	2	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
185	190	2024-2025	2025-04-28	2025-04-28 19:00:00-04	3	1	3	2	final	4	00:43	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
186	189	2024-2025	2025-04-29	2025-04-29 19:00:00-04	6	4	2	1	final	4	00:00	f	t	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
187	191	2024-2025	2025-04-30	2025-04-30 19:00:00-04	5	2	0	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
188	194	2024-2025	2025-05-03	2025-05-03 12:00:00-04	6	5	1	2	final	4	02:08	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
189	193	2024-2025	2025-05-03	2025-05-03 13:00:00-04	1	2	1	8	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
190	192	2024-2025	2025-05-03	2025-05-03 14:00:00-04	4	3	2	3	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	\N
191	195	2024-2025	2025-05-07	2025-05-07 19:00:00-04	6	2	3	2	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
192	197	2024-2025	2025-05-08	2025-05-08 19:00:00-04	3	5	2	3	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
193	196	2024-2025	2025-05-09	2025-05-09 19:00:00-04	6	2	3	5	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
194	199	2024-2025	2025-05-11	2025-05-11 14:00:00-04	3	5	3	2	final	7	04:27	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
195	203	2024-2025	2025-05-11	2025-05-11 18:00:00-04	2	6	7	5	final	3	00:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
196	200	2024-2025	2025-05-13	2025-05-13 19:00:00-04	5	3	1	0	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
197	204	2024-2025	2025-05-14	2025-05-14 19:00:00-04	2	6	4	3	final	4	04:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
198	201	2024-2025	2025-05-16	2025-05-16 19:00:00-04	5	3	2	1	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
199	206	2024-2025	2025-05-20	2025-05-20 19:00:00-04	5	2	2	1	final	4	17:13	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
200	207	2024-2025	2025-05-22	2025-05-22 19:00:00-04	5	2	1	2	final	4	03:36	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
201	208	2024-2025	2025-05-24	2025-05-24 17:00:00-04	2	5	2	1	final	6	10:03	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
202	209	2024-2025	2025-05-26	2025-05-26 17:00:00-04	2	5	2	1	final	4	08:00	f	f	Xcel Energy Center | St. Paul	2026-03-05 08:03:26.439115-05	\N
203	330	2024-2025	2025-11-13	2025-11-13 15:00:00-05	4	2	2	5	final	3	00:00	f	f	Codey Arena	2026-03-05 08:03:26.439115-05	\N
204	331	2024-2025	2025-11-14	2025-11-14 12:00:00-05	4	2	6	2	final	3	00:00	f	f	Codey Arena	2026-03-05 08:03:26.439115-05	\N
205	332	2024-2025	2025-11-15	2025-11-15 19:30:00-05	3	1	3	2	final	4	02:29	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	\N
206	333	2024-2025	2025-11-15	2025-11-15 22:00:00-05	8	7	3	0	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	\N
207	334	2024-2025	2025-11-16	2025-11-16 13:00:00-05	5	6	2	3	final	4	02:44	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
208	335	2024-2025	2025-11-16	2025-11-16 20:00:00-05	8	7	2	4	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	\N
209	336	2024-2025	2025-11-17	2025-11-17 13:00:00-05	5	6	0	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	\N
230	229	2024-2025	2025-12-19	2025-12-17 22:00:00-05	2	1	4	1	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
231	230	2024-2025	2025-12-20	2025-12-19 20:00:00-05	8	3	5	2	final	3	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
232	231	2024-2025	2025-12-21	2025-12-20 15:00:00-05	4	6	2	4	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
233	232	2024-2025	2025-12-21	2025-12-21 12:00:00-05	2	5	3	4	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
235	234	2024-2025	2025-12-23	2025-12-21 17:00:00-05	6	5	1	3	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
237	236	2024-2025	2025-12-27	2025-12-23 22:00:00-05	5	1	2	1	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
238	237	2024-2025	2025-12-27	2025-12-27 12:00:00-05	3	6	3	2	final	4	00:00	f	t	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
241	240	2024-2025	2025-12-30	2025-12-28 18:00:00-05	6	2	4	3	final	3	00:00	f	f	American Airlines Center | Dallas	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
242	241	2024-2025	2025-12-31	2025-12-30 19:00:00-05	4	8	1	5	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
243	242	2024-2025	2026-01-02	2025-12-31 13:00:00-05	4	3	2	0	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
244	243	2024-2025	2026-01-03	2026-01-02 13:00:00-05	5	2	4	3	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
246	245	2024-2025	2026-01-03	2026-01-03 14:00:00-05	1	8	2	3	final	4	00:00	f	f	TD Coliseum | Hamilton	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
247	246	2024-2025	2026-01-04	2026-01-03 19:00:00-05	3	2	3	4	final	3	00:00	f	f	Little Caesars Arena | Detroit	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
248	247	2024-2025	2026-01-06	2026-01-04 14:00:00-05	6	4	3	2	final	4	01:38	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
249	248	2024-2025	2026-01-09	2026-01-06 19:00:00-05	5	8	0	2	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
251	249	2024-2025	2026-01-11	2026-01-09 19:00:00-05	1	5	4	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
253	252	2024-2025	2026-01-11	2026-01-11 14:00:00-05	3	8	6	2	final	3	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
254	253	2024-2025	2026-01-13	2026-01-11 14:00:00-05	3	5	1	0	final	3	00:00	f	f	Videotron Centre | Quebec City	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
256	255	2024-2025	2026-01-16	2026-01-14 19:00:00-05	4	2	2	1	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
257	256	2024-2025	2026-01-17	2026-01-16 19:00:00-05	6	8	2	3	final	4	04:08	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
260	259	2024-2025	2026-01-20	2026-01-18 22:00:00-05	4	5	1	2	final	4	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
262	261	2024-2025	2026-01-21	2026-01-20 22:00:00-05	2	3	6	4	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
263	262	2024-2025	2026-01-22	2026-01-21 19:00:00-05	8	6	1	2	final	4	01:57	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
264	263	2024-2025	2026-01-24	2026-01-22 22:00:00-05	3	5	5	0	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
265	264	2024-2025	2026-01-25	2026-01-24 14:00:00-05	2	4	3	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
267	266	2024-2025	2026-01-28	2026-01-25 18:00:00-05	3	6	1	3	final	3	00:00	f	f	Ball Arena | Denver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
269	268	2024-2025	2026-01-28	2026-01-28 19:00:00-05	1	4	4	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
270	269	2024-2025	2026-01-28	2026-01-28 19:00:00-05	2	8	4	3	final	4	00:00	f	t	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
271	270	2024-2025	2026-02-26	2026-01-28 21:00:00-05	4	3	4	1	final	3	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
273	272	2024-2025	2026-02-28	2026-02-27 22:00:00-05	5	1	2	5	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
274	273	2024-2025	2026-03-01	2026-02-28 14:00:00-05	3	2	2	3	final	4	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
275	274	2024-2025	2026-03-01	2026-03-01 13:00:00-05	8	6	4	0	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
250	250	2024-2025	2026-01-07	2026-01-07 19:00:00-05	1	7	2	1	final	3	00:00	f	f	Agganis Arena | Boston	2026-03-05 08:03:26.439115-05	\N
276	275	2024-2025	2026-03-03	2026-03-01 16:00:00-05	6	3	1	2	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
278	277	2024-2025	2026-03-05	2026-03-04 19:00:00-05	4	1	4	3	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
279	278	2024-2025	2026-03-08	2026-03-05 19:00:00-05	4	5	0	1	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
331	210	2025-2026	2025-11-21	2025-11-21 19:00:00-05	2	6	1	2	final	3	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-06 06:00:01.126664-05	\N
332	215	2025-2026	2025-11-26	2025-11-26 19:00:00-05	5	8	5	1	final	3	00:00	f	f	TD Place | Ottawa	2026-03-06 06:00:01.126664-05	\N
333	220	2025-2026	2025-12-03	2025-12-03 19:00:00-05	1	8	2	0	final	3	00:00	f	f	Agganis Arena | Boston	2026-03-06 06:00:01.126664-05	\N
335	233	2025-2026	2025-12-21	2025-12-21 14:00:00-05	2	5	2	3	final	4	01:05	f	f	Allstate Arena | Chicago	2026-03-06 06:00:01.126664-05	\N
336	235	2025-2026	2025-12-23	2025-12-23 19:00:00-05	6	5	3	4	final	4	03:36	f	f	Coca-Cola Coliseum | Toronto	2026-03-06 06:00:01.126664-05	\N
337	239	2025-2026	2025-12-27	2025-12-27 15:00:00-05	8	2	1	2	final	4	02:03	f	f	Rogers Place | Edmonton	2026-03-06 06:00:01.126664-05	\N
338	244	2025-2026	2026-01-03	2026-01-03 13:00:00-05	5	2	5	2	final	3	00:00	f	f	TD Place | Ottawa	2026-03-06 06:00:01.126664-05	\N
339	251	2025-2026	2026-01-11	2026-01-11 12:00:00-05	1	5	1	2	final	4	00:00	f	f	Scotiabank Centre | Halifax	2026-03-06 06:00:01.126664-05	\N
343	267	2025-2026	2026-01-28	2026-01-28 18:30:00-05	3	6	3	0	final	3	00:00	f	f	Place Bell | Laval	2026-03-06 06:00:01.126664-05	\N
345	276	2025-2026	2026-03-03	2026-03-03 19:00:00-05	6	3	3	4	final	4	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-06 06:00:01.126664-05	\N
346	307	2025-2026	2026-04-04	2026-04-04 14:00:00-04	2	8	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-06 06:00:01.126664-05	\N
347	310	2025-2026	2026-04-07	2026-04-07 21:30:00-04	8	1	0	0	scheduled	1	00:00	f	f	Rogers Place | Edmonton	2026-03-06 06:00:01.126664-05	\N
348	314	2025-2026	2026-04-11	2026-04-11 19:00:00-04	1	3	0	0	scheduled	1	00:00	f	f	TD Garden | Boston	2026-03-06 06:00:01.126664-05	\N
349	324	2025-2026	2026-04-22	2026-04-22 19:00:00-04	1	5	0	0	scheduled	1	00:00	f	f	Tsongas Center | Lowell	2026-03-06 06:00:01.126664-05	\N
350	327	2025-2026	2026-04-25	2026-04-25 03:00:00-04	8	2	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-06 06:00:01.126664-05	\N
342	265	2025-2026	2026-01-25	2026-01-25 15:00:00-05	2	4	6	2	final	3	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-06 06:00:01.126664-05	\N
334	228	2025-2026	2025-12-17	2025-12-17 19:00:00-05	4	1	0	2	final	3	00:00	f	f	Prudential Center | Newark	2026-03-06 06:00:01.126664-05	\N
283	283	2024-2025	2026-03-11	2026-03-11 22:00:00-04	7	1	0	0	scheduled	1	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	\N
284	284	2024-2025	2026-03-13	2026-03-13 20:00:00-04	2	7	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	\N
285	285	2024-2025	2026-03-14	2026-03-14 15:00:00-04	8	5	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
286	286	2024-2025	2026-03-15	2026-03-15 13:00:00-04	3	1	0	0	scheduled	1	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
340	258	2025-2026	2026-01-18	2026-01-18 14:00:00-05	4	3	2	1	final	3	00:00	f	f	Capital One Arena | Washington	2026-03-06 06:00:01.126664-05	\N
341	260	2025-2026	2026-01-20	2026-01-20 19:00:00-05	4	5	3	4	final	4	03:31	f	f	Prudential Center | Newark	2026-03-06 06:00:01.126664-05	\N
344	271	2025-2026	2026-02-26	2026-02-26 19:00:00-05	4	3	1	4	final	3	00:00	f	f	Prudential Center | Newark	2026-03-06 06:00:01.126664-05	\N
287	287	2024-2025	2026-03-15	2026-03-15 13:00:00-04	6	7	0	0	scheduled	1	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	\N
292	292	2024-2025	2026-03-19	2026-03-19 19:00:00-04	3	7	0	0	scheduled	1	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	\N
210	337	2024-2025	2025-11-21	2025-11-17 14:00:00-05	2	6	3	2	final	3	00:00	f	f	Verdun Auditorium | Montreal	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
294	294	2024-2025	2026-03-21	2026-03-21 16:00:00-04	1	7	0	0	scheduled	1	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	\N
212	211	2024-2025	2025-11-22	2025-11-21 22:00:00-05	5	4	4	3	final	4	03:24	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
213	212	2024-2025	2025-11-23	2025-11-22 19:00:00-05	1	3	0	4	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
214	213	2024-2025	2025-11-25	2025-11-23 13:00:00-05	3	4	2	0	final	3	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
298	298	2024-2025	2026-03-25	2026-03-25 20:00:00-04	7	4	0	0	scheduled	1	00:00	f	f	Allstate Arena | Chicago	2026-03-05 08:03:26.439115-05	\N
215	214	2024-2025	2025-11-26	2025-11-25 19:00:00-05	5	8	4	0	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
217	216	2024-2025	2025-11-29	2025-11-28 16:00:00-05	4	8	0	3	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
218	217	2024-2025	2025-11-29	2025-11-29 12:00:00-05	6	1	5	1	final	3	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
219	218	2024-2025	2025-12-02	2025-11-29 14:00:00-05	5	2	1	3	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
303	303	2024-2025	2026-03-29	2026-03-29 19:00:00-04	7	5	0	0	scheduled	1	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	\N
220	219	2024-2025	2025-12-03	2025-12-02 19:00:00-05	1	8	1	5	final	3	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
222	221	2024-2025	2025-12-04	2025-12-03 22:00:00-05	6	5	2	1	final	3	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
223	222	2024-2025	2025-12-06	2025-12-04 19:00:00-05	8	4	3	1	final	3	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
224	223	2024-2025	2025-12-07	2025-12-06 15:00:00-05	3	6	4	0	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
309	308	2024-2025	2026-04-04	2026-04-04 20:00:00-04	4	7	0	0	scheduled	1	00:00	f	f	Madison Square Garden | New York	2026-03-05 08:03:26.439115-05	\N
320	320	2024-2025	2026-04-18	2026-04-18 03:00:00-04	7	8	0	0	scheduled	1	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	\N
326	325	2024-2025	2026-04-22	2026-04-22 22:00:00-04	7	2	0	0	scheduled	1	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	\N
288	288	2024-2025	2026-03-15	2026-03-15 16:00:00-04	2	4	0	0	scheduled	1	00:00	f	f	Ball Arena | Denver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
289	289	2024-2025	2026-03-17	2026-03-17 19:00:00-04	1	6	0	0	scheduled	1	00:00	f	f	Agganis Arena | Boston	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
290	290	2024-2025	2026-03-18	2026-03-18 19:00:00-04	2	5	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
291	291	2024-2025	2026-03-18	2026-03-18 22:00:00-04	8	4	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
225	224	2024-2025	2025-12-07	2025-12-07 12:00:00-05	1	2	3	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
226	225	2024-2025	2025-12-16	2025-12-07 15:00:00-05	8	5	4	1	final	3	00:00	f	f	Agganis Arena | Boston	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
227	226	2024-2025	2025-12-17	2025-12-16 22:00:00-05	6	3	2	1	final	3	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
228	227	2024-2025	2025-12-17	2025-12-17 18:30:00-05	4	1	1	2	final	4	00:00	f	f	Scotiabank Centre | Halifax	2026-03-05 08:03:26.439115-05	2026-03-06 06:00:01.126664-05
239	238	2024-2025	2025-12-27	2025-12-27 14:00:00-05	8	2	1	2	final	3	00:00	f	f	Bell Centre | Montréal	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
255	254	2024-2025	2026-01-14	2026-01-13 19:00:00-05	1	6	2	1	final	3	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
258	257	2024-2025	2026-01-18	2026-01-17 15:00:00-05	4	3	2	1	final	4	00:08	f	f	Scotiabank Arena | Toronto	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
280	279	2024-2025	2026-03-08	2026-03-08 12:00:00-04	6	2	0	0	scheduled	1	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
281	280	2024-2025	2026-03-10	2026-03-08 12:00:00-04	8	1	0	0	scheduled	1	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
282	281	2024-2025	2026-04-03	2026-03-10 22:00:00-04	5	3	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
293	293	2024-2025	2026-03-21	2026-03-21 15:00:00-04	8	2	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
295	295	2024-2025	2026-03-22	2026-03-22 19:00:00-04	5	3	0	0	scheduled	1	00:00	f	f	Canada Life Centre | Winnipeg	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
296	296	2024-2025	2026-03-24	2026-03-24 19:00:00-04	1	8	0	0	scheduled	1	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
297	297	2024-2025	2026-03-25	2026-03-25 19:00:00-04	2	3	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
299	299	2024-2025	2026-03-27	2026-03-27 19:00:00-04	6	1	0	0	scheduled	1	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
300	300	2024-2025	2026-03-28	2026-03-28 13:00:00-04	3	4	0	0	scheduled	1	00:00	f	f	Little Caesars Arena | Detroit	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
301	301	2024-2025	2026-03-29	2026-03-29 13:00:00-04	6	8	0	0	scheduled	1	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
302	302	2024-2025	2026-03-29	2026-03-29 16:00:00-04	2	1	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
304	304	2024-2025	2026-04-01	2026-04-01 19:00:00-04	4	2	0	0	scheduled	1	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
305	305	2024-2025	2026-04-01	2026-04-01 19:00:00-04	3	8	0	0	scheduled	1	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
306	306	2024-2025	2026-04-01	2026-04-01 21:30:00-04	5	6	0	0	scheduled	1	00:00	f	f	Scotiabank Saddledome | Calgary	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
307	282	2024-2025	2026-04-04	2026-04-03 19:00:00-04	2	8	0	0	scheduled	1	00:00	f	f	Canadian Tire Centre | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
310	309	2024-2025	2026-04-07	2026-04-07 19:00:00-04	8	1	0	0	scheduled	1	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
312	311	2024-2025	2026-04-11	2026-04-08 19:00:00-04	2	4	0	0	scheduled	1	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
313	312	2024-2025	2026-04-11	2026-04-11 13:00:00-04	6	5	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
314	313	2024-2025	2026-04-11	2026-04-11 14:00:00-04	1	3	0	0	scheduled	1	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
316	315	2024-2025	2026-04-15	2026-04-14 22:00:00-04	4	6	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
317	316	2024-2025	2026-04-15	2026-04-15 19:00:00-04	1	2	0	0	scheduled	1	00:00	f	f	Prudential Center | Newark	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
318	317	2024-2025	2026-04-17	2026-04-15 19:00:00-04	3	1	0	0	scheduled	1	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
319	318	2024-2025	2026-04-18	2026-04-17 19:00:00-04	5	4	0	0	scheduled	1	00:00	f	f	Place Bell | Laval	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
321	319	2024-2025	2026-04-19	2026-04-18 14:00:00-04	2	6	0	0	scheduled	1	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
322	321	2024-2025	2026-04-21	2026-04-19 13:30:00-04	6	4	0	0	scheduled	1	00:00	f	f	Grand Casino Arena | St. Paul	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
323	322	2024-2025	2026-04-21	2026-04-21 19:00:00-04	8	3	0	0	scheduled	1	00:00	f	f	Coca-Cola Coliseum | Toronto	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
324	323	2024-2025	2026-04-22	2026-04-21 22:00:00-04	1	5	0	0	scheduled	1	00:00	f	f	Pacific Coliseum | Vancouver	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
327	328	2024-2025	2026-04-25	2026-04-25 00:00:00-04	8	2	0	0	scheduled	1	00:00	f	f	TD Place | Ottawa	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
328	329	2024-2025	2026-04-25	2026-04-25 00:00:00-04	5	6	0	0	scheduled	1	00:00	f	f	Tsongas Center | Lowell	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
329	326	2024-2025	2026-04-25	2026-04-25 03:00:00-04	1	4	0	0	scheduled	1	00:00	f	f	Climate Pledge Arena | Seattle	2026-03-05 08:03:26.439115-05	2026-03-05 14:26:36.546725-05
\.


--
-- Data for Name: league_invites; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.league_invites (id, league_id, email, invite_code, is_used, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: league_members; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.league_members (id, league_id, user_id, role, joined_at) FROM stdin;
1	1	1	commissioner	2026-03-05 00:14:50.271497-05
2	1	2	member	2026-03-05 00:18:02.629271-05
48	17	3	commissioner	2026-03-07 02:22:59.157574-05
49	17	2	member	2026-03-07 02:22:59.157574-05
50	17	1	member	2026-03-07 02:22:59.157574-05
51	18	1	commissioner	2026-03-07 02:22:59.295063-05
52	18	2	member	2026-03-07 02:22:59.295063-05
54	19	1	commissioner	2026-03-07 02:22:59.386319-05
55	19	2	member	2026-03-07 02:22:59.386319-05
57	20	1	commissioner	2026-03-07 02:22:59.493075-05
58	20	2	member	2026-03-07 02:22:59.493075-05
60	21	1	commissioner	2026-03-07 02:22:59.612623-05
61	21	2	member	2026-03-07 02:22:59.612623-05
63	22	1	commissioner	2026-03-07 02:22:59.75089-05
64	22	2	member	2026-03-07 02:22:59.75089-05
66	23	1	commissioner	2026-03-07 02:22:59.900004-05
67	23	2	member	2026-03-07 02:22:59.900004-05
69	24	1	commissioner	2026-03-07 02:23:00.038423-05
70	24	2	member	2026-03-07 02:23:00.038423-05
72	25	1	commissioner	2026-03-07 02:23:00.171028-05
73	25	2	member	2026-03-07 02:23:00.171028-05
75	26	1	commissioner	2026-03-07 02:23:00.305721-05
76	26	2	member	2026-03-07 02:23:00.305721-05
78	27	1	commissioner	2026-03-07 02:23:00.448045-05
79	27	2	member	2026-03-07 02:23:00.448045-05
81	28	1	commissioner	2026-03-07 02:23:00.584013-05
82	28	2	member	2026-03-07 02:23:00.584013-05
84	29	1	commissioner	2026-03-07 02:23:00.71014-05
85	29	2	member	2026-03-07 02:23:00.71014-05
87	30	1	commissioner	2026-03-07 02:23:00.836232-05
88	30	2	member	2026-03-07 02:23:00.836232-05
90	31	1	commissioner	2026-03-07 02:23:00.949847-05
91	31	2	member	2026-03-07 02:23:00.949847-05
93	32	1	commissioner	2026-03-07 02:23:01.095697-05
94	32	2	member	2026-03-07 02:23:01.095697-05
96	33	1	commissioner	2026-03-07 02:23:01.229375-05
97	33	2	member	2026-03-07 02:23:01.229375-05
99	34	1	commissioner	2026-03-07 02:23:01.341114-05
100	34	2	member	2026-03-07 02:23:01.341114-05
\.


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.leagues (id, name, commissioner_id, invite_code, max_teams, is_public, draft_type, draft_status, draft_order, current_draft_pick, season, roster_size, active_roster_size, ir_slots, waiver_type, trade_deadline, is_active, created_at, updated_at) FROM stdin;
1	PWHL Fantasy League 2025	1	xejKT6DOXBs	8	t	snake	in_progress	[1, 2]	0	2024-2025	20	13	2	rolling	\N	t	2026-03-05 00:14:50.271497-05	2026-03-05 00:18:02.677474-05
17	Eric's Test League	3	J7O_J_v0_pY	4	f	snake	completed	\N	0	2025-2026	23	13	2	rolling	\N	t	2026-03-07 02:22:59.157574-05	\N
18	Sim League (5 teams)	1	Q_iSmoXUYOI	5	f	snake	completed	\N	0	2025-2026	23	13	2	rolling	\N	t	2026-03-07 02:22:59.295063-05	\N
19	Sim League (6 teams)	1	r_nv7wb3GjA	6	f	snake	completed	\N	0	2025-2026	22	13	2	rolling	\N	t	2026-03-07 02:22:59.386319-05	\N
20	Sim League (7 teams)	1	ITgw1UkjWEo	7	f	snake	completed	\N	0	2025-2026	22	13	2	rolling	\N	t	2026-03-07 02:22:59.493075-05	\N
21	Sim League (8 teams)	1	tysqY8AOrIM	8	f	snake	completed	\N	0	2025-2026	22	13	2	rolling	\N	t	2026-03-07 02:22:59.612623-05	\N
22	Sim League (9 teams)	1	ILeoAXiKEu8	9	f	snake	completed	\N	0	2025-2026	19	13	2	rolling	\N	t	2026-03-07 02:22:59.75089-05	\N
23	Sim League (10 teams)	1	ocxjSoKDuBQ	10	f	snake	completed	\N	0	2025-2026	17	13	2	rolling	\N	t	2026-03-07 02:22:59.900004-05	\N
24	Sim League (11 teams)	1	LV_zQLEU--8	11	f	snake	completed	\N	0	2025-2026	15	13	2	rolling	\N	t	2026-03-07 02:23:00.038423-05	\N
25	Sim League (12 teams)	1	e8sSEeaqi8c	12	f	snake	completed	\N	0	2025-2026	14	13	2	rolling	\N	t	2026-03-07 02:23:00.171028-05	\N
26	Sim League (13 teams)	1	WizVbTvk8OE	13	f	snake	completed	\N	0	2025-2026	13	13	2	rolling	\N	t	2026-03-07 02:23:00.305721-05	\N
27	Sim League (14 teams)	1	iEfsKKfSsQY	14	f	snake	completed	\N	0	2025-2026	12	12	2	rolling	\N	t	2026-03-07 02:23:00.448045-05	\N
28	Sim League (15 teams)	1	9Vqp05yKbC8	15	f	snake	completed	\N	0	2025-2026	11	11	2	rolling	\N	t	2026-03-07 02:23:00.584013-05	\N
29	Sim League (16 teams)	1	Q9lCuUDlzkw	16	f	snake	completed	\N	0	2025-2026	11	11	2	rolling	\N	t	2026-03-07 02:23:00.71014-05	\N
30	Sim League (17 teams)	1	xqawgwVYAX0	17	f	snake	completed	\N	0	2025-2026	10	10	2	rolling	\N	t	2026-03-07 02:23:00.836232-05	\N
31	Sim League (18 teams)	1	aAt3t36R_WM	18	f	snake	completed	\N	0	2025-2026	10	10	2	rolling	\N	t	2026-03-07 02:23:00.949847-05	\N
32	Sim League (19 teams)	1	-0LbL-czubg	19	f	snake	completed	\N	0	2025-2026	9	9	2	rolling	\N	t	2026-03-07 02:23:01.095697-05	\N
33	Sim League (20 teams)	1	-VW-sNsZwgc	20	f	snake	completed	\N	0	2025-2026	9	9	2	rolling	\N	t	2026-03-07 02:23:01.229375-05	\N
34	Sim League (21 teams)	1	jxv9lrm2XKE	21	f	snake	completed	\N	0	2025-2026	9	9	2	rolling	\N	t	2026-03-07 02:23:01.341114-05	\N
\.


--
-- Data for Name: news_articles; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.news_articles (id, title, url, thumbnail, fallback_image, date_str, summary, scraped_at, team_logos, player_image_url) FROM stdin;
1	KADIROVA SCORES TWICE, INCLUDING LATE GAME-WINNER TO LEAD OTTAWA TO WIN OVER SEATTLEHighlights and Press Conferences available on Ottawa and Seattle YouTube channelsOTTAWA, ON (March 4, 2026) – Fanuza Kadirova scored twice, including the game-winning goal on the power play with 1:46 remaining in the third period, to lift the Ottawa Ch...Mar 05, 2026	https://www.thepwhl.com/en/news/2026/march/04/kadirova-scores-twice-including-late-game-winner-to-lead-ottawa-to-win-over-seattle	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Kadirova-GWG?_a=DATAg1ZSZAA0	https://source.unsplash.com/800x450/?women+ice+hockey&sig=pwhl-0	2026-03-04	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/240.jpg
28	Indigenous History Celebration | Ottawa Charge - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinAFBVV95cUxObUc0a3I4UWllRDdJVm5ObkpvRHc1OHJxYVZURTRoTnpPLWNpM1JJRWhsZnU3dmFKV2dNeVhtZGtRM1lBOWFhMFNvQ1owTHR3RzAxdEJsVXhaWUVPekRSd1JNUEtOS1JUeEF2U1RyS2xzRW1rV0hET1NlOWFneUFtS3FCNThMMFZlbVg0cVg2TDhJdnZwdHJ5VFJ4RUo?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-Unity-Games-Web-Slates-Indigenous-EN-1200x800_3-2?_a=DATAg1ZSZAA0	\N	2026-03-04T00:54:51+0000	\N	2026-03-05 21:42:26.570448-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
2	MAR. 4: SEATTLE AT OTTAWA PRE-GAME PRIMERWednesday, March 4, 2026 | 7 p.m. ET | TD PlaceWATCH LIVE: TSN 3, TSN.ca, TSN App, FOX 13+, PWHL YouTube & thepwhl.com (U.S. / International), More\nDaniella Ponticelli (Play-by-Play), Cheryl Pounder (Analyst), Kelly Greig (Reporter)SEATTLE TORRENT     ...Mar 04, 2026	https://www.thepwhl.com/en/news/2026/march/04/mar-4-seattle-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_JK15830?_a=DATAg1ZSZAA0	https://source.unsplash.com/800x450/?ice+hockey+player&sig=pwhl-1	2026-03-04	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/199.jpg
69	KIRK BACKSTOPS SCEPTRES TO ROAD WIN OVER GOLDENEYES	https://www.thepwhl.com/en/news/2026/march/01/kirk-backstops-sceptres-to-road-win-over-goldeneyes	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_VAN_-_Mar._1_2026_03?_a=DATAg1ZSZAA0	\N	2026-03-01	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/240x240/211.jpg
73	TORRENT PLACE KNIGHT ON LTIR, SIGN LANGSETH	https://www.thepwhl.com/en/news/2026/february/27/torrent-place-knight-on-ltir-sign-langseth	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Langseth-2526-SOC-SEA-Signed-1200x800?_a=DATAg1ZSZAA0	\N	2026-02-27	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/13.jpg
90	ALINA MÜLLER CAPS OFF RECORD-SETTING PERFORMANCE AT MILANO CORTINA 2026 WITH BRONZE MEDAL-WINNING GOAL	https://www.thepwhl.com/en/news/2026/february/19/alina-muller-caps-record-setting-performance-at-milano-cortina-2026-with-bronze-medal-winning-goal	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Image_1?_a=DATAg1ZSZAA0	\N	2026-02-19T13:33:56-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/15.jpg
7	PWHL TEAMS SELL OUT BOTH MADISON SQUARE GARDEN AND TD GARDEN - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMingFBVV95cUxQZDZEVEVJTHk4YkdQY2RidUFTY2JLclhJUmdnaEdJOG9vX0JVQkpRT1JqYzZaTnF2VllmWVU5TzZPdDBqZUd1aW0zRmliMlJ3ZkNhbjA4YUgwbW1LOFNiRWhCTUVoRktRV3hzZG51elpkc09DRG9iUjlOSmtaZXJmX015eXNwM2t5OUM2M1l3UFFibkdhVGdzZlZodUFHZw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-SOC-GardenSellOut-16x9?_a=DATAg1ZSZAA0	\N	2026-03-05T15:00:00+0000	\N	2026-03-05 21:42:17.090167-05	\N	\N
8	NEW YORK SIRENS SELL OUT MADISON SQUARE GARDEN FOR APRIL 4TH GAME AGAINST SEATTLE TORRENT - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMi7gFBVV95cUxPYWpOc0tkRDVPUHNhTE9SQzdscS1hSTkyV3hFVXdfcGhVWFo1UUtadXl5TUVucGJ5OHhUQS1nRmU2WGZpNTd4TWV3X1dMNmRVdDZ0UHFpaXRnTkNxNzJfNjNnNjFWR0RiRFhqaklUSWlGVUlPQ1hCb1VhVW5qaks1dWFzVWV2OVBZS1AtOWdTRDJBdVFjZzRiS2xaT3E2c1V3SE9oZzl0V3pEV0hIcjY3bC03aHkwX0ZKV3VTbVRVRG9uUzIxZy1Fb2ZZOFNMQmRfTnNwOXdITnlPWXFWVFlLSUs2Q01rWDhfUDNCRVl3?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MSG-SoldOut-NY-1920x1080?_a=DATAg1ZSZAA0	\N	2026-03-05T16:35:29+0000	\N	2026-03-05 21:42:17.090167-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
3	Eight Dates to Watch in the second half of the PWHL SeasonTime to clear your calendar...Mar 04, 2026	https://www.thepwhl.com/en/news/2026/march/04/eight-dates-to-watch-in-the-second-half-of-the-pwhl-season	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/pannek_barnes_for_dates_to_watch?_a=DATAg1ZSZAA0	https://source.unsplash.com/800x450/?hockey+rink&sig=pwhl-2	2026-03-04	\N	2026-03-05 14:27:52.469454-05	\N	\N
6	MAR. 5: BOSTON AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/march/05/mar-5-boston-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/game-208?_a=DATAg1ZSZAA0	\N	2026-03-05	\N	2026-03-05 14:27:52.469454-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
91	MEGAN KELLER'S WINNER GIVES USA 2026 OLYMPIC WINTER GAMES GOLD MEDAL IN OVERTIME THRILLER	https://www.thepwhl.com/en/news/2026/february/19/megan-kellers-winner-gives-usa-2026-olympic-winter-games-gold-medal-in-overtime-thriller	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Image_2?_a=DATAg1ZSZAA0	\N	2026-02-19T16:07:58-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/12.jpg
92	HILARY KNIGHT WRAPS UP OLYMPIC WINTER GAMES CAREER WITH A SECOND GOLD MEDAL AND A HOST OF RECORDS	https://www.thepwhl.com/en/news/2026/february/19/hilary-knight-wraps-up-olympic-winter-games-career-with-second-gold-medal-and-a-host-of-records	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/27f5a5ed-8544-404f-841e-038bb3bb4cff?_a=DATAg1ZSZAA0	\N	2026-02-19	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/13.jpg
100	AERIN FRANKEL BREAKS THE ALL-TIME OLYMPIC RECORD FOR MOST SHUTOUTS IN A SINGLE TOURNAMENT	https://www.thepwhl.com/en/news/2026/february/16/aerin-frankel-breaks-the-all-time-olympic-record-for-most-shutouts-in-a-single-tournament	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/frankel_record_setting_brief_copy?_a=DATAg1ZSZAA0	\N	2026-02-16T15:38:50-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/240x240/6.jpg
102	MARIE-PHILIP POULIN BECOMES WOMEN’S ALL-TIME OLYMPIC WINTER GAMES GOAL-SCORING LEADER	https://www.thepwhl.com/en/news/2026/february/16/marie-philip-poulin-becomes-women-s-all-time-olympic-winter-games-goal-scoring-leader	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/poulin_record_news_story_2-16?_a=DATAg1ZSZAA0	\N	2026-02-16T17:49:37-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/31.jpg
103	ALINA MÜLLER SENDS SWITZERLAND INTO OLYMPIC SEMIFINALS AS THEY KNOCK OFF FINLAND 1-0	https://www.thepwhl.com/en/news/2026/february/14/alina-mullers-second-period-goal-sends-switzerland-into-olympic-semifinals-as-they-knock-off-finland-1-0	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PHOTO-2026-02-14-17-38-02?_a=DATAg1ZSZAA0	\N	2026-02-14T17:26:01-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/15.jpg
110	MARIE-PHILIP POULIN TIES ALL-TIME OLYMPIC WINTER GAMES GOAL-SCORING RECORD	https://www.thepwhl.com/en/news/2026/february/14/marie-philip-poulin-ties-all-time-winter-olympic-games-goal-scoring-record	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MTL_Poulin1-FR-web-header-3x2-ap?_a=DATAg1ZSZAA0	\N	2026-02-14T13:54:24-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/31.jpg
113	Hilary Knight ties U.S. women’s hockey career scoring record at the Winter Olympic Games	https://www.thepwhl.com/en/news/2026/february/11/hilary-knight-ties-us-womens-hockey-career-scoring-record-at-winter-olympic-games	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/knight_record_try_3?_a=DATAg1ZSZAA0	\N	2026-02-11	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/13.jpg
115	Abby Boreen carves out key role for herself on the Victoire even while doubling as a full-time student	https://www.thepwhl.com/en/news/2025/may/06/abby-boreen-is-one-of-the-most-important-players-on-the-victoire-even-as-a-full-time-student	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/BorrenAbigail_3416?_a=DATAg1ZSZAA0	\N	2025-05-06T11:39:59-04:00	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/60x60/114.jpg
120	Boston Fleet's Alina Müller becomes Switzerland's All-Time Olympic Goal-Scoring Leader	https://www.thepwhl.com/en/news/2026/february/10/boston-fleets-alina-muller-becomes-switzerlands-all-time-olympic-goal-scoring-leader	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/mueller_bos_olympics_2?_a=DATAg1ZSZAA0	\N	2026-02-10	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	https://assets.leaguestat.com/pwhl/60x60/15.jpg
124	CANADA’S FOUR-GOAL FIRST PERIOD POWERS WIN OVER CZECHIA DESPITE INJURY TO CAPTAIN MARIE-PHILIP POULIN	https://www.thepwhl.com/en/news/2026/february/09/canadas-four-goal-first-period-powers-win-over-czechia-despite-injury-to-captain-marie-philip-poulin	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/can_czechia_2-10_hp?_a=DATAg1ZSZAA0	\N	2026-02-09T17:42:16-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/31.jpg
127	5 Questions With: Brianne Jenner	https://www.thepwhl.com/en/news/2024/march/15/5-questions-with-brianne-jenner	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Content/Migration/967db7fcb6cac6302a45fa9480c8ab535240660f7862c54725f78fea42f86e7c?_a=DATAg1ZSZAA0	\N	2024-03-15T14:29:11-04:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/58.jpg
131	Natálie Mlýnková becomes first Czech women's hockey player to score three goals at the Olympics	https://www.thepwhl.com/en/news/2026/february/09/natalie-mlynkova-becomes-first-czech-womens-hockey-player-to-score-three-goals-at-olympics	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Mlynokova_record?_a=DATAg1ZSZAA0	\N	2026-02-09	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/274.jpg
133	NINA JOBST-SMITH'S OT WINNER LIFTS GERMANY PAST FRANCE 2-1	https://www.thepwhl.com/en/news/2026/february/09/nina-jobst-smiths-ot-winner-lifts-germany-past-france-2-1	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-20260209-GERvsFRA-1203?_a=DATAg1ZSZAA0	\N	2026-02-09T15:45:25-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/305.jpg
137	ALINA MÜLLER AND SWITZERLAND PULL OFF THE COMEBACK WIN IN THE SHOOTOUT, TOPPING CZECHIA 4–3	https://www.thepwhl.com/en/news/2026/february/06/alina-muller-and-switzerland-pull-off-the-comeback-win-in-the-shootout-topping-czechia-4-3	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/5489c406-bb81-44a9-aca1-5258efea891b?_a=DATAg1ZSZAA0	\N	2026-02-06T12:58:32-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/15.jpg
138	GERMANY BOUNCES BACK TO BEAT JAPAN 5–2 THANKS TO A FOUR-POINT OUTBURST FROM LAURA KLUGE	https://www.thepwhl.com/en/news/2026/february/07/germany-bounces-back-to-beat-japan-5-2-thanks-to-a-four-point-outburst-from-laura-kluge	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-20260207-GERvsJPN-8447?_a=DATAg1ZSZAA0	\N	2026-02-07T13:47:01-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/212.jpg
151	Toronto Sceptres Anna Kjellbin and Sara Hjalmarsson named to Team Sweden's leadership group for Milano Cortina 2026	https://www.thepwhl.com/en/news/2026/february/03/toronto-sceptres-anna-kjellbin-and-sara-hjalmarsson-named-to-team-swedens-leadership-group-for-milano-cortina-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-Sceptres-sweden?_a=DATAg1ZSZAA0	\N	2026-02-03	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/60x60/200.jpg
153	PWHL CELEBRATES BLACK HISTORY WITH GAMES AND ACTIVATIONS ACROSS THE LEAGUE	https://www.thepwhl.com/en/news/2026/february/2/pwhl-celebrates-black-history-with-games-and-activations-across-the-league	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/BHM_-_Tiles_-_Header?_a=DATAg1ZSZAA0	\N	2026-02-02	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/251.jpg
154	2026 U.S. Olympic Hockey names Hilary Knight, Alex Carpenter and Megan Keller to leadership group	https://www.thepwhl.com/en/news/2026/february/02/2026-us-olympic-hockey-names-hilary-knight-alex-carpenter-and-megan-keller-to-leadership-group	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/OLY-PWHL-Captains-Knight-1200x800?_a=DATAg1ZSZAA0	\N	2026-02-02	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/12.jpg
156	DESBIENS BACKSTOPS VICTOIRE TO SHUTOUT WIN OVER SCEPTRES BEFORE THE BREAK	https://www.thepwhl.com/en/news/2026/january/28/desbiens-backstops-victoire-to-shutout-win-over-sceptres-before-the-break	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20260128-TORvMTL-LCA02675?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/240x240/28.jpg
157	LESLIE SCORES TWICE TO LEAD OTTAWA TO LAST-MINUTE VICTORY AGAINST SEATTLE	https://www.thepwhl.com/en/news/2026/january/28/leslie-scores-twice-to-lead-ottawa-to-last-minute-victory-against-seattle	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Jenner-win-bobblehead-night?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/72.jpg
166	PWHL VANCOUVER SIGNS SOPHIE JAQUES TO THREE-YEAR CONTRACT	https://www.thepwhl.com/en/news/2025/june/04/pwhl-vancouver-signs-sophie-jaques-to-three-year-contract	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/VAN-PlayerSign-1200x800-SophieJaques?_a=DATAg1ZSZAA0	\N	2026-01-27	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/60x60/11.jpg
175	SANDRA ABSTREITER TO REMAIN IN MONTRÉAL	https://www.thepwhl.com/en/news/2025/june/19/sandra-abstreiter-de-retour-montreal	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MTL_-_Abstreiter-_16x9?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/240x240/48.jpg
180	HEISE’S OT HEROICS LIFT MINNESOTA OVER VANCOUVER IN EDMONTON	https://www.thepwhl.com/en/news/2025/december/27/heises-ot-heroics-lift-minnesota-over-vancouver-in-edmonton	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/credit_pwhl_-_min_at_van_-_dec._27_2025_18?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/60x60/21.jpg
184	TORRENT DEFENDER ANETA TEJRALOVÁ NAMED TO 2026 CZECHIA OLYMPIC ROSTER	https://www.thepwhl.com/en/news/2026/january/08/torrent-defender-aneta-tejralova-named-to-2026-czechia-olympic-roster	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/3d2da63e-ee27-4ceb-bc57-55e7c38f67c5_1LL0045?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/62.jpg
193	POULIN LEADS VICTOIRE TO SECOND OVERTIME WIN AGAINST FROST	https://www.thepwhl.com/en/news/2026/january/21/poulin-leads-victoire-to-second-overtime-win-against-frost	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MTL_at_MIN_-_Jan._21_2026_14?_a=DATAg1ZSZAA0	\N	2026-01-21	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/60x60/31.jpg
205	WATTS’ OVERTIME GOAL GIVES SCEPTRES 2-1 WIN OVER GOLDENEYES IN BATTLE ON BAY STREET	https://www.thepwhl.com/en/news/2026/january/17/watts-overtime-goal-gives-sceptres-2-1-win-over-goldeneyes-in-battle-on-bay-street	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_VAN_at_TOR_-_Jan._17_2026_08?_a=DATAg1ZSZAA0	\N	2026-01-17	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/60x60/63.jpg
219	DESBIENS SHUTS OUT GOLDENEYES IN QUÉBEC CITY TO LEAD VICTOIRE TO NARROW 1-0 WIN	https://www.thepwhl.com/en/news/2026/january/11/desbiens-shuts-out-goldeneyes-in-quebec-city-to-lead-victoire-to-narrow-1-0-win	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_VAN_at_MTL_QC_-_Jan._11_2026_05?_a=DATAg1ZSZAA0	\N	2026-01-11	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/240x240/28.jpg
235	DANIEL, MILLER LEAD GOLDENEYES TO COMEBACK WIN AGAINST FIRST-PLACE FLEET	https://www.thepwhl.com/en/news/2026/january/03/daniel-miller-lead-goldeneyes-to-comeback-win-against-first-place-fleet	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/010326-AMF-3670?_a=DATAg1ZSZAA0	\N	2026-01-03	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/60x60/209.jpg
284	MASCHMEYER SHUTS OUT SIRENS TO RECORD GOLDENEYES’ FIRST-EVER WIN IN REGULATION	https://www.thepwhl.com/en/news/2025/december/06/maschmeyer-shuts-out-sirens-to-record-goldeneyes-first-ever-win-in-regulation	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_NY_at_VAN_-_Dec._6_202515?_a=DATAg1ZSZAA0	\N	2025-12-06	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/240x240/59.jpg
292	FRANKEL SHUTS OUT VANCOUVER, BOSTON STAYS UNDEFEATED	https://www.thepwhl.com/en/news/2025/december/03/frankel-shuts-out-vancouver-boston-stays-undefeated	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Image_32?_a=DATAg1ZSZAA0	\N	2025-12-03	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/240x240/6.jpg
308	JENNER DELIVERS FOUR POINTS IN CHARGE’S 5-1 WIN OVER GOLDENEYES	https://www.thepwhl.com/en/news/2025/november/26/jenner-delivers-four-points-in-charge-s-5-1-win-over-goldeneyes	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Jenner-goal-first-season?_a=DATAg1ZSZAA0	\N	2025-11-26	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	https://assets.leaguestat.com/pwhl/60x60/58.jpg
336	PWHL MEDIA HOUSE ANNOUNCES SEASON THREE OF JOCKS IN JILLS PRESENTED BY SHARKNINJA, HOSTED BY TESSA BONHOMME AND JULIA TOCHERI	https://www.thepwhl.com/en/news/2025/october/23/pwhl-media-house-announces-season-three-of-jocks-in-jills-presented-by-sharkninja-hosted-by-tessa-bonhomme-and-julia-tocheri	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/JiJ_-_S3-_Cover_-_16x9?_a=DATAg1ZSZAA0	\N	2025-10-23	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/217.jpg
341	MINNESOTA FROST SIGN FORWARD BRITTA CURL-SALEMME TO A TWO-YEAR CONTRACT EXTENSION	https://www.thepwhl.com/en/news/2025/october/06/minnesota-frost-sign-forward-britta-curl-salemme-to-a-two-year-contract-extension	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Brittta_Curl-Salemme?_a=DATAg1ZSZAA0	\N	2025-10-06T10:04:42-04:00	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	https://assets.leaguestat.com/pwhl/60x60/189.jpg
35	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 18 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxPQlF6M3ZLS1laT2o3SnozU3V3SWxTUU5VS01YblJSWXBKQXpjNnNVQW0ya1pZNkU3WWs3N0Y0RV9qZHZkQ3ZaTHBHTVhZcEZBQ0NkcGNsUFFVQndZVXpxOWZpVHNCNE43TjRMdDBraXI1Z2lpejZlM2V3VlBYbVdWY2luUVl4SHZtbXVuaXdpck90NzFhWEI5RTE4SWNEWWs?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CAN_USA_Faceoff?_a=DATAg1ZSZAA0	\N	2026-02-18T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	\N	\N
38	Olympics women’s hockey must-watches: Ranking the best forwards and defenders in Milan - The Athletic - The New York Times	https://news.google.com/rss/articles/CBMirAFBVV95cUxPMmJZWTNvV2NueFdrVHJIbDZ2dnZHcXB4V2dPaFZNZV94OUplZmhYZTlua0M1TTRrWmZpcnl6UENvSmFNYTZBMnR1UFBLWXZQTi1zR2l3OXVsTm1WRzhaWHJWSW1GQlRORG9rXzhtNlV1TjkwMXN3dGFaN3ItU3p0MnR5OGMtUUpuN0V3YmVXWkcxSTRfS1lUb0xwUkZyWUloNGdVSjE4QjNibFR2?oc=5	https://static01.nyt.com/athletic/uploads/wp/2026/02/04055511/0203-whock-scaled.jpg?width=1200&height=630&fit=cover	\N	2026-02-10T08:00:00+0000	\N	2026-03-05 21:43:00.146896-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
52	Ultimate Watch Parties Bring PWHL Fans Closer to the Olympic Action | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMitgFBVV95cUxNUFJ1a2ZUVk90ZUFUeEU3WFBBZExSYXdxeGx3eW11RVpEdlhDX3hiejZfcUpUX01ZVnFfanpUM215TzR5TzJ2WWQ5OWlzWUMzSFhkNjdDdGhKT1N1aTF3MGRHQ1E1SFRGSk1HYUVNLUR4dXlZc1NZM0phbVc4ZjUyVXFoT05UN2NTelR1YlBOekIyRTgtOGI4cHJGWVJLc3F4OTZYclVrYklwX01TRnYxcWVMaFotQQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/sirens_2-10_watch_party_fans?_a=DATAg1ZSZAA0	\N	2026-02-11T08:00:00+0000	\N	2026-03-05 21:43:00.146896-05	\N	\N
51	Capital One Arena Hosts Record-Setting PWHL Game, Highest-Attended In-Arena Game in U.S. Women’s Hockey History | Washington Capitals - NHL.com	https://news.google.com/rss/articles/CBMi2wFBVV95cUxOVGJEYUotRUdKd1o1QlpSbjRDRExLNTVtMEFBNXdjcmxqbm42UkFSc0R1V3d0VVk1RHY1b01XU0tuM2dIa1hkNkZHU1EtbjZiU1BzWmNVb2FIaDVqbjhSX1hYQU1LVC0xalFpN3lUXzg4dGo5LUxoZ2Yta2xYeHhUOXRIaVgzeWhxNWZnSHM0UGlsaTVfVkJ0clJSdWw5eTdadE8xeTd6QktIa0NXYVVwVjdfQ2FNcXRPVXVkbWdSUTM0RDZ2bnNwNEcyQ00tS21Tbm4yNmFDT0lUZ3M?oc=5	https://media.d3.nhle.com/image/private/t_ratio16_9-size50/prd/roccbxgsc07ixvdfkk8m.png	\N	2026-01-18T08:00:00+0000	\N	2026-03-05 21:43:09.505869-05	\N	\N
50	TWENTY-THREE PWHL PLAYERS SELECTED FOR CANADIAN OLYMPIC WOMEN’S ICE HOCKEY TEAM - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMixAFBVV95cUxPR0tLRnA1U2lGWjBFb3VGalFVLUl5eUdxa2FQQkg5dFpNTjc0R1lZS1J1Ukk4NjNsejd0a25McVM1RDd6cjdXbG8zNEgtZVVyeWlkREhQY2dybXVIV3l3N0JxRTZIMHJpVnNkaVVtWEhzWm1UR0Vpc2ZGaWdZT3JjNnh6TWxkWEpjRDEwNjUwaDNFQ1pESjYzRGhwTVlpN09kN2d4b21peG9nNzEtVzZSa1NBVHVLcGJoeTIySW5pYndnSFEt?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/09-25-2025_PWHL_001_Marie-Phillip_Poulin_00251?_a=DATAg1ZSZAA0	\N	2026-01-09T08:00:00+0000	\N	2026-03-05 21:43:18.945319-05	\N	\N
46	PWHL reaping the benefits of Olympic women's tournament - Reuters	https://news.google.com/rss/articles/CBMilAFBVV95cUxQaEhFcmFIdE8zMUVseGZnUUVLd2ZmR1Jycm5jdmp4NTNmYk1DWTl3RGotdURod1dnWm0wUVhuYmdzdmdFNGp3UTNrWXNRNEtVOEdaTzJXcEtVdUM3VUZOczhSbXBMeTc5Qm5SWWR2Szdfc2JZdzVFM1dzQ2dCMDJCekpVVjRmc2FHYkhYWHprWkhfU1NY?oc=5	https://lh3.googleusercontent.com/J6_coFbogxhRI9iM864NL_liGXvsQp2AupsKei7z0cNNfDvGUmWUy20nuUhkREQyrpY4bEeIBuc=s0-w300	\N	2026-02-26T08:00:00+0000	\N	2026-03-07 01:29:45.101981-05	\N	\N
55	PWHL looking to take advantage of Olympics to grow women’s hockey - Sports Business Journal	https://news.google.com/rss/articles/CBMiwAFBVV95cUxPN0p2ODMwRWEzZFliTFNSTWk0aEhHSUF1WkdUd2lPSWZ5OVE2LWdLRm8wUGZFTDhXUHBDQ3pzNGU0clNDdkJLSEdsaU1uQXpBTjBKY09sQlMzbmxOR0drTDhlSTdiZ0h1eW5qaXdtOUJFZWFGS1BpWkRwZDRPNE1PUmoyR2lxTXVrTlAwT1FJdnppZDhhamo0THhFa2tOZkZvTXhZMGlRMFZHOXhPTy1NcFdYSE5zZll2TGIwUjZQOEE?oc=5	https://www.sportsbusinessjournal.com/resizer/v2/ESQZDQFX2VC2LCN63NIUPOAYHQ.jpg?smart=true&auth=aaa0a7a8fbebe8708b63c694dd18e73401da779aae895f4c5a86603aa832d470&width=1200&height=630	\N	2026-02-19T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	\N	\N
343	BOSTON FLEET SELL OUT APRIL 11 GAME AT TD GARDEN - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMisAFBVV95cUxNa2F1X0huRUloOVpmWlhQcjRpREw4aEdhRDJJcnA2QWJER2E4em9pVURJZzFpR1R4YmJIdVBrdmYzcWRZZ2xMSW1MbE94ZDB5R0wxQjZrRHItRFlRb2hwc1JPdGpkOW53c3JMUi1zQndmU1c3ZjdVaGstWlJDbVoya3ZQaGczNHRUaVVpampHTW1PMHhGSDdiTFRQaHJvQXJlc0dMMktoOXVTNGtobDBEdQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/TDGarden-SoldOut-16x9?_a=DATAg1ZSZAA0	\N	2026-03-05T15:00:00+0000	\N	2026-03-05 21:42:17.090167-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	\N
347	Seattle Torrent at Ottawa Charge - March 4, 2026 - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMijwFBVV95cUxQbFk1SjVFeGJnQV9zTHRxNXpycVlkeUphYWFvZlUtajNpeXZjUmMteFpGUzZoNnlKSmJPVFNobnFFeVNtdVlrNjFFeld4eE0yUmpTWV9nRjQwa2hOR20xVVJfXzRmbVE1Z0E4Z3dPNE14NmdFSURLQWFiMmpWd3M2T2lzWGtuWFdMalhydnhwVQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Brightcove/videos/images/PWHL-Seattle-Torrent-at-Ottawa-Charge-March-4-2026-8mRbXdIxoEU?_a=DATAg1ZSZAA0	\N	2026-03-04T12:43:11+0000	\N	2026-03-05 21:42:22.182656-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
348	MAR. 4: SEATTLE AT OTTAWA PRE-GAME PRIMER - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMijgFBVV95cUxOVlE0MVN0VUJybmRpSGhsT3VBR3dfMlNRejJWWkw0cEZ0OEFfS0t2N2c2MTF0RW1kVDUwNC1rTndpSjIzSUZ4aEtmM214RkY3ZkZvaEkxdmdlVi1ILWdaR1F2aHRDcVdJempwZm13V2lCS3gzVnN4VV9qd1dUSWEtMVZLYUJKMUxwUndJMWp3?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_JK15830?_a=DATAg1ZSZAA0	\N	2026-03-04T19:10:31+0000	\N	2026-03-05 21:42:22.182656-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
12	PWHL WEEKLY NOTEBOOK: MAR. 2, 2026 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMigwFBVV95cUxNTGZpS0wyeWJQdXY3cmZOeFVqYjQ4NlpUdTJBcFpyV0ozTTJxOG5CNFROVWIzSnpxRmxGMk1aZ3ZBNW9PZEVUVWszZ2Uzb2c4RWxRZUpBVWZMT0Z2VFRjLTVzTDAyWC1IM25YSGh2My0tb0wwbXgyRHNsdHFGbnhYS1h3OA?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/260227_Torrent_vSceptres6246?_a=DATAg1ZSZAA0	\N	2026-03-02T23:34:38+0000	\N	2026-03-05 21:42:31.279555-05	\N	\N
59	PWHL will help grow women's hockey, not diminish US-Canada rivalry - USA Today	https://news.google.com/rss/articles/CBMixwFBVV95cUxPeUdxTVZscFhWT3pOVTJxYTJIbGQ4MEJFcWo3RVNlYUd6cHlIQ21zT2Vfa1NyZU9pZG42MEZsa1dxWUV0V040MnpGXy10OU5JZmsxQzNZaEYwWWswcnJYVm1kZV81Q3hnOTE3YmYwbVljRXFBOUpDS2hTNVBQRGpqSWhUZXJyUTFINGwycGhndFNSTmZ6aUV4eGgtdk1HLVd2czlWT0t6R2JOYmpRYnd0TmZONVlYcTBYdHYxLWRlRDh2NjFtT29z?oc=5	https://www.usatoday.com/gcdn/authoring/authoring-images/2026/02/10/USAT/88598236007-usatsi-28194543.jpg?crop=4147,2333,x650,y739&width=3200&height=1801&format=pjpg&auto=webp	\N	2026-02-10T08:00:00+0000	\N	2026-03-05 21:43:00.146896-05	\N	\N
62	THE ULTIMATE AWAY GAME: PWHL SET FOR UNPRECEDENTED OLYMPIC IMPACT - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiswFBVV95cUxPR0lBdUJQUXE1MzUyX0ZJeXV1Smg3M3Q4VlFQb2lldG1FMzJIUi1MTEMyMndQSTQ2OFhQY1Q5QjFHZXhaVm45cFVrZWhaS2ROZEJVbDZ0SzFCRHl6elRvTmFEdF9sN1h1R3dsWEZ0anBaOThCVktnY1k3cGloTWFDN3ZqX0Q2dzFpcVlHUDZ1UlVEcDA5N0dKV0d0bXpkVWZGcWV1aHcyRTFKdFp5d3REUmZhcw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1200x800-PWHLOLYGAMES?_a=DATAg1ZSZAA0	\N	2026-02-03T08:00:00+0000	\N	2026-03-05 21:43:09.505869-05	\N	\N
56	PWHL EXPANDS TAKEOVER TOUR FOR 2025-26 SEASON, FEATURING 16 NEUTRAL-SITE GAMES - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMixAFBVV95cUxPUkZ4cWhVaGU3N3JHMmVDejB4a3pUel9TVDFCSW5wdkN5ZENPZnJqQTRtU0JvQnpsVTJmbzRYd0hZUWp6ajA4UDhzTWI1ZHlKQ2RmdUJBQzFtUXJENG83Q2ZUYnlyQlJYbnpUdklQSTMzUGhtZEhlM1I0aVYyckFsTWUwSXhTMHZHcmhkTHZpUnBab0tXd3k1VmthLUZPRzNNQlplb3VWZnJtNDRERDhRajU2ODdhRUVEMEtTZEZoQVRhbXNz?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2025-26_Takeover_Tour_-_Announcement_-_1200x800?_a=DATAg1ZSZAA0	\N	2025-11-10T08:00:00+0000	\N	2026-03-05 21:43:18.945319-05	\N	\N
359	PWHL Sells Out Madison Square Garden As Women’s Hockey Interest Grows - Forbes	https://news.google.com/rss/articles/CBMivgFBVV95cUxOR0o4LTNLaXNNaVJzXzNvZDg4ZU5CUWpId29uQVB4SG5lMW53eTViRnMyaXRUcTk4cjZxMkUtZW1MeVhRYmo1NjNzbkVadndFOW11U0RaU1EwUW50aWJYVHVjTkR1UGpJVTlhbF9vbjBRc25ERkhmRHo0WTRrU21Yb2ZZMlVQQlMxT0xaUGVlMWpQTlB0ZkdNTWlMYnE5dEpPc2R0M2RYS2dxWkE4MC1zbXF2LTZDMHRWWFo5ekNB?oc=5	https://lh3.googleusercontent.com/J6_coFbogxhRI9iM864NL_liGXvsQp2AupsKei7z0cNNfDvGUmWUy20nuUhkREQyrpY4bEeIBuc=s0-w300	\N	2026-03-05T22:30:51+0000	\N	2026-03-06 17:29:46.887909-05	\N	\N
11	MAR. 3: MONTRÉAL AT TORONTO PRE-GAME PRIMER - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMikAFBVV95cUxPT0I5QXdxRU5pNHhOQXVUN1k4T1FSNkVZLVBlbUUyQ0UyRmVmNTFtdHRLcFVybjMxV0NJdjBTMHRsVTd6dWY5V1JjMmhVNnBmUGlFRXpfWVlLWVM2eU5tV3ZHZ1o1OEJVOF96UzBCYTNKQllDa2NvX08zeUR2SC1tT3ZCaTlZbEwwN2dHOWx2RHE?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20251227-tor-mtl-ABC00751?_a=DATAg1ZSZAA0	\N	2026-03-03T18:10:26+0000	\N	2026-03-05 21:42:26.570448-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
19	GOLDENEYES SIGN BRIANNA BROOKS TO 10-DAY CONTRACT - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMivwFBVV95cUxQUEJFTnZlVGJRaXFBdVhBeDVGU3NFQnNPcUs3SzVRVlliZ0thYUladmdTSnJWYWxUZHYydTRKcTVCX3doaUx2VHlXM09rYVVoNndfSm1GMXFiM0VqcUNQS00xcEU4aHY0c2Zka2U4WEZlUHVGSy1xcmFIb3hLQTBTVDNqUUI4bUpSbHBnWDBBLXIyVUlXTlBBaU84ZTF0dW9NdUEtNklfS1ZtelR4VGRrZ3E4akczVmhXb2hLeFN5cw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/roster_updares?_a=DATAg1ZSZAA0	\N	2026-03-01T17:35:37+0000	\N	2026-03-05 21:42:31.279555-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/300.jpg
360	Guess the Toronto Sceptres Player - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMipAFBVV95cUxQaWFmUUJ0NUVHeHJ4MEpBU3VDSEdJaTg2SnAybjFIOS1ZcnJDT3l1U2ViMmdHeVpVUU9NNjctdi1IMUtJRkotRHk0eFNhTnhEcndlR3B6NTJjaDJlRG5UbHJRT01yd3dqaWZNbVhVOWc2Uzc1c0ZPRGNZdjYwVk1yU1JTSWtJUk1LMEJlcTQ0dzVjdTVuNThvVWN3dHpaMWNEcFdFYg?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/EmmaWoods-blurred_page_pre?_a=DATAg1ZSZAA0	\N	2026-03-05T22:29:00+0000	\N	2026-03-05 21:42:13.093616-05	["https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
10	PWHL Officially Sells Out New York's Madison Square Garden And Boston's TD Garden - The Hockey News	https://news.google.com/rss/articles/CBMiuwFBVV95cUxOM2tEbUNOdkVrQUJvcG1jOU1ISEZSd00yUjdSQnRSSjY0QzhPSzd4cjl3d0RZVlpEcFNJdnBIQk9FUV9oaUQ4dXE1T2JQTjlUcC1LazdNVndRSGxNYmNkYTFwQXFyOHpSdm4wRTZta3dtNEoyQzc4dXlUSzJyWU9JWGFvOFBnOS1vc3lUamx1YmhnMkR5NlNCTE00SExrVVFfM044blRsM0lHQnJpMnZIdUk5Y1dFRGRxc3c4?oc=5	https://deweb-519a7.b-cdn.net/post-images/67ae9c69-9f77-426d-b42b-bcf0e54628cf.jpeg	\N	2026-03-05T16:31:22+0000	\N	2026-03-05 21:42:17.090167-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
13	Boston Fleet at New York Sirens - March 5, 2026	https://news.google.com/rss/articles/CBMijgFBVV95cUxPYXM4QVUzWDZMRHp1djJwem81bEp3eTE3YjdhUGhYWE85MWcxRS1QdDBhNm1wTmx0U08tY29mRzBQYTdJRllMTmtTSU1fblc4bU5KNkg4RUVJQW91OERjdVhoaU5DNjdvY19CTHJmR0k5ZjhMU1ZzNkU2bmExTXlVMnNGVmtraUt1VEd0SEx3?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Brightcove/videos/images/PWHL-Boston-Fleet-at-New-York-Sirens-March-5-2026-w0wMPXcVZAA?_a=DATAg1ZSZAA0	\N	2026-03-04T19:24:05+0000	\N	2026-03-05 21:42:22.182656-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
361	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - News-Times	https://news.google.com/rss/articles/CBMioAFBVV95cUxPcVNnbWhOcklFOWpPR3loTGF1MUR0S3FyUHVGdDhxY0tWbjBJRUtQZk1qRXdsR1FmaEx5aVl5eHYzQmlNLURnX203NmtUVXFCRGJwNF9LRl96SnVVQm1DWFEyLVRySXFXNy1jZEJKWk0xaTJUTnItM29rTjFLbDlZNDJnSXVWd2FNNGZVTlVpSDZPTFl0NHRzaU0wbVUySjFi?oc=5	\N	\N	2026-03-05T20:43:54+0000	\N	2026-03-06 09:45:10.457739-05	\N	\N
14	Guess the Seattle Torrent Player - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiogFBVV95cUxPOWlHa0dwYm80bDNTQUJ4ek9ISWlCQ0ppUzliZ1hMaXdSLXdUaFd2ZnlVeVNfUkZ0SlhPZjVEbm1saUcyNVRoLV9CVjZxVXB3RGlPem5KVUpKRF9FNHFSZkM5NHEyaGpiejQ4ek4wS1lFdEh1UVJjU1NndmFvLURtU0o5a0MxMjhSUGJtRnpGX2tfRGs2bUFnNzBGUU1CUUE5Q0E?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CorinneSchroeder-blurred_page_pre?_a=DATAg1ZSZAA0	\N	2026-03-04T04:47:15+0000	\N	2026-03-05 21:42:26.570448-05	["https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
16	MAR. 1: TORONTO AT VANCOUVER PRE-GAME PRIMER	https://news.google.com/rss/articles/CBMikgFBVV95cUxOVkh6d3pRdHJiYm96ck83RUZrdHRyT2ZHcDZiMWVyaGtsQlF3ZXlLYXVQLUVVdGtWM1N2Tlk4alBVRWpPRFExNnZ3a09TYVVLZzZzOG5nUi0zb0IycHFUeW1Fd1dwRHhJQ0ptSURWQmphZXFvRExUdDNMN3pSQzZ3MUZpdjc0TnNvaXRHT1pHdVVQQQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_VAN_-_Jan._22_2026_12?_a=DATAg1ZSZAA0	\N	2026-03-01T17:20:37+0000	\N	2026-03-05 21:42:31.279555-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
17	TORRENT PLACE KNIGHT ON LTIR, SIGN LANGSETH - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMilgFBVV95cUxPbmJXUS15RlRGR05DSkdhSHd3UUV6VGI5MnJnZVVudE43TVg1QUxzSmIzbGVFNEdxRVpUSEhIckJnVkZfNTgzMHM0TUVqRHFkWnJWRjVCWGJPV3ZncUtUS29oS2I3SEk4V1FJRElvdVA4M1JrNkJybnJNRWZkbTF5N1FwdTVfN1ZCZzdWdllVVGZKZmt4d0E?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Langseth-2526-SOC-SEA-Signed-1200x800?_a=DATAg1ZSZAA0	\N	2026-02-28T00:40:04+0000	\N	2026-03-05 21:42:41.487879-05	["https://assets.leaguestat.com/pwhl/logos/7.png"]	https://assets.leaguestat.com/pwhl/60x60/13.jpg
362	PWHL game at MSG set to break US attendance record for women's hockey - USA Today	https://news.google.com/rss/articles/CBMiywFBVV95cUxOcGtYdzU1V1c4Q1cyLTlwczM1Wmk4MEFsSUtzd3U1bkxOOEQxSjZpN3ZzdTZDY3phX19wX2tIdUNqUC1YMWhmUnR2b3hSV0dYZEpyeEVueGxxMkRDeFRvT1IwSEk2WUVmWUEzZ1EydldkUm14VEFMcXFfNWhmVXNvU0hYVGhxaUtaTS1ldDhSUWMycklnMk8ydlVYcDZ5Rm1hRTRVaXVzYlZqYkt1MTlvbXdOUV9LQTJTaUxpRl9EU25mSVdQMTF1djRMYw?oc=5	https://www.usatoday.com/gcdn/authoring/authoring-images/2026/03/05/USAT/89007343007-torrent.jpg?crop=4971,2796,x0,y0&width=3200&height=1800&format=pjpg&auto=webp	\N	2026-03-05T23:10:00+0000	\N	2026-03-05 21:42:13.093616-05	\N	\N
363	PWHL game at MSG set to break US attendance record for women's hockey - Yahoo Sports UK	https://news.google.com/rss/articles/CBMie0FVX3lxTE5uUmc2S0NpODQ3c2xrd0JMbEY4RlNVTTFtSGRzbm5aTl9SSkgzc2pMT3VTNlZPaHNYWHFreUlKWjJKQzd0TWNmcC1fMjZtbW1qeGVfNFo3Sm9xczJCXzQxbjJWYk9PZHZpamJqQUczSEJEM0ZjVWhxOFlJOA?oc=5	https://s.yimg.com/ny/api/res/1.2/JdluNREoPlQfWsZZFAKDkg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA7Y2Y9d2VicA--/https://media.zenfs.com/en/usa_today_sports_articles_558/e8a23ff05a8a8311d98135bb0ae27745	\N	2026-03-05T23:10:48+0000	\N	2026-03-05 21:42:13.093616-05	\N	\N
365	Ottawa Charge overcomes ice troubles, lost lead, to jump into PWHL playoff spot - Ottawa Citizen	https://news.google.com/rss/articles/CBMivwFBVV95cUxQUXZ2VW1Cem9BMkRNWU1JbmJPMGhmcm0yNS01YnA3T1NuWUZncGRlNnhzNk0zdkdrdV96YjMzdldDY1cxOUVpblNNX0VIM0VGX0JIbmQzTkhhR0NReFAxem1sNHRzUkpLa3RNT0YwRjlWelF6eEd1MG9ZanRzYVI5N2hCSnRIc01FeUc3VU12S2VMeE1rdUt1QnJOTXBieVJlS1JuYU14c1NLUk9kU2hldzF0dDVadE1HRThYNkc0aw?oc=5	https://smartcdn.gprod.postmedia.digital/ottawacitizen/wp-content/uploads/2026/03/CP175920856-e1772682792378.jpg	\N	2026-03-05T05:11:30+0000	\N	2026-03-05 21:42:22.182656-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
367	B.C. hockey star with PWHL potential aims for national title with UBC - coastmountainnews.com	https://news.google.com/rss/articles/CBMirwFBVV95cUxPR1BxaDd5Y0h2R3U1R1R3LXdzdHpXanVodThPaVhlQnRGOFJ6WlZIaHE5RmRCS195SVFtZGthempTRDRUV1c0dl9WcVRWbFNoNmYyRTlRdXJNR1JaLWlkUGNOejFna0VjSmJKUmx4dDc5S2liM3JmcWpvTGx5Zjc2THJOZmF5ODljcVNUUW1ibjBsQVJHenZ3c1RwRWY0V3NkRGZEZjA2WFo5UzYtajlZ?oc=5	https://coastmountainnews.com/wp-content/uploads/sites/2/2026/03/41721443_web1_260305-PAN-Grace-Elliott-hockey-star-playoffs_1.jpg?w=1024	\N	2026-03-03T22:13:37+0000	\N	2026-03-05 21:42:26.570448-05	\N	\N
366	PWHL resumes after women's hockey players leave mark at 2026 Winter Olympics - Yahoo Sports	https://news.google.com/rss/articles/CBMiiwFBVV95cUxNVzVrWXVOdHJhQ3h1eUZORGF4V0RkckJramNGbGhMQkcxS0ZrUExlUlBqd3hNREFxWG1QVmdnZE11VkotWnE1YTlBSXdYbmNBU2wzZEdzQjZZeTlmZEhzX2NCVHZIRnVlQlVCMHlFOUlOb0xNV2JCMm41OS0xS0M3YTMySDVpakM2LWdJ?oc=5	https://s.yimg.com/ny/api/res/1.2/xqej0bGVCpziwnxlxdZ8ag--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA7Y2Y9d2VicA--/https://media.zenfs.com/en/usa_today_sports_articles_558/9e326e038f1a9a7a9d34c2468e138f44	\N	2026-02-26T20:42:21+0000	\N	2026-03-05 21:42:41.487879-05	\N	\N
364	TWENTY-TWO PWHL PLAYERS TO REPRESENT SIX EUROPEAN COUNTRIES AT 2026 OLYMPIC GAMES - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiyAFBVV95cUxPNUhSWUNkTlZUR2l0cnZoeDdxX3Q3R3RrUTQzbW1zX1dhcVNsUFdJS05wTHVtbXg5WU1iNk5QOWgyNlk5VEc3OUw4dFd5ZVBJQWRDSjhBOHJCOWhsbkJ1Z280V1FQdFdhNlFrS0NtMUprZWRRYUhHX2pnaDRTZ3NScmozX3FNX0M1cDBtck9LZDdQdW56QS11bVBGXzFJY2k2dVNOd1U3TzZZakhxTmZUYjRSMmxUV0t6cS1nNlpTQWZKbzY4VWVLeg?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/120625_Goldeneyes_v_Sirens_-_Jones_-_Final_Take-438?_a=DATAg1ZSZAA0	\N	2026-01-20T08:00:00+0000	\N	2026-03-05 21:43:09.505869-05	\N	\N
368	What’s the biggest issue in women’s hockey today? PWHL players talk salary, schedules, more - The Athletic - The New York Times	https://news.google.com/rss/articles/CBMilwFBVV95cUxNWVpSU1F4aVREMjM3X21Zc3FvaG5nemtiWXh4NzZqejJUVDlERGpvMnotdFZ4aGF0c1hscDlnallUSDkxWTlCWnppcS04VDIzYTRjWG9iOU5TSUZ4c3VFVmRDRFhGTVZfZDA3X2R1bXNKSXpSS2IyLVRIRi1aR19wc212bmJwTXgyMDU5VU01a0VpYjNKS0RJ?oc=5	https://static01.nyt.com/athletic/uploads/wp/2026/01/20192427/0121_PWHLAnonymousPlayerPoll_Issues-scaled.jpg?width=1200&height=630&fit=cover	\N	2026-01-21T08:00:00+0000	\N	2026-03-05 21:43:09.505869-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
248	PWHL WEEKLY NOTEBOOK: DEC. 29, 2025	https://www.thepwhl.com/en/news/2025/december/29/pwhl-weekly-notebook-dec-29-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Bilka_Simpson_TT_Dallas?_a=DATAg1ZSZAA0	\N	2025-12-29	\N	2026-03-05 14:42:39.225882-05	\N	\N
400	NEW YORK SIRENS TO CELEBRATE WOMEN’S EMPOWERMENT ON MARCH 8 VS. OTTAWA CHARGE - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMi3AFBVV95cUxNcFJxbGlGbzlpSXhJTzRCREcwNmZHQ0dBNmI2YTRDbi1jeFh0MnRtUlZuM2hiN3B6dzF2eWF1RUJPT1ZOTDNDUTF0YnRlZGlMVUN5ak5TN21kRGNsa0hueXdmbEN1NGlKeUJFdVFqQ3h3b3dYaW5VS1dhcE1RVThhZ0FVd1oxLTdMX2ZoMDh0eW1HMzREdE9yV0lJUjRpN0dQdUxicktXZGF1T3o4Vk1Id3NCN3JZa3BGVTQ4N2dDS2xpXzRMS2xNSHN0Y0gxTnR1NG5vQkRzT0FoZ1NG?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/23d6b82d-3cf0-4d6a-b47f-f1c3df96fc93Sirens-Victoire5430?_a=DATAg1ZSZAA0	\N	2026-03-04T20:34:38+0000	\N	2026-03-07 13:29:47.014455-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
401	Stats - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiXEFVX3lxTE1qYUhYRXZuUlRSX3pvcUNIeE9UdWl2ZmtDSkpWT3FaSWE5T2hHeFBETk9hSmU3bUFkVkZZNDZsLVpxdGYxLWVUWU5mUzlWSUVwTWlXcnZpd2dpTjA3?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2025-10-19T00:45:02+0000	\N	2026-03-07 13:29:51.197003-05	\N	\N
344	Women's hockey league reaches new heights with sold-out game at Madison Square Garden - NBC News	https://news.google.com/rss/articles/CBMigAFBVV95cUxNTE5uMXc0d2Y3RVhENGJhRGs5NHpncmFESnpiY0ZjdjNVYkRiRlFnTzBOTUtsQ1lxZm15YlhycngwaG5ELTlzdEtvQk1ZUUR1ZTRjMERJWFBDWjZ3SW1HajV2YW1wSk5tM3E3WVhZUl84ZUh2YXJ6ZzF2LXMzazNncQ?oc=5	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2026-03/260305-ny-sirens-ch-1529-53eb0d.jpg	\N	2026-03-05T20:32:30+0000	\N	2026-03-05 21:42:13.093616-05	\N	\N
9	Sold-out PWHL game at MSG to set U.S. attendance record - ESPN	https://news.google.com/rss/articles/CBMikgFBVV95cUxQaXV4LVh6bm5BaE1lU21wY2hna3J3QmRCMzNkMzhKOVlFa1pNWXdnU3ZBNk1QQ01rODczR1dlYmY4cUdJZ3BXQzg0NUp1amhhekY2UGM2NlprUUlpU0lqMUFFcDlQY3RaUGN2aFQzME40ZGhLR3hleURvYm4wVDVVLXlNZHNVbS11WlRRc2RDSFJHQQ?oc=5	https://a2.espncdn.com/combiner/i?img=%2Fphoto%2F2026%2F0305%2Fr1623705_1296x729_16%2D9.jpg	\N	2026-03-05T16:14:00+0000	\N	2026-03-05 21:42:17.090167-05	\N	\N
349	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - The Register-Herald	https://news.google.com/rss/articles/CBMiqgJBVV95cUxQaC1TV2RlLUhYYk1uWG5YUnpWb2d0ckpRZ2dpTmlOZDZsMnE5TEt4Y2hRSlV2eDZzc21PN2NheDBXUHotb19RbEszaFpBNGFLb3VVOUVZcmRUTE9zRkZOXzhOZmpMckNZOFpSd1Bod1d0cTFGSFVlLWpjeXJveVhpLWdlNjhqRnhkYktKdEdNOUxFejhKYkFzMldZampSaVFRTHR2TEloVkN5QTlTR1gzXzRrWHlYTzAtajFvdFA1YWc1LV9IZDRPajZUSGdkRjdpRVRudGV0MG8td3plYXhVUVVVYTBDZlRfTVdlTmlLVGdCX1BDQlRGME9xeGpXb0hFOTVDeVRRNWp6djVZOUdKbW9jTFhSazJpX3d6WFdwVGRLT2xsYXQ4UXdB?oc=5	https://bloximages.chicago2.vip.townnews.com/register-herald.com/content/tncms/assets/v3/editorial/f/3f/f3f63cc3-3846-54ee-80c5-0711571d2fc0/69a36d7ae2ef4.image.jpg?crop=1763%2C926%2C0%2C124&resize=1200%2C630&order=crop%2Cresize	\N	2026-03-05T19:50:33+0000	\N	2026-03-05 21:42:17.090167-05	\N	\N
41	Poulin leads PWHL-leading Victoire to 6th straight win, 4- 3 over Sceptres in shootout - Newsday	https://news.google.com/rss/articles/CBMihwFBVV95cUxPY1pUUmVhdVBaSk5xcklGQXdpNHA5QWN3ZzRqY0J0eWo3VVN5Y0czeDJ1WG1FLXM0cVJKWE8tSzhzUzZaWnpTZkhqeTEweDZnZkRjWGszWW5mcThoQVdpbFJZZDc1blR6RHEwT3hhRzZRX2NKV2FHNDE1WWtGalZLYWFQaVB3RlE?oc=5	https://cdn.newsday.com/ace/c:NDU1YWIzMjYtOGQ5NS00:ZWRjOGM4Y2MtMGYxNi00/landscape/1280	\N	2026-03-04T03:33:07+0000	\N	2026-03-05 21:42:26.570448-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/60x60/31.jpg
40	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 19 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxPeXExTUJIbDBSQzVSWDR5bnZBZWFYanNOWGU1RkdRQUE4WmJlRk9idXQ2cDFLMmNTQkJHSFhhcUlqcVpjc2pfM0xLREYzTHA4LTBlZElKaWh1UDE2WldZY1BacVlwd0FvRHV5VVFFcjUzNmIwdVVJU2lWb1Y3QzFPSkwwSW5laEh4emxEZy1WRmc0QXlsVlo4aTR4SHlkTFU?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/USA_Olympics_Gold?_a=DATAg1ZSZAA0	\N	2026-02-19T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	\N	\N
42	NEW YORK SIRENS TO HOST OLYMPIC GOLD MEDAL GAME WATCH PARTY AT AMERICAN DREAM MALL - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMi6AFBVV95cUxQRzcxVEoyek42UE5wRDhpcEFfQlRrNEdCSE4tbmk1VW9Gbl9RR0laV0JGUExza3I5RDM2a2xTRy16QVBjY05SaGRCaUM5TEFhelZoTmx1Vm1KSlFRVVQ0VGtvLWl0Y3NBVFNDVkdWZlJFNjk2bmhBNlk5QUtDWFloOE0tYzdNZ0g5V3Q0dE94WDJpVDFoSkxrOUcxR2ZzcHdJdHFVc2c1bkpiakNQMFJGTHZMVHI0M29vd1FaMVZwNEJtakhLeE9iM2FrdmRmMUdsa1pZVGpEMnhHSEhWNkpXUXRoT1dXWU9X?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2-14_American_Dream_LED_Mall?_a=DATAg1ZSZAA0	\N	2026-02-17T08:00:00+0000	\N	2026-03-05 21:43:00.146896-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
53	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 16 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxNZGE4SFByRVlhTWFub0dGcmdSaHlOTnc5U0pKalNJdzZVTWdsWDc3akdJQjJxLVRnZll6cTdodjFZc2hJOWJYRi1RWWV3M01kRGlQcmJjdXhuT0psS0s2azBHUmVVWlV1WWpWTjhvZm5UTWdWamZXMVdsdkJqY0RMTVZHWVNSQmdPcVZiS0dlWTZYRUFReF9DRFZLMndPSTg?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Poulin_Canada_SF?_a=DATAg1ZSZAA0	\N	2026-02-16T08:00:00+0000	\N	2026-03-05 21:43:00.146896-05	\N	\N
402	MAR. 8: OTTAWA AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/march/07/mar-8-ottawa-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_OTT_at_NY_-_Jan._20_202617?_a=DATAg1ZSZAA0	\N	2026-03-07T21:30:00Z	\N	2026-03-07 17:29:45.470136-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
403	Stats - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiXEFVX3lxTE8wbG5sRXBVSUZZcWluQkRlR3NTejMyTnh1M0g4Sk81X1JzamtKUVI2VlFBWlpzR2ItOUNDd01FSjlIWmlJdzlkMmdGQldRSThaeTNpaTE0eTFGMDl0?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2025-11-12T16:07:02+0000	\N	2026-03-07 17:29:51.226863-05	\N	\N
4	MONTRÉAL WINS SIXTH STRAIGHT GAME AS POULIN SEALS SHOOTOUT WIN OVER TORONTOHighlights and Press Conferences available on Toronto and Montréal YouTube channels  TORONTO (March 3, 2026) – In their fifth and final meeting of the regular season, the Montréal Victoire edged out the Toronto Sceptres 4-3 in a shootout thanks to capt...Mar 04, 2026	https://www.thepwhl.com/en/news/2026/march/04/montr-al-wins-sixth-straight-game-as-poulin-seals-shootout-win-over-toronto	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MTL_at_TOR_-_Mar._3_2026_14?_a=DATAg1ZSZAA0	https://source.unsplash.com/800x450/?women+hockey+game&sig=pwhl-3	2026-03-04	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/60x60/31.jpg
34	SIXTEEN PWHL PLAYERS NAMED TO U.S. OLYMPIC WOMEN’S ICE HOCKEY TEAM - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMisAFBVV95cUxNSmRlWFRwT0ZkUEQ5NDQ0ajVDektxWkNNRlNPLUduY2FiMkt2d2dxaUxxN2pJNUl6X19aZzNMY0xHejR3NHhHeXV1V2pZMVJ6Y201dHFyTTNVUjQ3Ri1hLTZhWEdOV29fbHZXM2FBOXVWQzdCMlYxa3JlQk1MbW5LZjdvYVBFU2JNdDhkODUtdzQzU09MOU9SamVNMm92ME8wTEFPOEZuS2drZ2VCcHNjNw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEA_KnightChrisMast_20251118_PWHL_REG_SEATTLE_TORRENT_Knight-Hillary_0345?_a=DATAg1ZSZAA0	\N	2026-01-02T08:00:00+0000	\N	2026-03-05 21:43:18.945319-05	\N	\N
357	PWHL sells out Madison Square Garden, TD Garden	https://www.theixsports.com/the-ice-garden/pwhl/pwhl-sellouts-madison-square-garden-td-garden/	https://www.theixsports.com/wp-content/uploads/2026/03/CREDIT-PWHL-SEA-at-NY-Dec.-28-2025_17-scaled.jpg	\N	2026-03-05T21:29:08+0000	\N	2026-03-05 17:37:04.009708-05	\N	\N
358	The IX Sports Podcast: PWHL, SNL and the Olympic hangover	https://www.theixsports.com/podcast/the-ix-sports-podcast/the-ix-sports-podcast-pwhl-snl-and-the-olympic-hangover/	https://www.theixsports.com/wp-content/uploads/2026/03/The-IX-Sports-Podcast-Youtube-Template-8.png	\N	2026-03-05T21:01:58+0000	\N	2026-03-05 17:37:04.009708-05	\N	\N
60	NOV. 28: MINNESOTA AT SEATTLE PRE-GAME PRIMER - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMilwFBVV95cUxQamxRSFU0QkdHaWRrWXJfOC1FSWpKTEJUakdINmtoM2JfdlJKYTNhU1RJblRzR3Z5d3h4YzA3R2Yta3F6UmV5d2JsRUl3b1prdjhSWGhEdzY3V0xYeVVvQlVGbjBEX3M1Vm1IVlE3Mi1uTEwwckRRd21jdjM0cTJzbEtROFNIejEybFJwUWprZ01CLUV1QXNN?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/11.4-new-SEA-t_-_SGT_matchup_-_1200x800_-vs-_MIN?_a=DATAg1ZSZAA0	\N	2025-11-28T08:00:00+0000	\N	2026-03-05 21:43:18.945319-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
63	MINNESOTA FROST ANNOUNCE 2025-26 ROSTER - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMirwFBVV95cUxPVlkyQWJ1ZWsxTDI1cy1wN20tNkpvVHZramhPWDVlYnFaa3E5RWdiVFBfanBTdlRPRmZxaHIzc2dUYXBWbE8tNE9aUU5abnNzUU1CTHE5UEFPdnhMVVhhUTRTQUhGX1doREJVMkhSUlBwM2VoemlDeFhFWHFYaF9GbEVrOXhYNXhGeTRWSWZDcmRZZllRNzdlTzJpOTh6bGVsdVI1OTNid2Q2V0M4S2Nj?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-SOC-MINN-OpeningGameRoster-1200x800-2?_a=DATAg1ZSZAA0	\N	2025-11-20T08:00:00+0000	\N	2026-03-05 21:43:18.945319-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
356	PWHL UNVEILS EXPANSION TEAM IDENTITIES: SEATTLE TORRENT AND VANCOUVER GOLDENEYES	https://news.google.com/rss/articles/CBMixwFBVV95cUxNcEhKWGwwMlNLWnFmT3hfRTE1ZXNxSllmTnZ0d09vSVMxVHlIMXhsLVJ0OF82TGJIRHRkbVVkdHBHQlpibGkwM0pkbGFIWFhBVnJ5Y3dPTHhVR1RtQk9nRy1qTlNwN0Z1bnBpNVBnaEx5LXdIN1I5ZkZMNHcxQ3dlb1FleS1JRVVBUFVXczVQRXJ0QlZjUC1fTnAzcUd2QVVHMnFLTDNUVVMtQ04yNDZocTlKUFRfM3o5eEI2Q1huaUlVTEw3Z204?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-BrandLaunch-Lockup-Header-PressRelease-1200x800_1?_a=DATAg1ZSZAA0	\N	2025-11-06T08:00:00+0000	\N	2026-03-05 21:43:18.945319-05	["https://assets.leaguestat.com/pwhl/logos/7.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
80	MINNESOTA FROST TO HOST OLYMPIC WATCH PARTIES THROUGHOUT OLYMPIC WINTER GAMES MILANO CORTINA 2026	https://www.thepwhl.com/en/news/2026/february/06/minnesota-frost-to-host-olympic-watch-parties-throughout-olympic-winter-games-milano-cortina-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MIN-OlympicsWatchParty-1920x1080_5?_a=DATAg1ZSZAA0	\N	2026-02-06	\N	2026-03-05 14:42:23.88156-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
5	PWHL TEAMS SELL OUT BOTH MADISON SQUARE GARDEN AND TD GARDENMadison Square Garden – April 4 – New York Sirens vs. Seattle Torrent TD Garden – April 11 – Boston Fleet vs. Montréal Victoire New York Sirens’ first-ever home game at Madison Square Garden, presented by Title Partner, e.l.f. Cosmetics, could set new ...Mar 05, 2026	https://www.thepwhl.com/en/news/2026/march/05/pwhl-teams-sell-out-madison-square-garden-td-garden	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-SOC-GardenSellOut-16x9?_a=DATAg1ZSZAA0	\N	2026-03-05T10:00:00-05:00	\N	2026-03-05 14:27:52.469454-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
64	Eight Dates to Watch in the first half of the PWHL Schedule	https://www.thepwhl.com/en/news/2025/october/17/eight-dates-to-watch-in-the-first-half-of-the-pwhl-schedule	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_37A5739?_a=DATAg1ZSZAA0	\N	2025-10-17	\N	2026-03-05 14:42:21.653214-05	\N	\N
68	DESBIENS STUMPS FROST AS VICTOIRE TAKE OVER FIRST PLACE	https://www.thepwhl.com/en/news/2026/march/01/DESBIENS-STUMPS-FROST-AS-VICTOIRE-TAKE-OVER-FIRST-PLACE	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_MTL_-_Mar._1_2026_21?_a=DATAg1ZSZAA0	\N	2026-03-01	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/240x240/28.jpg
66	BOSTON OVERTAKES OTTAWA 3-2 IN THIRD-STRAIGHT SHOOTOUT	https://www.thepwhl.com/en/news/2026/february/28/boston-overtakes-ottawa-3-2-in-third-straight-shootout	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_OTT_-_Feb._28_2026_15?_a=DATAg1ZSZAA0	\N	2026-02-28	\N	2026-03-05 14:42:21.653214-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
67	MAR. 3: MONTRÉAL AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/march/03/mar-3-montreal-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20251227-tor-mtl-ABC00751?_a=DATAg1ZSZAA0	\N	2026-03-03	\N	2026-03-05 14:42:21.653214-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
77	DESBIENS SHINES AS MONTRÉAL WINS FOURTH STRAIGHT, MOVES INTO TIE FOR FIRST	https://www.thepwhl.com/en/news/2026/february/26/desbiens-shines-as-montr-al-wins-fourth-straight-moves-into-tie-for-first	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Sirens-Victoire1758?_a=DATAg1ZSZAA0	\N	2026-02-26	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/240x240/28.jpg
70	PWHL WEEKLY NOTEBOOK: MAR. 2, 2026	https://www.thepwhl.com/en/news/2026/march/02/pwhl-weekly-notebook-mar-2-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/260227_Torrent_vSceptres6246?_a=DATAg1ZSZAA0	\N	2026-03-02	\N	2026-03-05 14:42:21.653214-05	\N	\N
71	MAR. 1: MINNESOTA AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/march/01/mar-1-minnesota-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20260104-MINvMTL-LCA01190?_a=DATAg1ZSZAA0	\N	2026-03-01	\N	2026-03-05 14:42:21.653214-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
79	FROST PLACE KENDALL COYNE SCHOFIELD ON LTIR, SIGN FORWARD ÉLIZABETH GIGUÈRE	https://www.thepwhl.com/en/news/2026/february/27/frost-sign-forward-lizabeth-gigu-re-place-kendall-coyne-schofield-on-ltir	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MINN-2526-Signed-16x9_1?_a=DATAg1ZSZAA0	\N	2026-02-27	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	https://assets.leaguestat.com/pwhl/60x60/20.jpg
76	FEB. 28: BOSTON AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/february/28/feb-28-boston-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_OTT_-_Dec._27_20255?_a=DATAg1ZSZAA0	\N	2026-02-28	\N	2026-03-05 14:42:23.88156-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
25	MAR. 1: MINNESOTA AT MONTRÉAL PRE-GAME PRIMER	https://news.google.com/rss/articles/CBMikwFBVV95cUxQRTU4LWFMT21MZW40cjdBY1d3Tm1yNjJ3RzZXN2lKS2E4MDEtVlZtcFk0SnZIM0FSdF8wTTQxUG5nR1hfZUwxOVVHdXoxeDE2azg2dm5vN051T0RtbXU1dzFHRno2NnNIdnBpX1JwT0o5SElUZ2FrbGg1NU5lOVc3b3p0bHhOazV0TlBMdkJmdnJ3dUE?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20260104-MINvMTL-LCA01190?_a=DATAg1ZSZAA0	\N	2026-03-01T15:25:35+0000	\N	2026-03-05 21:42:31.279555-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
369	BOSTON WINS FIFTH STRAIGHT WITH 1-0 VICTORY OVER NEW YORK	https://www.thepwhl.com/en/news/2026/march/06/boston-wins-fifth-straight-with-1-0-victory-over-new-york	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_NY_-_Mar._5_2026_02?_a=DATAg1ZSZAA0	\N	2026-03-06T04:15:00Z	\N	2026-03-06 01:29:45.523814-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
26	Boston Fleet at Ottawa Charge | February 28, 2026	https://news.google.com/rss/articles/CBMijgFBVV95cUxQQy1KU3ZmdGRhR2x0dEV2MGI5aDVZU3VxeFpEeEtNcGU4MUFrWktEYXNTclZmSDFYUmlGR0lhcTFrb0JTQmh6T1hybVBXdGZWTldEdVBLNHNuQjVkTnBoQXBzY2hyaE5wdEtHdDVVczVTdV9adjQxR2lSZV9LcFVRVG1LOXphakRGUHo2aHhB?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Brightcove/videos/images/PWHL-Boston-Fleet-at-Ottawa-Charge-February-28-2026-zz47oP7HUGE?_a=DATAg1ZSZAA0	\N	2026-02-28T08:00:00+0000	\N	2026-03-05 21:42:41.487879-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
23	PWHL: Olympians returned with long term injuries, including Frost’s Kendall Coyne Schofield - Pioneer Press	https://news.google.com/rss/articles/CBMixgFBVV95cUxOUHlBRGUySVREYXNoeURPa1NRU3RxbGlqVzNoczNtMXhXNlFPVElKNFhiTmJCZlVBYUdiblFfTE82YjZQWXdNTGRYTk91YjRud0ozeDBDWDlqOV9zS3ZlN05jYjJrU2kxX3VXczA2Q3F5RlJzNF8wWUJnVU1Cd2R0LThTdE1pZmpMWFNBLXJCTHhTZFp1NFVBWmdMYzg1cDM4eXlFek9QV3NWdHVnSFV3U0V1dE5wWm56QkNkWDFwdC11cy1pYVE?oc=5	https://www.twincities.com/wp-content/uploads/2026/03/stp-l-TeamUSA-0306-01.jpg?w=1024&h=683	\N	2026-03-05T14:38:13+0000	\N	2026-03-05 21:42:22.182656-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	https://assets.leaguestat.com/pwhl/60x60/20.jpg
81	Ultimate Watch Parties Bring PWHL Fans Closer to the Olympic Action	https://www.thepwhl.com/en/news/2026/february/11/ultimate-watch-party-brings-pwhl-fans-closer-to-the-olympic-action	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/sirens_2-10_watch_party_fans?_a=DATAg1ZSZAA0	\N	2026-02-11T15:21:54-05:00	\N	2026-03-05 14:42:23.88156-05	\N	\N
82	PWHL WEEKLY NOTEBOOK: FEB. 26, 2026	https://www.thepwhl.com/en/news/2026/february/26/pwhl-weekly-notebook-feb-26-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Knight_USA_Gold?_a=DATAg1ZSZAA0	\N	2026-02-26	\N	2026-03-05 14:42:23.88156-05	\N	\N
83	FEB. 26: MONTRÉAL AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/february/26/feb-26-montreal-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/EVB02783?_a=DATAg1ZSZAA0	\N	2026-02-26	\N	2026-03-05 14:42:23.88156-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
84	Top 10 PWHL Players to watch coming out of the Olympics	https://www.thepwhl.com/en/news/2026/february/20/top-10-pwhl-players-to-watch-coming-out-of-the-olympics	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-20260219-6734?_a=DATAg1ZSZAA0	\N	2026-02-20	\N	2026-03-05 14:42:24.800641-05	\N	\N
85	Recapping the seven PWHL Olympic Rookies who won gold at Milano Cortina 2026	https://www.thepwhl.com/en/news/2026/february/23/recapping-the-seven-pwhl-olympic-rookies-who-won-gold-at-milano-cortina-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/frankel_and_philips_3?_a=DATAg1ZSZAA0	\N	2026-02-23	\N	2026-03-05 14:42:24.800641-05	\N	\N
86	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 19	https://www.thepwhl.com/en/news/2026/february/19/pwhl-notebook-olympic-winter-games-edition-feb-19	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/USA_Olympics_Gold?_a=DATAg1ZSZAA0	\N	2026-02-19	\N	2026-03-05 14:42:24.800641-05	\N	\N
89	ALINA MÜLLER IS THE HERO AS HER OVERTIME GOAL EARNS SWITZERLAND BRONZE OVER SWEDEN	https://www.thepwhl.com/en/news/2026/february/19/alina-muller-the-hero-as-overtime-goal-earns-switzerland-bronze-over-sweden-at-winter-olympic-games	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Image?_a=DATAg1ZSZAA0	\N	2026-02-19T11:12:42-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/15.jpg
88	Article Component Demo: PWHL UNVEILS MINNESOTA FROST IN LEAGUE-WIDE TEAM IDENTITY LAUNCH	https://www.thepwhl.com/en/news/2024/september/09/article-component-demo-pwhl-unveils-minnesota-frost-in-league-wide-team-identity-launch	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MIN-Email-for-Announcement_y8gdxq?_a=DATAg1ZSZAA0	\N	2024-09-09T09:00:00-04:00	\N	2026-03-05 14:42:24.800641-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
93	2026 Winter Olympics Women's Hockey Bronze Medal Game Preview	https://www.thepwhl.com/en/news/2026/february/18/2026-winter-olympics-womens-hockey-bronze-medal-game-preview	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2026-02-18	\N	2026-03-05 14:42:24.800641-05	\N	\N
94	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 18	https://www.thepwhl.com/en/news/2026/february/18/pwhl-notebook-olympic-winter-games-edition-feb-18	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CAN_USA_Faceoff?_a=DATAg1ZSZAA0	\N	2026-02-18	\N	2026-03-05 14:42:25.671409-05	\N	\N
95	The Ultimate Away Game: Best of Social Media	https://www.thepwhl.com/en/news/2026/february/the-ultimate-away-game-best-of-social-media	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1200x800-TUAG-1.28.26-ap?_a=DATAg1ZSZAA0	\N	2026-02-17	\N	2026-03-05 14:42:25.671409-05	\N	\N
96	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 16	https://www.thepwhl.com/en/news/2026/february/16/pwhl-notebook-olympic-winter-games-edition-feb-16	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Poulin_Canada_SF?_a=DATAg1ZSZAA0	\N	2026-02-16	\N	2026-03-05 14:42:25.671409-05	\N	\N
97	PROFESSIONAL WOMEN’S HOCKEY LEAGUE TEAMS UP WITH OAK VIEW GROUP FOR SPONSORSHIP SALES TO POWER NEXT ERA OF GROWTH	https://www.thepwhl.com/en/news/2026/february/17/professional-women-s-hockey-league-teams-up-with-oak-view-group-for-sponsorship-sales-to-power-next-era-of-growth	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/02_17_26_PWHL_Ice_Crew_Image_for_Release?_a=DATAg1ZSZAA0	\N	2026-02-17	\N	2026-03-05 14:42:25.671409-05	\N	\N
98	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 17	https://www.thepwhl.com/en/news/2026/february/17/pwhl-notebook-olympic-winter-games-edition-feb-17	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Frankel_USA_SF?_a=DATAg1ZSZAA0	\N	2026-02-17	\N	2026-03-05 14:42:25.671409-05	\N	\N
99	USA ADVANCES TO THE GOLD MEDAL GAME AFTER SHUTTING OUT SWEDEN	https://www.thepwhl.com/en/news/2026/february/16/usa-advances-to-the-gold-medal-game-after-shutting-out-sweden	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/barmes_for_semis_recap_1_copy_2?_a=DATAg1ZSZAA0	\N	2026-02-16T15:05:12-05:00	\N	2026-03-05 14:42:25.671409-05	\N	\N
119	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 10	https://www.thepwhl.com/en/news/2026/february/10/pwhl-notebook-olympic-winter-games-edition-feb-10	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CAN_USA_Olympic_Puck_Battle?_a=DATAg1ZSZAA0	\N	2026-02-10	\N	2026-03-05 14:42:27.473675-05	\N	\N
101	CANADA MOVES ON TO GOLD MEDAL GAME AT MILANO CORTINA 2026 DESPITE LATE PUSH FROM SWITZERLAND	https://www.thepwhl.com/en/news/2026/february/16/canada-moves-on-to-gold-medal-game-despite-late-push-from-switzerland	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/canadawinssemis?_a=DATAg1ZSZAA0	\N	2026-02-16T17:27:07-05:00	\N	2026-03-05 14:42:25.671409-05	\N	\N
371	PWHL's Boston Fleet sell out TD Garden for upcoming game in April - WMUR	https://news.google.com/rss/articles/CBMikgFBVV95cUxPOHpwVGlMT2xiVnlmUnkxN1JDWHJtSXQ4TlF4Y2l0M0FEaW1FaHZwaHgtQlpYY21uVU1pemRvdkI2YVMtZWlEOEU3dlhYbEx5Zk5xYldWdUN2WVBGOVdTS28zekNPRkR4dVZHUDFqSGdfWXJiMVhUZVJaMUZCUVVhNmpkLVVHelZOTVl5eUxWRWJVQQ?oc=5	https://kubrick.htvapps.com/htv-prod-media.s3.amazonaws.com/images/screenshot-2026-03-05-232855-69aa586d6ef15.png?crop=1.00xw:1.00xh;0,0&resize=1200:*	\N	2026-03-06T04:32:00+0000	\N	2026-03-06 01:29:46.793038-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	\N
372	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - WSOC TV	https://news.google.com/rss/articles/CBMiekFVX3lxTE5NTXlONEdUV29MNlRTUm9obUhxUGlWZnN1ekpsd1BrUElvWm0yNVgzN0Z3VWZ1SWUybWpfa1FTTmdGOG5ISkdmcFE2TTBxU1VlU2s2WDlvRFFDQWZ3bUNwd0pIcDVzc3l0dDQ2ZkxBNVotZ1BuVUlsY09B0gGOAUFVX3lxTE1abVpIbHA4TkVGQm9IVnh5MEFqb0lBT1lMaFhFYW10eVd1SWNIQ1hZN3BQSWozby1RcGIyRHdJSkN6MDl0eDFiMlhtcll4bmFsemZsRE9KMkJoRFJrdmlDeHAyQ2dHN0NubndULTM5TFVkbUsyVjVhRWZaeHFoaC01TWxSME93VENzZFNPY1E?oc=5	https://cmg-cmg-tv-10030-prod.cdn.arcpublishing.com/resizer/v2/https%3A%2F%2Fcloudfront-us-east-1.images.arcpublishing.com%2Fcmg%2FOY6ELXUQRE5XDFWGMNUTCLKHPA.jpg?auth=c89eaaa8c21580c6c552de647c663d373d8c845650ebe23635d368ba50ce3bc7&width=1200&height=630&smart=true	\N	2026-03-05T19:50:33+0000	\N	2026-03-06 01:29:46.793038-05	\N	\N
104	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 14	https://www.thepwhl.com/en/news/2026/february/14/pwhl-notebook-olympic-winter-games-edition-feb-14	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Muller_SUI_QF?_a=DATAg1ZSZAA0	\N	2026-02-14	\N	2026-03-05 14:42:26.595677-05	\N	\N
105	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 15	https://www.thepwhl.com/en/news/2026/february/15/pwhl-notebook-olympic-winter-games-edition-feb-15	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Hjalmarsson-20260213-QF-SWEvsCZE-311279?_a=DATAg1ZSZAA0	\N	2026-02-15	\N	2026-03-05 14:42:26.595677-05	\N	\N
106	CANADA FINISHES PRELIMINARY ROUND STRONG, BEATING FINLAND 5-0	https://www.thepwhl.com/en/news/2026/february/12/canada-finishes-preliminary-round-strong-beating-finland-5-0	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/desbiens_for_fin-can?_a=DATAg1ZSZAA0	\N	2026-02-12	\N	2026-03-05 14:42:26.595677-05	\N	\N
107	USA EXPLODES FOR FIVE SECOND-PERIOD GOALS TO DEFEAT ITALY IN OLYMPIC QUARTERFINALS	https://www.thepwhl.com/en/news/2026/february/13/usa-explodes-for-five-second-period-goals-to-defeat-italy-in-the-quarterfinals	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PHOTO-2026-02-13-17-32-59?_a=DATAg1ZSZAA0	\N	2026-02-13	\N	2026-03-05 14:42:26.595677-05	\N	\N
108	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 13	https://www.thepwhl.com/en/news/2026/february/13/pwhl-notebook-olympic-winter-games-edition-feb-13	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Keller_USA_QF?_a=DATAg1ZSZAA0	\N	2026-02-13	\N	2026-03-05 14:42:26.595677-05	\N	\N
109	CANADA ADVANCES TO THE SEMIFINALS WITH A 5-1 WIN OVER GERMANY	https://www.thepwhl.com/en/news/2026/february/14/canada-advances-to-the-semifinals-with-a-5-1-win-over-germany	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PHOTO-2026-02-14-13-20-04?_a=DATAg1ZSZAA0	\N	2026-02-14T13:21:51-05:00	\N	2026-03-05 14:42:26.595677-05	\N	\N
373	NHL and PWHL Are Riding a Post-Olympic Wave With Audience Spikes - Front Office Sports	https://news.google.com/rss/articles/CBMigAFBVV95cUxOcWJxUjEyQmVFYnloN0loLS00UUV2T0RYT1B1SF9OS0VzcG9oLXJXeGZ0V3h6TUxXYnZ1MTFkQXNqRVBkT2VGOEJhaURUektKSG8taGFqR0NtbkdxejFjVUxKLXNRUXhDS2VVMjJ4Mk00WmQwWW1uRmR1OHk1QlFPVg?oc=5	https://frontofficesports.com/wp-content/uploads/2025/12/CREDIT-PWHL-SEA-at-VAN-Nov.-21-202516-scaled-e1770674274795.jpg?quality=100	\N	2026-03-04T17:48:25+0000	\N	2026-03-06 01:29:46.793038-05	\N	\N
111	SWEDEN UPSETS CZECHIA IN THE QUARTERFINALS AT MILANO CORTINA 2026	https://www.thepwhl.com/en/news/2026/february/13/sweden-upsets-czechia-in-the-olympic-quarterfinals	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/nylen_quarters_for_wbe_2-13?_a=DATAg1ZSZAA0	\N	2026-02-13	\N	2026-03-05 14:42:26.595677-05	\N	\N
112	‘THE INAUGURAL SEASON OF THE PWHL’ DOCUMENTARY TO DEBUT FEBRUARY 16 ON PEACOCK	https://www.thepwhl.com/en/news/2026/february/11/the-inaugural-season-of-the-pwhl-documentary-to-debut-february-16-on-peacock	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2026-02-11	\N	2026-03-05 14:42:26.595677-05	\N	\N
114	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 12	https://www.thepwhl.com/en/news/2026/february/12/pwhl-notebook-olympic-winter-games-edition-feb-12	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CAN_FIN-2026-02-12-09-08-27?_a=DATAg1ZSZAA0	\N	2026-02-12	\N	2026-03-05 14:42:27.473675-05	\N	\N
116	SWEDEN BLANKS JAPAN TO FINISH PRELIMINARY ROUND PLAY UNDEFEATED AND SECURE FIRST PLACE IN GROUP B	https://www.thepwhl.com/en/news/2026/february/10/sweden-finishes-preliminary-round-play-undefeated-as-they-shut-out-japan-to-secure-first-place-in-group-b	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/sweden_japan_game_story?_a=DATAg1ZSZAA0	\N	2026-02-10T12:20:51-05:00	\N	2026-03-05 14:42:27.473675-05	\N	\N
117	USA FINISHES ATOP GROUP A WITH A DOMINANT 5-0 SHUTOUT OF CANADA	https://www.thepwhl.com/en/news/2026/february/10/usa-finishes-top-of-group-a-with-a-dominant-5-0-shutout-of-canada	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/WhatsApp_Image_2026-02-10_at_2.53.30_PM?_a=DATAg1ZSZAA0	\N	2026-02-10	\N	2026-03-05 14:42:27.473675-05	\N	\N
118	FINLAND TOPS SWITZERLAND 3-1 BEHIND TWO POWER-PLAY GOALS	https://www.thepwhl.com/en/news/2026/february/10/special-teams-reign-supreme-as-finland-topple-switzerland-3-1-behind-two-power-play-goals	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2026-02-10T18:20:00-05:00	\N	2026-03-05 14:42:27.473675-05	\N	\N
374	PWHL UNVEILS 2025-26 REGULAR-SEASON SCHEDULE | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMilgFBVV95cUxNM1NpbFBjaFd0UkdHZkZBOTZ2UF83UnpSalVieVRROXNZQURuV1pYVVJncWZNTlNQcUxRMHRLYkFrMURmNUNMYVM4aXFpOFltSUUtWk9FWGg2NG1QaDRkNmt6MHowWFhZUzlTWk0zRzNzZGlsNDJIOWZCX1F1Sktmd0FIZ2JxbHgtTWYxWXJPS0NoNmduSXc?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/League-ScheduleRelease-WEB?_a=DATAg1ZSZAA0	\N	2025-10-01T07:00:00+0000	\N	2026-03-06 01:29:50.773141-05	\N	\N
121	ARTIST SOPHIA YESHI TEAMS UP WITH THE PWHL IN A CELEBRATION OF BLACK EXCELLENCE	https://www.thepwhl.com/en/news/2026/february/11/artist-sophia-yeshi-teams-up-with-the-pwhl-in-a-celebration-of-black-excellence	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/sophia_yeshi_new_header?_a=DATAg1ZSZAA0	\N	2026-02-11	\N	2026-03-05 14:42:27.473675-05	\N	\N
122	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 11	https://www.thepwhl.com/en/news/2026/february/11/pwhl-notebook-olympic-winter-games-edition-feb-11	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Karvinen_Finland?_a=DATAg1ZSZAA0	\N	2026-02-11	\N	2026-03-05 14:42:27.473675-05	\N	\N
123	USA RECORDS FIVE GOALS FOR A THIRD STRAIGHT GAME TO HANDLE SWITZERLAND AND STAY UNDEFEATED IN PRELIMINARY ROUND	https://www.thepwhl.com/en/news/2026/february/09/usa-records-five-goals-for-a-third-straight-game-as-they-handle-switzerland-to-stay-undefeated-in-the-preliminary-round	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DOC06774?_a=DATAg1ZSZAA0	\N	2026-02-09T17:08:59-05:00	\N	2026-03-05 14:42:27.473675-05	\N	\N
125	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 9	https://www.thepwhl.com/en/news/2026/february/09/pwhl-notebook-olympic-winter-games-edition-feb-9	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Canada_Goal_vs_Czechia?_a=DATAg1ZSZAA0	\N	2026-02-09	\N	2026-03-05 14:42:29.236786-05	\N	\N
126	GERMANY LEAPFROGS ITALY IN GROUP B WITH 2-1 WIN AS BOTH TEAMS QUALIFY FOR THE KNOCKOUT STAGE	https://www.thepwhl.com/en/news/2026/february/10/germany-leapfrogs-italy-in-the-group-b-standings-with-a-2-1-win-as-both-teams-qualify-for-the-knockout-stage	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20260122_BOS_OlympicsEDITS_013_1?_a=DATAg1ZSZAA0	\N	2026-02-10T16:23:23-05:00	\N	2026-03-05 14:42:29.236786-05	\N	\N
128	CANADA HOLDS SWITZERLAND TO SIX SHOTS ON GOAL AS REIGNING OLYMPIC CHAMPIONS WIN OPENING MATCH IN MILANO CORTINA	https://www.thepwhl.com/en/news/2026/february/07/canada-holds-switzerland-to-just-six-shots-on-goal-as-the-reigning-olympic-champions-win-their-opening-match-in-milano-cortina	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/XUJ09697?_a=DATAg1ZSZAA0	\N	2026-02-07T17:40:07-05:00	\N	2026-03-05 14:42:29.236786-05	\N	\N
129	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 8	https://www.thepwhl.com/en/news/2026/february/08/pwhl-notebook-olympic-winter-games-edition-feb-8	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Mlynkova_Czechia_Feb82026?_a=DATAg1ZSZAA0	\N	2026-02-08	\N	2026-03-05 14:42:29.236786-05	\N	\N
130	CZECHIA RIDES TWO FIRST-PERIOD GOALS TO TAKE DOWN FINLAND 2-0	https://www.thepwhl.com/en/news/2026/february/08/czechia-rides-two-first-period-goals-to-take-down-finland-2-0	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/cze_fin_recap?_a=DATAg1ZSZAA0	\N	2026-02-08T17:56:37-05:00	\N	2026-03-05 14:42:29.236786-05	\N	\N
132	ITALY HOLD ON AGAINST JAPAN TO GET SECOND WIN OF THE WINTER OLYMPIC GAMES	https://www.thepwhl.com/en/news/2026/february/09/italy-hold-on-against-japan-to-get-their-second-win-of-the-winter-olympic-games	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/IMG_5552?_a=DATAg1ZSZAA0	\N	2026-02-09T10:16:45-05:00	\N	2026-03-05 14:42:29.236786-05	\N	\N
134	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 7	https://www.thepwhl.com/en/news/2026/february/07/pwhl-notebook-olympic-winter-games-edition-feb-7	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Kluge-GERvsJPN-8835?_a=DATAg1ZSZAA0	\N	2026-02-07	\N	2026-03-05 14:42:30.049603-05	\N	\N
135	SWEDEN REMAINS PERFECT IN GROUP B, BLANKING FRANCE 4-0	https://www.thepwhl.com/en/news/2026/february/08/sweden-remains-perfect-in-group-b-blanking-france-4-0	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-20260208-SWEvsFRA-538963?_a=DATAg1ZSZAA0	\N	2026-02-08T15:46:26-05:00	\N	2026-03-05 14:42:30.049603-05	\N	\N
136	KRISTIN DELLA ROVERE’S TWO-POINT PERFORMANCE LIFTS HOSTS ITALY TO AN EMPHATIC OPENING WINTER GAMES VICTORY OVER FRANCE	https://www.thepwhl.com/en/news/2026/february/05/kristen-della-roveres-two-point-performance-lifts-hosts-italy-to-an-emphatic-opening-winter-games-victory-over-france	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/c3b51bbd-91d2-4b2a-ab7e-4600e5322cfe?_a=DATAg1ZSZAA0	\N	2026-02-05T13:35:24-05:00	\N	2026-03-05 14:42:30.049603-05	\N	\N
139	SWEDEN HANG SIX ON ITALY AS THEY CRUISE PAST THE HOSTS 6-1	https://www.thepwhl.com/en/news/2026/february/07/sweden-hang-six-on-italy-as-they-cruise-past-the-hosts-6-1	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2026-02-07T14:24:49-05:00	\N	2026-03-05 14:42:30.049603-05	\N	\N
140	USA SHUTS OUT FINLAND, CRUISING TO THEIR SECOND WIN OF THE TOURNAMENT	https://www.thepwhl.com/en/news/2026/february/07/usa-shuts-out-finland-as-they-cruise-to-their-second-win-of-the-tournament	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-20260207-USAvsFIN-4292?_a=DATAg1ZSZAA0	\N	2026-02-07T16:56:56-05:00	\N	2026-03-05 14:42:30.049603-05	\N	\N
141	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 6	https://www.thepwhl.com/en/news/2026/february/06/pwhl-notebook-olympic-winter-games-edition-feb-6	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20260122_BOS_Olympics_Muller_068?_a=DATAg1ZSZAA0	\N	2026-02-06	\N	2026-03-05 14:42:30.049603-05	\N	\N
143	USA DISPATCHES CZECHIA IN 5–1 WIN TO START THEIR CAMPAIGN OFF ON THE RIGHT FOOT	https://www.thepwhl.com/en/news/2026/february/05/usa-dispatches-czechia-in-5-1-win-to-start-their-campaign-off-on-the-right-foot	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/WhatsApp_Image_2026-02-05_at_11.09.38_AM_1?_a=DATAg1ZSZAA0	\N	2026-02-05T14:08:31-05:00	\N	2026-03-05 14:42:30.049603-05	\N	\N
144	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 5	https://www.thepwhl.com/en/news/2026/february/05/pwhl-notebook-olympic-winter-games-edition-feb-5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Ljungblom_Sweden2?_a=DATAg1ZSZAA0	\N	2026-02-05	\N	2026-03-05 14:42:31.07488-05	\N	\N
145	The PWHL celebrates National Girls & Women in Sports Day with Growing Grassroots and Community Impact Programming	https://www.thepwhl.com/en/news/2026/february/04/the-pwhl-celebrates-national-girls-and-women-in-sports-day-with-growing-grassroots-and-community-impact-programming	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DSC_2075?_a=DATAg1ZSZAA0	\N	2026-02-04	\N	2026-03-05 14:42:31.07488-05	\N	\N
146	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 4	https://www.thepwhl.com/en/news/2026/february/04/pwhl-notebook-olympic-winter-games-edition	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1200x800-PWHLOLYGAMES?_a=DATAg1ZSZAA0	\N	2026-02-04	\N	2026-03-05 14:42:31.07488-05	\N	\N
147	PWHL LAUNCHES INAUGURAL MENTORSHIP PROGRAM FOR GIRLS IN HOCKEY	https://www.thepwhl.com/en/news/2025/december/16/pwhl-launches-inaugural-mentorship-program-for-girls-in-hockey	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2026-02-03	\N	2026-03-05 14:42:31.07488-05	\N	\N
148	THE ULTIMATE AWAY GAME: PWHL SET FOR UNPRECEDENTED OLYMPIC IMPACT	https://www.thepwhl.com/en/news/2026/february/03/the-ultimate-away-game-pwhl-set-for-unprecedented-olympic-impact	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1200x800-PWHLOLYGAMES?_a=DATAg1ZSZAA0	\N	2026-02-03	\N	2026-03-05 14:42:31.07488-05	\N	\N
149	OTTAWA CHARGE SIGN MAGGY BURBIDGE TO A RESERVE PLAYER CONTRACT	https://www.thepwhl.com/en/news/2026/february/03/ottawa-charge-sign-maggy-burbidge-to-a-reserve-player-contract	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/maggy-burbidge-_-st-fx?_a=DATAg1ZSZAA0	\N	2026-02-03T11:30:00-05:00	\N	2026-03-05 14:42:31.07488-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
150	A New Generation of USA Women’s Hockey heads to Milan Hungry for Gold	https://www.thepwhl.com/en/news/2026/february/03/a-new-generation-of-usa-womens-hockey-heads-to-milan-hungry-for-gold	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/7f861926-8642-42a5-b32b-1f8e55aa48f220260104-min-mtl-ABC01290?_a=DATAg1ZSZAA0	\N	2026-02-03	\N	2026-03-05 14:42:31.07488-05	\N	\N
152	PWHL ANNOUNCES JANUARY’S PWHL STARTING SIX	https://www.thepwhl.com/en/news/2026/february/03/pwhl-announces-january-s-pwhl-starting-six	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-Starting-Six-JAN-1200x800?_a=DATAg1ZSZAA0	\N	2026-02-03T16:00:00-05:00	\N	2026-03-05 14:42:31.07488-05	\N	\N
155	PWHL WEEKLY NOTEBOOK: JAN. 29, 2026	https://www.thepwhl.com/en/news/2026/january/29/pwhl-weekly-notebook-jan-29-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Kaltounkova_vs_Boston?_a=DATAg1ZSZAA0	\N	2026-01-29	\N	2026-03-05 14:42:31.896109-05	\N	\N
376	Top 10 PWHL Players to watch coming out of the Olympics | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMipwFBVV95cUxPMTRLVG9FX0VwLUwwaVUxQ2JnelZfd0g4NWxLemtyWUtrTXpQYnBFbG1VSnluWlVjS3hPeFJfaldfWU5rZmdsNExsM3NqVHhIX0hvcXVISmgxUWotTXFJZzh2TDUyLWZieW5pSVBzR2VDTWhpb3pnQzduQVdjZHgxNXI5N2lDYjNwR2t2Q3N0S0xIVU1ORWhLNmNSampSZVJGZWQyZUJwbw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-20260219-6734?_a=DATAg1ZSZAA0	\N	2026-02-20T08:00:00+0000	\N	2026-03-06 05:29:52.085395-05	\N	\N
142	LINA LJUNGBLOM'S TWO GOALS KICKS OFF MILANO CORTINA 2026 WITH A DOMINANT 4-1 VICTORY FOR SWEDEN OVER GERMANY	https://www.thepwhl.com/en/news/2026/february/05/lina-ljungblom-s-two-goals-kicks-off-milano-cortina-2026-with-a-dominant-4-1-victory-for-sweden-over-germany	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Ljungblom_Sweden?_a=DATAg1ZSZAA0	\N	2026-02-05T12:51:59-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/201.jpg
158	MÜLLER LEADS BOSTON TO 4-3 SHOOTOUT WIN OVER NEW YORK	https://www.thepwhl.com/en/news/2026/january/28/muller-leads-boston-to-4-3-shootout-win-over-new-york	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_NY_at_BOS_-_Jan._28_2026_14?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	https://assets.leaguestat.com/pwhl/60x60/15.jpg
160	SIXTEEN PWHL PLAYERS NAMED TO U.S. OLYMPIC WOMEN’S ICE HOCKEY TEAM	https://www.thepwhl.com/en/news/2026/january/02/sixteen-pwhl-players-named-to-us-olympic-womens-ice-hockey-team	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEA_KnightChrisMast_20251118_PWHL_REG_SEATTLE_TORRENT_Knight-Hillary_0345?_a=DATAg1ZSZAA0	\N	2026-01-02	\N	2026-03-05 14:42:31.896109-05	\N	\N
161	JAN. 28: TORONTO AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/28/jan-28-toronto-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/12-9-ap-20251207-TORvsMTL-LCA01806?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 14:42:31.896109-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
164	PWHL SUSPENSION TO NEW YORK’S TAYLOR GIRARD REDUCED TO THREE GAMES	https://www.thepwhl.com/en/news/2026/january/28/pwhl-suspension-to-new-york-taylor-girard-reduced-to-three-games	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	https://assets.leaguestat.com/pwhl/60x60/9.jpg
163	JAN. 28: NEW YORK AT BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/28/jan-28-new-york-at-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/BOSvNY0374?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 14:42:31.896109-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
169	PWHL AND THE TRAGICALLY HIP RELEASE EXCLUSIVE MERCHANDISE COLLECTION	https://www.thepwhl.com/en/news/2026/january/27/pwhl-and-the-tragically-hip-release-exclusive-merchandise-collection	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CollectionTile-Desktop?_a=DATAg1ZSZAA0	\N	2026-01-27	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/301.jpg
172	5 Questions With: Emily Clark	https://www.thepwhl.com/en/news/2024/february/08/5-questions-with-emily-clark	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Content/Migration/2b12d5fd11f4823bd8c775b7607f43554d3ca56ee41bd55279b83cd80c2380ab?_a=DATAg1ZSZAA0	\N	2024-02-07T19:36:09-05:00	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/53.jpg
167	TWO MINNESOTA FROST SKATERS NAMED TO 2026 CZECHIA WOMEN’S OLYMPIC NATIONAL TEAM	https://www.thepwhl.com/en/news/2026/january/06/two-minnesota-frost-skaters-named-to-2026-czechia-women-s-olympic-national-team	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-20251230-1105?_a=DATAg1ZSZAA0	\N	2026-01-06	\N	2026-03-05 14:42:32.544571-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
168	PWHL WEEKLY NOTEBOOK: JAN. 26, 2026	https://www.thepwhl.com/en/news/2026/january/26/pwhl-weekly-notebook-jan-26-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_VAN_-_Jan._22_2026_04?_a=DATAg1ZSZAA0	\N	2026-01-26	\N	2026-03-05 14:42:32.544571-05	\N	\N
170	MINNESOTA MOVES UP TO SECOND PLACE WITH 6-2 WIN OVER NEW YORK	https://www.thepwhl.com/en/news/2026/january/25/minnesota-moves-up-to-second-place-with-6-2-win-over-new-york	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MINvNY_1st-07803?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 14:42:32.544571-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
174	MONTRÉAL SIGNS FORWARD HAYLEY SCAMURRA	https://www.thepwhl.com/en/news/2025/june/17/montreal-signs-forward-hayley-scamurra	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MTL_-_Scamurra_-_16x9?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/60x60/61.jpg
173	EIGHTEEN PWHL PLAYERS NAMED TO INTERNATIONAL ROSTERS FOR WOMEN’S WORLDS	https://www.thepwhl.com/en/news/2025/april/01/eighteen-pwhl-players-named-to-international-rosters-for-womens-worlds	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/League_-_Headline_-_COPY_ONLY_-_16x9WWIR?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 14:42:32.544571-05	\N	\N
176	SUMMER CAMPS HEAT UP WITH SIX MONTHS UNTIL OLYMPICS	https://www.thepwhl.com/en/news/2025/august/08/summer-camps-heat-up-with-six-months-until-olympics	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Hilary_Knight_USA?_a=DATAg1ZSZAA0	\N	2025-08-08	\N	2026-03-05 14:42:33.364766-05	\N	\N
379	When does PWHL season start back up? When, where to watch Hilary Knight - USA Today	https://news.google.com/rss/articles/CBMivgFBVV95cUxPbHlKLWhOM2JzWUZ3UTBYdEFUZFZFUTd6UFVXeFg3SU1LeHhCZExsOWxOUlg3Q0g5bVNjNXNOVU5QUndSajhGVGRuYjlfNGxlYjdDd0RIcUFnZFpSc21mWFpWQ1BZVXFxTUtrNWo4TmVzYlA3ZER4cVVYT1FmTWdsT3NnTld4SlR4aFBnZWphZHJPeDRNeF9ycXhSUFRXNG53MkVXSC1XcXptbUQ0bHNVQ3dKQzJWTDlFSzlRX1Rn?oc=5	https://www.usatoday.com/gcdn/authoring/authoring-images/2026/02/23/SFTW/88821670007-2248944222.jpg?crop=4138,2328,x0,y0&width=3200&height=1801&format=pjpg&auto=webp	\N	2026-02-23T08:00:00+0000	\N	2026-03-06 05:29:52.085395-05	\N	\N
58	Fanuza Kadirova scores twice, Charge defeat Torrent 4-3 in PWHL play	https://news.google.com/rss/articles/CBMivwFBVV95cUxQeGs3QmpzbTh3UFdCdjRWZmtEbjA2YUdYM3JqSFFYRDRUWl94bkRtaFliWmpZb2RWaTFYdzZrZmtYVTRlVm9sZnNGT3hBX2E0QTJkY21UeTFTMF96ZFRBV0s4dnZfQnhSaEpITHlPVkJ4anU3NWdxN3RIMGVYaTA4WDZUV0FVUVhERGVxV3haN29HRnpkMUpuLXduNWdaOFBBZWlzY2lKdVpZU0RwaDZ6eEg0QUtqd1Zmc2xXNjJ0dw?oc=5	\N	\N	2026-03-05T04:40:28+0000	\N	2026-03-05 17:36:55.747273-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/60x60/240.jpg
178	FROST CAPTAIN COYNE SCHOFIELD POTS HAT TRICK IN 5-1 WIN OVER CHARGE	https://www.thepwhl.com/en/news/2025/december/02/frost-captain-coyne-schofield-pots-hat-trick-in-5-1-win-over-charge	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Coyne-net?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	https://assets.leaguestat.com/pwhl/60x60/20.jpg
181	FLEET DEFENDER DANIELA PEJŠOVÁ NAMED TO CZECHIA’S 2026 OLYMPIC ROSTER	https://www.thepwhl.com/en/news/2026/january/06/fleet-defender-daniela-pejsova-named-to-czechia-2026-olympic-roster	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PEJ%C5%A0OV%C3%81_AWAY?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	https://assets.leaguestat.com/pwhl/60x60/185.jpg
182	CHARGE FORWARD KATEŘINA MRÁZOVÁ NAMED TO CZECHIA’S OLYMPIC ROSTER	https://www.thepwhl.com/en/news/2026/january/06/charge-forward-katerina-mrazova-named-to-czechia-olympic-roster	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Mrazova-flag?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	https://assets.leaguestat.com/pwhl/60x60/88.jpg
183	KALTOUNKOVÁ’S TWO GOALS, OSBORNE’S SHUTOUT PROPEL SIRENS TO RECORD FOURTH STRAIGHT WIN	https://www.thepwhl.com/en/news/2026/january/06/kaltounkov-s-two-goals-osborne-s-shutout-propel-sirens-to-record-fourth-straight-win	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-NY_at_TOR_-_Jan._6_202610?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	https://assets.leaguestat.com/pwhl/60x60/245.jpg
185	TWENTY-THREE PWHL PLAYERS SELECTED FOR CANADIAN OLYMPIC WOMEN’S ICE HOCKEY TEAM	https://www.thepwhl.com/en/news/2026/january/09/twenty-three-pwhl-players-selected-for-canadian-olympic-womens-ice-hockey-team	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/09-25-2025_PWHL_001_Marie-Phillip_Poulin_00251?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 14:42:34.092611-05	\N	\N
186	TWENTY-TWO PWHL PLAYERS TO REPRESENT SIX EUROPEAN COUNTRIES AT 2026 OLYMPIC GAMES	https://www.thepwhl.com/en/news/2026/january/20/twenty-two-pwhl-players-to-represent-six-european-countries-at-2026-olympic-games	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/120625_Goldeneyes_v_Sirens_-_Jones_-_Final_Take-438?_a=DATAg1ZSZAA0	\N	2026-01-20T09:42:54-05:00	\N	2026-03-05 14:42:34.092611-05	\N	\N
188	JAN. 25: NEW YORK AT MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/25/jan-25-new-york-at-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DSC02727?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 14:42:34.092611-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
187	MURPHY SCORES TWICE TO LEAD MONTRÉAL TO 3-1 HOME WIN AGAINST OTTAWA	https://www.thepwhl.com/en/news/2026/january/24/murphy-scores-twice-to-lead-montreal-to-3-1-home-win-against-ottawa	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_OTT_at_MTL_-_Jan._24_202621?_a=DATAg1ZSZAA0	\N	2026-01-24	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	https://assets.leaguestat.com/pwhl/120x160/250.jpg
190	JAN. 24: OTTAWA AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/24/jan-24-ottawa-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20260113-OTTvsMTL-LCA01056?_a=DATAg1ZSZAA0	\N	2026-01-24	\N	2026-03-05 14:42:34.092611-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
191	PWHL AND PARIS JEWELLERS UNVEIL 2024-25 MINNESOTA FROST CHAMPIONSHIP RING	https://www.thepwhl.com/en/news/2026/january/22/pwhl-and-paris-jewellers-unveil-2024-25-minnesota-frost-championship-ring	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MIN_Frost_Championship_Ring_2024-25_-_1200x800?_a=DATAg1ZSZAA0	\N	2026-01-22	\N	2026-03-05 14:42:34.092611-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
375	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - Ottumwa Courier	https://news.google.com/rss/articles/CBMiqAJBVV95cUxOaDdEUzlJbXFSNVlvZjVoMWgxQ0sxN3AyLWthcWRMNzAyM0tEZU9ILVpzazdWcUd4T2NERkctNnV6YVZuVzAwWERIUkdnallTaG1GNWpCdGMzZzhBZjJqZEQwLVAwdzFlRzhha2lMdnphcWZ3clNUZm1DRW5DM1dFbzEyZmpwcU1wN0NUOThvUjN5MGFTWl9jbTRmcHZFSWJTb0NkV2hCV25WNjhfRWdRZWdGUGd6VmZlNnUyZjlXQ3VpXzhzTDZJVWt6Q0RINzZTTTlKY0lvS2JJeWJkQ1cyTExOV3NKWm9QTHMwRGFfclhLOTZMaDMwVVJtS2VWbS16NVFTQzhGYVktOXBOUlNfamZEMzBWeWhkbHJfQzJLWEljaTROUV91TQ?oc=5	https://bloximages.chicago2.vip.townnews.com/ottumwacourier.com/content/tncms/assets/v3/editorial/0/31/031fd672-ccf1-596c-be99-62ccb586fa7d/69a9e8dbc90d3.image.jpg?crop=1763%2C926%2C0%2C124&resize=1200%2C630&order=crop%2Cresize	\N	2026-03-05T19:50:33+0000	\N	2026-03-06 05:29:47.103825-05	\N	\N
378	PWHL has women’s hockey positioned to finally capitalize on must-watch Olympic momentum - New York Post	https://news.google.com/rss/articles/CBMiqAFBVV95cUxNYjVUcFQtNjV3dzhUV1NqdWg5RjVYV3QyRFBiT1VGcmdRcW96Y3EtSE8zMjNSLWFEbE5PRE1XZ1JST0NOU2Q2ckE2LW9NODBIMXhycEp4MnhRUWh0LXkyU1F4eExNZ2FhMW1aUW5CQ2tveVNHZl9seUV4MlBQb2ctUXVfSmt1WHJ4MkdJOTByZ0d3NzlKM2ZFM2J0M0NkbXVfWG16WjZNM2Y?oc=5	https://nypost.com/wp-content/uploads/sites/2/2026/02/newspress-collage-57za4ya89-1772240837887.jpg?quality=75&strip=all&1772222885&w=1200	\N	2026-02-28T01:30:00+0000	\N	2026-03-06 05:29:47.103825-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
377	Women's hockey Olympians headed to Detroit during PWHL Takeover Tour - How to see them play - FOX 2 Detroit	https://news.google.com/rss/articles/CBMioAFBVV95cUxOOUloSkVkRDhuVjhfQTFEdE5FMGEwMlBwNEF2X3l6R1Q5NXJOUGx2S2hockhNZTdsR3ZBcjB6WVZMRThDLVdLQTZkcFh6M1FyNExWcFZQeFd4OW1jVVJjd1hma1NOclFkLXVLZHFVNEJhRzNJa21NRVJmU1Jsd3I2Y1NKRThXVUtUVlZQUGJuWWYxNjdYaE5yUU5QazVXNUtL0gGmAUFVX3lxTE91LWdHTnpRS3N6QlVMcGVFVFBHdXYxVDJfcDdwSE1lLTF1VFhHa1RBb3R4cll2akZMNkUyX0NYVFVwRGdIX3pwSzRkZzl6MkJpbkNNYzNya1AtbkxHY1h4UzFDRndlRTE4T0dEa0NLZ2lBd3p2ckNJdDVBVmh4Tm5JU1JWeWRTekMyRXQwbHdEbG9DMWVFS1UydEM1U21ZVFlmbDJTc0E?oc=5	https://images.foxtv.com/static.fox2detroit.com/www.fox2detroit.com/content/uploads/2026/02/1200/630/gettyimages-2262509966.jpg?ve=1&tl=1	\N	2026-02-23T08:00:00+0000	\N	2026-03-06 05:29:52.085395-05	\N	\N
380	15 Olympic women's hockey players coming to Detroit for 2nd PWHL game, including Canada's captain - WXYZ Channel 7	https://news.google.com/rss/articles/CBMivwFBVV95cUxPVExFN1ZjdDQ5Tk9jWGNULXhJc0NNWnZYdUt5SjlMaGEyN2dfSDhqNDY5ZGw5RHBzZTAycXZYMEpWb0pFOENxRjJ2ck4zWEd0NjdGdW5vQzktSGtUV2otam1oWURoR2RlZW8tR09lYUdwUTFLM2drOF9mY0Vnc1JMczNFR3BDd3JVSXNrWWZoVXFKdVBmZDFKbGxkSEF5aFllZnZ2aUpCOFEtcFBjdHhTYVFlaXBqOGxXUkh6dUl5SQ?oc=5	https://ewscripps.brightspotcdn.com/dims4/default/eb67dd0/2147483647/strip/true/crop/1024x538+0+73/resize/1200x630!/quality/90/?url=http%3A%2F%2Fewscripps-brightspot.s3.amazonaws.com%2Fef%2Fdd%2F9050d31243c286afbff616ec2d98%2Fap26040820014747.jpg	\N	2026-02-25T16:06:58+0000	\N	2026-03-06 05:29:52.085395-05	\N	\N
195	CHARGE ESCAPE WITH 4-3 OVERTIME WIN OVER SIRENS	https://www.thepwhl.com/en/news/2026/january/20/charge-escape-with-4-3-overtime-win-over-sirens	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Wozniewicz_OTW_vs_NY?_a=DATAg1ZSZAA0	\N	2026-01-20	\N	2026-03-05 14:42:35.004215-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
197	JAN. 21: MONTRÉAL AT MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/21/jan-21-montreal-at-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/011225_AP-88?_a=DATAg1ZSZAA0	\N	2026-01-21	\N	2026-03-05 14:42:35.004215-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
198	JAN. 20: OTTAWA AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/20/jan-20-ottawa-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CHARGE_AT_SIRENS_03105-ap-1.19.26?_a=DATAg1ZSZAA0	\N	2026-01-20	\N	2026-03-05 14:42:35.004215-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
383	2025-26 PWHL Power Rankings: Week 11 (02/26-03/05)	https://www.theixsports.com/the-ice-garden/pwhl/pwhl-power-rankings-fleet-victoire-frost-charge-sirens-sceptres-torrent-goldeneyes/	https://www.theixsports.com/wp-content/uploads/2026/03/Screenshot-2026-03-06-at-12.44.21-AM.png	\N	2026-03-06T14:00:00+0000	\N	2026-03-06 09:29:46.555415-05	\N	\N
200	NEW YORK EARNS 2-1 WIN OVER MONTRÉAL IN RECORD-SETTING GAME IN D.C.	https://www.thepwhl.com/en/news/2026/january/18/new-york-earns-2-1-win-over-montreal-in-record-setting-game-in-d-c-	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MTL_at_NY_-_Jan._18_2026_19?_a=DATAg1ZSZAA0	\N	2026-01-18	\N	2026-03-05 14:42:35.004215-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
381	Lily Shannon Aims To Make A Big Impact Both On And Off The Ice In The PWHL - The Hockey News	https://news.google.com/rss/articles/CBMisgFBVV95cUxPZm5Sc3JVYWhjRnZqVzBFbV9nVlZabDZEUk9YLWxzQVV6Zy1YdnNaWFJZd3VQblV4WHpPcTh1Xzl3c3ZaR2dYb2JERHAyTl9qS0EyMHo3Zko4a2FtaXVBd3dFenhfNFZHWXRZb3dtTGJEbXp3bjB0Sm9tVmVJbm5tWndralBwRlRuNWRUbHlpREJsblZBOHp6azFOMl9DZEctNXJ6NGlMR3J1dnlrYmZzV2pR?oc=5	https://deweb-519a7.b-cdn.net/post-images/76b0c41b-f3b1-42bd-880d-8fbfd154ccc7.webp	\N	2026-03-06T12:23:49+0000	\N	2026-03-06 09:29:46.805571-05	\N	\N
382	Inside The Anatomy Of A PWHL Shootout - The Hockey News	https://news.google.com/rss/articles/CBMigAFBVV95cUxPajYwVG1SR2VvOGw3N3dLOVFmdlF0MTNIUkh2aURMZ1B3Qm9NaW1xam44aThPTGpVOTlQZ2lmQzJBblc4eTMwNVJ0NGdzVlVFTHhtQWtyUTN4T3NjdWx5WWFwdGViRTZIcWlLbHNfV3hKMXM1Nlo2YTB3WGpHaTBpRw?oc=5	https://deweb-519a7.b-cdn.net/post-images/5a7d23f2-c6f8-4420-b3e7-bf2b45af05a3.jpeg	\N	2026-03-05T01:08:25+0000	\N	2026-03-06 09:29:46.805571-05	\N	\N
203	PWHL WEEKLY NOTEBOOK: JAN. 19, 2026	https://www.thepwhl.com/en/news/2026/january/19/pwhl-weekly-notebook-jan-19-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Sirens_DC_JR22352?_a=DATAg1ZSZAA0	\N	2026-01-19	\N	2026-03-05 14:42:35.004215-05	\N	\N
204	PWHL PLAYER SAFETY COMMITTEE DISCIPLINARY ACTION: JAN. 19, 2026	https://www.thepwhl.com/en/news/2026/january/19/pwhl-player-safety-committee-disciplinary-action-jan-19-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Player_Safety_-_Headline_-_16x9_2?_a=DATAg1ZSZAA0	\N	2026-01-19	\N	2026-03-05 14:42:35.947099-05	\N	\N
206	JAN. 18: PWHL TAKEOVER TOUR MONTRÉAL VS. NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/18/jan-18-pwhl-takeover-tour-montreal-vs-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/ToT-DC-0118-1200x800-with-BJs-logo?_a=DATAg1ZSZAA0	\N	2026-01-18	\N	2026-03-05 14:42:35.947099-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
208	PWHL BREAKS U.S. WOMEN'S HOCKEY ATTENDANCE RECORD AT CAPITAL ONE ARENA IN WASHINGTON, D.C.	https://www.thepwhl.com/en/news/2026/january/18/pwhl-breaks-us-womens-hockey-attendance-record-at-capital-one-arena-in-washington-dc	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1200x800DC_Final?_a=DATAg1ZSZAA0	\N	2026-01-18	\N	2026-03-05 14:42:35.947099-05	\N	\N
209	FROST SILENCE SIRENS IN 3-2 OVERTIME VICTORY	https://www.thepwhl.com/en/news/2026/january/16/frost-silence-sirens-in-3-2-overtime-victory	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_NY_-_Jan._16_2026_01?_a=DATAg1ZSZAA0	\N	2026-01-16	\N	2026-03-05 14:42:35.947099-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
211	BEGINNER'S GUIDE TO THE PWHL	https://www.thepwhl.com/en/news/2025/april/18/pwhl-beginners-guide	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/League-BeginnersGuide-Slide1-1200x800?_a=DATAg1ZSZAA0	\N	2026-01-16	\N	2026-03-05 14:42:35.947099-05	\N	\N
212	JAN. 16: MINNESOTA AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/16/jan-16-minnesota-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/FROST_SIRENS_26419?_a=DATAg1ZSZAA0	\N	2026-01-16	\N	2026-03-05 14:42:35.947099-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
213	BOSTON STAYS UNBEATEN AT HOME WITH 2-1 WIN OVER TORONTO	https://www.thepwhl.com/en/news/2026/january/14/boston-stays-unbeaten-at-home-with-2-1-win-over-toronto	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_BOS_-_Jan._14_2026_10?_a=DATAg1ZSZAA0	\N	2026-01-14	\N	2026-03-05 14:42:35.947099-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
214	CHARGE TRIO NAMED TO CANADA’S OLYMPIC ROSTER	https://www.thepwhl.com/en/news/2026/january/09/charge-trio-named-to-canada-s-olympic-roster	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Jenner-flag?_a=DATAg1ZSZAA0	\N	2026-01-09T16:04:39-05:00	\N	2026-03-05 14:42:36.720898-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
215	MONTRÉAL SNAPS OTTAWA’S WIN STREAK WITH 2-1 VICTORY	https://www.thepwhl.com/en/news/2026/january/13/montreal-snaps-ottawa-win-streak-with-2-1-victory	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_OTT_at_MTL_-_Jan._13_2026_04?_a=DATAg1ZSZAA0	\N	2026-01-13	\N	2026-03-05 14:42:36.720898-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
216	JAN. 14: TORONTO AT BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/14/jan-14-toronto-at-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1010?_a=DATAg1ZSZAA0	\N	2026-01-14	\N	2026-03-05 14:42:36.720898-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
217	OTTAWA WINS SIXTH STRAIGHT, TOPPING BOSTON 2-1 IN HALIFAX	https://www.thepwhl.com/en/news/2026/january/11/ottawa-wins-sixth-straight-topping-boston-2-1-in-halifax	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-OTT_at_BOS_-_Halifax_Takeover_Tour20?_a=DATAg1ZSZAA0	\N	2026-01-11	\N	2026-03-05 14:42:36.720898-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
220	PWHL WEEKLY NOTEBOOK: JAN. 12, 2026	https://www.thepwhl.com/en/news/2026/january/12/pwhl-weekly-notebook-jan-12-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Takeover_Tour_Quebec_City_Crowd?_a=DATAg1ZSZAA0	\N	2026-01-12	\N	2026-03-05 14:42:36.720898-05	\N	\N
221	JAN. 13: OTTAWA AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/13/jan-13-ottawa-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v2-20250129-OTTvMTL-LCA00218?_a=DATAg1ZSZAA0	\N	2026-01-13	\N	2026-03-05 14:42:36.720898-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
222	PWHL PLAYER SAFETY COMMITTEE DISCIPLINARY ACTION: JAN. 13, 2026	https://www.thepwhl.com/en/news/2026/january/13/pwhl-player-safety-committee-disciplinary-action-jan-13-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Player_Safety_-_Headline_-_16x9_2?_a=DATAg1ZSZAA0	\N	2026-01-13	\N	2026-03-05 14:42:36.720898-05	\N	\N
223	JAN. 11: PWHL TAKEOVER TOUR OTTAWA VS. BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/11/jan-11-pwhl-takeover-tour-ottawa-vs-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/12.30.25-Takeover-Tour-Halifax-2-1200x800?_a=DATAg1ZSZAA0	\N	2026-01-11	\N	2026-03-05 14:42:36.720898-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
355	PWHL WEEKLY NOTEBOOK: JAN. 12, 2026	https://news.google.com/rss/articles/CBMihwFBVV95cUxQNkFjSUs1NnJBYjdjZlpkbHFXM2dXR05ISUVOYVRKVDJoczlJdkNlSC1yRVVhNzcza1JIUm5XczZMVGZZVGtBOGdUQjhWLVNQaXRncElucHgzR3RTM2R3dkRYVy1SZmVUS0tQTERDaWYxdFgtUDhNSE9MMlBCVnR6cm5Ma0hzUU0?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Takeover_Tour_Quebec_City_Crowd?_a=DATAg1ZSZAA0	\N	2026-01-12T08:00:00+0000	\N	2026-03-05 21:43:09.505869-05	\N	\N
354	PWHL SEATTLE UNVEILS INAUGURAL SEASON SCHEDULE	https://news.google.com/rss/articles/CBMiqwFBVV95cUxNR0NFUkJsbzI5MGJRX21DaFYyd1Zva2hpZ3p1NXdGMm05eXNDMzV3Zi11MlpGT3F1RlZFX0V6VjZ2Tk1uSVNqTnNSLUR6a0hqUnAxQUlQOWxPVEZFWWVUMnU5cDZDYTBjbmhpUnFvN0c2T1Z5Q0IyczI2Y2M2c3FKSFU4UDlCbHgxcml6Sm1TT19XMEpxTnhSbXg3d3BFaWxLd0dHVWo1MW55aGc?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL-seattle-SEA-Schedule-1200x800?_a=DATAg1ZSZAA0	\N	2025-10-01T07:00:00+0000	\N	2026-03-05 21:43:18.945319-05	["https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
370	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - Midland Daily News	https://news.google.com/rss/articles/CBMiogFBVV95cUxNNVJJejVSVlFLUUE4NEo3dWNIOVNZLU9zS2tNeWJqdDVtTDdzNXQyclp0SG9uR2lES0pJVmVrVy1nM0t5MWlkb0RPRlI1TmVNYXMxa19wSFg1c1Ria04yVlFjVWw1dThud1B4VURmUmUybzZld0J1TEdCbDlyNGhVc1FMLW45MmpwWkI4WDFTUS1Sd0JEVmxDY1RuLUZaSVRhUnc?oc=5	\N	\N	2026-03-05T20:13:30+0000	\N	2026-03-06 09:45:10.457739-05	\N	\N
233	POULIN’S OVERTIME GOAL, THREE POINTS LEAD VICTOIRE TO THRILLING 3-2 WIN OVER FROST	https://www.thepwhl.com/en/news/2026/january/04/poulin-overtime-goal-three-points-lead-victoire-to-thrilling-3-2-win-over-frost	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_MTL_-_Jan._4_2026_12?_a=DATAg1ZSZAA0	\N	2026-01-04	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/60x60/31.jpg
230	PWHL WEEKLY NOTEBOOK: JAN. 5, 2026	https://www.thepwhl.com/en/news/2026/january/05/pwhl-weekly-notebook-jan-5-2026	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_SEA_TORJAN32026_COFFEY_ALLFINALS-112?_a=DATAg1ZSZAA0	\N	2026-01-05	\N	2026-03-05 14:42:37.641985-05	\N	\N
231	JAN. 6: NEW YORK AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/06/jan-6-new-york-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-Sceptres-20250125-0845?_a=DATAg1ZSZAA0	\N	2026-01-06	\N	2026-03-05 14:42:37.641985-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
232	OTTAWA STREAK REACHES FOUR WITH 5-2 WIN OVER MINNESOTA	https://www.thepwhl.com/en/news/2026/january/03/ottawa-streak-reaches-four-with-5-2-win-over-minnesota	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Charge-win-Clark-goal?_a=DATAg1ZSZAA0	\N	2026-01-03	\N	2026-03-05 14:42:37.641985-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
245	HEISE, COYNE SCHOFIELD LEAD MINNESOTA TO 5-1 ROAD WIN OVER TORONTO	https://www.thepwhl.com/en/news/2025/december/30/heise-coyne-schofield-lead-minnesota-to-5-1-road-win-over-toronto	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/A15I0718?_a=DATAg1ZSZAA0	\N	2025-12-30	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/60x60/20.jpg
236	JAN. 4: MINNESOTA AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/04/jan-4-minnesota-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20250117-MINvMTL-LCA00234?_a=DATAg1ZSZAA0	\N	2026-01-04	\N	2026-03-05 14:42:38.458384-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
237	SIRENS OPEN NEW YEAR WITH THIRD STRAIGHT WIN OVER VICTOIRE	https://www.thepwhl.com/en/news/2026/january/02/sirens-open-new-year-with-third-straight-win-over-victoire	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MTL_at_NY_-_Jan._2_202619?_a=DATAg1ZSZAA0	\N	2026-01-02	\N	2026-03-05 14:42:38.458384-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
239	JAN. 3: MINNESOTA AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/03/jan-3-minnesota-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_37A7551?_a=DATAg1ZSZAA0	\N	2026-01-03	\N	2026-03-05 14:42:38.458384-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
242	JAN. 2: MONTRÉAL AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/02/jan-2-montreal-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/VICTOIRE_SIRENS_51752?_a=DATAg1ZSZAA0	\N	2026-01-02	\N	2026-03-05 14:42:38.458384-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
243	PWHL ANNOUNCES DECEMBER’S PWHL STARTING SIX	https://www.thepwhl.com/en/news/2026/january/02/pwhl-announces-december-s-pwhl-starting-six	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-Starting-Six-DEC-1200x800?_a=DATAg1ZSZAA0	\N	2026-01-02T12:30:00-05:00	\N	2026-03-05 14:42:38.458384-05	\N	\N
247	PWHL PLAYER SAFETY COMMITTEE DISCIPLINARY ACTION: DEC. 31, 2025	https://www.thepwhl.com/en/news/2025/december/31/pwhl-player-safety-committee-disciplinary-action-dec-31-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Player_Safety_-_Headline_-_16x9_2?_a=DATAg1ZSZAA0	\N	2025-12-31	\N	2026-03-05 14:42:39.225882-05	\N	\N
37	Milano Cortina 2026 Olympics Hub - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiS0FVX3lxTE1sMGtWZ0hPNExTenB3OGFkREo0VjJzbExDRzBoUVRtVC1TMDE1ZDB2OHNfVEpwWDFoTjl1NFZ6cnBJaWE0UXZfNzVIWQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2026-01-27T21:48:17+0000	\N	2026-03-05 21:43:09.505869-05	\N	\N
27	Opinion: The Time Has Come For All PWHL Venues To Share The Ice And Put Down Team Logos - The Hockey News	https://news.google.com/rss/articles/CBMiwgFBVV95cUxQVV9NTFMxbWZMUFA3Y1d5MkxudXFMX0RTSml0X3lvbTVwR1h1VGtveTRfclkxeUtHV3gtd3dXaDlYWVZlM3duOERwQS1JdS04Z0FOMVJud1RSWDRUdUZVZWdXMk9aWnVDaC05LUJJWjVpYm5BSUh1MlhyX3cxNFRWTGpsQkVSa3QzNFdrUUlsZkI4Z2Y0ZW1kUWxTb3g1THVhajBuWElIODMxajJqMThoN29ubmRHY0NmN0l0dGRyX3g2Zw?oc=5	https://deweb-519a7.b-cdn.net/post-images/3191b6b6-9999-4c5e-908f-21d0df0cc061.jpeg	\N	2026-03-04T14:24:50+0000	\N	2026-03-05 21:42:22.182656-05	\N	\N
36	Recapping the seven PWHL Olympic Rookies who won gold at Milano Cortina 2026	https://news.google.com/rss/articles/CBMiwwFBVV95cUxNTWJwX2hQSzhsdC1oVlJWQzlrZzFuT0dPdVpjem51SkZhay1XZVc1dERBSkloaHVrY2hZUVVWU1NiVVJXUmEzR1lmY2I1a25TYVNURU1DenJUVVRJajRJM0NPREVqOVdYTFdSWHJCc0pfUzk0a2lFZGlsbk1ITmVTcFJWNWhycUtZSmVMazkzd0FsUU0tTlVnSUhnOURxb1plY3ZmUFdzUVp1dkgxU0NINUFLUmdKdm9vSlplWm10WXk5YVE?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/frankel_and_philips_3?_a=DATAg1ZSZAA0	\N	2026-02-23T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	\N	\N
384	Olympic gold, sold-out arenas: Kendall Coyne Schofield sees PWHL surge - Marco Eagle	https://news.google.com/rss/articles/CBMi2gFBVV95cUxQRnZSVndnQjRubk9GclZMcEQ3QjJGRWQ5MDhmbHpGcllFZnVET0VBbF9BU0lBV0JGY1NsX2d6ZVFpQ01LSDlERUtJbldIaktvaE5KZW5qczhQbGlybVIxN0h0Z1JGOW9RNkRfaU5HSEtDME9JUFlocjc0VmFNd2lpT2dnbDQyZmlfWU8zTWJYN2hZUE9Qb2RUMVdPaHI5bTJWMkNBY0ozaEZWQmFiMTJNclVLTC1Qd1duQmRxc0s3cWJaX091SThLUktMeElWVTNjR0tYVHUzYVlMdw?oc=5	https://www.marconews.com/gcdn/authoring/authoring-images/2026/03/06/SFTW/89016486007-2249400385.jpg?crop=4935,2777,x0,y44&width=3200&height=1801&format=pjpg&auto=webp	\N	2026-03-06T18:20:00+0000	\N	2026-03-06 13:29:47.421546-05	\N	\N
249	DEC. 30: MINNESOTA AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/30/dec-30-minnesota-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-20250211-TORvMIN-9444?_a=DATAg1ZSZAA0	\N	2025-12-30	\N	2026-03-05 14:42:39.225882-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
250	TORONTO BEATS MONTRÉAL 2-1 AT THE BELL CENTRE	https://www.thepwhl.com/en/news/2025/december/27/toronto-beats-montreal-2-1-at-the-bell-centre	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_MTL_-_Dec._27_2025_15?_a=DATAg1ZSZAA0	\N	2025-12-27	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/60x60/50.jpg
252	CHARGE TOPS FIRST-PLACE FLEET IN SHOOTOUT FOR THIRD STRAIGHT EXTRA TIME WIN	https://www.thepwhl.com/en/news/2025/december/27/charge-tops-first-place-fleet-in-shootout-for-third-straight-extra-time-win	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Fanuza-goal?_a=DATAg1ZSZAA0	\N	2025-12-27	\N	2026-03-05 14:42:39.225882-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
254	DEC. 27: BOSTON AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/27/dec-27-boston-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Credit_PWHL_-_BOS_at_OTT_-_MAR_15_20251?_a=DATAg1ZSZAA0	\N	2025-12-27	\N	2026-03-05 14:42:40.059468-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
255	DEC. 27: TORONTO AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/27/dec-27-toronto-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/12.26.25-20250301-BOSvMTL-ABB05642?_a=DATAg1ZSZAA0	\N	2025-12-27	\N	2026-03-05 14:42:40.059468-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
257	CHARGE SCORE FOUR STRAIGHT GOALS TO SHOCK SCEPTRES IN OVERTIME	https://www.thepwhl.com/en/news/2025/december/23/charge-score-four-straight-goals-to-shock-sceptres-in-overtime	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/OTTatTOR-23.12.25?_a=DATAg1ZSZAA0	\N	2025-12-24	\N	2026-03-05 14:42:40.059468-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
259	PWHL WEEKLY NOTEBOOK: DEC. 22, 2025	https://www.thepwhl.com/en/news/2025/december/22/pwhl-weekly-notebook-dec-22-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_Takeover_Tour_-_Toronto_vs_Montreal_-_Starting_Lineups_-_Oh_Canada_-_Puck_Drops_-19?_a=DATAg1ZSZAA0	\N	2025-12-22	\N	2026-03-05 14:42:40.059468-05	\N	\N
260	DEC. 23: OTTAWA AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/23/dec-23-ottawa-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_OTT_at_TOR_-_Dec._4_20254?_a=DATAg1ZSZAA0	\N	2025-12-23	\N	2026-03-05 14:42:40.059468-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
263	MONTRÉAL OPENS TAKEOVER TOUR WITH 2-1 SHOOTOUT WIN OVER TORONTO IN HALIFAX	https://www.thepwhl.com/en/news/2025/december/18/montr-al-opens-takeover-tour-with-2-1-shootout-win-over-toronto-in-halifax	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_Takeover_Tour_Halifax_-_MTL_vs_TOR_-_Dec._17_2025_04?_a=DATAg1ZSZAA0	\N	2025-12-17	\N	2026-03-05 14:42:40.059468-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
44	Professional Women’s Hockey League (PWHL) | Expansion, Teams, History, & Schedule - Britannica	https://news.google.com/rss/articles/CBMidEFVX3lxTE12MEl0NGtEWE00cWxwcHpNLWJ2R2FPMXBJY3ZoS210N0JCYXJUTm9TSy1sSVlBRDU2ZnZnaElqY3BUeFNoRHhpdnBtMnpJOHJQeHVtM0lDQkVsUVNyZ2hLTFdWZmtBVzdxWGdqVWx1MEdBWXlU?oc=5	\N	\N	2026-02-05T08:00:00+0000	\N	2026-03-05 17:37:04.009708-05	\N	\N
265	DEC. 21: TORONTO AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/21/dec-21-toronto-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SIRENS_SCEPTRES_12182422109?_a=DATAg1ZSZAA0	\N	2025-12-21	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
39	If The PWHL Were To Sell Of Franchises, What Would They Be Valued At? - The Hockey News	https://news.google.com/rss/articles/CBMiqAFBVV95cUxPU2hSZXE2eW1YRGFqbW5YQk15cWZqMzI5OXVFT0NnYktWdzJVLTdqbm9IWVJ6TDJ5b0Z6MEFhcEU3VFpIRExGTmktOFUtQjNfNE9mQzkxSm5KYlpQRExBSWlzS1VxRTZIaDF5S2UzQ0xzdFN5TENvbEFIYkRVVGFuU21FcXR0VVVzVFd2RzVMQjlaa0Fxb3FNbHczeUNhRU9reDZUR2RvVGE?oc=5	https://deweb-519a7.b-cdn.net/post-images/c336fc3c-90f5-46a3-b3e4-402ea152f288.jpeg	\N	2026-03-03T17:25:16+0000	\N	2026-03-05 21:42:26.570448-05	\N	\N
266	DEC. 21: PWHL TAKEOVER TOUR OTTAWA VS. MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/21/dec-21-pwhl-takeover-tour-ottawa-vs-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-Tot-CHI-1221-1200x800?_a=DATAg1ZSZAA0	\N	2025-12-21	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
268	SCEPTRES HOLD ON FOR 4-3 WIN OVER SIRENS	https://www.thepwhl.com/en/news/2025/december/21/sceptres-hold-on-for-4-3-win-over-sirens	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_NY_-_Dec._21_2025_02?_a=DATAg1ZSZAA0	\N	2025-12-21	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
269	OTTAWA BEATS MINNESOTA 3-2 IN OVERTIME IN CHICAGO’S TAKEOVER TOUR DEBUT	https://www.thepwhl.com/en/news/2025/december/21/ottawa-beats-minnesota-3-2-in-overtime-in-chicago-s-takeover-tour-debut	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_OTT_at_MIN_CHICAGO_-_Dec._21_2025_17?_a=DATAg1ZSZAA0	\N	2025-12-21	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
270	FROST FREEZE FLEET’S STREAK WITH 5-2 WIN AT HOME	https://www.thepwhl.com/en/news/2025/december/19/frost-freeze-fleet-s-streak-with-5-2-win-at-home	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_MIN-_Dec._19_2025_06?_a=DATAg1ZSZAA0	\N	2025-12-19	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
272	DEC. 19: BOSTON AT MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/19/dec-19-boston-at-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DSC01040?_a=DATAg1ZSZAA0	\N	2025-12-19	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
273	BOSTON SECURES RECORD FIFTH-STRAIGHT VICTORY WITH 2-0 WIN OVER NEW YORK	https://www.thepwhl.com/en/news/2025/december/17/boston-secures-record-fifth-straight-victory-with-2-0-win-over-new-york	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_NY_-_Dec._17_2025_09?_a=DATAg1ZSZAA0	\N	2025-12-17	\N	2026-03-05 14:42:40.907655-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
274	PWHL goes big with 2025-26 brand campaign	https://www.thepwhl.com/en/news/2025/december/18/pwhl-goes-big-with-2025-26-brand-campaign	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-Campaign3-BTS-3206?_a=DATAg1ZSZAA0	\N	2025-12-18	\N	2026-03-05 14:42:41.737602-05	\N	\N
276	DEC. 17: PWHL TAKEOVER TOUR MONTRÉAL VS. TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/17/dec-17-pwhl-takeover-tour-montreal-vs-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-Takeover_Tour_-_Halifax_1_-_1200x800?_a=DATAg1ZSZAA0	\N	2025-12-17	\N	2026-03-05 14:42:41.737602-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
277	DEC. 17: BOSTON AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/17/dec-17-boston-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v2-FLEET_AT_SIRENS_60906?_a=DATAg1ZSZAA0	\N	2025-12-17	\N	2026-03-05 14:42:41.737602-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
280	PWHL WEEKLY NOTEBOOK: DEC. 15, 2025	https://www.thepwhl.com/en/news/2025/december/15/pwhl-weekly-notebook-dec-15-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/120625_Goldeneyes_v_Sirens_-_Jones_-_Final_Take-250?_a=DATAg1ZSZAA0	\N	2025-12-15	\N	2026-03-05 14:42:41.737602-05	\N	\N
281	THE PWHL AND THE REALEST ANNOUNCE A FIRST OF ITS KIND LEAGUE-WIDE AUTHENTICATION PROGRAM AND AUTHENTICS SHOP FOR WOMEN’S HOCKEY MEMORABILIA	https://www.thepwhl.com/en/news/2025/december/10/the-professional-women-s-hockey-league-pwhl-and-the-realest-announce-a-first-of-its-kind-league-wide-authentication-program-and-authentics-shop-for-women-s-hockey-memorabilia	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2025-12-11	\N	2026-03-05 14:42:41.737602-05	\N	\N
282	BOSTON HEADS INTO THE BREAK UNDEFEATED WITH 4-1 WIN OVER MINNESOTA	https://www.thepwhl.com/en/news/2025/december/07/boston-heads-into-the-break-undefeated-with-4-1-win-over-minnesota	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/credit_pwhl_-_min_at_bos_-_dec._7_2025_11?_a=DATAg1ZSZAA0	\N	2025-12-07T19:10:51-05:00	\N	2026-03-05 14:42:41.737602-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
283	PWHL WEEKLY NOTEBOOK: DEC. 8, 2025	https://www.thepwhl.com/en/news/2025/december/08/pwhl-weekly-notebook-dec-8-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_BOS_-_Dec._7_2025_02?_a=DATAg1ZSZAA0	\N	2025-12-08	\N	2026-03-05 14:42:41.737602-05	\N	\N
294	PWHL NAMES SANDY CROSS VICE PRESIDENT OF PEOPLE & CULTURE	https://www.thepwhl.com/en/news/2025/december/04/pwhl-names-sandy-cross-vice-president-of-people-and-culture	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2025-12-04	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/251.jpg
285	DEC. 7: TORONTO AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/07/dec-7-toronto-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20250130-TORvMTL-LCA00203?_a=DATAg1ZSZAA0	\N	2025-12-07	\N	2026-03-05 14:42:42.758693-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
286	DEC. 7: MINNESOTA AT BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/07/dec-7-minnesota-at-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/EJ21625_80?_a=DATAg1ZSZAA0	\N	2025-12-07	\N	2026-03-05 14:42:42.758693-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
287	MONTRÉAL WINS SECOND STRAIGHT WITH 3-1 VICTORY OVER TORONTO	https://www.thepwhl.com/en/news/2025/december/07/montreal-wins-second-straight-with-3-1-victory-over-toronto	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_MTL_-_Dec._7_2025_14?_a=DATAg1ZSZAA0	\N	2025-12-07	\N	2026-03-05 14:42:42.758693-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
289	DEC. 4: OTTAWA AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/04/dec-4-ottawa-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-TORvOTT-20241231-3-14?_a=DATAg1ZSZAA0	\N	2025-12-04	\N	2026-03-05 14:42:42.758693-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
290	TORONTO TAKES DOWN OTTAWA TO EARN FIRST HOME WIN OF THE SEASON	https://www.thepwhl.com/en/news/2025/december/04/toronto-takes-down-ottawa-to-earn-first-home-win-of-the-season	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/4.12.25-TORvOTT?_a=DATAg1ZSZAA0	\N	2025-12-04	\N	2026-03-05 14:42:42.758693-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
296	DEC. 2: MINNESOTA AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/02/dec-2-minnesota-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2025_03_11_Ott_vs_Min-06858?_a=DATAg1ZSZAA0	\N	2025-12-02	\N	2026-03-05 14:42:43.477361-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
297	PWHL ANNOUNCES NOVEMBER’S PWHL STARTING SIX	https://www.thepwhl.com/en/news/2025/december/02/pwhl-announces-novembers-pwhl-starting-six	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-Starting-Six-NOV-1200x800?_a=DATAg1ZSZAA0	\N	2025-12-02T15:30:00-05:00	\N	2026-03-05 14:42:43.477361-05	\N	\N
300	FLEET STAY UNDEFEATED, BEAT SCEPTRES 3-1 IN TORONTO HOME OPENER	https://www.thepwhl.com/en/news/2025/november/29/fleet-stay-undefeated-beat-sceptres-3-1-in-toronto-home-opener	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_TOR_-_Nov._28_202520?_a=DATAg1ZSZAA0	\N	2025-11-29	\N	2026-03-05 14:42:43.477361-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
386	Kadirova Proving There’s A PWHL Talent Pipeline Available In Russia - The Hockey News	https://news.google.com/rss/articles/CBMiqAFBVV95cUxQcW5EZFRrOWFOZjFtemlnU3RwQ3hzUVlrLWdIMEFtMFEyUzhiSHAydk5OTjRRNXZCcUxhTWNKMG1icV9SalhDc3R1M1h0anBPRFdhY050QlBJMzgtQkd2N3JDaDdWZ1kwdnVQb0Fha3drS1Byb3ZmbWI2bVZWMmlBU3JIdEhOMXM1UEZFNHhvVkd1eVp1ZUNKRldHSUtQdGRfcl9WeG90RV8?oc=5	https://deweb-519a7.b-cdn.net/post-images/8f828283-5ef9-4f38-a053-983c2d1c3293.jpeg	\N	2026-03-06T14:46:29+0000	\N	2026-03-06 13:29:47.421546-05	\N	\N
54	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 12 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxPMTdQWlY0STExUVJQbjB2QmNvS1dVZm5UbEVzTEl5SmRybEZfa0ltbVVNRFgxTmJBQ3ZNZzJXZWlfZ053NXlBMjNmNFdHTUs1WmI4b2RWSWwybjZhTnZGTWJiVW84ZWNFczJtelZpamQyYlJ3N3pJMmd1WlE4bmlfWE5sbGJRR0pwTUpCUUFkaldRVVFZZTNCZkZ0OHBHWDQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CAN_FIN-2026-02-12-09-08-27?_a=DATAg1ZSZAA0	\N	2026-02-12T08:00:00+0000	\N	2026-03-05 21:43:00.146896-05	\N	\N
388	Caroline Harvey is having a star-making run at the Olympics for U.S. women’s hockey - The Athletic - The New York Times	https://news.google.com/rss/articles/CBMimgFBVV95cUxOcmtJS251b0tMUjZVTl9GZmVsNUlGb1ZVdWpEVTBHT1J1QlhwM0NmdnRuc0lKdEFtRFJCZExlWWs5WHZZc3NPUUNrVXNOWlJLMDQweGJ3REtWUUZMa1VFSS0zR3VSdUdNUjNNNkRWdVB2TFdXVVI4R3o2eGZUMGRrOUp4WkhmeFp3QlRrM3ZzNmRITU5Wb19JblRR?oc=5	https://static01.nyt.com/athletic/uploads/wp/2026/02/14202914/GettyImages-2260942978-scaled.jpg?width=1200&height=630&fit=cover	\N	2026-02-19T08:00:00+0000	\N	2026-03-06 13:29:53.440914-05	["https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
385	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - The Register Citizen	https://news.google.com/rss/articles/CBMiqAFBVV95cUxPcGZyZW10QVNTVl94ZENxNDI5MndJclAzY0tWbnFtbkEtbzZaVWl5cHRLajJFc0Y2YS1hTkNpN0xzRHFRTFhXZ2VENklpeFFBakJEWXZsRjJoWG0xV3lkWm11ekNnZEJsSmNvUkh4ZjJjVnktdHc0dy1zM2VHRm5xNmctZDFMeDB2eEplS0VYSTgtejRwNWU2VFlZaFNvUXhXXzl4RTV5T1o?oc=5	https://lh3.googleusercontent.com/J6_coFbogxhRI9iM864NL_liGXvsQp2AupsKei7z0cNNfDvGUmWUy20nuUhkREQyrpY4bEeIBuc=s0-w300	\N	2026-03-05T20:40:59+0000	\N	2026-03-06 17:29:47.043781-05	\N	\N
301	PWHL WEEKLY NOTEBOOK: DEC. 1, 2025	https://www.thepwhl.com/en/news/2025/december/01/pwhl-weekly-notebook-dec-1-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEATTLE_OPENER_CLM_20251128_5122?_a=DATAg1ZSZAA0	\N	2025-12-01	\N	2026-03-05 14:42:43.477361-05	\N	\N
306	FRANKEL, FLEET SHUT OUT VICTOIRE IN HOME OPENER	https://www.thepwhl.com/en/news/2025/november/23/frankel-fleet-shut-out-victoire-in-home-opener	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MK_09101?_a=DATAg1ZSZAA0	\N	2025-11-23	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	https://assets.leaguestat.com/pwhl/240x240/6.jpg
303	NOV. 29: BOSTON AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/29/nov-29-boston-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v2-HeatherPollock-20241130-PWHL-TORvBOS_1__0335-2?_a=DATAg1ZSZAA0	\N	2025-11-29	\N	2026-03-05 14:42:43.477361-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
309	ROQUE’S THREE POINTS POWERS VICTOIRE TO HOME OPENER WIN OVER SIRENS	https://www.thepwhl.com/en/news/2025/november/25/ROQUES-THREE-POINTS-POWERS-VICTOIRE-TO-HOME-OPENER-WIN-OVER-SIRENS-	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20251125-ny-mtl-ABD04710?_a=DATAg1ZSZAA0	\N	2025-11-26	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	https://assets.leaguestat.com/pwhl/60x60/42.jpg
314	GIRARD, OSBORNE LEAD SIRENS TO 4-0 WIN OVER CHARGE	https://www.thepwhl.com/en/news/2025/november/22/girard-osborne-lead-sirens-to-4-0-win-over-charge	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/NY_Win_-_Osborne_Girard?_a=DATAg1ZSZAA0	\N	2025-11-22T23:04:47-05:00	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	https://assets.leaguestat.com/pwhl/60x60/9.jpg
315	KIRK SHINES AS SCEPTRES EDGE FROST 2-1 TO LAUNCH 2025-26 PWHL SEASON	https://www.thepwhl.com/en/news/2025/november/21/kirk-shines-as-sceptres-edge-frost-2-1-to-launch-2025-26-pwhl-season	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_MIN_-_Nov._21_202515?_a=DATAg1ZSZAA0	\N	2025-11-21	\N	2026-03-05 16:42:28.232253-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	https://assets.leaguestat.com/pwhl/240x240/211.jpg
310	NOV. 23: MONTRÉAL AT BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/23/nov-23-montreal-at-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CLM_20250105_3545?_a=DATAg1ZSZAA0	\N	2025-11-23	\N	2026-03-05 14:42:44.263214-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
311	NOV. 25: NEW YORK AT MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/25/nov-25-new-york-at-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20241204-NYvMTL-LCA01922?_a=DATAg1ZSZAA0	\N	2025-11-25	\N	2026-03-05 14:42:44.263214-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
312	PWHL PLAYER SAFETY COMMITTEE DISCIPLINARY ACTION: NOV. 25, 2025	https://www.thepwhl.com/en/news/2025/november/25/pwhl-player-safety-committee-disciplinary-action-nov-25-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Player_Safety_-_Headline_-_16x9_2?_a=DATAg1ZSZAA0	\N	2025-11-25	\N	2026-03-05 14:42:44.263214-05	\N	\N
313	PWHL WEEKLY NOTEBOOK: NOV. 24, 2025	https://www.thepwhl.com/en/news/2025/november/24/pwhl-weekly-notebook-nov-24-2025	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEA_at_VAN_DSC_4230?_a=DATAg1ZSZAA0	\N	2025-11-24	\N	2026-03-05 14:42:44.263214-05	\N	\N
316	NOV. 22: NEW YORK AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/22/nov-22-new-york-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/game-33?_a=DATAg1ZSZAA0	\N	2025-11-22	\N	2026-03-05 14:42:44.957706-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
317	Play it Big: PWHL Releases Season 3 Brand Campaign	https://www.thepwhl.com/en/news/2025/november/21/play-it-big-pwhl-releases-season-3-brand-campaign	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/20250924-143011-ABB01748?_a=DATAg1ZSZAA0	\N	2025-11-21	\N	2026-03-05 14:42:44.957706-05	\N	\N
318	PWHL TO MAKE HISTORY WITH SEASON THREE PUCK DROP TONIGHT	https://www.thepwhl.com/en/news/2025/november/21/pwhl-to-make-history-with-season-three-puck-drop-tonight	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_-_PLAY_IT_BIG?_a=DATAg1ZSZAA0	\N	2025-11-21T13:15:56-05:00	\N	2026-03-05 14:42:44.957706-05	\N	\N
346	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - KWKT - FOX 44	https://news.google.com/rss/articles/CBMizwFBVV95cUxPeG5sRWJqdjY4eW80VTdmNGJZdUNlSXdjSlZFelJZeWlsQk5BZ01LcDRWYUxWOUFMTXFNWloyT3V5SXo1OEptVzR6U2gzdlNBdXJISG43T2k1Q2F5NUJVY2hqUU5NZlNUM3diUGFZZUk0eFcta2lVV0xfaDFkN0lWcm0yRlBJZ3BHMWRTckNSSjFpUWVJeGpFdF8xamFPLWZ1VlM3MEFPUktBaVBhd2Y3OFM2RlQtd3FuQUxVSmZaVWN0SDFMWWwtV1ozZzBOWWPSAdQBQVVfeXFMTld0YXNVaDJHbnJuc1pQVWdPU1gwcGQ2QkdkRkFvZTNiR0JfR3hrTGczcndES0F5YXBhNzNmNlpVNldFLXdLMDJJQ0FhZm5NN1NmbkVKSGU4ZFdwV1BVazM1Q1JFTG5VTUczTHhfMU4xZWU4cGQ5MGJUY0VJZTZGa1JzU3dwNy1IbzFGRWJuMjhjdFk2VDhTNWhnZnV3M1JDQXdjWG81SWNLdU0ybEMzRHlSaUZoWXhYNEdseW5RR1dUUjRZcjRiUUFHNEFFREZsTDRzcmU?oc=5	\N	\N	2026-03-05T19:50:33+0000	\N	2026-03-05 17:37:04.009708-05	\N	\N
345	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - The Killeen Daily Herald	https://news.google.com/rss/articles/CBMikAJBVV95cUxQNkVxZjVQeTdyUHQ2U1dBWHNIS093c2lreFZzbXlKdFF4RXI0S2ppLTJEN3VnZ1IxUG5nVDhxelF0eFEwbHVxX044dTZIZE04ZWR6ZWZ4VFdNeEdrTURSMVJsbUxzQi1NQnk5WkQ2bzF2R1B1UUtMWDVOYUIyeGlkX0M4eVQ2OVM5Zjc1VXlwMExRc09adjJXdkFYckZJQ29zZW1OaGdHZlRwSkphVlVXYlVqSHZRRzNtQmFaUjNRUXotMGNQNk5NZ2JmVUctUUdfaHhHUThkMDlmbUJWS0FuUWpNUzRYdHpfbjR2Sk52MkROYW9RWllGQWx5WUxSV0VDT3B6OHJ3d1hHZHpyS3RwZA?oc=5	https://bloximages.newyork1.vip.townnews.com/kdhnews.com/content/tncms/assets/v3/editorial/3/11/3116e6a3-1499-5323-88fd-ca3a5b3f39fb/69a370964f371.image.jpg?crop=1763%2C926%2C0%2C124&resize=1200%2C630&order=crop%2Cresize	\N	2026-03-05T19:50:33+0000	\N	2026-03-05 21:42:17.090167-05	\N	\N
319	NOV 21: TORONTO AT MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/21/nov-21-toronto-at-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DSC09887?_a=DATAg1ZSZAA0	\N	2025-11-21	\N	2026-03-05 14:42:44.957706-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
332	PWHL ANNOUNCES OFFICIATING LEADERSHIP DEPARTMENT AND TEAM, RULE CHANGES FOR 2025-26 SEASON	https://www.thepwhl.com/en/news/2025/november/14/pwhl-announces-officiating-leadership-department-and-team-rule-changes-for-2025-26-season	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2025-11-14	\N	2026-03-05 16:42:28.232253-05	\N	https://assets.leaguestat.com/pwhl/60x60/301.jpg
321	The PWHL empowers the next generation of hockey players at Ottawa Pre-Draft Event in partnership with Strong Girls United	https://www.thepwhl.com/en/news/2025/july/25/pwhl-and-strong-girls-united-empower-next-generation-of-female-hockey-players-at-ottawa-pre-draft-event	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-Draft-20250624-25728?_a=DATAg1ZSZAA0	\N	2025-07-25	\N	2026-03-05 14:42:44.957706-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
322	PWHL, Barbie and Tim Hortons partnership supports Grindstone to grow girls’ hockey	https://www.thepwhl.com/en/news/2025/august/22/pwhl-barbie-and-tim-hortons-partnership-supports-grindstone-to-grow-girls-hockey	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/LBolliger_PWHL_Barbie_TimHortons_Event_Aug_7_25-87606-Edit?_a=DATAg1ZSZAA0	\N	2025-08-22	\N	2026-03-05 14:42:44.957706-05	\N	\N
350	US women's hockey gold medalists return to PWHL action: When do they play? - AOL.com	https://news.google.com/rss/articles/CBMigAFBVV95cUxPbmxVMFdYQWhObWxlRU9iczdvOHJ4OE1BcnFCZkxqM3FSMURxZy0zR3AyTVpodmxRX0E5N01YZmxEVF93blg3b2kxNE85aFRhX1E2VEJRRE5KVFpWMktHT3B6VUVzYWNQN2Q1UFA3bzBYTmRKR1E3YnZnMGFGYnd3Ng?oc=5	https://s.yimg.com/ny/api/res/1.2/FUSR7weaP99IomfpXwXZTA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/aol_fox_news_articles_947/573a6d3fa05eaefccbf62bbc1d78b2f9	\N	2026-03-05T05:53:51+0000	\N	2026-03-05 21:42:22.182656-05	\N	\N
324	OTTAWA CHARGE ANNOUNCE TRAINING CAMP ROSTER UPDATES	https://www.thepwhl.com/en/news/2025/november/18/ottawa-charge-announce-training-camp-roster-updates	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/OTT-charge-25-26-Roster_Updates_-_1200x800?_a=DATAg1ZSZAA0	\N	2025-11-18T20:16:47-05:00	\N	2026-03-05 14:42:45.649834-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
325	SCEPTRES TAKE FINAL PRESEASON SCRIMMAGE AGAINST CHARGE WITH SHUTOUT VICTORY	https://www.thepwhl.com/en/news/2025/november/17/sceptres-take-final-preseason-scrimmage-against-charge-with-shutout-victory	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_OTT_-_Nov._17_Preseason_5?_a=DATAg1ZSZAA0	\N	2025-11-17	\N	2026-03-05 14:42:45.649834-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
326	PWHL ANNOUNCES 2025–26 BROADCAST SCHEDULE	https://www.thepwhl.com/en/news/2025/november/18/pwhl-announces-2025-26-broadcast-schedule	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2025-11-18	\N	2026-03-05 14:42:45.649834-05	\N	\N
327	TORONTO BEATS OTTAWA 3-2 IN OVERTIME IN FIRST PRESEASON SCRIMMAGE	https://www.thepwhl.com/en/news/2025/november/16/toronto-beats-ottawa-3-2-in-overtime-in-first-preseason-scrimmage	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_Toronto_at_Ottawa_-_Nov_16_Preseason_03?_a=DATAg1ZSZAA0	\N	2025-11-16	\N	2026-03-05 14:42:45.649834-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/6.png"]	\N
329	MONTRÉAL SECURES FIRST PRESEASON WIN OVER BOSTON, 3-2 IN OVERTIME	https://www.thepwhl.com/en/news/2025/november/15/montreal-secures-first-preseason-win-over-boston-3-2-in-overtime	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_Boston_at_Montreal_-_Nov_15_Preseason_01?_a=DATAg1ZSZAA0	\N	2025-11-15	\N	2026-03-05 14:42:45.649834-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
331	MINNESOTA WINS FIRST PRESEASON SCRIMMAGE 5-2 OVER NEW YORK	https://www.thepwhl.com/en/news/2025/november/13/minnesota-wins-first-preseason-scrimmage-5-2-over-new-york	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_Minnesota_at_New_York_-_Nov_13_Preseason_04?_a=DATAg1ZSZAA0	\N	2025-11-13	\N	2026-03-05 14:42:45.649834-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
333	NEW YORK DEFEATS MINNESOTA 6-2 IN FINAL PRESEASON SCRIMMAGE	https://www.thepwhl.com/en/news/2025/november/14/new-york-defeats-minnesota-6-2-in-final-preseason-scrimmage	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_Minnesota_at_New_York_-_Nov_14_Preseason_04?_a=DATAg1ZSZAA0	\N	2025-11-14	\N	2026-03-05 14:42:45.649834-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/4.png"]	\N
334	PWHL EXPANDS TAKEOVER TOUR FOR 2025-26 SEASON, FEATURING 16 NEUTRAL-SITE GAMES	https://www.thepwhl.com/en/news/2025/november/10/pwhl-expands-takeover-tour-for-2025-26-season-featuring-16-neutral-site-games	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2025-26_Takeover_Tour_-_Announcement_-_1200x800?_a=DATAg1ZSZAA0	\N	2025-11-10	\N	2026-03-05 14:42:46.650867-05	\N	\N
24	FEB. 28: BOSTON AT OTTAWA PRE-GAME PRIMER	https://news.google.com/rss/articles/CBMikgFBVV95cUxPaXBob2d4Z0p4UWpBcXNKc3ktcWJyVnJINzFiOFJrcTgzcF9uWDhrTU5RLVhZU3haRnZjYjhnMnJhVHlnbUU3RHFqWE1fNzJwMXFyY0piSXB1RHJ5MlY4cHBQczZFZVRRWWo1OUtuVEVway1sRHdZR3J2WWFJelBZekNuSzlwT2phaXA3aU0wZWJuZw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_OTT_-_Dec._27_20255?_a=DATAg1ZSZAA0	\N	2026-02-28T15:45:09+0000	\N	2026-03-05 21:42:41.487879-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
353	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 11 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxOZU9QMWQyZER6RFNXWTdmWkpCOXd6ejRNUHR6Q2JjamxuQ2pFWGNSa291d1dJb19xUjZIR1phbWFMU1ozdHlORFBjVDE5TkM4RXhpQWFNWmE1Rm9pdEhIZnJzdlhDNl9vMnFyS2F6c0dvX2FXZGpzQ2M4SGZieG1zRThJaG1yc1lRVlRRQnZDY0pvMnN6SlQ5QkxxSlRkRWs?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Karvinen_Finland?_a=DATAg1ZSZAA0	\N	2026-02-11T23:05:03+0000	\N	2026-03-05 21:43:00.146896-05	\N	\N
337	Strong in Sport, Stronger in Skin - Aveeno® and the PWHL announce new collaboration	https://www.thepwhl.com/en/news/2025/october/22/strong-in-sport-stronger-in-skin-aveeno-and-the-pwhl-announce-new-collaboration	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Aveeno-EN-PAR-LEAGUE-1200x800?_a=DATAg1ZSZAA0	\N	2025-10-22	\N	2026-03-05 14:42:46.650867-05	\N	\N
338	CITY OF OTTAWA CHARGED UP BY FINALS APPEARANCE	https://www.thepwhl.com/en/news/2025/may/21/ottawa-charged-up-by-finals-appearance	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_37A3646?_a=DATAg1ZSZAA0	\N	2025-05-21	\N	2026-03-05 14:42:46.650867-05	["https://assets.leaguestat.com/pwhl/logos/5.png"]	\N
339	PWHL ANNOUNCES UPDATES TO 2025-26 REGULAR-SEASON SCHEDULE	https://www.thepwhl.com/en/news/2025/october/15/pwhl-announces-updates-to-2025-26-regular-season-schedule	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_PR_Header?_a=DATAg1ZSZAA0	\N	2025-10-15T15:30:00-04:00	\N	2026-03-05 14:42:46.650867-05	\N	\N
340	NEW ERA FOR WOMEN’S WORLD CHAMPIONSHIP	https://www.thepwhl.com/en/news/2025/october/06/new-era-for-womens-world-championship	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_LOGO?_a=DATAg1ZSZAA0	\N	2025-10-06T10:30:00-04:00	\N	2026-03-05 14:42:46.650867-05	\N	\N
18	Ice hockey	https://news.google.com/rss/articles/CBMixgFBVV95cUxONFAxVWh3V0RBcVBha2xDeExCVnJfeU5mSXRQTDk4M1A1dExBWGRzcVVCaVVlSmxWSEpVWk41U3VMZWpXT3RxX0dDeDBWR3dvTWxTbjhOUzNVSFpLY1ZQRmxpOUFEeEJQX2ozR1RGQzE3VDF2U1RJWlVfM0xkeGl0LVJsRlp1M2hiY3pxZGwxV0xyd2FoU21NOWxZWjE3emJmTEN0WjhhS3VaUFBkbGVROEFKd05wUlZxSzdfZ2IyQ2FuREh4a0HSAcsBQVVfeXFMTm5yeHhqZUNFTHY5dG9UWW12U2FKbThvUy15WFRxZWI0WkNnUG9SVnNlTXhlUmd5WTNTOXNROE9zYTZUamtLelVGV3dIdEZIb0VYSERkM2pQVFR5ZDhjaE5UNW9CSnh0LUpnM0dZa3VPM0lxRFA0Nkg0Mllhb2xkNGhOaTV3eUJjZzhHMi1XNV9yUFlBQXU1OU13LU5IMFozaVJOc0d5YllzcHQ3VENMS08zV25PcFhXSzhOWlk1d1dJczEtUGFOZzlVMzQ?oc=5	https://www.devdiscourse.com/remote.axd?https://devdiscourse.blob.core.windows.net/imagegallery/16_01_2019_13_01_16_4088895.jpg?width=920&format=jpeg	\N	2026-03-05T18:23:49+0000	\N	2026-03-05 21:42:17.090167-05	\N	\N
342	PWHL UNVEILS 2025-26 REGULAR-SEASON SCHEDULE	https://www.thepwhl.com/en/news/2025/october/1/pwhl-unveils-2025-26-regular-season-schedule	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/League-ScheduleRelease-WEB?_a=DATAg1ZSZAA0	\N	2025-10-01	\N	2026-03-05 14:42:46.650867-05	\N	\N
387	Ice hockey-PWHL continues to rise with sold-out Madison Square Garden - CNA	https://news.google.com/rss/articles/CBMiqwFBVV95cUxNeHVBVDFPam9rN1lsWHNoMzRDTzlMT2xlT2xjSzRsWGR4azZnRjJoRi1lQkc4aUNlS0dCb2NkelZXMEtRM24ycGZaUXFUVFVjYmxVcXgxZ3U5aWtaQkdBanJqU2dMY3RCdVpjbFo3VGpwamxid2FYREgyclFJMVZ6bDItVzlpcDJsUThCcFJDRWNIZ09JUVJQRXpieTljNEtNekxBeUZUMlFISUU?oc=5	https://dam.mediacorp.sg/image/upload/s--lp95eRld--/c_fill,g_auto,h_676,w_1200/fl_relative,g_south_east,l_mediacorp:cna:watermark:2024-04:reuters_1,w_0.1/f_auto,q_auto/v1/one-cms/core/2026-03-05T182539Z_1_LYNXMPEM241CZ_RTROPTP_3_HOCKEY-NHL-NYR-CAR.JPG?itok=B2JLHxhA	\N	2026-03-05T18:21:56+0000	\N	2026-03-06 13:29:47.421546-05	\N	\N
352	Stats - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiXEFVX3lxTE1nMjk4V1Ixc1pGbkhhVjNxX1lvcU9Ib2EyV1gwVWJjT3lUZWY1ZGFSd0NaUGZ2NDVLb20wMnFieFh2OE1uZlFHaFZIRllxeGtlc2U5ZEY2Y294M1RX?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2025-10-01T14:08:11+0000	\N	2026-03-05 21:43:18.945319-05	\N	\N
351	Boston Fleet sell out first PWHL game at TD Garden on April 11 - The Boston Globe	https://news.google.com/rss/articles/CBMiigFBVV95cUxOT1dvQTkySUwtQktPcS1XSXhvU2p5Q01XUUxxSzRPOFdsWFdSQ0Jjc3ZjSjRoMkQ0T1pTcWN2cGtUem4wSU9Zcm51VkJ6VnhVTVhWRU9HcGhGRFh2U0szQWVaVG8xMjBOMG1CR3FPSUgzdmpPMVFFOVJyYk82NGxmRVp5Mm13czh5Tnc?oc=5	https://bostonglobe-prod.cdn.arcpublishing.com/resizer/v2/MGHCMPT2YALK7UXW56AAYIUUJ4.jpg?auth=b70d7183567888e0724293a1d70ce171317b5a41870f1295168b00f284f7f3e8&width=1440	\N	2026-03-05T22:58:04+0000	\N	2026-03-05 21:42:13.093616-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	\N
20	LAURA STACEY JAILBREAK 🗣️ #pwhl #hockey - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMid0FVX3lxTE9Db0Nod1dwWFMzV3hqaV9rLW5JMEoxQm91RW1IY05saHV0SkJUQ1UzeHJEQnR1UkIzcS1PaFZta0xHZGV1TUVGRm1QRVRWU0p1cEY1SGhvUEJYQlpzNzZrR2JKeHlyc0c3R0RETWo2MDlQeXhVV1hZ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Brightcove/videos/images/LAURA-STACEY-JAILBREAK-pwhl-hockey-IQ_iuzRpVnc?_a=DATAg1ZSZAA0	\N	2026-03-02T03:25:15+0000	\N	2026-03-05 21:42:31.279555-05	\N	https://assets.leaguestat.com/pwhl/60x60/32.jpg
22	Minnesota Frost at Montréal Victoire | March 1, 2026	https://news.google.com/rss/articles/CBMikgFBVV95cUxPaFJ5Rlpjb3NtY19Ed09WamNiVEhCd0V2Qi1zQ3h0OHBkTmRwM0FPRmZTeG40eTZmRW9Qc3RhTWFCZkVJZ19QZ3hKSHhiUl9IRzlFb1BOQ3hWRkhtRHQyeHN3WHFQMFFzRC12b3VtdFpMX3JOTXpNQjJ1U2czazNCbW51V1pCbVVockRvZUhvR0dCQQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/v1/Brightcove/videos/images/PWHL-Minnesota-Frost-at-Montreal-Victoire-March-1-2026-D3_44Gnm0Tk?_a=DATAg1ZSZAA0	\N	2026-03-01T08:00:00+0000	\N	2026-03-05 21:42:41.487879-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
31	SIX MINNESOTA FROST WIN OLYMPIC GOLD IN ITALY - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMi3wFBVV95cUxPbG5oaGxTMXBpVjEtbC1DWU54Y29fbks1d3paVkhfaFgydVY3WW9vZVF6SlhIWnhtS2RqdGJwMkZzV2M5czZhZEtaeU5jTk52eDhSOGNhdU1lY2JpMEYxWWpFNlRWbWpaVmZTbTZlc3pzUEtaM21LT3Jsa3d2VjNCemc2QzYxR1NIcmdZdTVwUWZCLXcweDhkME5PUDM4S2tqT3JLNkU4YXlJWmNDRHowNlZkY0tONGtxTEFKaTY5V2JCcjVjSU9lOUNKbnpYbXZIb2ZhMTYyRnBCcVlFZTJz?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Frost_Olympians_Group?_a=DATAg1ZSZAA0	\N	2026-02-19T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	["https://assets.leaguestat.com/pwhl/logos/2.png"]	\N
33	PWHL WEEKLY NOTEBOOK: FEB. 26, 2026 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiiAFBVV95cUxQM00xU3NXWk9feEFlbm1DSDN5REtxNjF5dkJsMl9uMGN4SHB5VlZsb25ZY282ZkgwQWt4b1ZweG85M3lPMWtTR2pkM21aQzBDRl9VQi02Yi1zeWx4WW04aHdkNlplZFF3cDRLVEp1YkNCZnBkSkdlU1NXR2VfbzZyLWhtWmFfTF9t?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Knight_USA_Gold?_a=DATAg1ZSZAA0	\N	2026-02-26T15:09:48+0000	\N	2026-03-05 21:42:50.662294-05	\N	\N
29	PWHL BREAKS U.S. WOMEN'S HOCKEY ATTENDANCE RECORD AT CAPITAL ONE ARENA IN WASHINGTON, D.C. - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMizAFBVV95cUxNUlY5UU41emxnYmIxZUpZa3hDbVRERkxaM1R2Z0FkNmI0TzVYRjROUDFiNEdIU0NGQV9lVmdZTzFsNkJqc1cxbHpvdzV1QzF6R2I0Z01fdm1xeXh3ODB0Qk95VDZGaXlobUd3NURZWC1MQVhBNU9yU0ZOSFhMZldUVXdqcXdfYUhrbnU0QmFMdk5zVGhpVVE5bTZtcVhsOW80c2gyVGR2N25MdHdKZjcxY0JIZmdIQks5bFNlQkdIUHdGbkJ4dEQ2LXlQZG0?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/1200x800DC_Final?_a=DATAg1ZSZAA0	\N	2026-01-18T08:00:00+0000	\N	2026-03-05 21:43:09.505869-05	\N	\N
389	KJELLBIN AND HJALMARSSON NAMED TO SWEDEN'S OLYMPIC ROSTER - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMixgFBVV95cUxOTmVWWDBORnBSVzh3RXNoTFVBTkxESlpMRjlXTW0wc3BWdVl4NGFMTVVIUEsxUHE1djVDZW50UlVGMnZESW4yT1NuOFJkZmhJV1cxRDhPZi1FMlpIUk0ydklzQk1aWHphOV9yd3BoX2FEa1V0bmN6ZzlPRjV4MkhQeDRLMkZMQ1ZPMGlxXzZPUWlCZnBXdGZEZ09oLUJVdkxjT0lGOUx3UWQ3VEhBaDZWUXNpQWk3U1ZqXzd3UnFUb3BHcXNtMEE?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/TOR_SWE_KjellbinHjalmarssonFlag?_a=DATAg1ZSZAA0	\N	2026-01-12T08:00:00+0000	\N	2026-03-06 13:29:53.440914-05	\N	\N
45	Erica Reider Among Veterans Eyeing PWHL After Multiple Seasons In Europe, And An Olympic Attempt In Cycling - The Hockey News	https://news.google.com/rss/articles/CBMi6AFBVV95cUxQRnViU25oTnRva0w4d3JfUEhlajRJSGM0UVpEd3A3RkJjWXpYNTNEZ2ZyZ01laWlfYVNaRko1OWRtU1JBekpVWm9ZdlV2ZVF6VmJPVFlMcHBweWk0Ym1lM0I1cFNmWWY2MUVrUGlYdXU2aEtTRmkyODlFQldHWlVWRE5DWUw3LV9yS1Y2Y05DSERneFYzWTZ2MGNaSnZIekJ5aE1oWmZLV3RDYTVpTjJIbEFYeEp0WFBQaHVtampDc3Q5ZDNKVjRfVGJHMTdkM0NmSEVkeTJPVkY4NjZoZm1lZDVEeE9xOE9L?oc=5	https://deweb-519a7.b-cdn.net/post-images/10d4700b-6699-4449-8ddd-fff2e1351ddf.jpeg	\N	2026-03-03T19:23:23+0000	\N	2026-03-05 21:42:26.570448-05	\N	\N
47	PWHL game ticket demand spikes after US women's Olympic hockey gold -- How to see the league live in Detroit - FOX 2 Detroit	https://news.google.com/rss/articles/CBMixAFBVV95cUxOaDdiRjlXa1NTeC1TeWdPbjMwTjdCRklOWllKTHFHaFB3N2k2TnlVYndnM0gtYXVwSU43Z1UyOHk1dnFpallIVG9OdHZoeHdDcGo2YmZ2cjlMa2NOOUo4OERyRkVwMHAyYWJtVU52RVhKd0txX0NoYlM5TlpIUV9uQ3RjdHUzYWk1WXRmZElZdl9RbVREVnNPVHEyY0c5bzd0cF9aekxQTW94anVJX1l5bFh3aThidWlUME0xS3NmVnBNLUhS0gHKAUFVX3lxTE5jaGxONXdhODhpd3hFUnNIV1hyMWZ2b3VJVXhCYnBySDJ1Ynl0ZkdLNmZqR1YzZS0wazVwLTJwdTZHVmxQQnFXWFJub2NNTUlONm56Uml5MGc3NndZZWIzRkhoaEhUTVZ2WmxzWlJKOV9jZnJOaUVsTDZLYi15YWo1aV90ZFRwYWFxbU15Ri0yVlpsVnZ4YkxMV2RoWUl2d2dGQ1BmZi1NR1RUTFE2XzdHQUg3UkYxLXRTcGcxTGJTcm5IaFNaamEwUHc?oc=5	https://images.foxtv.com/static.fox2detroit.com/www.fox2detroit.com/content/uploads/2026/02/1200/630/gettyimages-2256416490.jpg?ve=1&tl=1	\N	2026-02-26T19:00:10+0000	\N	2026-03-05 21:42:41.487879-05	\N	\N
48	PWHL resumes after women's hockey players leave mark at 2026 Winter Olympics - USA Today	https://news.google.com/rss/articles/CBMiygFBVV95cUxOQ1VIZmhlQjQzdWlJRnJWZmtvc2lUOVhtc0phWHQtckh3MmVJdDNFMjNXYnlSUjJCRlNkZ0pFZEhmekJrUFFmVVJhTHlFWlpRNDVNblNYQ1RoWk5lRlNhd0RWUzJFcHdPU1BRbGdMLUVkeE9SYW5nYU1lUGk1SWZLZmJoaVdSOXZobEJ3ckpjQ0NZNnliMFUwSHNnY21YY2F3ZlFLR3ZFdTNYVmxOaGNwN1h4ZEpCaDJIMGRBd3pPRTA5dUhJV1A2ck13?oc=5	https://www.usatoday.com/gcdn/authoring/authoring-images/2026/02/25/USAT/88851107007-usatsi-28286029.jpg?crop=5995,3374,x0,y0&width=3200&height=1801&format=pjpg&auto=webp	\N	2026-02-26T21:02:00+0000	\N	2026-03-05 21:42:41.487879-05	\N	\N
57	PWHL influence apparent in women's Olympic hockey - Seattle Sports	https://news.google.com/rss/articles/CBMimAFBVV95cUxNZ1lhcGpULUsxQXhxSXFpNDZ6V195TUdBTDlVUnQzVmt0bDduUkh2Q2l1Zk9WUnViLVM5MklJdFIzNDZUTzVuU0JobU1UZXA2cXlTRTFxeGVuWDd6blRmbUxIUEFJZ1lFZ3ZPODktem9BUWstN2VQZXpETVdFQWdyOGJla1c2RURELUVaMmZkb1A0ckpFR2Fobg?oc=5	https://sports.mynorthwest.com/wp-content/uploads/2026/02/pwhl-olympic-hockey-usa-women-flag-getty-900.jpg	\N	2026-02-20T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
49	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 17 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxONE1fdkoyZnFGOERwLXAzVU9hRW55UTlvY2FNWnBFaEtZSDNKeUVqYjFNS0FYRENkeElfS1Nxek11MlBHMXZ3ZXlfNWxCVmoyc0oxX0RFaHlNSVQ0LXF4bVU3anBfU3BKcVZxbWNNXzR1T29oNUtBakM1MHB3ckIwaFp0SENLLWVTeExQN1FwZF9ZN2tFdzByb01MaXBndTg?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Frankel_USA_SF?_a=DATAg1ZSZAA0	\N	2026-02-17T23:45:11+0000	\N	2026-03-06 01:29:50.773141-05	\N	\N
392	Why Halifax deserves a PWHL team	https://www.theixsports.com/the-ice-garden/pwhl/why-halifax-deserves-a-pwhl-team/	https://www.theixsports.com/wp-content/uploads/2026/03/CREDIT-PWHL-Takeover-Tour-Halifax-MTL-vs-TOR-Dec.-17-2025_04-1-scaled.jpg	\N	2026-03-06T19:00:18+0000	\N	2026-03-06 17:29:47.431899-05	\N	\N
390	Olympic gold, sold-out arenas: Kendall Coyne Schofield sees PWHL surge - USA Today	https://news.google.com/rss/articles/CBMi2AFBVV95cUxQMnlsUnc4al9DUWVFQ2VMUlRYM3dVUVYyQXkxemp1a2RWal9zMlVNRldZcU05aFRQZGVoVlctcVpMdWtFTVJjVXo2Y2NfREI2Q0xVaThNYUV3MGJrMDdHQWhETjVFU2dyRUgyVzJ6ZlZObERZVjRFTEtqcXhFdEhpXzVPTFVkVm5DT2R5YlFsOUVCQl9FMmN3aDVleThPSXNPeEFtOWNjYWRxcy1fOFEtcGJoa0NvZ2E4a0tmeWpGY0hCdWthMlBrWlpXcW1xdmVYZFJmUlRRVmM?oc=5	https://www.usatoday.com/gcdn/authoring/authoring-images/2026/03/06/SFTW/89016486007-2249400385.jpg?crop=4935,2777,x0,y44&width=3200&height=1801&format=pjpg&auto=webp	\N	2026-03-06T18:20:00+0000	\N	2026-03-06 17:29:47.603722-05	\N	\N
391	PWHL’s influence apparent at Olympics with OT medal games and the gap closing behind US and Canada - AP News	https://news.google.com/rss/articles/CBMikAFBVV95cUxPbkE4LWdBa2JhQjNodlZvRFVsOTY0UlU3YkEtYm0zTW1BajVfaEcxcTUxRE1CRktDX1ZaYXZDR3dQd3cwZG1wZ3BSRmJMWk1DWUhwR0haQ19DcHExN1c1U1ozQktSaklqbS1QU2xCb0ZwYS1TQU1iMWdPd1l5OGdNUkFEaU1Ub09aOXdVam9tYlY?oc=5	https://dims.apnews.com/dims4/default/3eadbf4/2147483647/strip/true/crop/5366x3576+0+1/resize/980x653!/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2F7a%2F69%2F2a5845f2b096666a0d463f36558a%2F159285f6d62a4746bb1ea0d503a69d3e	\N	2026-02-20T08:00:00+0000	\N	2026-03-06 17:29:51.677215-05	\N	\N
61	Torrent’s Olympians look to drive Seattle to PWHL playoffs - Pro Hockey News	https://news.google.com/rss/articles/CBMijAFBVV95cUxQZjRWNHBiWVFlZWhiOS04ODB2OEd2aUFSd2V1d21paE03dkhSS3VkNi1GS1ViR2M4MG5RaUFULWVHdFpwV3FMWGdiSUZ4ZHhRaWU5VXpVZm9NWERVTGJXcVR6cFRTbnNVZGVWbWR5U2s3bk5uSTJZaWlKZGMwQ2prMXY1U1d4blZqQWg2Sg?oc=5	https://prohockeynews.com/wp-content/uploads/2025/06/PWHL-coffee.jpg	\N	2026-03-03T15:07:11+0000	\N	2026-03-05 21:42:31.279555-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
393	FLEET SIGN OLIVIA ZAFUTO, PLACE OLIVIA MOBLEY ON LTIR - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMivAFBVV95cUxQdkowc0tfQm10cFRBdm1zMnNkYmxiWF9HR05ERXp5WG1mUzA1LXI1UjJMTDBGMHdkVThMV0ZZZ3JCOGhid0Y0SkpVaDBDRWRRUDRXRXZnWEJHMElfYm95ZzV4dTRDWl9IeXg3NlhkS3NTTDR2eEpBU05SM0tMYUJfRkkxdC1GNGhqckJDV05FOFdsU1ZhZExxWVVLcHVOcUN6T3JUbzd6WTdmaDdaWDlCbVZ3ajZYeFI0eTdwcg?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/f91a930c-3f10-4153-b96f-0c1f29a90a90BOS_Zafuto12?_a=DATAg1ZSZAA0	\N	2026-02-27T16:14:59+0000	\N	2026-03-06 21:29:46.10621-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	\N
21	Guess the Vancouver Goldenyes Player - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMirgFBVV95cUxPQU5JczBuQUpqX08wWEs1UzE5eEdKLXZjQTAzcVlfWkl4Y2dTc2ltRXhONUNndzJJSHRxOU1maDlLN3d2NE9fQnAxeGwxT2RGZTk1ZW13bUQ4VGZJZDBfUnU4Mm9QUWpBRkVwUURUUVM1aEo0LTB0QUd4UmRZWFBJZ2ExMWZKZmJ2dlJJYVpCN25DdF9ZV21TSWtCX0o5cjRHcVNmd1BjbXo4N1l1d3c?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SophieJaques-blurred_for_page_pre?_a=DATAg1ZSZAA0	\N	2026-03-04T05:01:20+0000	\N	2026-03-05 21:42:26.570448-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
32	PWHL’s Seattle Torrent Sets U.S. Women’s Hockey Attendance Record at Climate Pledge Arena - TicketNews	https://news.google.com/rss/articles/CBMivwFBVV95cUxOTXVOZXZQQURSUTk2ajZOWkhKLVRxYS1xMTJuUnZ5ckFhSHFRcTJQaHFPa2JuTnpjeUFMdm9YcDc4TE1DOU50OVpWSENvWkgwVWsxOUtIcVdOakE2cEJTc1B1Q2RUTmpVYUl2RzBmVWFwZ2JXWmVGQnhHS3phRWNnenpkOWU2dVNmTXZJZkRaMXlwTzZUbXQ4TW1CTFREa1JyZDJ4WjUwRHJiQVhzSFFGYUoyNnlINzQweUFfelZucw?oc=5	https://www.ticketnews.com/wp-content/uploads/2026/03/Professional-Womens-Hockey-League-PWHL.webp	\N	2026-03-02T17:24:10+0000	\N	2026-03-05 21:42:31.279555-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
43	KIRK BACKSTOPS SCEPTRES TO ROAD WIN OVER GOLDENEYES	https://news.google.com/rss/articles/CBMingFBVV95cUxQbDRlRUJwLU5wZXVBUXpkNVNpMHBtaENUWFZsX3hfel9udmhuSXdJMHoxRS1aR3pVU2UzVnpzMWpRVXpnakcyQTFFbjdqNnFSVFI5bVlqTDRZRHVWR05jR1VlMjRhWk5yRy03ZWIwSTFGaXkyQUczQ1MxWG0tMjg1cWxKNENTUTNyOUM2MDkyUk1DUTg3RlhzVTUyTks1Zw?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_VAN_-_Mar._1_2026_03?_a=DATAg1ZSZAA0	\N	2026-03-02T01:40:40+0000	\N	2026-03-05 21:42:31.279555-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	https://assets.leaguestat.com/pwhl/240x240/211.jpg
65	SEATTLE TORRENT’S OLYMPIC STARS LOOK TO IGNITE A PUSH TO THE PWHL PLAYOFFS	https://www.thepwhl.com/en/news/2026/march/03/seattle-torrents-olympic-stars-look-to-ignite-push-to-the-pwhl-playoffs	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/HeatherPollock-PWHL-20260219-torrent_feature_3-3?_a=DATAg1ZSZAA0	\N	2026-03-03	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
30	SEATTLE TORRENT PLAYERS BRING HOME FIVE OLYMPIC MEDALS FROM MILANO CORTINA WOMEN’S ICE HOCKEY TOURNAMENT - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMi6AFBVV95cUxPSjd2QmhEcWROcGw2bXdKYWQ1U2t6ay10eEVrMTBkMW5zcTl2d19VZXBtbmZfQUE3cm5nZkw1emNxQkhqS3hYRFVET2dWeDY0X3dTVWpOWk9UdV9RVTJQNWtpRmR4Ym53bnNVdWpWNU96Rm55NlozcGxnZ05VMEJIb1prbFJCanBGUThCbEtweEJsUktHdGhRMy0yTXNqV1U3RHpfN2lfSjZfLTB0WTFiclp5d29tWU42anBxdDByUFRxUWtKSzJ4Z284ZkxhYjU5RzRfZTV3alRRVVo1Y0dMcTFvN0ZWa3hM?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/iz2dnddzs9rskifx9u8s?_a=DATAg1ZSZAA0	\N	2026-02-20T08:00:00+0000	\N	2026-03-05 21:42:50.662294-05	["https://assets.leaguestat.com/pwhl/logos/7.png"]	\N
72	MAR. 1: TORONTO AT VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/march/01/mar-1-toronto-at-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_TOR_at_VAN_-_Jan._22_2026_12?_a=DATAg1ZSZAA0	\N	2026-03-01	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
74	SEATTLE TORRENT BREAK U.S. ARENA ATTENDANCE RECORD WITH 17,335 FANS	https://www.thepwhl.com/en/news/2026/february/27/seattle-torrent-break-u-s-arena-attendance-record-with-17-335-fans	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/260227_Torrent_vSceptres6254?_a=DATAg1ZSZAA0	\N	2026-02-27	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
75	TORRENT BREAK U.S. ATTENDANCE RECORD, FALL TO SCEPTRES 5-2	https://www.thepwhl.com/en/news/2026/february/27/torrent-break-u-s-attendance-record-fall-to-sceptres-5-2	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/260227_Torrent_vSceptres6367?_a=DATAg1ZSZAA0	\N	2026-02-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
78	FEB. 27: TORONTO AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/february/27/feb-27-toronto-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/260120_Torrent_vSceptres2413?_a=DATAg1ZSZAA0	\N	2026-02-27	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
87	SEATTLE TORRENT PLAYERS BRING HOME FIVE OLYMPIC MEDALS FROM MILANO CORTINA WOMEN’S ICE HOCKEY TOURNAMENT	https://www.thepwhl.com/en/news/2026/february/19/seattle-torrent-players-bring-home-five-olympic-medals-from-milano-cortina-women-s-ice-hockey-tournament	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/iz2dnddzs9rskifx9u8s?_a=DATAg1ZSZAA0	\N	2026-02-20	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
159	THREE-GOAL FIRST PERIOD PROPELS FROST TO 4-1 WIN OVER GOLDENEYES	https://www.thepwhl.com/en/news/2026/january/28/three-goal-first-period-propels-frost-to-4-1-win-over-goldeneyes	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DSC04419?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
162	JAN. 28: SEATTLE AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/28/jan-28-seattle-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_OTT_at_SEA-_Dec._17_2025_11?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
165	JAN. 28: VANCOUVER AT MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/28/jan-28-vancouver-at-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_VAN_-_Dec._27_2025_14?_a=DATAg1ZSZAA0	\N	2026-01-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
171	GOLDENEYES EDGE TORRENT 3-1 IN SECOND MATCHUP BETWEEN PWHL EXPANSION TEAMS	https://www.thepwhl.com/en/news/2026/january/25/goldeneyes-edge-torrent-3-1-in-second-matchup-between-pwhl-expansion-teams	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/145A3930?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
177	MINNESOTA FROST AND VANCOUVER GOLDENEYES COMPLETE TRADE	https://www.thepwhl.com/en/news/2025/november/19/minnesota-frost-and-vancouver-goldeneyes-complete-trade	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/MIN-VAN_Trade-16x9-20251119?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
179	SEATTLE SCORES SEASON-HIGH FOUR GOALS TO BEAT OTTAWA 4-1	https://www.thepwhl.com/en/news/2025/december/17/seattle-scores-season-high-four-goals-to-beat-ottawa-4-1	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/PWHL_OTTAWA-TORRENT_MM-72?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
394	Guess the Boston Fleet Player - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMingFBVV95cUxPRjZXUkRQeEdmdlF5QW5sb29XVi1qTG5SeWFXTGxSXy1JX08xRnRSbDdpNk9fMWlwbmRsU0E3d0RSdkJwMWlrSjFibk02bWstUWM4NjVrMWxFamlxejliWFUxYUktMS1UYlhnNGlycVNQZUdoOEpJWWVDUEJlaDBEMHVkVS03VXhGc3h6c1VhbS10M0RyZmhzRi1qZ2NBQQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/BOS_Maloneyblur_header?_a=DATAg1ZSZAA0	\N	2026-02-23T08:00:00+0000	\N	2026-03-06 21:29:51.093943-05	["https://assets.leaguestat.com/pwhl/logos/1.png"]	\N
189	JAN. 25: PWHL TAKEOVER TOUR VANCOUVER VS. SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/25/jan-25-pwhl-takeover-tour-vancouver-vs-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-ToT-DEN-0125-1200x800?_a=DATAg1ZSZAA0	\N	2026-01-25	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
192	GOLDENEYES’ OFFENSE BREAKS THROUGH WITH FIVE-GOAL SHUTOUT OVER SCEPTRES	https://www.thepwhl.com/en/news/2026/january/22/goldeneyes-offense-breaks-through-with-five-goal-shutout-over-sceptres	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/012226_Goldeneyes_v_Sceptres_-_Jones_-_3rd-6?_a=DATAg1ZSZAA0	\N	2026-01-23	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
194	JAN. 22: TORONTO AT VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/22/jan-22-toronto-at-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/VAN_TOR_A15I4667?_a=DATAg1ZSZAA0	\N	2026-01-22	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
196	SEATTLE TOPS TORONTO IN HIGH-SCORING 6-4 THRILLER	https://www.thepwhl.com/en/news/2026/january/20/seattle-tops-toronto-in-high-scoring-6-4-thriller	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/260120_Torrent_vSceptres2451?_a=DATAg1ZSZAA0	\N	2026-01-20	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
199	JAN. 20: TORONTO AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/20/jan-20-toronto-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-SEA_at_TOR_-_Jan._3_20264?_a=DATAg1ZSZAA0	\N	2026-01-20	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
201	OTTAWA CHARGE AND VANCOUVER GOLDENEYES COMPLETE SIX-PLAYER TRADE	https://www.thepwhl.com/en/news/2026/january/18/ottawa-charge-and-vancouver-goldeneyes-complete-six-player-trade	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/OTT_VAN_Trade_Jan18?_a=DATAg1ZSZAA0	\N	2026-01-18	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
202	BOSTON FINDS A WAY TO WIN, OVERTAKING SEATTLE IN FIRST SHOOTOUT VICTORY OF THE SEASON	https://www.thepwhl.com/en/news/2026/january/18/boston-finds-a-way-to-win-overtaking-seattle-in-first-shootout-victory-of-the-season	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_1LL2834?_a=DATAg1ZSZAA0	\N	2026-01-19	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
396	Indigenous Peoples Celebration | Montréal Victoire - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMioAFBVV95cUxOQnE0VkY2UHhGTGJRVkxOZzBJdzBSSzdldnRkVEFWOXJ0SkswZG9WNG1uQlRkVVNVenJ2R1B2QmZuMkVyTlZIdmlJRzdzQmUwX1B0U01SQjQ5V1JwdHBJck9HNklMS2VqLVFlVDluckJxUGlhV0QwOVpyY2ZvanQzdFpUT2FIWVA2Y1p5VENsM1VxRlB3NWpxaVlXb0xnS0tY?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-Unity-Games-Web-Slates-Indigenous-EN-1200x800_2-27?_a=DATAg1ZSZAA0	\N	2026-02-28T05:15:34+0000	\N	2026-03-06 21:29:46.10621-05	["https://assets.leaguestat.com/pwhl/logos/3.png"]	\N
207	JAN. 18: BOSTON AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/18/jan-18-boston-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_1LL9356?_a=DATAg1ZSZAA0	\N	2026-01-18	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
210	JAN. 17: VANCOUVER AT TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/17/jan-17-vancouver-at-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/0I7A1884?_a=DATAg1ZSZAA0	\N	2026-01-17	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
218	FROST BEAT VISITING TORRENT 6-2, MOVE INTO SECOND PLACE	https://www.thepwhl.com/en/news/2026/january/11/frost-beat-visiting-torrent-6-2-move-into-second-place	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/DSC07839?_a=DATAg1ZSZAA0	\N	2026-01-11	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
395	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 13 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxQUGZMY0E4Tkp2UFVfbTBEaG1IVjBJanZjdi1WaS1FWnJ4VFdpUUJ4QmRxNExOb3FEaE1YR2d2VF9vemFOZm9HNEMwbHZSamEwNVFXanFlRmh3YVlFMnFabWQ3XzZJbGpQaGVBZ0QtdkFJa0lvRGl3WDBNRV9wSGxBWVRLMU9BUG8yVHdsRms2ZGg1SXhZRUFVQXhNTHF0eGM?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Keller_USA_QF?_a=DATAg1ZSZAA0	\N	2026-02-13T08:00:00+0000	\N	2026-03-06 21:29:51.093943-05	\N	\N
224	JAN. 11: PWHL TAKEOVER TOUR VANCOUVER VS. MONTRÉAL PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/11/jan-11-pwhl-takeover-tour-vancouver-vs-montreal-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-Takeover_Tour_-_Qu%C3%A9bec_City_-_1200x800?_a=DATAg1ZSZAA0	\N	2026-01-11	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
225	JAN. 11: SEATTLE AT MINNESOTA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/11/jan-11-seattle-at-minnesota-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_SEA_-_Nov._28_202515?_a=DATAg1ZSZAA0	\N	2026-01-11	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
226	CHARGE HOLD ON TO SECURE RECORD FIFTH STRAIGHT VICTORY WITH 4-2 WIN OVER GOLDENEYES	https://www.thepwhl.com/en/news/2026/january/09/charge-hold-on-to-secure-record-fifth-straight-victory-with-4-2-win-over-goldeneyes	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2025-01-09-Charge-win-vs-VCR?_a=DATAg1ZSZAA0	\N	2026-01-09	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
227	JAN. 9: VANCOUVER AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/09/jan-9-vancouver-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_JK16432?_a=DATAg1ZSZAA0	\N	2026-01-09	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
228	JAN. 7: SEATTLE AT BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/07/jan-7-seattle-at-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_BOS_at_SEA_-_Dec._21_2025_08?_a=DATAg1ZSZAA0	\N	2026-01-07	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
229	BOSTON STAYS UNBEATEN AT HOME WITH 2-1 WIN OVER SEATTLE	https://www.thepwhl.com/en/news/2026/january/07/boston-stays-unbeaten-at-home-with-2-1-win-over-seattle	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_SEA_at_BOS_-_Jan._7_2026_10?_a=DATAg1ZSZAA0	\N	2026-01-07	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
234	TORRENT BEAT SCEPTRES 3-2 IN SHOOTOUT, EARN FIRST ROAD WIN	https://www.thepwhl.com/en/news/2026/january/03/torrent-beat-sceptres-3-2-in-shootout-earn-first-road-win	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-SEA_at_TOR_-_Jan._3_202619?_a=DATAg1ZSZAA0	\N	2026-01-03	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
238	FOUR SEATTLE TORRENT PLAYERS NAMED TO 2026 U.S. OLYMPIC ROSTER	https://www.thepwhl.com/en/news/2026/january/02/four-seattle-torrent-players-named-to-2026-u-s-olympic-roster	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/_1LL3131?_a=DATAg1ZSZAA0	\N	2026-01-02	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
240	JAN. 3: PWHL TAKEOVER TOUR SEATTLE VS. TORONTO PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/03/jan-3-pwhl-takeover-tour-seattle-vs-toronto-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-Takeover_Tour_-_Hamilton_-_1200x800?_a=DATAg1ZSZAA0	\N	2026-01-03	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/6.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
241	JAN. 3: PWHL TAKEOVER TOUR VANCOUVER VS. BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2026/january/03/jan-3-pwhl-takeover-tour-vancouver-vs-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-ToT-DET-0103-1200x800?_a=DATAg1ZSZAA0	\N	2026-01-03	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
244	SIRENS RECORD SECOND-STRAIGHT WIN WITH 2-0 VICTORY OVER GOLDENEYES	https://www.thepwhl.com/en/news/2025/december/31/sirens-record-second-straight-win-with-2-0-victory-over-goldeneyes	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_VAN_at_NY_-_Dec._31_2025_10?_a=DATAg1ZSZAA0	\N	2025-12-31	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
246	DEC. 31: VANCOUVER AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/31/dec-31-vancouver-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/EVB04347?_a=DATAg1ZSZAA0	\N	2025-12-31	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
251	O’BRIEN HAT TRICK LEADS NEW YORK TO WIN OVER SEATTLE IN DALLAS	https://www.thepwhl.com/en/news/2025/december/28/o-brien-hat-trick-leads-new-york-to-win-over-seattle-in-dallas	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_SEA_at_NY_-_Dec._28_2025_17?_a=DATAg1ZSZAA0	\N	2025-12-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
253	DEC. 28: PWHL TAKEOVER TOUR SEATTLE VS. NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/28/dec-28-pwhl-takeover-tour-seattle-vs-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/25-26-ToT-DAL-1228-1200x800?_a=DATAg1ZSZAA0	\N	2025-12-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
256	DEC. 27: PWHL TAKEOVER TOUR MINNESOTA VS. VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/27/dec-27-pwhl-takeover-tour-minnesota-vs-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Takeover_Tour_-_Edmonton_1_-_1200x800_-_Stecklein_and_Maschmeyer?_a=DATAg1ZSZAA0	\N	2025-12-27	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
258	SEATTLE SNAPS MONTRÉAL’S STREAK WITH 2-1 NAILBITTER	https://www.thepwhl.com/en/news/2025/december/23/seattle-snaps-montr-al-s-streak-with-2-1-nailbitter	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/251223_Torrent_vVictoire52894?_a=DATAg1ZSZAA0	\N	2025-12-23	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
261	DEC. 23: MONTRÉAL AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/23/dec-23-montreal-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEA_-_SGT_matchup-logo-right-1200x800_-_MTL?_a=DATAg1ZSZAA0	\N	2025-12-23	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
262	BOSTON RECORDS SIXTH WIN IN SEVEN GAMES WITH 3-1 VICTORY OVER SEATTLE	https://www.thepwhl.com/en/news/2025/december/21/boston-records-sixth-win-in-seven-games-with-3-1-victory-over-seattle	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/251221_Torrent_vFleet52242?_a=DATAg1ZSZAA0	\N	2025-12-21	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
264	MONTRÉAL BRINGS OFFENSIVE POWER WEST HANDING VANCOUVER FIRST HOME LOSS	https://www.thepwhl.com/en/news/2025/december/20/montreal-brings-offensive-power-west-handing-vancouver-first-home-loss	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MON_at_VAN_-_Dec._20_2025_06?_a=DATAg1ZSZAA0	\N	2025-12-20	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
267	DEC. 21: BOSTON AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/21/dec-21-boston-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEA_-_SGT_matchup-logo-right-1200x800_-_BOS?_a=DATAg1ZSZAA0	\N	2025-12-21	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
271	DEC. 20: MONTRÉAL AT VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/20/dec-20-montreal-at-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/VAN_-_SGT_matchup-logo-right-1200x800_-_MTL?_a=DATAg1ZSZAA0	\N	2025-12-20	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/3.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
275	VANCOUVER MAKES HISTORY WITH 2-1 WIN OVER OTTAWA FOR THIRD STRAIGHT HOME VICTORY	https://www.thepwhl.com/en/news/2025/december/16/vancouver-makes-history-with-2-1-win-over-ottawa-for-third-straight-home-victory	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/credit_pwhl_-_ott_at_van_-_dec._16_2025_02?_a=DATAg1ZSZAA0	\N	2025-12-17	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
278	DEC. 17: OTTAWA AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/17/dec-17-ottawa-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/SEA_-_SGT_matchup-logo-right-1200x800_-_OTT?_a=DATAg1ZSZAA0	\N	2025-12-17	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
279	DEC. 16: OTTAWA AT VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/16/dec-16-ottawa-at-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/OTT_VAN_JK16432?_a=DATAg1ZSZAA0	\N	2025-12-16	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
288	DEC. 6: NEW YORK AT VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/06/dec-6-new-york-at-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_VAN_at_NY_-_Nov._28_202520?_a=DATAg1ZSZAA0	\N	2025-12-06	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
291	DEC. 3: NEW YORK AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/03/dec-3-new-york-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/logo-right-SEA_-_SGT_matchup_-_1200x800_-_NY?_a=DATAg1ZSZAA0	\N	2025-12-03	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
397	Scores - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMiSEFVX3lxTE43TnluQzVPWlVfNlNOVzdGenBZZUpmM201bVJBV21aR3NsTVYzTm44Z2Z3WG5hRlRSbVRoX2cxdUh1UXFZb1RMSQ?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,w_600/c_mpad,h_630,w_1200/q_auto/f_jpg/PWHL_Logo_Logotype_Ultra_Violet_cgbt5r?_a=DATAg1ZSZAA0	\N	2026-02-28T05:15:33+0000	\N	2026-03-07 05:29:46.185345-05	\N	\N
293	SEATTLE SCORES TWO LATE GOALS AGAINST NEW YORK TO RECORD FIRST-EVER HOME WIN	https://www.thepwhl.com/en/news/2025/december/04/seattle-scores-two-late-goals-against-new-york-to-record-first-ever-home-win	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_NY_at_SEA_-_Dec._3_2025_-_12?_a=DATAg1ZSZAA0	\N	2025-12-04	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
295	DEC. 3: VANCOUVER AT BOSTON PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/december/03/dec-3-vancouver-at-boston-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/NEW-11.4.25-VAN-GE-_-_SGT_matchup_-_1200x800_-_BOS?_a=DATAg1ZSZAA0	\N	2025-12-03	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/1.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
298	SEATTLE DRAWS RECORD CROWD OF 16,014 FOR HOME DEBUT, FALLS 3-0 TO MINNESOTA	https://www.thepwhl.com/en/news/2025/november/28/seattle-draws-record-crowd-of-16014-for-home-debut-fall-3-0-to-minnesota	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_MIN_at_SEA_-_Nov._28_20251?_a=DATAg1ZSZAA0	\N	2025-11-29	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
299	ROOKIES SHINE AS SIRENS TOP GOLDENEYES 5-1 IN HOME OPENER	https://www.thepwhl.com/en/news/2025/november/29/rookies-shine-as-sirens-top-goldeneyes-5-1-in-home-opener	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/EVB03655?_a=DATAg1ZSZAA0	\N	2025-11-29	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
302	NOV. 29: VANCOUVER AT NEW YORK PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/29/nov-29-vancouver-at-new-york-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/NEW-VAN-GE-_-_SGT_matchup_-_1200x800_-_NY?_a=DATAg1ZSZAA0	\N	2025-11-29	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/4.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
304	NOV. 28: MINNESOTA AT SEATTLE PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/28/nov-28-minnesota-at-seattle-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/11.4-new-SEA-t_-_SGT_matchup_-_1200x800_-vs-_MIN?_a=DATAg1ZSZAA0	\N	2025-11-28	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/2.png", "https://assets.leaguestat.com/pwhl/logos/8.png"]	\N
305	VANCOUVER GOLDENEYES NOTCH OVERTIME WIN OVER SEATTLE TORRENT ON HISTORIC NIGHT	https://www.thepwhl.com/en/news/2025/november/21/vancouver-goldeneyes-notch-overtime-win-over-seattle-torrent-on-historic-night	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CREDIT_PWHL_-_SEA_at_VAN_-_Nov._21_20257?_a=DATAg1ZSZAA0	\N	2025-11-22	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
307	NOV. 26: VANCOUVER AT OTTAWA PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/26/nov-26-vancouver-at-ottawa-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/NEW-11.4-VAN-GE-_-_SGT_matchup_-_1200x800_-_OTT?_a=DATAg1ZSZAA0	\N	2025-11-26	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/5.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
398	PWHL NOTEBOOK: OLYMPIC WINTER GAMES EDITION, FEB. 10 | PWHL - Professional Women's Hockey League - Professional Women's Hockey League (PWHL)	https://news.google.com/rss/articles/CBMinwFBVV95cUxOSmdfY3J5U0d4ZTY3amI0NjNBb3BvMENROEhuV0tCRjdFRkl2cndjNkRNREFNQ19wcDBpZ1NxWk5xTi05ZnpLZnBFUm83Qm1uTjV5emlFcXlnYTlXQzZvNzJVOXhlM3o2di14S3dVcHZnaTF3Z1JFZ0tETHpIVDRTamVsbmduUjc3NEhmYWR6SDIteFFnZS1WZHpxclJVVWM?oc=5	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/CAN_USA_Olympic_Puck_Battle?_a=DATAg1ZSZAA0	\N	2026-02-10T08:00:00+0000	\N	2026-03-07 05:29:51.103029-05	\N	\N
320	NOV. 21: SEATTLE AT VANCOUVER PRE-GAME PRIMER	https://www.thepwhl.com/en/news/2025/november/21/nov-21-seattle-at-vancouver-pre-game-primer	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/111525_Goldeneyes_v_Torrent_-_Jones_-_3rd-6?_a=DATAg1ZSZAA0	\N	2025-11-21	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
323	PWHL SEATTLE AND PWHL VANCOUVER UNVEIL INAUGURAL JERSEYS AHEAD OF 2025-26 SEASON	https://www.thepwhl.com/en/news/2025/october/21/pwhl-seattle-and-pwhl-vancouver-unveil-inaugural-jerseys-ahead-of-2025-26-season	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/Jersey-Launch-Site-Banner_1?_a=DATAg1ZSZAA0	\N	2025-10-21	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
328	SEATTLE WINS PRESEASON SCRIMMAGE 4-2 IN REMATCH AGAINST VANCOUVER	https://www.thepwhl.com/en/news/2025/november/16/seattle-wins-preseason-scrimmage-4-2-in-rematch-against-vancouver	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/111625_Goldeneyes_v_Torrent_-_Exhi_2_-_Jones_-_1st-4?_a=DATAg1ZSZAA0	\N	2025-11-16	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
330	VANCOUVER GOLDENEYES SHUTOUT SEATTLE TORRENT 3-0 IN FIRST PRESEASON SCRIMMAGE	https://www.thepwhl.com/en/news/2025/november/15/vancouver-goldeneyes-shutout-seattle-torrent-3-0-in-first-preseason-scrimmage	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/111525_Goldeneyes_v_Torrent_-_Jones_-_1st-47?_a=DATAg1ZSZAA0	\N	2025-11-16	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
335	PWHL UNVEILS EXPANSION TEAM IDENTITIES: SEATTLE TORRENT AND VANCOUVER GOLDENEYES	https://www.thepwhl.com/en/news/2025/november/06/pwhl-unveils-expansion-team-identities-seattle-torrent-and-vancouver-goldeneyes	https://res.cloudinary.com/pwhl-low/image/upload/c_fill,g_faces:auto,h_630,w_1200/q_auto/f_jpg/2526-BrandLaunch-Lockup-Header-PressRelease-1200x800_1?_a=DATAg1ZSZAA0	\N	2025-11-06	\N	2026-03-05 16:41:53.181415-05	["https://assets.leaguestat.com/pwhl/logos/8.png", "https://assets.leaguestat.com/pwhl/logos/9.png"]	\N
399	PWHL Players Association strengthens voice by affiliating with AFL-CIO and its 15 million workers - Huron Daily Tribune	https://news.google.com/rss/articles/CBMipwFBVV95cUxOS0NKbG5ydVZQSUpnYlVNQ3d4WElZSGZZdk5INWhxbmc0N2xsbE50b3JOYTBjZzJ1V0NNbVFOWWZCQ3hPZldINU56MEFWWWlkZnFRS2x1TW9wSGFSNVhPSUdUbGdtVnBxUmlpRllfM1NfLUlpZlRabkVRQUxxNTFxU1dxRXdYaDVwdHRTTm1icXpZek9icHpHMUlkVDYxdF91d2FVVkcwNA?oc=5	https://lh3.googleusercontent.com/J6_coFbogxhRI9iM864NL_liGXvsQp2AupsKei7z0cNNfDvGUmWUy20nuUhkREQyrpY4bEeIBuc=s0-w300	\N	2026-03-05T19:57:30+0000	\N	2026-03-07 09:29:45.944623-05	\N	\N
\.


--
-- Data for Name: player_stats; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.player_stats (id, player_id, season, game_id, games_played, goals, assists, points, plus_minus, penalty_minutes, shots, hits, blocks, faceoffs_won, faceoffs_total, time_on_ice, wins, losses, overtime_losses, saves, shots_against, goals_against, shutouts, save_percentage, goals_against_average, fantasy_points, is_season_total, created_at, updated_at) FROM stdin;
13	13	2025-2026	\N	16	5	7	12	1	0	40	24	11	0	0	0	0	0	0	0	0	0	0	0	0	42	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
14	14	2025-2026	\N	18	5	7	12	-4	0	36	3	6	167	311	0	0	0	0	0	0	0	0	0	0	35.8	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
16	16	2025-2026	\N	16	3	8	11	5	0	38	12	12	109	175	0	0	0	0	0	0	0	0	0	0	41.4	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
18	18	2025-2026	\N	17	1	10	11	-3	4	59	25	10	63	145	0	0	0	0	0	0	0	0	0	0	35.7	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
26	26	2025-2026	\N	16	4	5	9	3	6	34	9	15	109	241	0	0	0	0	0	0	0	0	0	0	32.2	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
35	35	2025-2026	\N	16	1	7	8	-1	4	48	12	21	0	0	0	0	0	0	0	0	0	0	0	0	28.4	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
37	37	2025-2026	\N	18	1	7	8	6	16	29	32	13	5	16	0	0	0	0	0	0	0	0	0	0	23.7	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
42	42	2025-2026	\N	16	3	4	7	-2	2	19	11	5	3	10	0	0	0	0	0	0	0	0	0	0	19.7	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
50	50	2025-2026	\N	15	5	1	6	2	34	35	14	3	1	2	0	0	0	0	0	0	0	0	0	0	12.5	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
51	51	2025-2026	\N	15	5	1	6	6	2	20	6	4	1	3	0	0	0	0	0	0	0	0	0	0	28	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
54	54	2025-2026	\N	18	3	3	6	3	8	26	8	10	1	10	0	0	0	0	0	0	0	0	0	0	21.8	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
57	57	2025-2026	\N	16	2	4	6	-6	2	41	9	11	0	0	0	0	0	0	0	0	0	0	0	0	19.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
62	62	2025-2026	\N	17	0	6	6	5	4	19	8	18	0	0	0	0	0	0	0	0	0	0	0	0	20.7	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
65	65	2025-2026	\N	18	4	1	5	-5	12	41	15	21	179	319	0	0	0	0	0	0	0	0	0	0	15.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
71	71	2025-2026	\N	16	1	4	5	0	6	26	26	17	0	0	0	0	0	0	0	0	0	0	0	0	15.8	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
72	72	2025-2026	\N	16	1	4	5	6	0	16	4	11	3	5	0	0	0	0	0	0	0	0	0	0	21.8	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
73	73	2025-2026	\N	18	1	4	5	-3	14	28	6	27	0	0	0	0	0	0	0	0	0	0	0	0	9.4	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
95	95	2025-2026	\N	16	2	2	4	-3	6	39	13	0	9	17	0	0	0	0	0	0	0	0	0	0	15.7	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
78	78	2025-2026	\N	16	1	3	4	0	10	28	7	18	3	4	0	0	0	0	0	0	0	0	0	0	12.4	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
89	89	2025-2026	\N	15	2	1	3	-2	0	19	9	9	58	137	0	0	0	0	0	0	0	0	0	0	11.7	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
90	90	2025-2026	\N	16	2	1	3	2	2	22	21	18	39	77	0	0	0	0	0	0	0	0	0	0	15.6	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
91	91	2025-2026	\N	17	2	1	3	0	4	11	6	3	2	3	0	0	0	0	0	0	0	0	0	0	9.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
101	101	2025-2026	\N	13	0	3	3	3	4	7	2	5	0	0	0	0	0	0	0	0	0	0	0	0	9.1	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
104	104	2025-2026	\N	17	0	3	3	0	6	13	7	10	25	52	0	0	0	0	0	0	0	0	0	0	6.9	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
105	105	2025-2026	\N	18	0	3	3	-1	29	24	18	20	2	5	0	0	0	0	0	0	0	0	0	0	-2.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
107	107	2025-2026	\N	14	2	0	2	1	2	15	11	8	0	0	0	0	0	0	0	0	0	0	0	0	10.5	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
122	122	2025-2026	\N	18	0	2	2	0	0	16	8	9	1	2	0	0	0	0	0	0	0	0	0	0	8.8	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
123	123	2025-2026	\N	18	0	2	2	2	2	10	2	1	28	76	0	0	0	0	0	0	0	0	0	0	8	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
131	131	2025-2026	\N	14	1	0	1	0	2	14	15	8	0	0	0	0	0	0	0	0	0	0	0	0	6.2	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
138	138	2025-2026	\N	14	0	1	1	3	2	5	22	4	0	0	0	0	0	0	0	0	0	0	0	0	5.5	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
139	139	2025-2026	\N	15	0	1	1	1	8	7	9	7	1	8	0	0	0	0	0	0	0	0	0	0	1.1	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
141	141	2025-2026	\N	16	0	1	1	-2	2	13	4	4	88	169	0	0	0	0	0	0	0	0	0	0	2.9	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
148	148	2025-2026	\N	18	0	1	1	-1	12	21	12	18	0	0	0	0	0	0	0	0	0	0	0	0	1.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
153	153	2025-2026	\N	2	0	0	0	0	0	2	0	1	0	2	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
158	158	2025-2026	\N	3	0	0	0	0	0	1	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
166	166	2025-2026	\N	8	0	0	0	-1	0	11	5	3	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
756	208	2025-2026	\N	16	0	0	0	0	0	0	0	0	0	0	0	12	2	0	390	413	23	4	0.944	1.4	127	t	2026-03-06 06:00:00.93433-05	2026-03-07 06:00:00.798213-05
582	117	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
585	136	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
597	149	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
598	98	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
607	155	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
613	16	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
614	111	2024-2025	\N	1	0	0	0	-1	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 11:14:30.28561-05	\N
616	131	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
617	112	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
626	124	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
636	152	2024-2025	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
637	145	2024-2025	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
656	135	2024-2025	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
670	72	2024-2025	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	\N
193	12	2024	\N	26	11	9	20	5	0	59	0	0	0	0	0	0	0	0	0	0	0	0	0	0	73.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
194	60	2024	\N	30	9	10	19	11	0	53	0	0	0	0	0	0	0	0	0	0	0	0	0	0	73.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
195	55	2024	\N	30	9	10	19	1	0	87	0	0	0	0	0	0	0	0	0	0	0	0	0	0	74.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
196	16	2024	\N	26	7	12	19	1	0	51	0	0	0	0	0	0	0	0	0	0	0	0	0	0	61.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
197	26	2024	\N	30	11	7	18	-4	0	56	0	0	0	0	0	0	0	0	0	0	0	0	0	0	59.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
198	23	2024	\N	30	9	9	18	2	0	70	0	0	0	0	0	0	0	0	0	0	0	0	0	0	68	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
199	33	2024	\N	30	5	13	18	10	0	55	0	0	0	0	0	0	0	0	0	0	0	0	0	0	67.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
1	1	2025-2026	\N	15	10	6	16	13	0	48	5	5	1	1	0	0	0	0	0	0	0	0	0	0	69.4	t	2026-03-05 00:17:39.625897-05	\N
2	2	2025-2026	\N	18	10	6	16	3	0	53	3	3	0	8	0	0	0	0	0	0	0	0	0	0	60.9	t	2026-03-05 00:17:39.625897-05	\N
181	19	2024	\N	30	15	14	29	0	0	111	0	0	0	0	0	0	0	0	0	0	0	0	0	0	106.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
3	3	2025-2026	\N	17	8	8	16	5	20	56	20	11	200	313	0	0	0	0	0	0	0	0	0	0	51.8	t	2026-03-05 00:17:39.625897-05	\N
11	11	2025-2026	\N	18	11	1	12	2	35	75	26	9	18	39	0	0	0	0	0	0	0	0	0	0	42	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
4	4	2025-2026	\N	18	8	8	16	2	6	51	16	6	174	311	0	0	0	0	0	0	0	0	0	0	54.3	t	2026-03-05 00:17:39.625897-05	\N
5	5	2025-2026	\N	16	7	9	16	11	10	29	19	18	21	42	0	0	0	0	0	0	0	0	0	0	53.7	t	2026-03-05 00:17:39.625897-05	\N
6	6	2025-2026	\N	16	3	13	16	11	6	42	13	3	113	232	0	0	0	0	0	0	0	0	0	0	55.6	t	2026-03-05 00:17:39.625897-05	\N
7	7	2025-2026	\N	16	8	7	15	9	2	34	2	17	163	290	0	0	0	0	0	0	0	0	0	0	56.2	t	2026-03-05 00:17:39.625897-05	\N
8	8	2025-2026	\N	16	6	9	15	-2	8	66	8	7	1	5	0	0	0	0	0	0	0	0	0	0	49.8	t	2026-03-05 00:17:39.625897-05	\N
9	9	2025-2026	\N	16	7	6	13	-3	4	36	6	5	3	8	0	0	0	0	0	0	0	0	0	0	38.8	t	2026-03-05 00:17:39.625897-05	\N
200	27	2024	\N	30	4	14	18	1	0	51	0	0	0	0	0	0	0	0	0	0	0	0	0	0	56.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
201	67	2024	\N	29	8	9	17	6	0	53	0	0	0	0	0	0	0	0	0	0	0	0	0	0	63.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
202	15	2024	\N	30	6	11	17	-8	0	80	0	0	0	0	0	0	0	0	0	0	0	0	0	0	56	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
203	58	2024	\N	24	8	8	16	-1	0	50	0	0	0	0	0	0	0	0	0	0	0	0	0	0	54	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
204	21	2024	\N	29	5	11	16	-2	0	45	0	0	0	0	0	0	0	0	0	0	0	0	0	0	48.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
205	5	2024	\N	28	9	6	15	3	0	64	0	0	0	0	0	0	0	0	0	0	0	0	0	0	61.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
206	150	2024	\N	29	8	7	15	2	0	40	0	0	0	0	0	0	0	0	0	0	0	0	0	0	52	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
207	4	2024	\N	28	7	8	15	-1	0	68	0	0	0	0	0	0	0	0	0	0	0	0	0	0	56.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
208	52	2024	\N	21	6	8	14	-10	0	66	0	0	0	0	0	0	0	0	0	0	0	0	0	0	43.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
209	64	2024	\N	30	6	8	14	-9	0	51	0	0	0	0	0	0	0	0	0	0	0	0	0	0	40.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
210	62	2024	\N	27	3	11	14	-9	0	38	0	0	0	0	0	0	0	0	0	0	0	0	0	0	33.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
211	13	2024	\N	30	5	8	13	-5	0	50	0	0	0	0	0	0	0	0	0	0	0	0	0	0	41	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
212	117	2024	\N	30	2	11	13	-1	0	45	0	0	0	0	0	0	0	0	0	0	0	0	0	0	40.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
213	84	2024	\N	28	0	13	13	10	0	41	0	0	0	0	0	0	0	0	0	0	0	0	0	0	48.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
214	25	2024	\N	16	5	6	11	-4	0	36	0	0	0	0	0	0	0	0	0	0	0	0	0	0	33.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
215	24	2024	\N	30	5	6	11	1	0	77	0	0	0	0	0	0	0	0	0	0	0	0	0	0	51.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
216	141	2024	\N	30	3	8	11	5	0	30	0	0	0	0	0	0	0	0	0	0	0	0	0	0	39	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
217	7	2024	\N	30	3	8	11	3	0	51	0	0	0	0	0	0	0	0	0	0	0	0	0	0	43.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
218	56	2024	\N	28	2	9	11	11	0	47	0	0	0	0	0	0	0	0	0	0	0	0	0	0	49.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
219	22	2024	\N	22	4	6	10	-7	0	49	0	0	0	0	0	0	0	0	0	0	0	0	0	0	31.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
220	8	2024	\N	30	4	6	10	3	0	51	0	0	0	0	0	0	0	0	0	0	0	0	0	0	42.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
221	42	2024	\N	30	4	6	10	1	0	40	0	0	0	0	0	0	0	0	0	0	0	0	0	0	37	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
222	88	2024	\N	18	3	7	10	2	0	32	0	0	0	0	0	0	0	0	0	0	0	0	0	0	34.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
223	94	2024	\N	30	1	9	10	4	0	24	0	0	0	0	0	0	0	0	0	0	0	0	0	0	32.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
224	105	2024	\N	30	1	9	10	-5	0	56	0	0	0	0	0	0	0	0	0	0	0	0	0	0	32.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
225	169	2024	\N	24	6	3	9	-1	0	32	0	0	0	0	0	0	0	0	0	0	0	0	0	0	32.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
226	120	2024	\N	30	4	5	9	6	0	52	0	0	0	0	0	0	0	0	0	0	0	0	0	0	43.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
227	28	2024	\N	30	4	5	9	-5	0	39	0	0	0	0	0	0	0	0	0	0	0	0	0	0	28.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
228	63	2024	\N	30	3	6	9	2	0	45	0	0	0	0	0	0	0	0	0	0	0	0	0	0	36.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
229	90	2024	\N	30	3	6	9	1	0	52	0	0	0	0	0	0	0	0	0	0	0	0	0	0	37.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
230	103	2024	\N	30	3	6	9	-2	0	33	0	0	0	0	0	0	0	0	0	0	0	0	0	0	28.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
231	85	2024	\N	30	3	6	9	7	0	25	0	0	0	0	0	0	0	0	0	0	0	0	0	0	35.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
10	10	2025-2026	\N	17	6	7	13	1	0	61	3	8	1	5	0	0	0	0	0	0	0	0	0	0	51.3	t	2026-03-05 00:17:39.625897-05	\N
232	61	2024	\N	28	4	4	8	3	0	39	0	0	0	0	0	0	0	0	0	0	0	0	0	0	34.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
233	54	2024	\N	30	4	4	8	0	0	47	0	0	0	0	0	0	0	0	0	0	0	0	0	0	34.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
234	110	2024	\N	30	4	4	8	2	0	34	0	0	0	0	0	0	0	0	0	0	0	0	0	0	32.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
235	80	2024	\N	30	3	5	8	4	0	43	0	0	0	0	0	0	0	0	0	0	0	0	0	0	35.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
236	75	2024	\N	30	3	5	8	0	0	50	0	0	0	0	0	0	0	0	0	0	0	0	0	0	34	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
237	69	2024	\N	30	2	6	8	-6	0	48	0	0	0	0	0	0	0	0	0	0	0	0	0	0	26.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
238	48	2024	\N	14	3	4	7	-4	0	19	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
239	70	2024	\N	30	3	4	7	-4	0	52	0	0	0	0	0	0	0	0	0	0	0	0	0	0	28.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
240	71	2024	\N	30	2	5	7	-4	0	52	0	0	0	0	0	0	0	0	0	0	0	0	0	0	27.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
241	39	2024	\N	30	2	5	7	-5	0	31	0	0	0	0	0	0	0	0	0	0	0	0	0	0	20.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
242	176	2024	\N	29	1	6	7	4	0	31	0	0	0	0	0	0	0	0	0	0	0	0	0	0	28.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
243	77	2024	\N	30	0	7	7	-2	0	28	0	0	0	0	0	0	0	0	0	0	0	0	0	0	20.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
244	129	2024	\N	30	4	2	6	-2	0	46	0	0	0	0	0	0	0	0	0	0	0	0	0	0	27.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
245	97	2024	\N	27	3	3	6	1	0	23	0	0	0	0	0	0	0	0	0	0	0	0	0	0	22.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
246	41	2024	\N	28	3	3	6	-5	0	34	0	0	0	0	0	0	0	0	0	0	0	0	0	0	20.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
247	87	2024	\N	29	3	3	6	-3	0	45	0	0	0	0	0	0	0	0	0	0	0	0	0	0	25.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
248	73	2024	\N	23	2	4	6	-1	0	26	0	0	0	0	0	0	0	0	0	0	0	0	0	0	20.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
249	89	2024	\N	27	2	4	6	-1	0	29	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
250	86	2024	\N	29	2	4	6	-5	0	33	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
251	145	2024	\N	29	2	4	6	0	0	13	0	0	0	0	0	0	0	0	0	0	0	0	0	0	17.9	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
252	106	2024	\N	25	1	5	6	0	0	17	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
253	104	2024	\N	27	0	6	6	-9	0	35	0	0	0	0	0	0	0	0	0	0	0	0	0	0	13.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
254	74	2024	\N	30	0	6	6	-2	0	37	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
255	45	2024	\N	14	3	2	5	-1	0	31	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
256	72	2024	\N	30	3	2	5	1	0	30	0	0	0	0	0	0	0	0	0	0	0	0	0	0	23	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
257	78	2024	\N	24	2	3	5	-3	0	18	0	0	0	0	0	0	0	0	0	0	0	0	0	0	14.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
258	99	2024	\N	28	1	4	5	2	0	15	0	0	0	0	0	0	0	0	0	0	0	0	0	0	17.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
259	113	2024	\N	30	1	4	5	8	0	32	0	0	0	0	0	0	0	0	0	0	0	0	0	0	28.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
260	65	2024	\N	30	1	4	5	-12	0	35	0	0	0	0	0	0	0	0	0	0	0	0	0	0	9.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
261	148	2024	\N	30	1	4	5	-11	0	41	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
262	102	2024	\N	28	0	5	5	1	0	25	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
263	119	2024	\N	29	3	1	4	1	0	22	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
264	151	2024	\N	30	3	1	4	2	0	28	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
265	133	2024	\N	24	2	2	4	7	0	21	0	0	0	0	0	0	0	0	0	0	0	0	0	0	23.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
266	154	2024	\N	29	2	2	4	-5	0	37	0	0	0	0	0	0	0	0	0	0	0	0	0	0	16.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
267	121	2024	\N	19	1	3	4	4	0	29	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
268	143	2024	\N	26	1	3	4	-1	0	12	0	0	0	0	0	0	0	0	0	0	0	0	0	0	11.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
269	118	2024	\N	29	1	3	4	3	0	24	0	0	0	0	0	0	0	0	0	0	0	0	0	0	19.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
270	98	2024	\N	29	1	3	4	-7	0	15	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
271	112	2024	\N	29	1	3	4	-2	0	31	0	0	0	0	0	0	0	0	0	0	0	0	0	0	16.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
272	153	2024	\N	20	2	1	3	-1	0	19	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
273	50	2024	\N	23	1	2	3	-1	0	18	0	0	0	0	0	0	0	0	0	0	0	0	0	0	11.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
274	29	2024	\N	25	1	2	3	-2	0	56	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
275	147	2024	\N	27	1	2	3	-5	0	19	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
276	2	2024	\N	27	1	2	3	-6	0	30	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
277	122	2024	\N	23	0	3	3	-2	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	5.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
278	136	2024	\N	23	0	3	3	2	0	19	0	0	0	0	0	0	0	0	0	0	0	0	0	0	13.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
279	20	2024	\N	25	0	3	3	13	0	20	0	0	0	0	0	0	0	0	0	0	0	0	0	0	25	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
280	83	2024	\N	25	0	3	3	-6	0	14	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
281	149	2024	\N	28	0	3	3	3	0	20	0	0	0	0	0	0	0	0	0	0	0	0	0	0	15	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
282	131	2024	\N	28	0	3	3	-1	0	18	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
283	68	2024	\N	29	0	3	3	-2	0	14	0	0	0	0	0	0	0	0	0	0	0	0	0	0	8.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
284	93	2024	\N	30	2	0	2	-8	0	28	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
285	177	2024	\N	15	1	1	2	-3	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
286	49	2024	\N	21	1	1	2	-2	0	11	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
287	109	2024	\N	21	1	1	2	-2	0	22	0	0	0	0	0	0	0	0	0	0	0	0	0	0	9.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
288	43	2024	\N	22	1	1	2	-5	0	28	0	0	0	0	0	0	0	0	0	0	0	0	0	0	8.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
289	92	2024	\N	28	1	1	2	-5	0	25	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
290	96	2024	\N	29	1	1	2	-1	0	21	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
291	115	2024	\N	30	1	1	2	-2	0	21	0	0	0	0	0	0	0	0	0	0	0	0	0	0	9.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
292	139	2024	\N	13	0	2	2	0	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	5.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
293	144	2024	\N	19	0	2	2	-2	0	19	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
294	138	2024	\N	22	0	2	2	-1	0	15	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
295	175	2024	\N	26	0	2	2	4	0	12	0	0	0	0	0	0	0	0	0	0	0	0	0	0	11.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
296	167	2024	\N	1	1	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.3	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
297	146	2024	\N	30	1	0	1	-10	0	28	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
298	79	2024	\N	19	0	1	1	2	0	17	0	0	0	0	0	0	0	0	0	0	0	0	0	0	9.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
508	18	2024-2025	\N	1	3	1	4	3	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	15.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
509	20	2024-2025	\N	1	2	1	3	2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
510	100	2024-2025	\N	2	2	1	3	2	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	11.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
511	14	2024-2025	\N	2	0	3	3	3	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
512	28	2024-2025	\N	1	2	0	2	2	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
513	67	2024-2025	\N	2	2	0	2	0	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
514	156	2024-2025	\N	2	2	0	2	1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	8.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
515	53	2024-2025	\N	1	1	1	2	2	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
516	65	2024-2025	\N	1	1	1	2	0	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
517	3	2024-2025	\N	1	1	1	2	1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
518	17	2024-2025	\N	1	1	1	2	1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
519	57	2024-2025	\N	2	1	1	2	3	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	8.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
520	132	2024-2025	\N	2	1	1	2	2	2	9	0	0	0	0	0	0	0	0	0	0	0	0	0	0	8.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
521	11	2024-2025	\N	2	1	1	2	1	2	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
522	171	2024-2025	\N	2	1	1	2	2	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
523	6	2024-2025	\N	1	0	2	2	1	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
524	75	2024-2025	\N	1	0	2	2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
525	10	2024-2025	\N	1	0	2	2	2	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
526	122	2024-2025	\N	2	0	2	2	2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
527	141	2024-2025	\N	1	1	0	1	1	2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
528	60	2024-2025	\N	1	1	0	1	2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	5.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
529	93	2024-2025	\N	1	1	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
12	12	2025-2026	\N	16	6	6	12	-6	2	47	1	8	226	378	0	0	0	0	0	0	0	0	0	0	37.1	t	2026-03-05 00:17:39.625897-05	\N
15	15	2025-2026	\N	17	5	7	12	2	27	40	18	5	81	148	0	0	0	0	0	0	0	0	0	0	29.5	t	2026-03-05 00:17:39.625897-05	\N
17	17	2025-2026	\N	18	3	8	11	7	10	81	11	8	0	1	0	0	0	0	0	0	0	0	0	0	51.3	t	2026-03-05 00:17:39.625897-05	\N
19	19	2025-2026	\N	14	3	7	10	-2	4	43	12	6	3	5	0	0	0	0	0	0	0	0	0	0	31.9	t	2026-03-05 00:17:39.625897-05	\N
20	20	2025-2026	\N	16	2	8	10	5	2	25	3	9	0	3	0	0	0	0	0	0	0	0	0	0	33.5	t	2026-03-05 00:17:39.625897-05	\N
21	21	2025-2026	\N	16	2	8	10	-5	10	23	13	5	102	217	0	0	0	0	0	0	0	0	0	0	18.9	t	2026-03-05 00:17:39.625897-05	\N
22	22	2025-2026	\N	16	6	3	9	-4	4	42	2	11	0	6	0	0	0	0	0	0	0	0	0	0	30.6	t	2026-03-05 00:17:39.625897-05	\N
23	23	2025-2026	\N	19	6	3	9	-4	6	49	11	14	45	95	0	0	0	0	0	0	0	0	0	0	31.7	t	2026-03-05 00:17:39.625897-05	\N
24	24	2025-2026	\N	19	5	4	9	-1	6	43	36	19	145	320	0	0	0	0	0	0	0	0	0	0	31.9	t	2026-03-05 00:17:39.625897-05	\N
25	25	2025-2026	\N	14	4	5	9	-6	2	38	8	7	1	2	0	0	0	0	0	0	0	0	0	0	26.4	t	2026-03-05 00:17:39.625897-05	\N
27	27	2025-2026	\N	15	3	6	9	1	6	28	7	18	0	0	0	0	0	0	0	0	0	0	0	0	27.4	t	2026-03-05 00:17:39.625897-05	\N
28	28	2025-2026	\N	19	3	6	9	-1	14	34	31	17	130	245	0	0	0	0	0	0	0	0	0	0	23.2	t	2026-03-05 00:17:39.625897-05	\N
29	29	2025-2026	\N	18	2	7	9	2	18	35	13	16	75	166	0	0	0	0	0	0	0	0	0	0	23.5	t	2026-03-05 00:17:39.625897-05	\N
30	30	2025-2026	\N	16	1	8	9	8	0	27	5	8	0	0	0	0	0	0	0	0	0	0	0	0	35.1	t	2026-03-05 00:17:39.625897-05	\N
31	31	2025-2026	\N	16	6	2	8	0	10	25	21	6	0	1	0	0	0	0	0	0	0	0	0	0	24.5	t	2026-03-05 00:17:39.625897-05	\N
32	32	2025-2026	\N	18	4	4	8	5	0	29	6	3	1	2	0	0	0	0	0	0	0	0	0	0	33.7	t	2026-03-05 00:17:39.625897-05	\N
33	33	2025-2026	\N	17	3	5	8	-5	0	35	15	5	1	4	0	0	0	0	0	0	0	0	0	0	24.5	t	2026-03-05 00:17:39.625897-05	\N
34	34	2025-2026	\N	16	2	6	8	9	2	29	19	5	0	2	0	0	0	0	0	0	0	0	0	0	34.7	t	2026-03-05 00:17:39.625897-05	\N
36	36	2025-2026	\N	17	1	7	8	5	6	30	25	3	4	10	0	0	0	0	0	0	0	0	0	0	28	t	2026-03-05 00:17:39.625897-05	\N
38	38	2025-2026	\N	18	1	7	8	-1	12	21	27	24	0	0	0	0	0	0	0	0	0	0	0	0	16.3	t	2026-03-05 00:17:39.625897-05	\N
39	39	2025-2026	\N	17	5	2	7	-2	6	19	7	10	5	10	0	0	0	0	0	0	0	0	0	0	19.7	t	2026-03-05 00:17:39.625897-05	\N
40	40	2025-2026	\N	17	4	3	7	-4	0	60	12	18	0	0	0	0	0	0	0	0	0	0	0	0	32	t	2026-03-05 00:17:39.625897-05	\N
41	41	2025-2026	\N	18	4	3	7	2	0	48	7	14	3	5	0	0	0	0	0	0	0	0	0	0	34.4	t	2026-03-05 00:17:39.625897-05	\N
43	43	2025-2026	\N	18	3	4	7	2	14	26	17	44	0	0	0	0	0	0	0	0	0	0	0	0	19.8	t	2026-03-05 00:17:39.625897-05	\N
44	44	2025-2026	\N	18	3	4	7	5	4	36	14	7	3	6	0	0	0	0	0	0	0	0	0	0	30.8	t	2026-03-05 00:17:39.625897-05	\N
45	45	2025-2026	\N	19	3	4	7	-5	4	56	4	10	6	17	0	0	0	0	0	0	0	0	0	0	26.8	t	2026-03-05 00:17:39.625897-05	\N
46	46	2025-2026	\N	17	1	6	7	-7	4	33	29	12	123	264	0	0	0	0	0	0	0	0	0	0	15.9	t	2026-03-05 00:17:39.625897-05	\N
47	47	2025-2026	\N	18	1	6	7	6	4	27	19	13	0	0	0	0	0	0	0	0	0	0	0	0	27.1	t	2026-03-05 00:17:39.625897-05	\N
48	48	2025-2026	\N	18	1	6	7	-5	4	20	17	10	101	222	0	0	0	0	0	0	0	0	0	0	14	t	2026-03-05 00:17:39.625897-05	\N
49	49	2025-2026	\N	16	6	0	6	3	8	21	14	13	14	29	0	0	0	0	0	0	0	0	0	0	23.3	t	2026-03-05 00:17:39.625897-05	\N
52	52	2025-2026	\N	6	4	2	6	4	2	22	8	8	55	112	0	0	0	0	0	0	0	0	0	0	25.6	t	2026-03-05 00:17:39.625897-05	\N
53	53	2025-2026	\N	17	3	3	6	-4	6	33	14	4	2	9	0	0	0	0	0	0	0	0	0	0	17.9	t	2026-03-05 00:17:39.625897-05	\N
55	55	2025-2026	\N	18	3	3	6	-4	2	52	24	3	4	6	0	0	0	0	0	0	0	0	0	0	25.6	t	2026-03-05 00:17:39.625897-05	\N
56	56	2025-2026	\N	18	3	3	6	0	2	42	23	17	0	0	0	0	0	0	0	0	0	0	0	0	26.6	t	2026-03-05 00:17:39.625897-05	\N
58	58	2025-2026	\N	19	2	4	6	-3	6	39	24	42	0	2	0	0	0	0	0	0	0	0	0	0	19.7	t	2026-03-05 00:17:39.625897-05	\N
59	59	2025-2026	\N	15	1	5	6	-2	10	23	35	15	0	0	0	0	0	0	0	0	0	0	0	0	12.9	t	2026-03-05 00:17:39.625897-05	\N
60	60	2025-2026	\N	18	1	5	6	0	6	24	9	7	7	14	0	0	0	0	0	0	0	0	0	0	17.2	t	2026-03-05 00:17:39.625897-05	\N
61	61	2025-2026	\N	18	1	5	6	6	10	28	18	8	0	0	0	0	0	0	0	0	0	0	0	0	22.4	t	2026-03-05 00:17:39.625897-05	\N
63	63	2025-2026	\N	19	0	6	6	2	4	22	9	15	3	8	0	0	0	0	0	0	0	0	0	0	18.6	t	2026-03-05 00:17:39.625897-05	\N
64	64	2025-2026	\N	17	4	1	5	-3	6	40	15	10	13	29	0	0	0	0	0	0	0	0	0	0	20	t	2026-03-05 00:17:39.625897-05	\N
66	66	2025-2026	\N	10	3	2	5	0	4	22	9	4	2	2	0	0	0	0	0	0	0	0	0	0	17.6	t	2026-03-05 00:17:39.625897-05	\N
67	67	2025-2026	\N	18	3	2	5	1	2	39	3	3	133	246	0	0	0	0	0	0	0	0	0	0	24.7	t	2026-03-05 00:17:39.625897-05	\N
68	68	2025-2026	\N	18	3	2	5	6	6	15	17	8	1	2	0	0	0	0	0	0	0	0	0	0	20.5	t	2026-03-05 00:17:39.625897-05	\N
69	69	2025-2026	\N	16	2	3	5	-1	6	28	15	11	111	232	0	0	0	0	0	0	0	0	0	0	16.4	t	2026-03-05 00:17:39.625897-05	\N
70	70	2025-2026	\N	19	2	3	5	-8	2	36	2	22	0	0	0	0	0	0	0	0	0	0	0	0	13.8	t	2026-03-05 00:17:39.625897-05	\N
74	74	2025-2026	\N	19	1	4	5	-8	4	33	10	14	0	0	0	0	0	0	0	0	0	0	0	0	10.9	t	2026-03-05 00:17:39.625897-05	\N
75	75	2025-2026	\N	16	0	5	5	-3	2	25	7	24	0	0	0	0	0	0	0	0	0	0	0	0	13.5	t	2026-03-05 00:17:39.625897-05	\N
76	76	2025-2026	\N	18	0	5	5	2	23	23	14	6	4	14	0	0	0	0	0	0	0	0	0	0	7.4	t	2026-03-05 00:17:39.625897-05	\N
77	77	2025-2026	\N	18	0	5	5	2	18	16	14	15	0	0	0	0	0	0	0	0	0	0	0	0	7.8	t	2026-03-05 00:17:39.625897-05	\N
79	79	2025-2026	\N	16	1	3	4	-2	12	16	23	20	0	1	0	0	0	0	0	0	0	0	0	0	5.8	t	2026-03-05 00:17:39.625897-05	\N
80	80	2025-2026	\N	16	1	3	4	-5	8	31	6	17	74	175	0	0	0	0	0	0	0	0	0	0	9.3	t	2026-03-05 00:17:39.625897-05	\N
81	81	2025-2026	\N	16	1	3	4	1	10	20	4	5	0	2	0	0	0	0	0	0	0	0	0	0	11	t	2026-03-05 00:17:39.625897-05	\N
82	82	2025-2026	\N	16	1	3	4	-3	6	16	4	2	0	8	0	0	0	0	0	0	0	0	0	0	7.8	t	2026-03-05 00:17:39.625897-05	\N
83	83	2025-2026	\N	19	1	3	4	4	0	13	8	12	0	1	0	0	0	0	0	0	0	0	0	0	16.9	t	2026-03-05 00:17:39.625897-05	\N
84	84	2025-2026	\N	14	0	4	4	3	2	22	6	25	0	0	0	0	0	0	0	0	0	0	0	0	16.6	t	2026-03-05 00:17:39.625897-05	\N
85	85	2025-2026	\N	16	0	4	4	-6	8	28	20	15	0	0	0	0	0	0	0	0	0	0	0	0	6.4	t	2026-03-05 00:17:39.625897-05	\N
86	86	2025-2026	\N	16	3	0	3	-4	4	20	8	16	4	18	0	0	0	0	0	0	0	0	0	0	9	t	2026-03-05 00:17:39.625897-05	\N
87	87	2025-2026	\N	9	2	1	3	4	2	6	3	2	27	43	0	0	0	0	0	0	0	0	0	0	12.8	t	2026-03-05 00:17:39.625897-05	\N
88	88	2025-2026	\N	10	2	1	3	-3	8	27	24	8	59	104	0	0	0	0	0	0	0	0	0	0	9.1	t	2026-03-05 00:17:39.625897-05	\N
92	92	2025-2026	\N	17	2	1	3	-2	6	14	13	8	0	0	0	0	0	0	0	0	0	0	0	0	7.2	t	2026-03-05 00:17:39.625897-05	\N
93	93	2025-2026	\N	19	2	1	3	-2	2	35	6	9	2	7	0	0	0	0	0	0	0	0	0	0	15.5	t	2026-03-05 00:17:39.625897-05	\N
94	94	2025-2026	\N	9	1	2	3	3	21	10	7	9	0	0	0	0	0	0	0	0	0	0	0	0	2.5	t	2026-03-05 00:17:39.625897-05	\N
96	96	2025-2026	\N	16	1	2	3	-2	4	15	18	10	41	97	0	0	0	0	0	0	0	0	0	0	7.5	t	2026-03-05 00:17:39.625897-05	\N
97	97	2025-2026	\N	17	1	2	3	-4	0	17	13	35	0	0	0	0	0	0	0	0	0	0	0	0	8.1	t	2026-03-05 00:17:39.625897-05	\N
98	98	2025-2026	\N	18	1	2	3	-3	6	12	25	14	0	3	0	0	0	0	0	0	0	0	0	0	4.6	t	2026-03-05 00:17:39.625897-05	\N
99	99	2025-2026	\N	18	1	2	3	4	4	23	15	11	0	1	0	0	0	0	0	0	0	0	0	0	15.9	t	2026-03-05 00:17:39.625897-05	\N
100	100	2025-2026	\N	19	1	2	3	-4	2	19	6	8	1	3	0	0	0	0	0	0	0	0	0	0	7.7	t	2026-03-05 00:17:39.625897-05	\N
102	102	2025-2026	\N	12	0	3	3	-2	2	9	10	3	0	2	0	0	0	0	0	0	0	0	0	0	5.7	t	2026-03-05 00:17:39.625897-05	\N
103	103	2025-2026	\N	14	0	3	3	8	2	19	4	12	0	1	0	0	0	0	0	0	0	0	0	0	18.7	t	2026-03-05 00:17:39.625897-05	\N
106	106	2025-2026	\N	18	0	3	3	2	8	12	8	29	0	0	0	0	0	0	0	0	0	0	0	0	7.6	t	2026-03-05 00:17:39.625897-05	\N
108	108	2025-2026	\N	19	2	0	2	-5	6	23	7	5	29	63	0	0	0	0	0	0	0	0	0	0	4.9	t	2026-03-05 00:17:39.625897-05	\N
109	109	2025-2026	\N	15	1	1	2	-8	4	18	5	5	2	8	0	0	0	0	0	0	0	0	0	0	0.4	t	2026-03-05 00:17:39.625897-05	\N
110	110	2025-2026	\N	17	1	1	2	-1	8	21	19	4	27	54	0	0	0	0	0	0	0	0	0	0	6.3	t	2026-03-05 00:17:39.625897-05	\N
111	111	2025-2026	\N	17	1	1	2	1	2	10	8	1	0	1	0	0	0	0	0	0	0	0	0	0	8	t	2026-03-05 00:17:39.625897-05	\N
112	112	2025-2026	\N	17	1	1	2	0	10	18	19	10	113	212	0	0	0	0	0	0	0	0	0	0	5.4	t	2026-03-05 00:17:39.625897-05	\N
113	113	2025-2026	\N	18	1	1	2	2	6	24	12	24	0	0	0	0	0	0	0	0	0	0	0	0	11.2	t	2026-03-05 00:17:39.625897-05	\N
114	114	2025-2026	\N	11	0	2	2	-2	2	7	5	12	1	1	0	0	0	0	0	0	0	0	0	0	3.1	t	2026-03-05 00:17:39.625897-05	\N
115	115	2025-2026	\N	13	0	2	2	2	8	6	11	18	1	2	0	0	0	0	0	0	0	0	0	0	3.8	t	2026-03-05 00:17:39.625897-05	\N
116	116	2025-2026	\N	13	0	2	2	2	4	8	2	2	0	0	0	0	0	0	0	0	0	0	0	0	6.4	t	2026-03-05 00:17:39.625897-05	\N
117	117	2025-2026	\N	16	0	2	2	-8	6	33	5	31	0	0	0	0	0	0	0	0	0	0	0	0	2.9	t	2026-03-05 00:17:39.625897-05	\N
118	118	2025-2026	\N	16	0	2	2	-4	6	12	16	22	0	0	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 00:17:39.625897-05	\N
119	119	2025-2026	\N	16	0	2	2	-2	0	8	5	28	0	0	0	0	0	0	0	0	0	0	0	0	4.4	t	2026-03-05 00:17:39.625897-05	\N
120	120	2025-2026	\N	16	0	2	2	-4	0	23	2	4	1	3	0	0	0	0	0	0	0	0	0	0	6.9	t	2026-03-05 00:17:39.625897-05	\N
121	121	2025-2026	\N	16	0	2	2	2	2	11	9	15	48	82	0	0	0	0	0	0	0	0	0	0	8.3	t	2026-03-05 00:17:39.625897-05	\N
124	124	2025-2026	\N	18	0	2	2	0	2	12	5	3	1	1	0	0	0	0	0	0	0	0	0	0	6.6	t	2026-03-05 00:17:39.625897-05	\N
125	125	2025-2026	\N	19	0	2	2	0	10	10	9	13	53	116	0	0	0	0	0	0	0	0	0	0	2	t	2026-03-05 00:17:39.625897-05	\N
126	126	2025-2026	\N	2	1	0	1	1	0	1	1	5	0	0	0	0	0	0	0	0	0	0	0	0	4.3	t	2026-03-05 00:17:39.625897-05	\N
127	127	2025-2026	\N	4	1	0	1	1	4	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 00:17:39.625897-05	\N
128	128	2025-2026	\N	5	1	0	1	1	0	3	4	2	1	2	0	0	0	0	0	0	0	0	0	0	4.9	t	2026-03-05 00:17:39.625897-05	\N
129	129	2025-2026	\N	11	1	0	1	0	4	18	9	1	11	20	0	0	0	0	0	0	0	0	0	0	6.4	t	2026-03-05 00:17:39.625897-05	\N
130	130	2025-2026	\N	13	1	0	1	-3	4	5	3	8	1	5	0	0	0	0	0	0	0	0	0	0	-0.5	t	2026-03-05 00:17:39.625897-05	\N
132	132	2025-2026	\N	16	1	0	1	-4	10	18	13	16	44	119	0	0	0	0	0	0	0	0	0	0	-0.6	t	2026-03-05 00:17:39.625897-05	\N
133	133	2025-2026	\N	18	1	0	1	-2	2	14	32	12	78	140	0	0	0	0	0	0	0	0	0	0	4.2	t	2026-03-05 00:17:39.625897-05	\N
134	134	2025-2026	\N	7	0	1	1	1	0	13	4	6	0	0	0	0	0	0	0	0	0	0	0	0	6.9	t	2026-03-05 00:17:39.625897-05	\N
135	135	2025-2026	\N	8	0	1	1	-3	0	3	5	6	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 00:17:39.625897-05	\N
136	136	2025-2026	\N	12	0	1	1	2	4	15	24	16	0	0	0	0	0	0	0	0	0	0	0	0	6.5	t	2026-03-05 00:17:39.625897-05	\N
137	137	2025-2026	\N	12	0	1	1	0	0	4	13	1	20	73	0	0	0	0	0	0	0	0	0	0	3.2	t	2026-03-05 00:17:39.625897-05	\N
140	140	2025-2026	\N	15	0	1	1	-1	8	14	9	10	0	0	0	0	0	0	0	0	0	0	0	0	1.2	t	2026-03-05 00:17:39.625897-05	\N
142	142	2025-2026	\N	16	0	1	1	-2	6	17	5	1	0	0	0	0	0	0	0	0	0	0	0	0	2.1	t	2026-03-05 00:17:39.625897-05	\N
143	143	2025-2026	\N	16	0	1	1	-1	2	9	3	6	2	6	0	0	0	0	0	0	0	0	0	0	2.7	t	2026-03-05 00:17:39.625897-05	\N
144	144	2025-2026	\N	16	0	1	1	9	4	6	1	11	0	0	0	0	0	0	0	0	0	0	0	0	10.8	t	2026-03-05 00:17:39.625897-05	\N
145	145	2025-2026	\N	16	0	1	1	-2	0	6	5	6	1	10	0	0	0	0	0	0	0	0	0	0	1.8	t	2026-03-05 00:17:39.625897-05	\N
147	147	2025-2026	\N	17	0	1	1	-2	0	12	18	17	0	0	0	0	0	0	0	0	0	0	0	0	3.6	t	2026-03-05 00:17:39.625897-05	\N
149	149	2025-2026	\N	18	0	1	1	-1	23	5	11	5	0	0	0	0	0	0	0	0	0	0	0	0	-9	t	2026-03-05 00:17:39.625897-05	\N
150	150	2025-2026	\N	18	0	1	1	-4	4	13	29	3	4	7	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 00:17:39.625897-05	\N
151	151	2025-2026	\N	19	0	1	1	-3	2	15	9	5	2	5	0	0	0	0	0	0	0	0	0	0	2.5	t	2026-03-05 00:17:39.625897-05	\N
152	152	2025-2026	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 00:17:39.625897-05	\N
154	154	2025-2026	\N	1	0	0	0	-3	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2.7	t	2026-03-05 00:17:39.625897-05	\N
155	155	2025-2026	\N	2	0	0	0	-1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	-1	t	2026-03-05 00:17:39.625897-05	\N
156	156	2025-2026	\N	2	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 00:17:39.625897-05	\N
157	157	2025-2026	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 00:17:39.625897-05	\N
159	159	2025-2026	\N	3	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 00:17:39.625897-05	\N
160	160	2025-2026	\N	4	0	0	0	1	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.5	t	2026-03-05 00:17:39.625897-05	\N
161	161	2025-2026	\N	4	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 00:17:39.625897-05	\N
162	162	2025-2026	\N	5	0	0	0	1	0	1	2	1	0	0	0	0	0	0	0	0	0	0	0	0	1.3	t	2026-03-05 00:17:39.625897-05	\N
163	163	2025-2026	\N	6	0	0	0	0	2	1	2	0	1	1	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 00:17:39.625897-05	\N
164	164	2025-2026	\N	6	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 00:17:39.625897-05	\N
165	165	2025-2026	\N	7	0	0	0	-2	0	1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	-1.7	t	2026-03-05 00:17:39.625897-05	\N
167	167	2025-2026	\N	8	0	0	0	2	2	5	8	5	0	0	0	0	0	0	0	0	0	0	0	0	2.5	t	2026-03-05 00:17:39.625897-05	\N
168	168	2025-2026	\N	10	0	0	0	-1	2	2	3	0	11	24	0	0	0	0	0	0	0	0	0	0	-1.4	t	2026-03-05 00:17:39.625897-05	\N
169	169	2025-2026	\N	12	0	0	0	-1	4	12	7	3	1	1	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 00:17:39.625897-05	\N
170	170	2025-2026	\N	13	0	0	0	0	2	1	6	5	19	40	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 00:17:39.625897-05	\N
171	171	2025-2026	\N	13	0	0	0	-1	2	7	7	1	0	0	0	0	0	0	0	0	0	0	0	0	0.1	t	2026-03-05 00:17:39.625897-05	\N
172	172	2025-2026	\N	14	0	0	0	0	6	3	19	5	0	0	0	0	0	0	0	0	0	0	0	0	-2.1	t	2026-03-05 00:17:39.625897-05	\N
173	173	2025-2026	\N	14	0	0	0	-4	2	10	11	2	56	113	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 00:17:39.625897-05	\N
174	174	2025-2026	\N	14	0	0	0	-4	0	6	0	5	19	45	0	0	0	0	0	0	0	0	0	0	-2.2	t	2026-03-05 00:17:39.625897-05	\N
175	175	2025-2026	\N	15	0	0	0	-1	4	1	1	1	0	1	0	0	0	0	0	0	0	0	0	0	-2.7	t	2026-03-05 00:17:39.625897-05	\N
176	176	2025-2026	\N	17	0	0	0	-6	2	12	30	20	0	0	0	0	0	0	0	0	0	0	0	0	-3.4	t	2026-03-05 00:17:39.625897-05	\N
177	177	2025-2026	\N	17	0	0	0	-2	2	6	16	5	5	13	0	0	0	0	0	0	0	0	0	0	-1.2	t	2026-03-05 00:17:39.625897-05	\N
530	1	2024-2025	\N	1	1	0	1	1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
531	7	2024-2025	\N	1	1	0	1	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
686	179	2024-2025	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:23:08.128046-05	\N
532	103	2024-2025	\N	1	1	0	1	-2	2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
146	146	2025-2026	\N	17	0	1	1	-2	6	11	18	1	4	9	0	0	0	0	0	0	0	0	0	0	0.3	t	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
533	157	2024-2025	\N	1	1	0	1	2	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
534	142	2024-2025	\N	2	1	0	1	-4	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
535	107	2024-2025	\N	2	1	0	1	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
536	170	2024-2025	\N	2	1	0	1	-1	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
537	113	2024-2025	\N	2	1	0	1	1	0	7	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
538	154	2024-2025	\N	2	1	0	1	-1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
539	80	2024-2025	\N	2	1	0	1	-1	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
540	104	2024-2025	\N	2	1	0	1	2	0	8	0	0	0	0	0	0	0	0	0	0	0	0	0	0	7.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
541	177	2024-2025	\N	2	1	0	1	1	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
542	34	2024-2025	\N	2	1	0	1	1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	5.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
543	66	2024-2025	\N	2	1	0	1	-1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
544	172	2024-2025	\N	2	1	0	1	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
545	102	2024-2025	\N	2	1	0	1	1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
546	37	2024-2025	\N	2	1	0	1	2	2	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	5.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
547	97	2024-2025	\N	1	0	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
548	70	2024-2025	\N	1	0	1	1	2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
709	188	2024-2025	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:23:08.128046-05	\N
549	21	2024-2025	\N	1	0	1	1	0	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
550	119	2024-2025	\N	1	0	1	1	2	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
551	54	2024-2025	\N	1	0	1	1	1	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
552	90	2024-2025	\N	1	0	1	1	1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
553	46	2024-2025	\N	1	0	1	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
554	115	2024-2025	\N	1	0	1	1	2	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
555	41	2024-2025	\N	1	0	1	1	1	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
556	52	2024-2025	\N	1	0	1	1	2	2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
557	88	2024-2025	\N	1	0	1	1	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
558	42	2024-2025	\N	1	0	1	1	0	2	7	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
559	45	2024-2025	\N	1	0	1	1	2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
560	61	2024-2025	\N	1	0	1	1	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
561	27	2024-2025	\N	1	0	1	1	2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
562	22	2024-2025	\N	1	0	1	1	1	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
563	140	2024-2025	\N	2	0	1	1	0	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
696	184	2025-2026	\N	8	0	0	0	0	0	0	0	0	0	0	0	4	3	0	207	226	19	0	0.916	2.35	42.4	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
704	186	2024	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:23:08.128046-05	2026-03-05 13:18:09.886939-05
710	188	2024	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:23:08.128046-05	2026-03-05 13:18:09.886939-05
719	191	2024	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:23:08.128046-05	2026-03-05 13:18:09.886939-05
684	179	2025-2026	\N	15	0	0	0	0	0	0	0	0	0	0	0	11	2	0	364	384	20	4	0.948	1.3	119.8	t	2026-03-05 11:15:42.761239-05	2026-03-06 06:00:00.93433-05
564	162	2024-2025	\N	2	0	1	1	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
565	165	2024-2025	\N	2	0	1	1	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
566	71	2024-2025	\N	2	0	1	1	3	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	5.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
567	143	2024-2025	\N	2	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
683	178	2025-2026	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	26	27	1	0	0.963	1	9.2	t	2026-03-05 11:15:42.761239-05	2026-03-05 12:52:38.364184-05
568	47	2024-2025	\N	2	0	1	1	3	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
569	68	2024-2025	\N	2	0	1	1	1	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
680	179	2024	\N	23	0	0	0	0	0	0	0	0	0	0	0	12	8	0	591	642	51	1	0.921	2.28	130.2	t	2026-03-05 11:15:42.611066-05	2026-03-05 17:07:29.787326-05
681	178	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	39	42	3	0	0.929	2.88	4.8	t	2026-03-05 11:15:42.693614-05	2026-03-05 17:07:29.787326-05
694	183	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	18	18	0	0	1	0	8.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
695	183	2024	\N	11	0	0	0	0	0	0	0	0	0	0	0	7	3	0	243	270	27	1	0.9	2.53	59.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
697	184	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	17	20	3	0	0.85	4.5	0.4	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
698	184	2024	\N	19	0	0	0	0	0	0	0	0	0	0	0	8	7	0	379	418	39	2	0.907	2.07	82.8	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
182	18	2024	\N	30	13	16	29	10	0	105	0	0	0	0	0	0	0	0	0	0	0	0	0	0	112.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
183	10	2024	\N	30	12	15	27	-2	0	99	0	0	0	0	0	0	0	0	0	0	0	0	0	0	93.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
184	3	2024	\N	30	19	7	26	17	0	98	0	0	0	0	0	0	0	0	0	0	0	0	0	0	117.4	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
185	1	2024	\N	30	12	12	24	12	0	86	0	0	0	0	0	0	0	0	0	0	0	0	0	0	97.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
186	46	2024	\N	29	10	14	24	14	0	59	0	0	0	0	0	0	0	0	0	0	0	0	0	0	89.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
187	9	2024	\N	30	9	15	24	0	0	77	0	0	0	0	0	0	0	0	0	0	0	0	0	0	80.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
188	36	2024	\N	30	15	7	22	-2	0	87	0	0	0	0	0	0	0	0	0	0	0	0	0	0	83.1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
189	17	2024	\N	27	11	11	22	12	0	112	0	0	0	0	0	0	0	0	0	0	0	0	0	0	100.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
190	6	2024	\N	29	8	14	22	1	0	69	0	0	0	0	0	0	0	0	0	0	0	0	0	0	73.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
191	40	2024	\N	25	7	15	22	12	0	75	0	0	0	0	0	0	0	0	0	0	0	0	0	0	85.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
192	59	2024	\N	30	6	16	22	0	0	62	0	0	0	0	0	0	0	0	0	0	0	0	0	0	68.6	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
300	101	2024	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 09:36:40.981279-05	2026-03-05 13:18:09.886939-05
299	124	2024	\N	27	0	1	1	-4	0	9	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
301	135	2024	\N	4	0	0	0	-1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.2	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
302	164	2024	\N	4	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
303	161	2024	\N	9	0	0	0	-2	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.5	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
304	123	2024	\N	10	0	0	0	-2	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.8	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
305	159	2024	\N	12	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	t	2026-03-05 09:36:40.981279-05	2026-03-05 17:07:29.787326-05
570	101	2024-2025	\N	2	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
571	121	2024-2025	\N	2	0	1	1	1	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	4.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
572	2	2024-2025	\N	2	0	1	1	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
573	92	2024-2025	\N	2	0	1	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
574	51	2024-2025	\N	2	0	1	1	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
575	161	2024-2025	\N	2	0	1	1	-4	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
576	62	2024-2025	\N	2	0	1	1	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
577	89	2024-2025	\N	2	0	1	1	1	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
578	148	2024-2025	\N	2	0	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
579	174	2024-2025	\N	2	0	1	1	-4	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
580	85	2024-2025	\N	2	0	1	1	0	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
581	147	2024-2025	\N	1	0	0	0	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
583	25	2024-2025	\N	1	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
584	64	2024-2025	\N	1	0	0	0	0	2	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
586	118	2024-2025	\N	1	0	0	0	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
587	144	2024-2025	\N	1	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
588	12	2024-2025	\N	1	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
589	79	2024-2025	\N	1	0	0	0	-2	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
707	187	2024	\N	21	0	0	0	0	0	0	0	0	0	0	0	15	2	0	518	556	38	0	0.932	1.86	140.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
716	190	2024	\N	10	0	0	0	0	0	0	0	0	0	0	0	2	4	0	228	249	21	1	0.916	2.22	37.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
722	192	2024	\N	15	0	0	0	0	0	0	0	0	0	0	0	8	5	0	316	344	28	2	0.919	2.11	81.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
728	194	2024	\N	10	0	0	0	0	0	0	0	0	0	0	0	5	1	0	221	241	20	0	0.917	2.26	49.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
590	176	2024-2025	\N	1	0	0	0	-2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
591	55	2024-2025	\N	1	0	0	0	-2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
592	23	2024-2025	\N	1	0	0	0	-1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
593	5	2024-2025	\N	1	0	0	0	-1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
594	9	2024-2025	\N	1	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
595	59	2024-2025	\N	1	0	0	0	1	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
596	8	2024-2025	\N	1	0	0	0	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
599	96	2024-2025	\N	1	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
600	81	2024-2025	\N	1	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
601	40	2024-2025	\N	1	0	0	0	-2	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
602	4	2024-2025	\N	1	0	0	0	-2	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
603	13	2024-2025	\N	1	0	0	0	1	2	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
604	19	2024-2025	\N	1	0	0	0	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
605	159	2024-2025	\N	1	0	0	0	-2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
606	120	2024-2025	\N	1	0	0	0	-2	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
608	77	2024-2025	\N	1	0	0	0	-2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
609	99	2024-2025	\N	1	0	0	0	-2	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
610	150	2024-2025	\N	1	0	0	0	-2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
611	32	2024-2025	\N	1	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
612	48	2024-2025	\N	1	0	0	0	-2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
615	73	2024-2025	\N	1	0	0	0	-1	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
618	78	2024-2025	\N	1	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
619	29	2024-2025	\N	1	0	0	0	-1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
620	69	2024-2025	\N	1	0	0	0	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
621	58	2024-2025	\N	1	0	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
622	26	2024-2025	\N	1	0	0	0	0	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
623	94	2024-2025	\N	1	0	0	0	0	4	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
624	24	2024-2025	\N	1	0	0	0	-1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
625	36	2024-2025	\N	1	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
627	35	2024-2025	\N	1	0	0	0	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
628	151	2024-2025	\N	1	0	0	0	1	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
629	158	2024-2025	\N	1	0	0	0	1	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
630	105	2024-2025	\N	1	0	0	0	1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
631	22	2024-2025	\N	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
632	86	2024-2025	\N	2	0	0	0	1	0	7	0	0	0	0	0	0	0	0	0	0	0	0	0	0	3.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
633	91	2024-2025	\N	2	0	0	0	2	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
634	163	2024-2025	\N	2	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
635	106	2024-2025	\N	2	0	0	0	2	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
638	130	2024-2025	\N	2	0	0	0	-1	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
639	30	2024-2025	\N	2	0	0	0	-3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
640	63	2024-2025	\N	2	0	0	0	-1	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
641	175	2024-2025	\N	2	0	0	0	0	2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
642	168	2024-2025	\N	2	0	0	0	1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
643	129	2024-2025	\N	2	0	0	0	-3	2	8	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
644	169	2024-2025	\N	2	0	0	0	-1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
645	146	2024-2025	\N	2	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
646	43	2024-2025	\N	2	0	0	0	-4	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
647	153	2024-2025	\N	2	0	0	0	0	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
648	33	2024-2025	\N	2	0	0	0	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
649	160	2024-2025	\N	2	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
650	50	2024-2025	\N	2	0	0	0	0	2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
651	38	2024-2025	\N	2	0	0	0	-3	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-3.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
652	74	2024-2025	\N	2	0	0	0	1	0	6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
653	76	2024-2025	\N	2	0	0	0	0	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
654	108	2024-2025	\N	2	0	0	0	-1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
655	95	2024-2025	\N	2	0	0	0	0	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
657	31	2024-2025	\N	2	0	0	0	-1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
658	83	2024-2025	\N	2	0	0	0	1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
659	139	2024-2025	\N	2	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.3	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
660	49	2024-2025	\N	2	0	0	0	-1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
661	167	2024-2025	\N	2	0	0	0	-2	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
662	127	2024-2025	\N	2	0	0	0	1	0	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2.5	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
663	137	2024-2025	\N	2	0	0	0	-2	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
664	114	2024-2025	\N	2	0	0	0	-1	4	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2.1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
665	138	2024-2025	\N	2	0	0	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
666	110	2024-2025	\N	2	0	0	0	-3	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2.4	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
667	128	2024-2025	\N	2	0	0	0	1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
668	116	2024-2025	\N	2	0	0	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
669	15	2024-2025	\N	2	0	0	0	1	2	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
671	173	2024-2025	\N	2	0	0	0	0	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
672	82	2024-2025	\N	2	0	0	0	-3	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1.8	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
673	109	2024-2025	\N	2	0	0	0	1	0	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.6	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
674	126	2024-2025	\N	2	0	0	0	-2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
675	125	2024-2025	\N	2	0	0	0	-1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
676	133	2024-2025	\N	2	0	0	0	0	2	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.7	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
677	123	2024-2025	\N	2	0	0	0	0	0	4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.2	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
678	44	2024-2025	\N	2	0	0	0	1	0	3	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1.9	t	2026-03-05 11:14:30.28561-05	2026-03-05 17:07:29.787326-05
685	178	2024	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	1	0	28	33	5	0	0.848	3.9	0.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
693	183	2025-2026	\N	8	0	0	0	0	0	0	0	0	0	0	0	5	1	0	222	237	15	1	0.937	1.85	57.4	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
702	186	2025-2026	\N	3	0	0	0	0	0	0	0	0	0	0	0	2	1	0	67	76	9	0	0.882	2.98	14.4	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
703	186	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	8	9	1	0	0.889	3.01	5.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
705	187	2025-2026	\N	15	0	0	0	0	0	0	0	0	0	0	0	11	4	0	365	381	16	4	0.958	1.06	124	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
706	187	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21	22	1	0	0.955	1.5	3.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
708	188	2025-2026	\N	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	32	37	5	0	0.865	3.19	1.4	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
714	190	2025-2026	\N	16	0	0	0	0	0	0	0	0	0	0	0	7	7	0	390	426	36	3	0.915	2.35	86	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
715	190	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	25	27	2	0	0.926	2	8	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
717	191	2025-2026	\N	2	0	0	0	0	0	0	0	0	0	0	0	1	1	0	51	55	4	0	0.927	1.93	11.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
718	191	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	11	11	0	0	1	0	2.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
720	192	2025-2026	\N	16	0	0	0	0	0	0	0	0	0	0	0	9	6	0	472	509	37	0	0.927	2.3	102.4	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
721	192	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	18	19	1	0	0.947	1.94	2.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
726	194	2025-2026	\N	14	0	0	0	0	0	0	0	0	0	0	0	4	5	0	355	386	31	0	0.92	2.29	60	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
727	194	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	23	23	0	1	1	0	12.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
729	195	2025-2026	\N	6	0	0	0	0	0	0	0	0	0	0	0	3	3	0	139	154	15	0	0.903	2.66	27.8	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
730	195	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	11	13	2	0	0.846	1.93	5.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
731	195	2024	\N	11	0	0	0	0	0	0	0	0	0	0	0	4	6	0	244	268	24	0	0.91	2.42	44.8	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
738	198	2025-2026	\N	12	0	0	0	0	0	0	0	0	0	0	0	4	6	0	340	366	26	1	0.929	2.18	65	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
739	198	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	20	20	0	1	1	0	12	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
740	198	2024	\N	18	0	0	0	0	0	0	0	0	0	0	0	6	7	0	453	496	43	0	0.913	2.58	77.6	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
741	199	2025-2026	\N	5	0	0	0	0	0	0	0	0	0	0	0	2	3	0	121	132	11	1	0.917	2.21	26.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
742	199	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	19	22	3	0	0.864	4.5	0.8	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
743	199	2024	\N	21	0	0	0	0	0	0	0	0	0	0	0	9	8	0	466	512	46	0	0.91	2.25	92.2	t	2026-03-05 11:23:08.128046-05	2026-03-05 17:07:29.787326-05
744	200	2025-2026	\N	8	0	0	0	0	0	0	0	0	0	0	0	3	5	0	235	258	23	0	0.911	2.91	39	t	2026-03-05 11:31:31.043202-05	2026-03-05 17:07:29.787326-05
745	201	2025-2026	\N	8	0	0	0	0	0	0	0	0	0	0	0	2	4	0	204	227	23	0	0.899	2.81	27.8	t	2026-03-05 11:31:31.043202-05	2026-03-05 17:07:29.787326-05
748	200	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	7	8	1	0	0.875	3	5.4	t	2026-03-05 11:31:31.043202-05	2026-03-05 17:07:29.787326-05
749	201	2024-2025	\N	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	12	14	2	0	0.857	3	0.4	t	2026-03-05 11:31:31.043202-05	2026-03-05 17:07:29.787326-05
752	201	2024	\N	20	0	0	0	0	0	0	0	0	0	0	0	10	8	0	530	577	47	4	0.919	2.43	121	t	2026-03-05 11:31:31.043202-05	2026-03-05 17:07:29.787326-05
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.players (id, pwhl_player_id, first_name, last_name, "position", jersey_number, pwhl_team_id, nationality, birthdate, height_cm, weight_kg, shoots, is_active, headshot_url, created_at, updated_at) FROM stdin;
1	20	Kendall	Coyne Schofield	F	26	2	United States	1992-05-25	158	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/20.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
2	72	Rebecca	Leslie	F	37	5	Canada	1996-05-08	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/72.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
3	31	Marie-Philip	Poulin	F	29	3	Canada	1991-03-28	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/31.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
4	58	Brianne	Jenner	F	19	5	Canada	1991-05-04	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/58.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
5	189	Britta	Curl-Salemme	F	77	2	United States	2000-03-20	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/189.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
6	21	Taylor	Heise	F	27	2	United States	2000-03-17	178	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/21.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
7	23	Kelly	Pannek	F	12	2	United States	1995-12-29	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/23.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
10	63	Daryl	Watts	F	9	6	Canada	1999-05-15	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/63.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
15	42	Abby	Roque	F	11	3	United States	1997-09-25	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/42.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
47	253	Nicole	Gosling	D	61	3		2002-04-21	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/253.jpg	2026-03-05 00:17:39.625897-05	2026-03-05 20:46:42.409843-05
148	230	Allyson	Simpson	D	20	10	United States	2000-12-20	173	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/230.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
159	131	Olivia	Knowles	D	9	10	Canada	1999-01-24	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/131.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
13	12	Megan	Keller	F	5	1	United States	1996-05-01	180	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/12.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
16	15	Alina	Müller	C	11	1	Switzerland	1998-03-12	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/15.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
17	32	Laura	Stacey	F	7	3	Canada	1994-05-05	178	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/32.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
11	245	Kristýna	Kaltounková	F	98	10	Czechia	2002-04-14	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/245.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
20	188	Mae	Batherson	D	21	2	Canada	2000-12-05	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/188.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
14	280	Casey	O'Brien	F	26	10	United States	2001-08-27	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/280.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
18	205	Sarah	Fillier	F	10	10	Canada	2000-06-09	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/205.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
57	249	Anne	Cherkowski	F	24	10	Canada	2002-07-06	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/249.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
62	60	Jincy	Roese	D	71	10	United States	1997-05-15	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/60.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
65	30	Kristin	O'Neill	F	43	10	Canada	1998-03-30	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/30.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
21	57	Gabbie	Hughes	F	17	5	United States	1999-10-04	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/57.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
71	87	Jaime	Bourbonnais	D	14	10	Canada	1998-09-09	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/87.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
61	84	Kati	Tabin	D	9	3	Canada	1997-04-21	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/84.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
73	229	Maja	Nylen Persson	D	8	10	Sweden	2000-11-20	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/229.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
91	277	Anna	Bargman	F	22	10	United States	2002-08-07	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/277.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
104	206	Elle	Hartje	F	4	10	United States	2001-04-13	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/206.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
105	47	Micah	Zandee-Hart	D	28	10	Canada	1997-01-13	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/47.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
111	147	Savannah	Norcross	F	7	10	United States	2000-06-10	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/147.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
122	207	Lauren	Bernard	D	16	10	United States	2001-07-15	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/207.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
123	45	Kayla	Vespa	F	81	10	Canada	1997-04-01	158	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/45.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
126	283	Nicole	Vallario	D	11	10	Switzerland	2001-08-30	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/283.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
146	204	Emmy	Fecteau	F	29	10	Canada	1999-04-07	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/204.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
22	25	Grace	Zumwinkle	F	13	2	United States	1999-04-23	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/25.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
23	65	Jesse	Compher	F	18	6	United States	1999-07-01	173	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/65.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
24	76	Blayre	Turnbull	F	40	6	Canada	1993-07-15	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/76.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
26	78	Susanna	Tapani	C	77	1	Finland	1993-03-02	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/78.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
28	73	Emma	Maltais	F	27	6	Canada	1999-11-04	160	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/73.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
30	236	Kendall	Cooper	D	4	2	Canada	2002-05-19	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/236.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
31	240	Fanuza	Kadirova	F	71	5	Russia	1998-04-06	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/240.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
32	274	Natálie	Mlýnková	F	96	3	Czechia	2001-05-24	160	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/274.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
34	247	Abby	Hustler	F	74	2	Canada	2003-05-05	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/247.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
136	52	Zoe	Boyd	F	3	1	Canada	2000-08-09	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/52.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
165	162	Madison	Bizal	D	9	2		2000-01-25	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/162.jpg	2026-03-05 00:17:39.625897-05	2026-03-05 20:46:44.698463-05
8	210	Julia	Gosling	F	88	7	Canada	2001-02-21	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/210.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
9	36	Jessie	Eldridge	F	9	7	Canada	1997-12-17	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/36.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
12	34	Alex	Carpenter	F	25	7	United States	1994-04-13	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/34.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
19	13	Hilary	Knight	F	21	7	United States	1989-07-12	180	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/13.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
27	169	Claire	Thompson	D	42	8	Canada	1998-01-28	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/169.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
33	198	Jenn	Gardiner	F	12	8	Canada	2001-09-18	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/198.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
35	246	Haley	Winn	F	8	1	United States	2003-07-14	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/246.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
36	161	Tereza	Vanišová	F	13	8	Czechia	1996-01-30	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/161.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
38	242	Rory	Guilday	D	5	5	United States	2002-09-07	180	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/242.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
25	181	Hannah	Bilka	F	19	7	United States	2001-03-24	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/181.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
29	61	Hayley	Scamurra	F	16	3	United States	1994-12-14	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/61.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
39	209	Izzy	Daniel	F	8	8	United States	2000-09-29	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/209.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
40	11	Sophie	Jaques	D	16	8	Canada	2000-10-16	173	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/11.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
41	98	Maureen	Murphy	F	21	3	United States	1999-12-15	163	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/98.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
42	16	Jamie Lee	Rattray	RW	47	1	Canada	1992-09-30	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/16.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
187	28	Ann-Renée	Desbiens	G	35	3	Canadian	1994-04-10	175	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/28.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
43	79	Maggie	Flaherty	D	91	3	United States	2000-06-02	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/79.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
44	241	Sarah	Wozniewicz	F	23	5	Canada	2003-08-25	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/241.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
45	100	Natalie	Spooner	F	24	6	Canada	1990-10-17	178	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/100.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
188	282	Callie	Shanahan	G	37	4	American	2003-05-26	178	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/282.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
46	89	Hannah	Miller	F	34	8	Canada	1996-02-16	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/89.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
48	88	Kateřina	Mrázová	F	16	5	Czechia	1992-10-19	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/88.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
190	228	Kayle	Osborne	G	82	4	Canadian	2002-02-28	173	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/228.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
191	238	Sanni	Ahola	G	1	5	Finnish	2000-06-03	170	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/238.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
49	191	Katy	Knoll	F	6	2	United States	2001-01-16	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/191.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
51	259	Abby	Newhook	RW	19	1	Canada	2003-05-13	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/259.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
52	75	Sarah	Nurse	F	20	8	Canada	1995-01-04	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/75.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
53	252	Michelle	Karvinen	F	33	8	Denmark	1990-03-27	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/252.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
55	53	Emily	Clark	F	26	5	Canada	1995-11-28	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/53.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
200	\N	Hannah	Murphy	G	\N	\N	\N	\N	\N	\N	\N	t	https://assets.leaguestat.com/pwhl/120x160/250.jpg	2026-03-05 11:31:31.043202-05	2026-03-05 11:31:50.233576-05
201	\N	Corinne	Schroeder	G	\N	\N	\N	\N	\N	\N	\N	t	https://assets.leaguestat.com/pwhl/120x160/155.jpg	2026-03-05 11:31:31.043202-05	2026-03-05 11:31:50.233576-05
56	223	Ronja	Savolainen	D	88	5	Finland	1997-11-29	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/223.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
37	285	Maddi	Wheeler	F	18	10	Canada	2002-10-10	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/285.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
50	9	Taylor	Girard	F	17	10	United States	1998-07-17	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/9.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
178	41	Abbey	Levy	G	39	1	American	2000-04-02	185	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/41.jpg	2026-03-05 00:17:40.239914-05	2026-03-05 20:46:44.960728-05
179	6	Aerin	Frankel	G	31	1	American	1999-05-24	165	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/6.jpg	2026-03-05 00:17:40.239914-05	2026-03-05 20:46:44.960728-05
54	40	Paetyn	Levis	F	19	10	United States	1999-11-06	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/40.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
183	22	Nicole	Hensley	G	29	2	American	1994-06-23	170	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/22.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:45.920951-05
184	123	Maddie	Rooney	G	35	2	American	1997-07-07	165	\N	R	t	https://assets.leaguestat.com/pwhl/240x240/123.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
186	48	Sandra	Abstreiter	G	30	3	German	1998-07-23	180	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/48.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
192	222	Gwyneth	Philips	G	33	5	American	2000-09-17	170	\N	R	t	https://assets.leaguestat.com/pwhl/240x240/222.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
194	211	Raygan	Kirk	G	1	6	Canadian	2001-03-11	173	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/211.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
195	85	Elaine	Chuli	G	29	6	Canadian	1994-05-16	170	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/85.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
198	59	Emerance	Maschmeyer	G	38	8	Canadian	1994-10-05	168	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/59.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.25839-05
199	64	Kristen	Campbell	G	50	8	Canadian	1997-11-30	178	\N	L	t	https://assets.leaguestat.com/pwhl/240x240/64.jpg	2026-03-05 11:15:40.718822-05	2026-03-05 20:46:46.492591-05
208				G	0	\N		\N	\N	\N		t		2026-03-06 06:00:00.93433-05	\N
58	44	Ella	Shelton	D	17	6	Canada	1998-01-19	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/44.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
59	67	Renata	Fast	D	14	6	Canada	1994-10-06	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/67.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
60	115	Michela	Cava	F	86	5	Canada	1994-03-26	163	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/115.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
63	26	Claire	Dalton	F	42	6	Canada	2000-03-20	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/26.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
64	114	Abby	Boreen	F	22	8	United States	2000-04-03	173	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/114.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
66	256	Olivia	Mobley	RW	15	1	United States	2001-10-28	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/256.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
67	4	Shiann	Darkangelo	F	27	3	United States	1993-11-28	180	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/4.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
68	199	Dara	Greig	F	17	3	United States	2000-12-30	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/199.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
69	224	Danielle	Serdachny	F	92	7	Canada	2001-05-12	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/224.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
70	68	Kali	Flanagan	D	6	6	United States	1995-09-19	163	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/68.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
72	17	Theresa	Schafzahl	LW	17	1	Austria	2000-04-12	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/17.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
74	56	Savannah	Harmon	D	15	6	United States	1995-10-27	160	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/56.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
75	167	Sidney	Morin	D	5	2	United States	1995-06-06	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/167.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
76	286	Peyton	Hemp	F	29	5	United States	2003-05-15	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/286.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
77	71	Jocelyne	Larocque	D	3	5	Canada	1988-05-19	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/71.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
95	243	Ella	Huber	LW	26	1	United States	2002-12-18	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/243.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
79	208	Megan	Carter	D	27	7	Canada	2001-05-23	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/208.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
80	138	Mikyla	Grant-Mentis	F	13	7	Canada	1998-07-15	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/138.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
81	272	Skylar	Irving	F	88	3	United States	2002-01-21	173	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/272.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
78	149	Jill	Saulnier	LW	44	1	Canada	1992-03-07	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/149.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
82	239	Anna	Shokhina	F	97	8	Russia	1997-06-23	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/239.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
83	200	Anna	Kjellbin	D	71	6	Sweden	1994-03-16	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/200.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
84	83	Erin	Ambrose	D	23	3	Canada	1994-04-30	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/83.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
85	203	Anna	Wilgren	D	5	7	United States	1999-11-10	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/203.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
86	49	Lexie	Adzija	F	78	7	Canada	2000-06-30	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/49.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
87	201	Lina	Ljungblom	F	25	3	Sweden	2001-10-15	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/201.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
88	195	Dominique	Petrie	F	14	2	United States	2001-01-21	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/195.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
89	97	Liz	Schepers	C	13	1	United States	1999-02-13	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/97.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
90	183	Shay	Maloney	RW	27	1	United States	2000-01-13	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/183.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
92	221	Anna	Meixner	F	94	8	Austria	1994-06-16	160	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/221.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
93	66	Maggie	Connors	F	22	6	Canada	2000-10-22	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/66.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
94	62	Aneta	Tejralová	D	2	7	Czechia	1996-01-04	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/62.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
96	190	Klára	Hymlárová	F	71	2	Czechia	1999-02-27	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/190.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
97	50	Ashton	Bell	D	21	8	Canada	1999-12-07	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/50.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
98	38	Brooke	Hobson	D	11	5	Canada	1999-05-27	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/38.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
99	219	Stephanie	Markowski	D	6	5	Canada	2001-08-24	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/219.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
100	317	Kiara	Zanon	F	11	6	United States	2002-08-22	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/317.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
102	18	Sophie	Shirley	RW	9	1	Canada	1999-06-30	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/18.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
101	182	Hadley	Hartmetz	F	6	1	United States	2001-03-25	165	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/182.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
103	24	Lee	Stecklein	D	2	2	United States	1994-04-23	183	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/24.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
106	51	Amanda	Boulier	D	44	3	United States	1993-03-30	155	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/51.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
107	255	Riley	Brengman	F	16	1	United States	2002-07-06	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/255.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
108	313	Sara	Hjalmarsson	F	19	6	Sweden	1998-02-08	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/313.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
109	142	Natalie	Snodgrass	F	8	7	United States	1998-12-17	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/142.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
110	220	Mannon	McMahon	F	19	8	United States	2001-07-29	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/220.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
112	227	Gabby	Rosenthal	F	15	8	United States	1999-09-13	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/227.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
113	5	Jessica	DiGirolamo	D	22	3	Canada	1999-02-13	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/5.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
114	294	Lyndie	Lobdell	D	24	7	United States	2002-09-01	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/294.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
115	74	Allie	Munroe	D	12	6	Canada	1997-04-20	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/74.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
116	289	Kathryn	Reilly	D	8	5	Canada	2001-01-17	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/289.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
117	196	Cayla	Barnes	D	3	7	United States	1999-01-07	158	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/196.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
118	2	Emily	Brown	D	11	7	United States	1998-12-30	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/2.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
119	99	Mariah	Keopple	D	20	7	United States	2000-06-27	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/99.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
120	104	Denisa	Křížová	F	41	2	Czechia	1994-11-03	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/104.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
121	39	Alexandra	Labelle	F	13	3	Canada	1996-02-27	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/39.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
124	128	Kaitlin	Willoughby	F	19	3	Canada	1995-03-26	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/128.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
125	316	Clara	Van Wieren	F	25	6	United States	2002-01-25	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/316.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
127	273	Maya	Labad	F	4	3	Canada	2002-05-07	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/273.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
128	315	Lauren	Messier	F	16	6	Canada	2003-07-03	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/315.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
129	35	Jade	Downie-Landry	F	77	3	Canada	1995-10-03	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/35.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
130	301	Katie	Chan	F	9	8	Canada	2003-01-05	158	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/301.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
131	185	Daniela	Pejšová	F	55	1	Czechia	2002-08-14	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/185.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
132	244	Emma	Gentry	F	20	6	United States	2002-10-23	180	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/244.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
133	101	Alexa	Vasko	F	10	5	Canada	1999-02-07	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/101.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
134	305	Nina	Jobst-Smith	D	28	8	Canada	2001-08-30	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/305.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
135	108	Samantha	Isbell	D	55	5	Canada	1998-02-17	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/108.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
137	306	Darcie	Lappan	F	72	8	Canada	2001-09-15	170	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/306.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
138	232	Rylind	MacKinnon	F	53	1	Canada	2000-03-05	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/232.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
140	264	Brooke	Becker	D	15	2	United States	2002-05-30	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/264.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
139	212	Laura	Kluge	LW	25	1	Germany	1996-11-06	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/212.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
142	263	Peyton	Anderson	F	91	2	United States	2001-04-18	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/263.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
141	1	Hannah	Brandt	C	20	1	United States	1993-11-27	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/1.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
143	91	Brooke	Bryant	F	17	7	United States	2000-08-22	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/91.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
144	90	Natalie	Buchbinder	D	22	2	United States	1999-01-22	173	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/90.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
145	102	Claire	Butorac	F	7	2	United States	1999-09-24	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/102.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
147	180	Sydney	Bard	D	11	8	United States	2001-01-15	160	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/180.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
149	118	Emma	Greco	D	25	5	Canada	1995-03-06	175	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/118.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
150	192	Brooke	McQuigge	F	27	5	Canada	2000-06-09	173	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/192.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
151	86	Emma	Woods	F	67	6	Canada	1995-12-18	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/86.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
152	300	Brianna	Brooks	F	17	8	Canada	2002-06-28	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/300.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
154	37	Élizabeth	Giguère	F	18	2	Canada	1997-05-08	178	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/37.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
153	8	Loren	Gabel	LW	36	1	Canada	1997-07-24	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/8.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
155	293	Sydney	Langseth	F	71	7	United States	2002-01-29	\N	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/293.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
156	140	Malia	Schneider	F	18	8	Canada	1998-10-03	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/140.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
157	296	Olivia	Wallin	F	14	5	Canada	2002-03-09	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/296.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
158	46	Olivia	Zafuto	F	73	1	United States	1997-01-25	168	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/46.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
160	271	Tamara	Giaquinto	D	12	3	Canada	2002-03-29	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/271.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
161	194	Kaitlyn	O'Donohoe	F	16	2	United States	2001-09-20	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/194.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
162	254	Mia	Biotti	F	7	1	United States	2002-07-24	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/254.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
163	311	Hanna	Baskin	D	10	6	United States	2003-07-10	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/311.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
164	202	Kelly Ann	Nadeau	D	51	3	Canada	1998-03-30	170	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/202.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
167	132	Jessica	Kondas	D	2	6	Canada	2000-01-03	175	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/132.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
168	291	Lily	Delianedis	F	7	7	United States	2001-10-07	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/291.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
169	157	Catherine	Dubois	F	28	3	Canada	1995-07-29	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/157.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
170	237	Jenna	Buglioni	F	10	7	Canada	2002-03-13	160	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/237.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
171	295	Marah	Wagner	F	66	7	United States	2000-10-19	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/295.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
172	310	Madison	Samoskevich	F	7	8	United States	2002-11-15	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/310.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
173	248	Anna	Segedi	F	51	8	United States	2000-12-20	165	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/248.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
174	269	Vanessa	Upson	F	24	2	Canada	2003-11-18	\N	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/269.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
175	116	Clair	DeGeorge	F	8	6	United States	1999-06-07	180	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/116.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
176	129	Mellissa	Channell-Watkins	D	23	8	United States	1994-12-16	163	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/129.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
177	217	Taylor	House	F	22	5	United States	1998-09-29	178	\N	L	t	https://assets.leaguestat.com/pwhl/60x60/217.jpg	2026-03-05 00:17:39.625897-05	2026-03-06 06:00:00.476914-05
166	251	Dayle	Ross	D	2	10	Canada	2003-05-26	168	\N	R	t	https://assets.leaguestat.com/pwhl/60x60/251.jpg	2026-03-05 00:17:39.625897-05	2026-03-07 06:00:00.366356-05
\.


--
-- Data for Name: pwhl_teams; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.pwhl_teams (id, name, city, abbreviation, logo_url, primary_color, secondary_color, arena, created_at, updated_at) FROM stdin;
1	Boston Fleet	Boston	BOS	https://assets.leaguestat.com/pwhl/logos/1.png	#041E42	#B9975B	\N	2026-03-05 00:14:55.43759-05	2026-03-05 08:03:25.865248-05
2	Minnesota Frost	Minnesota	MIN	https://assets.leaguestat.com/pwhl/logos/2.jpg	#154734	#CFC493	\N	2026-03-05 00:14:55.43759-05	2026-03-05 08:03:25.865248-05
3	Montreal Victoire	Montreal	MTL	https://assets.leaguestat.com/pwhl/logos/3.png	#AF1E2D	#003DA5	\N	2026-03-05 00:14:55.43759-05	2026-03-05 08:03:25.865248-05
5	Ottawa Charge	Ottawa	OTT	https://assets.leaguestat.com/pwhl/logos/5.png	#DA1A32	#000000	\N	2026-03-05 00:14:55.43759-05	2026-03-05 08:03:25.865248-05
6	Toronto Sceptres	Toronto	TOR	https://assets.leaguestat.com/pwhl/logos/6.png	#00205B	#FFFFFF	\N	2026-03-05 00:14:55.43759-05	2026-03-05 08:03:25.865248-05
7	Seattle Torrent	Seattle	SEA	https://assets.leaguestat.com/pwhl/logos/8.png	#001D3E	#99D9D9	\N	2026-03-05 08:03:25.865248-05	\N
8	Vancouver Goldeneyes	Vancouver	VAN	https://assets.leaguestat.com/pwhl/logos/9.png	#00843D	#FFFFFF	\N	2026-03-05 08:03:25.865248-05	\N
4	New York Sirens	New York	NY	https://assets.leaguestat.com/pwhl/logos/4.png	#BE2BBB	#FFFFFF	\N	2026-03-05 00:14:55.43759-05	2026-03-05 09:22:08.340394-05
10	New York Sirens	New York	NYR	https://assets.leaguestat.com/pwhl/logos/4.png	#BE2BBB	#FFFFFF	\N	2026-03-07 06:00:00.356686-05	\N
\.


--
-- Data for Name: scoring_settings; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.scoring_settings (id, league_id, goal_pts, assist_pts, plus_minus_pts, pim_pts, shot_pts, hit_pts, block_pts, goalie_win_pts, goalie_save_pts, goals_against_pts, shutout_pts, goalie_loss_pts, created_at, updated_at) FROM stdin;
1	1	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-05 00:14:50.271497-05	\N
17	17	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.157574-05	\N
18	18	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.295063-05	\N
19	19	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.386319-05	\N
20	20	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.493075-05	\N
21	21	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.612623-05	\N
22	22	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.75089-05	\N
23	23	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:22:59.900004-05	\N
24	24	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.038423-05	\N
25	25	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.171028-05	\N
26	26	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.305721-05	\N
27	27	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.448045-05	\N
28	28	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.584013-05	\N
29	29	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.71014-05	\N
30	30	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.836232-05	\N
31	31	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:00.949847-05	\N
32	32	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:01.095697-05	\N
33	33	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:01.229375-05	\N
34	34	3	2	1	-0.5	0.3	0	0	5	0.2	-1	3	0	2026-03-07 02:23:01.341114-05	\N
\.


--
-- Data for Name: trade_items; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.trade_items (id, trade_id, player_id, from_team_id, to_team_id) FROM stdin;
\.


--
-- Data for Name: trades; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.trades (id, league_id, proposing_team_id, receiving_team_id, status, message, proposed_at, responded_at) FROM stdin;
\.


--
-- Data for Name: two_factor_setups; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.two_factor_setups (id, user_id, secret, is_confirmed, backup_codes, created_at) FROM stdin;
1	1	W7DS5VDPOFZ2HKNJLBGNYBZFG23LYUFL	f	\N	2026-03-05 00:17:49.802353-05
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.users (id, email, username, hashed_password, is_active, is_verified, two_factor_enabled, created_at, updated_at) FROM stdin;
1	test@pwhl.com	pwhl_fan	$2b$12$9qsCpUC8di1xL6WK8H2fLe534MpyJSZpH7KIRM7NPzNXLD3pCt5AK	t	f	f	2026-03-05 00:14:44.151016-05	\N
2	user2@pwhl.com	fan2	$2b$12$.Q.Uanb9Km5vjpcSCPmUUey6XO3C9v6pyeHDwBnRwoOm1Ajzcsoki	t	f	f	2026-03-05 00:18:02.053617-05	\N
3	ekzacharia@unsupervisedbias.com	ericzacharia	$2b$12$p9LI0PeFhTSqqb1XNOhA3ONX0uK0WXX7u/igpprs4AyGgFkj782zq	t	f	f	2026-03-05 08:16:59.715404-05	\N
\.


--
-- Data for Name: waivers; Type: TABLE DATA; Schema: public; Owner: eric
--

COPY public.waivers (id, league_id, fantasy_team_id, player_add_id, player_drop_id, status, priority, bid_amount, requested_at, processed_at) FROM stdin;
\.


--
-- Name: analytics_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.analytics_events_id_seq', 1122, true);


--
-- Name: device_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.device_profiles_id_seq', 1, true);


--
-- Name: draft_picks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.draft_picks_id_seq', 40, true);


--
-- Name: draft_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.draft_sessions_id_seq', 1, true);


--
-- Name: fantasy_rosters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.fantasy_rosters_id_seq', 5090, true);


--
-- Name: fantasy_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.fantasy_teams_id_seq', 392, true);


--
-- Name: game_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.game_events_id_seq', 1, false);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.games_id_seq', 350, true);


--
-- Name: league_invites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.league_invites_id_seq', 1, false);


--
-- Name: league_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.league_members_id_seq', 101, true);


--
-- Name: leagues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.leagues_id_seq', 34, true);


--
-- Name: news_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.news_articles_id_seq', 403, true);


--
-- Name: player_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.player_stats_id_seq', 756, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.players_id_seq', 208, true);


--
-- Name: pwhl_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.pwhl_teams_id_seq', 10, true);


--
-- Name: scoring_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.scoring_settings_id_seq', 34, true);


--
-- Name: trade_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.trade_items_id_seq', 2, true);


--
-- Name: trades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.trades_id_seq', 1, true);


--
-- Name: two_factor_setups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.two_factor_setups_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: waivers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eric
--

SELECT pg_catalog.setval('public.waivers_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: analytics_events analytics_events_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.analytics_events
    ADD CONSTRAINT analytics_events_pkey PRIMARY KEY (id);


--
-- Name: device_profiles device_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.device_profiles
    ADD CONSTRAINT device_profiles_pkey PRIMARY KEY (id);


--
-- Name: draft_picks draft_picks_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_picks
    ADD CONSTRAINT draft_picks_pkey PRIMARY KEY (id);


--
-- Name: draft_sessions draft_sessions_league_id_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_sessions
    ADD CONSTRAINT draft_sessions_league_id_key UNIQUE (league_id);


--
-- Name: draft_sessions draft_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_sessions
    ADD CONSTRAINT draft_sessions_pkey PRIMARY KEY (id);


--
-- Name: fantasy_rosters fantasy_rosters_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_rosters
    ADD CONSTRAINT fantasy_rosters_pkey PRIMARY KEY (id);


--
-- Name: fantasy_teams fantasy_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_teams
    ADD CONSTRAINT fantasy_teams_pkey PRIMARY KEY (id);


--
-- Name: game_events game_events_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: league_invites league_invites_invite_code_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_invites
    ADD CONSTRAINT league_invites_invite_code_key UNIQUE (invite_code);


--
-- Name: league_invites league_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_invites
    ADD CONSTRAINT league_invites_pkey PRIMARY KEY (id);


--
-- Name: league_members league_members_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_members
    ADD CONSTRAINT league_members_pkey PRIMARY KEY (id);


--
-- Name: leagues leagues_invite_code_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_invite_code_key UNIQUE (invite_code);


--
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_url_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_url_key UNIQUE (url);


--
-- Name: player_stats player_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: pwhl_teams pwhl_teams_abbreviation_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.pwhl_teams
    ADD CONSTRAINT pwhl_teams_abbreviation_key UNIQUE (abbreviation);


--
-- Name: pwhl_teams pwhl_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.pwhl_teams
    ADD CONSTRAINT pwhl_teams_pkey PRIMARY KEY (id);


--
-- Name: scoring_settings scoring_settings_league_id_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.scoring_settings
    ADD CONSTRAINT scoring_settings_league_id_key UNIQUE (league_id);


--
-- Name: scoring_settings scoring_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.scoring_settings
    ADD CONSTRAINT scoring_settings_pkey PRIMARY KEY (id);


--
-- Name: trade_items trade_items_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trade_items
    ADD CONSTRAINT trade_items_pkey PRIMARY KEY (id);


--
-- Name: trades trades_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_pkey PRIMARY KEY (id);


--
-- Name: two_factor_setups two_factor_setups_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.two_factor_setups
    ADD CONSTRAINT two_factor_setups_pkey PRIMARY KEY (id);


--
-- Name: two_factor_setups two_factor_setups_user_id_key; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.two_factor_setups
    ADD CONSTRAINT two_factor_setups_user_id_key UNIQUE (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: waivers waivers_pkey; Type: CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.waivers
    ADD CONSTRAINT waivers_pkey PRIMARY KEY (id);


--
-- Name: ix_analytics_events_created_at; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_analytics_events_created_at ON public.analytics_events USING btree (created_at);


--
-- Name: ix_analytics_events_event_type; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_analytics_events_event_type ON public.analytics_events USING btree (event_type);


--
-- Name: ix_analytics_events_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_analytics_events_id ON public.analytics_events USING btree (id);


--
-- Name: ix_analytics_events_session_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_analytics_events_session_id ON public.analytics_events USING btree (session_id);


--
-- Name: ix_analytics_events_user_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_analytics_events_user_id ON public.analytics_events USING btree (user_id);


--
-- Name: ix_device_profiles_device_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE UNIQUE INDEX ix_device_profiles_device_id ON public.device_profiles USING btree (device_id);


--
-- Name: ix_device_profiles_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_device_profiles_id ON public.device_profiles USING btree (id);


--
-- Name: ix_device_profiles_user_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_device_profiles_user_id ON public.device_profiles USING btree (user_id);


--
-- Name: ix_draft_picks_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_draft_picks_id ON public.draft_picks USING btree (id);


--
-- Name: ix_draft_picks_league_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_draft_picks_league_id ON public.draft_picks USING btree (league_id);


--
-- Name: ix_draft_sessions_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_draft_sessions_id ON public.draft_sessions USING btree (id);


--
-- Name: ix_fantasy_rosters_fantasy_team_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_fantasy_rosters_fantasy_team_id ON public.fantasy_rosters USING btree (fantasy_team_id);


--
-- Name: ix_fantasy_rosters_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_fantasy_rosters_id ON public.fantasy_rosters USING btree (id);


--
-- Name: ix_fantasy_rosters_player_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_fantasy_rosters_player_id ON public.fantasy_rosters USING btree (player_id);


--
-- Name: ix_fantasy_teams_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_fantasy_teams_id ON public.fantasy_teams USING btree (id);


--
-- Name: ix_game_events_game_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_game_events_game_id ON public.game_events USING btree (game_id);


--
-- Name: ix_game_events_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_game_events_id ON public.game_events USING btree (id);


--
-- Name: ix_games_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_games_id ON public.games USING btree (id);


--
-- Name: ix_games_pwhl_game_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE UNIQUE INDEX ix_games_pwhl_game_id ON public.games USING btree (pwhl_game_id);


--
-- Name: ix_league_invites_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_league_invites_id ON public.league_invites USING btree (id);


--
-- Name: ix_league_members_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_league_members_id ON public.league_members USING btree (id);


--
-- Name: ix_leagues_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_leagues_id ON public.leagues USING btree (id);


--
-- Name: ix_news_articles_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_news_articles_id ON public.news_articles USING btree (id);


--
-- Name: ix_player_stats_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_player_stats_id ON public.player_stats USING btree (id);


--
-- Name: ix_player_stats_player_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_player_stats_player_id ON public.player_stats USING btree (player_id);


--
-- Name: ix_players_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_players_id ON public.players USING btree (id);


--
-- Name: ix_players_pwhl_player_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE UNIQUE INDEX ix_players_pwhl_player_id ON public.players USING btree (pwhl_player_id);


--
-- Name: ix_pwhl_teams_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_pwhl_teams_id ON public.pwhl_teams USING btree (id);


--
-- Name: ix_scoring_settings_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_scoring_settings_id ON public.scoring_settings USING btree (id);


--
-- Name: ix_trade_items_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_trade_items_id ON public.trade_items USING btree (id);


--
-- Name: ix_trades_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_trades_id ON public.trades USING btree (id);


--
-- Name: ix_trades_league_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_trades_league_id ON public.trades USING btree (league_id);


--
-- Name: ix_two_factor_setups_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_two_factor_setups_id ON public.two_factor_setups USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: eric
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_username; Type: INDEX; Schema: public; Owner: eric
--

CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);


--
-- Name: ix_waivers_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_waivers_id ON public.waivers USING btree (id);


--
-- Name: ix_waivers_league_id; Type: INDEX; Schema: public; Owner: eric
--

CREATE INDEX ix_waivers_league_id ON public.waivers USING btree (league_id);


--
-- Name: draft_picks draft_picks_fantasy_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_picks
    ADD CONSTRAINT draft_picks_fantasy_team_id_fkey FOREIGN KEY (fantasy_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: draft_picks draft_picks_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_picks
    ADD CONSTRAINT draft_picks_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: draft_picks draft_picks_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_picks
    ADD CONSTRAINT draft_picks_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: draft_sessions draft_sessions_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.draft_sessions
    ADD CONSTRAINT draft_sessions_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: fantasy_rosters fantasy_rosters_fantasy_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_rosters
    ADD CONSTRAINT fantasy_rosters_fantasy_team_id_fkey FOREIGN KEY (fantasy_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: fantasy_rosters fantasy_rosters_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_rosters
    ADD CONSTRAINT fantasy_rosters_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: fantasy_teams fantasy_teams_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_teams
    ADD CONSTRAINT fantasy_teams_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: fantasy_teams fantasy_teams_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.fantasy_teams
    ADD CONSTRAINT fantasy_teams_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- Name: game_events game_events_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: game_events game_events_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: game_events game_events_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.pwhl_teams(id);


--
-- Name: games games_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.pwhl_teams(id);


--
-- Name: games games_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.pwhl_teams(id);


--
-- Name: league_invites league_invites_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_invites
    ADD CONSTRAINT league_invites_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: league_members league_members_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_members
    ADD CONSTRAINT league_members_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: league_members league_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.league_members
    ADD CONSTRAINT league_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: leagues leagues_commissioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_commissioner_id_fkey FOREIGN KEY (commissioner_id) REFERENCES public.users(id);


--
-- Name: player_stats player_stats_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: player_stats player_stats_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: players players_pwhl_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pwhl_team_id_fkey FOREIGN KEY (pwhl_team_id) REFERENCES public.pwhl_teams(id);


--
-- Name: scoring_settings scoring_settings_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.scoring_settings
    ADD CONSTRAINT scoring_settings_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: trade_items trade_items_from_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trade_items
    ADD CONSTRAINT trade_items_from_team_id_fkey FOREIGN KEY (from_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: trade_items trade_items_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trade_items
    ADD CONSTRAINT trade_items_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: trade_items trade_items_to_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trade_items
    ADD CONSTRAINT trade_items_to_team_id_fkey FOREIGN KEY (to_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: trade_items trade_items_trade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trade_items
    ADD CONSTRAINT trade_items_trade_id_fkey FOREIGN KEY (trade_id) REFERENCES public.trades(id);


--
-- Name: trades trades_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: trades trades_proposing_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_proposing_team_id_fkey FOREIGN KEY (proposing_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: trades trades_receiving_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_receiving_team_id_fkey FOREIGN KEY (receiving_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: two_factor_setups two_factor_setups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.two_factor_setups
    ADD CONSTRAINT two_factor_setups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: waivers waivers_fantasy_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.waivers
    ADD CONSTRAINT waivers_fantasy_team_id_fkey FOREIGN KEY (fantasy_team_id) REFERENCES public.fantasy_teams(id);


--
-- Name: waivers waivers_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.waivers
    ADD CONSTRAINT waivers_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: waivers waivers_player_add_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.waivers
    ADD CONSTRAINT waivers_player_add_id_fkey FOREIGN KEY (player_add_id) REFERENCES public.players(id);


--
-- Name: waivers waivers_player_drop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: eric
--

ALTER TABLE ONLY public.waivers
    ADD CONSTRAINT waivers_player_drop_id_fkey FOREIGN KEY (player_drop_id) REFERENCES public.players(id);


--
-- PostgreSQL database dump complete
--

