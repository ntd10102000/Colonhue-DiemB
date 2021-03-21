PGDMP     ;    7                y            colonhue_diemb    13.2    13.2 -    R           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            S           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            T           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            U           1262    34865    colonhue_diemb    DATABASE     r   CREATE DATABASE colonhue_diemb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE colonhue_diemb;
                postgres    false                        3079    34866    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            V           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2            �            1259    35881 
   db_danhmuc    TABLE     f   CREATE TABLE public.db_danhmuc (
    id_dm bigint NOT NULL,
    ten_dm text,
    trang_thai bit(1)
);
    DROP TABLE public.db_danhmuc;
       public         heap    postgres    false            �            1259    35887    db_danhmuc_id_dm_seq    SEQUENCE     �   ALTER TABLE public.db_danhmuc ALTER COLUMN id_dm ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_danhmuc_id_dm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    206            �            1259    35889    db_sach    TABLE     �   CREATE TABLE public.db_sach (
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
       public         heap    postgres    false            �            1259    35895    db_sach_id_sach_seq    SEQUENCE     �   ALTER TABLE public.db_sach ALTER COLUMN id_sach ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_sach_id_sach_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    208            �            1259    35897    db_sach_soSao_seq    SEQUENCE     |   CREATE SEQUENCE public."db_sach_soSao_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."db_sach_soSao_seq";
       public          postgres    false    208            W           0    0    db_sach_soSao_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."db_sach_soSao_seq" OWNED BY public.db_sach."soSao";
          public          postgres    false    210            �            1259    35899    db_sach_soluong_seq    SEQUENCE     |   CREATE SEQUENCE public.db_sach_soluong_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.db_sach_soluong_seq;
       public          postgres    false    208            X           0    0    db_sach_soluong_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.db_sach_soluong_seq OWNED BY public.db_sach.soluong;
          public          postgres    false    211            �            1259    35901    db_slide    TABLE     �   CREATE TABLE public.db_slide (
    id_slide bigint NOT NULL,
    ten_slide text,
    id_dm bigint,
    mota text,
    img_slide text
);
    DROP TABLE public.db_slide;
       public         heap    postgres    false            �            1259    35907    db_slide_id_slide_seq    SEQUENCE     �   ALTER TABLE public.db_slide ALTER COLUMN id_slide ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_slide_id_slide_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            �            1259    35925 	   db_tacgia    TABLE     �   CREATE TABLE public.db_tacgia (
    id_tacgia bigint NOT NULL,
    ten_tacgia text,
    avt_tacgia text,
    gioi_thieu text NOT NULL
);
    DROP TABLE public.db_tacgia;
       public         heap    postgres    false            �            1259    35909    db_user    TABLE     u   CREATE TABLE public.db_user (
    id_user bigint NOT NULL,
    us text,
    email text,
    sdt text,
    pa text
);
    DROP TABLE public.db_user;
       public         heap    postgres    false            �            1259    35915    db_user_id_user_seq    SEQUENCE     �   ALTER TABLE public.db_user ALTER COLUMN id_user ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_user_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            �            1259    35917    img_sach    TABLE     v   CREATE TABLE public.img_sach (
    id_img bigint NOT NULL,
    ten_img text,
    link_img text,
    id_sach bigint
);
    DROP TABLE public.img_sach;
       public         heap    postgres    false            �            1259    35923    img_sach_id_img_seq    SEQUENCE     �   ALTER TABLE public.img_sach ALTER COLUMN id_img ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.img_sach_id_img_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    35931    tac_gia_id_tacgia_seq    SEQUENCE     �   ALTER TABLE public.db_tacgia ALTER COLUMN id_tacgia ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tac_gia_id_tacgia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �           2604    35933    db_sach soluong    DEFAULT     r   ALTER TABLE ONLY public.db_sach ALTER COLUMN soluong SET DEFAULT nextval('public.db_sach_soluong_seq'::regclass);
 >   ALTER TABLE public.db_sach ALTER COLUMN soluong DROP DEFAULT;
       public          postgres    false    211    208            �           2604    35934    db_sach soSao    DEFAULT     r   ALTER TABLE ONLY public.db_sach ALTER COLUMN "soSao" SET DEFAULT nextval('public."db_sach_soSao_seq"'::regclass);
 >   ALTER TABLE public.db_sach ALTER COLUMN "soSao" DROP DEFAULT;
       public          postgres    false    210    208            B          0    35881 
   db_danhmuc 
   TABLE DATA           ?   COPY public.db_danhmuc (id_dm, ten_dm, trang_thai) FROM stdin;
    public          postgres    false    206   x/       D          0    35889    db_sach 
   TABLE DATA           u   COPY public.db_sach (id_sach, ten_sach, id_tacgia, gia_sach, soluong, "soSao", mota, "trangThai", id_dm) FROM stdin;
    public          postgres    false    208   �/       H          0    35901    db_slide 
   TABLE DATA           O   COPY public.db_slide (id_slide, ten_slide, id_dm, mota, img_slide) FROM stdin;
    public          postgres    false    212   �/       N          0    35925 	   db_tacgia 
   TABLE DATA           R   COPY public.db_tacgia (id_tacgia, ten_tacgia, avt_tacgia, gioi_thieu) FROM stdin;
    public          postgres    false    218   �/       J          0    35909    db_user 
   TABLE DATA           >   COPY public.db_user (id_user, us, email, sdt, pa) FROM stdin;
    public          postgres    false    214   M0       L          0    35917    img_sach 
   TABLE DATA           F   COPY public.img_sach (id_img, ten_img, link_img, id_sach) FROM stdin;
    public          postgres    false    216   �0       �          0    35173    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    202   �0       Y           0    0    db_danhmuc_id_dm_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_danhmuc_id_dm_seq', 5, true);
          public          postgres    false    207            Z           0    0    db_sach_id_sach_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_sach_id_sach_seq', 1, false);
          public          postgres    false    209            [           0    0    db_sach_soSao_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."db_sach_soSao_seq"', 1, false);
          public          postgres    false    210            \           0    0    db_sach_soluong_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_sach_soluong_seq', 1, false);
          public          postgres    false    211            ]           0    0    db_slide_id_slide_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.db_slide_id_slide_seq', 1, false);
          public          postgres    false    213            ^           0    0    db_user_id_user_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.db_user_id_user_seq', 1, true);
          public          postgres    false    215            _           0    0    img_sach_id_img_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.img_sach_id_img_seq', 1, false);
          public          postgres    false    217            `           0    0    tac_gia_id_tacgia_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tac_gia_id_tacgia_seq', 5, true);
          public          postgres    false    219            �           2606    35936    db_danhmuc db_danhmuc_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.db_danhmuc
    ADD CONSTRAINT db_danhmuc_pkey PRIMARY KEY (id_dm);
 D   ALTER TABLE ONLY public.db_danhmuc DROP CONSTRAINT db_danhmuc_pkey;
       public            postgres    false    206            �           2606    35938    db_sach db_sach_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.db_sach
    ADD CONSTRAINT db_sach_pkey PRIMARY KEY (id_sach);
 >   ALTER TABLE ONLY public.db_sach DROP CONSTRAINT db_sach_pkey;
       public            postgres    false    208            �           2606    35940    db_slide db_slide_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.db_slide
    ADD CONSTRAINT db_slide_pkey PRIMARY KEY (id_slide);
 @   ALTER TABLE ONLY public.db_slide DROP CONSTRAINT db_slide_pkey;
       public            postgres    false    212            �           2606    35942    db_user db_user_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.db_user
    ADD CONSTRAINT db_user_pkey PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public.db_user DROP CONSTRAINT db_user_pkey;
       public            postgres    false    214            �           2606    35944    img_sach img_sach_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.img_sach
    ADD CONSTRAINT img_sach_pkey PRIMARY KEY (id_img);
 @   ALTER TABLE ONLY public.img_sach DROP CONSTRAINT img_sach_pkey;
       public            postgres    false    216            �           2606    35946    db_tacgia tac_gia_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.db_tacgia
    ADD CONSTRAINT tac_gia_pkey PRIMARY KEY (id_tacgia);
 @   ALTER TABLE ONLY public.db_tacgia DROP CONSTRAINT tac_gia_pkey;
       public            postgres    false    218            B   +   x�3�,��LI5�4�2�,NL� 2�!b&@�	L�!���� ��3      D      x������ � �      H      x������ � �      N   P   x�3�t)�/�K����K����/(M��L���M/��2�'�l�hal�fi���l��d�l����a��W���eJ�N��=... 9�,�      J   =   x�3�LL�����+I14040200pH�M���K���4�432�04�4�442615����� ���      L      x������ � �      �      x������ � �     