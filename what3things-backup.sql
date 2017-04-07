--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: quotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE quotes (
    id integer NOT NULL,
    body character varying(255)
);


ALTER TABLE quotes OWNER TO postgres;

--
-- Name: quotes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quotes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE quotes_id_seq OWNER TO postgres;

--
-- Name: quotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quotes_id_seq OWNED BY quotes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE services (
    id integer NOT NULL,
    title character varying(255),
    body character varying(255),
    cta character varying(255),
    url character varying(255)
);


ALTER TABLE services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- Name: weights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE weights (
    id integer NOT NULL,
    weight double precision,
    quote_id integer,
    service_id integer
);


ALTER TABLE weights OWNER TO postgres;

--
-- Name: weights_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE weights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weights_id_seq OWNER TO postgres;

--
-- Name: weights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE weights_id_seq OWNED BY weights.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotes ALTER COLUMN id SET DEFAULT nextval('quotes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weights ALTER COLUMN id SET DEFAULT nextval('weights_id_seq'::regclass);


--
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY quotes (id, body) FROM stdin;
48	I’d feel most comfortable if support staff came to see me at home.
49	I’ll just wait and see what information and support I’m offered.
50	I want to say what I feel without anyone knowing who I am, but know that someone will still be there listening and supporting me.
51	I want to find somewhere local where I can meet other people with Parkinson’s and share my experiences.
52	I don’t want to wait for someone to help me, I want to go out and help myself.
53	There’s something specific I want to know about Parkinson’s and how it’s going to affect me.
54	I want to have a private one-to-one quite soon to talk things through
55	I’m happy chatting on forums and social media.
56	I want to understand my condition so I can plan for the long term.
\.


--
-- Name: quotes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quotes_id_seq', 56, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version, inserted_at) FROM stdin;
20170404093930	2017-04-05 09:39:17.924289
20170404105423	2017-04-05 09:39:17.965556
20170405101906	2017-04-05 11:04:00.625204
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY services (id, title, body, cta, url) FROM stdin;
56	Contact a local advisor	Your Parkinson's local advisor will have a wide range of knowledge and expertise about Parkinson's, and know about services available in your area. They are there to turn to, so no-one has to face Parkinson's alone.	Contact your local advisor	www.Parkinson'sLocalAdvisor.com
53	Meet your local group	Local groups provide a chance to talk and discuss worries and experiences - or may include a presentation by and invited speaker. Many groups hold social events and activites too.	Find your local group	www.Groups.com
60	Tailored information for newly diagnosed	Every year 10,000 people get told they have Parkinson's disease. Initially, there are lots of common questions that all those people share. You are not alone.	See what else everyone's asking	www.Newlydiagnosedlandingpage.com
54	See a Parkinson's Nurse	Parkinson's nurses have specialist experience, knowledge and skills in Parkinson's, and play a vital role in giving expert care to people with Parkinson's	Find your nearest Parkinson's nurse	www.Parkinson'sNurse.com
51	Speak one-to-one with a peer	Our free peer support service puts you in touch with a trained volunteer who has a similar experience of Parkinson's to you - someone who understands. The service is for people with Parkinson's and carers.	Call 0800 800 0303 and ask for out peer support service	www.PeerSupportService.com
62	Start an information reading list	We have 100s of publications, leaflets and papers on everything to do with Parkinson's; from Anxiety and Attendance Allowance to using computers and working tax credit.	Check out our publications	www.Publications.com
55	Self-management programme	lorem ipsum	lorem	www.Self-managementprogramme.com
57	First Steps	lorem ipsum	lorem	www.FirstSteps.com
61	Early onset web page	lorem ipsum	lorem	www.Earlyonsetwebpage.com
59	Join our Facebook community	Share your experiences and ask questions with other supporters. Our team regularly posts the latest news and events from across the Parkinson's UK community.	Join our Facebook community	www.Facebook.com
52	Chat online in our forum	Our forum community is for those affected by Parkinson's; including people with Parkinson's, carers, friends and family members. Community members share information, experiences... and sometimes a virtual cup of tea.	Read the posts for newly diagnosed	www.Forum.com
58	Call our confidential helpline	Our trained advisers, including specialist Parkinson's nurses, can provide confidentail information, advice and support about all aspects of living with Parkinson's.	Prefer to message? Check out our webchat	www.Helpline.com
\.


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('services_id_seq', 62, true);


--
-- Data for Name: weights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY weights (id, weight, quote_id, service_id) FROM stdin;
109	0	48	51
110	0	48	52
111	0	48	53
112	0.5	48	54
113	0	48	55
114	1	48	56
115	0	48	57
116	0	48	58
117	0	48	59
118	0	48	60
119	0	48	61
120	0	48	62
121	0	49	51
122	0	49	52
123	0	49	53
124	1	49	54
125	0.25	49	55
126	0	49	56
127	0.5	49	57
128	0	49	58
129	0	49	59
130	0.25	49	60
131	0	49	61
132	0	49	62
133	0.5	50	51
134	1	50	52
135	0	50	53
136	0	50	54
137	0	50	55
138	0	50	56
139	0	50	57
140	0.5	50	58
141	0.25	50	59
142	0	50	60
143	0	50	61
144	0	50	62
145	0	51	51
146	0	51	52
147	1	51	53
148	0	51	54
149	0.25	51	55
150	0	51	56
151	0.5	51	57
152	0	51	58
153	0	51	59
154	0	51	60
155	0	51	61
156	0	51	62
157	0	52	51
158	0	52	52
159	0.25	52	53
160	0	52	54
161	0	52	55
162	0	52	56
163	0	52	57
164	0	52	58
165	0.25	52	59
166	1	52	60
167	0.5	52	61
168	0.5	52	62
169	0.5	53	51
170	0	53	52
171	0	53	53
172	0.5	53	54
173	0	53	55
174	0.5	53	56
175	0	53	57
176	0.5	53	58
177	0	53	59
178	0.25	53	60
179	0	53	61
180	1	53	62
181	0.25	54	51
182	0	54	52
183	0	54	53
184	0.25	54	54
185	0	54	55
186	0.5	54	56
187	0	54	57
188	1	54	58
189	0	54	59
190	0	54	60
191	0	54	61
192	0	54	62
193	0	55	51
194	0.75	55	52
195	0	55	53
196	0	55	54
197	0	55	55
198	0	55	56
199	0	55	57
200	0	55	58
201	1	55	59
202	0	55	60
203	0	55	61
204	0	55	62
205	0	56	51
206	0	56	52
207	0	56	53
208	0.25	56	54
209	0.5	56	55
210	0.5	56	56
211	0	56	57
212	0	56	58
213	0	56	59
214	0.25	56	60
215	0.25	56	61
216	0.5	56	62
\.


--
-- Name: weights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('weights_id_seq', 216, true);


--
-- Name: quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: weights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weights
    ADD CONSTRAINT weights_pkey PRIMARY KEY (id);


--
-- Name: weights_quote_id_service_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX weights_quote_id_service_id_index ON weights USING btree (quote_id, service_id);


--
-- Name: weights_quote_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weights
    ADD CONSTRAINT weights_quote_id_fkey FOREIGN KEY (quote_id) REFERENCES quotes(id);


--
-- Name: weights_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weights
    ADD CONSTRAINT weights_service_id_fkey FOREIGN KEY (service_id) REFERENCES services(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

