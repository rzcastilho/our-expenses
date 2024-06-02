--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 16.1

-- Started on 2024-06-01 21:01:17 -03

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
-- TOC entry 3353 (class 0 OID 16955)
-- Dependencies: 214
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bills VALUES (1, 'Maio / Junho', '2024-05-20', '2024-06-20', '2024-05-24 01:30:16', '2024-05-25 23:24:16');


--
-- TOC entry 3355 (class 0 OID 16959)
-- Dependencies: 216
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (1, 'Transporte', 'Combustível / Vale Transporte', '2024-05-24 00:56:44', '2024-05-24 01:15:06', 800);
INSERT INTO public.categories VALUES (7, 'Vestuário', 'Roupas / Sapatos / Tênnis', '2024-05-28 00:47:35', '2024-05-28 00:47:35', 400);
INSERT INTO public.categories VALUES (4, 'Beleza', 'Barba / Cabelo / Unha', '2024-05-24 01:17:14', '2024-05-28 01:09:47', 400);
INSERT INTO public.categories VALUES (3, 'Saúde', 'Remédios / Consultas / Exames', '2024-05-24 00:57:47', '2024-05-28 01:10:45', 800);
INSERT INTO public.categories VALUES (2, 'Mercado / Alimentação', 'Compras / Fast Food', '2024-05-24 00:57:16', '2024-05-28 01:11:33', 2000);
INSERT INTO public.categories VALUES (5, 'Assinaturas', 'iCloud / Spotify / Github', '2024-05-25 23:34:03', '2024-05-28 01:11:43', 100);
INSERT INTO public.categories VALUES (6, 'Impostos', 'IOF', '2024-05-27 00:07:14', '2024-05-28 01:42:58', 10);
INSERT INTO public.categories VALUES (8, 'Educação', 'Cursos', '2024-05-29 10:16:09', '2024-05-29 10:16:09', 400);


--
-- TOC entry 3359 (class 0 OID 16970)
-- Dependencies: 220
-- Data for Name: owners; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.owners VALUES (1, 'Rodrigo', '2024-05-24 00:58:05', '2024-05-24 00:58:05');
INSERT INTO public.owners VALUES (2, 'Maísa', '2024-05-24 00:58:10', '2024-05-24 00:58:10');


--
-- TOC entry 3357 (class 0 OID 16965)
-- Dependencies: 218
-- Data for Name: entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.entries VALUES (3, 'Zona Azul', '2024-05-20', 12.72, 1, 1, false, 1, 1, '2024-05-25 23:25:42', '2024-05-25 23:25:42', 1);
INSERT INTO public.entries VALUES (5, 'Mini Extra', '2024-05-21', 85.71, 1, 1, false, 1, 2, '2024-05-25 23:28:30', '2024-05-25 23:28:30', 1);
INSERT INTO public.entries VALUES (4, 'Drogaria São Paulo', '2024-05-21', 66.76, 1, 1, false, 1, 3, '2024-05-25 23:27:37', '2024-05-25 23:28:52', 1);
INSERT INTO public.entries VALUES (6, 'Mini Extra', '2024-05-21', 96.16, 1, 1, false, 1, 2, '2024-05-25 23:29:37', '2024-05-25 23:29:37', 1);
INSERT INTO public.entries VALUES (7, 'Pizza', '2024-05-21', 142, 1, 1, false, 1, 2, '2024-05-25 23:30:12', '2024-05-25 23:30:12', 1);
INSERT INTO public.entries VALUES (8, 'Combustível', '2024-05-22', 157.36, 1, 1, false, 1, 1, '2024-05-25 23:31:22', '2024-05-25 23:31:22', 1);
INSERT INTO public.entries VALUES (9, 'Mini Extra', '2024-05-23', 118.79, 1, 1, false, 1, 2, '2024-05-25 23:32:39', '2024-05-25 23:32:39', 1);
INSERT INTO public.entries VALUES (10, 'iCloud', '2024-05-23', 14.9, 1, 1, true, 1, 5, '2024-05-25 23:35:56', '2024-05-25 23:35:56', 1);
INSERT INTO public.entries VALUES (11, 'Github', '2024-05-22', 21.8, 1, 1, true, 1, 5, '2024-05-25 23:36:43', '2024-05-25 23:36:43', 1);
INSERT INTO public.entries VALUES (12, 'Promofarma', '2024-05-24', 69.99, 1, 1, false, 1, 3, '2024-05-27 00:04:35', '2024-05-27 00:04:35', 1);
INSERT INTO public.entries VALUES (13, 'Trimais', '2024-05-24', 74.96, 1, 1, false, 1, 2, '2024-05-27 00:05:25', '2024-05-27 00:05:25', 1);
INSERT INTO public.entries VALUES (14, 'The Mad House', '2024-05-25', 160, 1, 1, false, 1, 4, '2024-05-27 00:06:34', '2024-05-27 00:06:34', 1);
INSERT INTO public.entries VALUES (15, 'IOF', '2024-05-23', 0.98, 1, 1, false, 1, 6, '2024-05-27 00:08:09', '2024-05-27 00:08:09', 1);
INSERT INTO public.entries VALUES (16, 'Amazon Prime', '2024-05-23', 19.9, 1, 1, true, 1, 5, '2024-05-27 00:09:42', '2024-05-27 00:09:42', 1);
INSERT INTO public.entries VALUES (17, 'Estacionamento', '2024-05-25', 25, 1, 1, false, 2, 1, '2024-05-27 00:13:55', '2024-05-27 00:13:55', 1);
INSERT INTO public.entries VALUES (18, 'Depilação', '2024-05-25', 49, 1, 1, false, 2, 4, '2024-05-27 00:14:37', '2024-05-27 00:14:37', 1);
INSERT INTO public.entries VALUES (19, 'Drogaria São Paulo', '2024-05-25', 284.03, 2, 1, false, 2, 3, '2024-05-27 00:16:16', '2024-05-27 00:16:16', 1);
INSERT INTO public.entries VALUES (20, 'Ortopé', '2024-05-24', 120.85, 1, 1, false, 2, 7, '2024-05-28 00:48:31', '2024-05-28 00:48:31', 1);
INSERT INTO public.entries VALUES (21, 'Mercado Livre', '2024-05-24', 199.07, 1, 1, false, 2, 7, '2024-05-28 00:49:07', '2024-05-28 00:49:07', 1);
INSERT INTO public.entries VALUES (22, 'Mercado Livre', '2024-05-24', 171.02, 1, 1, false, 2, 7, '2024-05-28 00:49:54', '2024-05-28 00:49:54', 1);
INSERT INTO public.entries VALUES (23, 'Shopee', '2024-05-24', 22.03, 1, 1, false, 2, 7, '2024-05-28 00:51:11', '2024-05-28 00:51:11', 1);
INSERT INTO public.entries VALUES (24, 'Carrefour', '2024-05-23', 4.48, 1, 1, false, 2, 2, '2024-05-28 00:53:06', '2024-05-28 00:53:06', 1);
INSERT INTO public.entries VALUES (25, 'Padaria', '2024-05-23', 72.3, 1, 1, false, 2, 2, '2024-05-28 00:54:31', '2024-05-28 00:54:31', 1);
INSERT INTO public.entries VALUES (26, 'Nutricar', '2024-05-22', 23.98, 1, 1, false, 2, 2, '2024-05-28 00:57:12', '2024-05-28 00:57:12', 1);
INSERT INTO public.entries VALUES (27, 'Bellafoods', '2024-05-22', 17.9, 1, 1, false, 2, 2, '2024-05-28 00:58:09', '2024-05-28 00:58:09', 1);
INSERT INTO public.entries VALUES (28, 'Coffee', '2024-05-21', 15.5, 1, 1, false, 2, 2, '2024-05-28 00:59:19', '2024-05-28 00:59:19', 1);
INSERT INTO public.entries VALUES (29, 'Boticário', '2024-05-21', 59.9, 1, 1, false, 2, 3, '2024-05-28 00:59:58', '2024-05-28 00:59:58', 1);
INSERT INTO public.entries VALUES (30, 'Trimais', '2024-05-26', 440.68, 1, 1, false, 1, 2, '2024-05-29 10:13:42', '2024-05-29 10:13:42', 1);
INSERT INTO public.entries VALUES (31, 'Padaria', '2024-05-26', 50.88, 1, 1, false, 1, 2, '2024-05-29 10:14:20', '2024-05-29 10:14:20', 1);
INSERT INTO public.entries VALUES (32, 'SESC', '2024-05-26', 10, 1, 1, false, 1, 2, '2024-05-29 10:15:15', '2024-05-29 10:15:15', 1);
INSERT INTO public.entries VALUES (33, 'Estácio', '2024-05-27', 150.79, 6, 1, false, 2, 8, '2024-05-29 10:16:56', '2024-05-29 10:16:56', 1);
INSERT INTO public.entries VALUES (34, 'Combustível', '2024-05-29', 80.24, 1, 1, false, 1, 1, '2024-05-29 11:34:49', '2024-05-29 11:34:49', 1);
INSERT INTO public.entries VALUES (35, 'Top', '2024-05-28', 1, 1, 1, false, 2, 1, '2024-05-29 11:35:21', '2024-05-29 11:35:21', 1);
INSERT INTO public.entries VALUES (36, 'Almoço Porto Bar', '2024-05-28', 49.49, 1, 1, false, 2, 2, '2024-05-29 11:36:12', '2024-05-29 11:36:12', 1);
INSERT INTO public.entries VALUES (37, 'Boticário', '2024-05-28', 47.4, 1, 1, false, 2, 4, '2024-05-29 11:36:47', '2024-05-29 11:36:47', 1);
INSERT INTO public.entries VALUES (38, 'Exame AC Camargo', '2024-06-18', 236.13, 6, 4, false, 1, 3, '2024-05-29 11:39:05', '2024-05-29 11:39:05', 1);
INSERT INTO public.entries VALUES (39, 'Tera', '2024-06-02', 237.49, 12, 4, false, 2, 8, '2024-05-29 11:39:50', '2024-05-29 11:39:50', 1);


--
-- TOC entry 3361 (class 0 OID 16974)
-- Dependencies: 222
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.schema_migrations VALUES (20240524003555, '2024-05-24 00:37:31');
INSERT INTO public.schema_migrations VALUES (20240524004231, '2024-05-24 00:55:54');
INSERT INTO public.schema_migrations VALUES (20240524005435, '2024-05-24 00:55:54');
INSERT INTO public.schema_migrations VALUES (20240524010450, '2024-05-24 01:06:59');
INSERT INTO public.schema_migrations VALUES (20240524012102, '2024-05-24 01:22:12');
INSERT INTO public.schema_migrations VALUES (20240524012355, '2024-05-24 01:24:50');


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 215
-- Name: bills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bills_id_seq', 1, true);


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 217
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 219
-- Name: entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entries_id_seq', 39, true);


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 221
-- Name: owners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.owners_id_seq', 2, true);


-- Completed on 2024-06-01 21:01:17 -03

--
-- PostgreSQL database dump complete
--

