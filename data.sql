PGDMP                          y            webgisB    13.1    13.1 -    E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            H           1262    57344    webgisB    DATABASE     j   CREATE DATABASE "webgisB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Vietnamese_Vietnam.1252';
    DROP DATABASE "webgisB";
                postgres    false                        3079    57345    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            I           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2            �            1259    58356 
   db_danhmuc    TABLE     f   CREATE TABLE public.db_danhmuc (
    id_dm bigint NOT NULL,
    ten_dm text,
    trang_thai bit(1)
);
    DROP TABLE public.db_danhmuc;
       public         heap    postgres    false            �            1259    58354    db_danhmuc_id_dm_seq    SEQUENCE     �   ALTER TABLE public.db_danhmuc ALTER COLUMN id_dm ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_danhmuc_id_dm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207            �            1259    58370    db_sach    TABLE     �   CREATE TABLE public.db_sach (
    id_sach bigint NOT NULL,
    ten_sach text,
    id_tacgia bigint,
    gia_sach bigint,
    soluong bigint,
    "soSao" bigint,
    mota text,
    "trangThai" text,
    id_dm bigint
);
    DROP TABLE public.db_sach;
       public         heap    postgres    false            �            1259    58364    db_sach_id_sach_seq    SEQUENCE     �   ALTER TABLE public.db_sach ALTER COLUMN id_sach ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_sach_id_sach_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    58368    db_sach_soSao_seq    SEQUENCE     |   CREATE SEQUENCE public."db_sach_soSao_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."db_sach_soSao_seq";
       public          postgres    false    211            J           0    0    db_sach_soSao_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."db_sach_soSao_seq" OWNED BY public.db_sach."soSao";
          public          postgres    false    210            �            1259    58366    db_sach_soluong_seq    SEQUENCE     |   CREATE SEQUENCE public.db_sach_soluong_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.db_sach_soluong_seq;
       public          postgres    false    211            K           0    0    db_sach_soluong_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.db_sach_soluong_seq OWNED BY public.db_sach.soluong;
          public          postgres    false    209            �            1259    58402    db_slide    TABLE     �   CREATE TABLE public.db_slide (
    id_slide bigint NOT NULL,
    ten_slide text,
    id_dm bigint,
    mota text,
    img_slide text
);
    DROP TABLE public.db_slide;
       public         heap    postgres    false            �            1259    58400    db_slide_id_slide_seq    SEQUENCE     �   ALTER TABLE public.db_slide ALTER COLUMN id_slide ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_slide_id_slide_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    58412    db_user    TABLE     u   CREATE TABLE public.db_user (
    id_user bigint NOT NULL,
    us text,
    email text,
    sdt text,
    pa text
);
    DROP TABLE public.db_user;
       public         heap    postgres    false            �            1259    58410    db_user_id_user_seq    SEQUENCE     �   ALTER TABLE public.db_user ALTER COLUMN id_user ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_user_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    58392    img_sach    TABLE     v   CREATE TABLE public.img_sach (
    id_img bigint NOT NULL,
    ten_img text,
    link_img text,
    id_sach bigint
);
    DROP TABLE public.img_sach;
       public         heap    postgres    false            �            1259    58390    img_sach_id_img_seq    SEQUENCE     �   ALTER TABLE public.img_sach ALTER COLUMN id_img ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.img_sach_id_img_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    58382    tac_gia    TABLE     �   CREATE TABLE public.tac_gia (
    id_tacgia bigint NOT NULL,
    ten_tacgia text,
    career text,
    "moTa" text,
    avt_tacgia text,
    fb_tacgia text,
    " twitter_tacgia" text,
    gmail_tacgia text,
    ig_tacgia text
);
    DROP TABLE public.tac_gia;
       public         heap    postgres    false            �            1259    58380    tac_gia_id_tacgia_seq    SEQUENCE     �   ALTER TABLE public.tac_gia ALTER COLUMN id_tacgia ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tac_gia_id_tacgia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            �           2604    58373    db_sach soluong    DEFAULT     r   ALTER TABLE ONLY public.db_sach ALTER COLUMN soluong SET DEFAULT nextval('public.db_sach_soluong_seq'::regclass);
 >   ALTER TABLE public.db_sach ALTER COLUMN soluong DROP DEFAULT;
       public          postgres    false    209    211    211            �           2604    58374    db_sach soSao    DEFAULT     r   ALTER TABLE ONLY public.db_sach ALTER COLUMN "soSao" SET DEFAULT nextval('public."db_sach_soSao_seq"'::regclass);
 >   ALTER TABLE public.db_sach ALTER COLUMN "soSao" DROP DEFAULT;
       public          postgres    false    211    210    211            6          0    58356 
   db_danhmuc 
   TABLE DATA           ?   COPY public.db_danhmuc (id_dm, ten_dm, trang_thai) FROM stdin;
    public          postgres    false    207   �/       :          0    58370    db_sach 
   TABLE DATA           u   COPY public.db_sach (id_sach, ten_sach, id_tacgia, gia_sach, soluong, "soSao", mota, "trangThai", id_dm) FROM stdin;
    public          postgres    false    211   20       @          0    58402    db_slide 
   TABLE DATA           O   COPY public.db_slide (id_slide, ten_slide, id_dm, mota, img_slide) FROM stdin;
    public          postgres    false    217   O0       B          0    58412    db_user 
   TABLE DATA           >   COPY public.db_user (id_user, us, email, sdt, pa) FROM stdin;
    public          postgres    false    219   l0       >          0    58392    img_sach 
   TABLE DATA           F   COPY public.img_sach (id_img, ten_img, link_img, id_sach) FROM stdin;
    public          postgres    false    215   �0       �          0    57650    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    202   �0       <          0    58382    tac_gia 
   TABLE DATA           �   COPY public.tac_gia (id_tacgia, ten_tacgia, career, "moTa", avt_tacgia, fb_tacgia, " twitter_tacgia", gmail_tacgia, ig_tacgia) FROM stdin;
    public          postgres    false    213   �0       L           0    0    db_danhmuc_id_dm_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_danhmuc_id_dm_seq', 5, true);
          public          postgres    false    206            M           0    0    db_sach_id_sach_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_sach_id_sach_seq', 1, false);
          public          postgres    false    208            N           0    0    db_sach_soSao_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."db_sach_soSao_seq"', 1, false);
          public          postgres    false    210            O           0    0    db_sach_soluong_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_sach_soluong_seq', 1, false);
          public          postgres    false    209            P           0    0    db_slide_id_slide_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.db_slide_id_slide_seq', 1, false);
          public          postgres    false    216            Q           0    0    db_user_id_user_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_user_id_user_seq', 1, false);
          public          postgres    false    218            R           0    0    img_sach_id_img_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.img_sach_id_img_seq', 1, false);
          public          postgres    false    214            S           0    0    tac_gia_id_tacgia_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tac_gia_id_tacgia_seq', 1, false);
          public          postgres    false    212            �           2606    58363    db_danhmuc db_danhmuc_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.db_danhmuc
    ADD CONSTRAINT db_danhmuc_pkey PRIMARY KEY (id_dm);
 D   ALTER TABLE ONLY public.db_danhmuc DROP CONSTRAINT db_danhmuc_pkey;
       public            postgres    false    207            �           2606    58379    db_sach db_sach_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.db_sach
    ADD CONSTRAINT db_sach_pkey PRIMARY KEY (id_sach);
 >   ALTER TABLE ONLY public.db_sach DROP CONSTRAINT db_sach_pkey;
       public            postgres    false    211            �           2606    58409    db_slide db_slide_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.db_slide
    ADD CONSTRAINT db_slide_pkey PRIMARY KEY (id_slide);
 @   ALTER TABLE ONLY public.db_slide DROP CONSTRAINT db_slide_pkey;
       public            postgres    false    217            �           2606    58419    db_user db_user_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.db_user
    ADD CONSTRAINT db_user_pkey PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public.db_user DROP CONSTRAINT db_user_pkey;
       public            postgres    false    219            �           2606    58399    img_sach img_sach_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.img_sach
    ADD CONSTRAINT img_sach_pkey PRIMARY KEY (id_img);
 @   ALTER TABLE ONLY public.img_sach DROP CONSTRAINT img_sach_pkey;
       public            postgres    false    215            �           2606    58389    tac_gia tac_gia_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tac_gia
    ADD CONSTRAINT tac_gia_pkey PRIMARY KEY (id_tacgia);
 >   ALTER TABLE ONLY public.tac_gia DROP CONSTRAINT tac_gia_pkey;
       public            postgres    false    213            6   +   x�3�,��LI5�4�2�,NL� 2�!b&@�	L�!���� ��3      :      x������ � �      @      x������ � �      B      x������ � �      >      x������ � �      �      x������ � �      <      x������ � �     