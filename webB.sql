PGDMP     .    8                y            colonhuediemb    13.2    13.2 ;    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    43057    colonhuediemb    DATABASE     q   CREATE DATABASE colonhuediemb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE colonhuediemb;
                postgres    false                        3079    43058    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2            �            1259    44101 	   db_tacgia    TABLE     �   CREATE TABLE public.db_tacgia (
    id_tacgia bigint NOT NULL,
    ten_tacgia text,
    avt_tacgia text,
    gioi_thieu text NOT NULL
);
    DROP TABLE public.db_tacgia;
       public         heap    postgres    false            �            1259    51283    author_admin    VIEW     �   CREATE VIEW public.author_admin AS
 SELECT db_tacgia.id_tacgia,
    db_tacgia.ten_tacgia,
    db_tacgia.avt_tacgia,
    db_tacgia.gioi_thieu
   FROM public.db_tacgia
  ORDER BY db_tacgia.id_tacgia;
    DROP VIEW public.author_admin;
       public          postgres    false    214    214    214    214            �            1259    44081    db_sach    TABLE     �   CREATE TABLE public.db_sach (
    id_sach bigint NOT NULL,
    ten_sach text,
    id_tacgia bigint,
    gia_sach bigint,
    soluong bigint,
    so_sao bigint,
    mota text,
    trang_thai text,
    id_dm bigint
);
    DROP TABLE public.db_sach;
       public         heap    postgres    false            �            1259    51317    count_author    VIEW     �   CREATE VIEW public.count_author AS
 SELECT db_sach.id_tacgia,
    count(db_sach.id_tacgia) AS soluong_tg
   FROM public.db_sach
  GROUP BY db_sach.id_tacgia;
    DROP VIEW public.count_author;
       public          postgres    false    208            �            1259    51321    count_category    VIEW     �   CREATE VIEW public.count_category AS
 SELECT db_sach.id_dm,
    count(db_sach.id_dm) AS soluong_dm
   FROM public.db_sach
  GROUP BY db_sach.id_dm;
 !   DROP VIEW public.count_category;
       public          postgres    false    208            �            1259    44073 
   db_danhmuc    TABLE     f   CREATE TABLE public.db_danhmuc (
    id_dm bigint NOT NULL,
    ten_dm text,
    trang_thai bit(1)
);
    DROP TABLE public.db_danhmuc;
       public         heap    postgres    false            �            1259    44079    db_danhmuc_id_dm_seq    SEQUENCE     �   ALTER TABLE public.db_danhmuc ALTER COLUMN id_dm ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_danhmuc_id_dm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    206            �            1259    44087    db_sach_id_sach_seq    SEQUENCE     �   ALTER TABLE public.db_sach ALTER COLUMN id_sach ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_sach_id_sach_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    208            �            1259    44089    db_sach_soSao_seq    SEQUENCE     |   CREATE SEQUENCE public."db_sach_soSao_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."db_sach_soSao_seq";
       public          postgres    false    208            �           0    0    db_sach_soSao_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public."db_sach_soSao_seq" OWNED BY public.db_sach.so_sao;
          public          postgres    false    210            �            1259    44091    db_sach_soluong_seq    SEQUENCE     |   CREATE SEQUENCE public.db_sach_soluong_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.db_sach_soluong_seq;
       public          postgres    false    208            �           0    0    db_sach_soluong_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.db_sach_soluong_seq OWNED BY public.db_sach.soluong;
          public          postgres    false    211            �            1259    44093    db_slide    TABLE     �   CREATE TABLE public.db_slide (
    id_slide bigint NOT NULL,
    ten_slide text,
    id_dm bigint,
    mota text,
    img_slide text
);
    DROP TABLE public.db_slide;
       public         heap    postgres    false            �            1259    44099    db_slide_id_slide_seq    SEQUENCE     �   ALTER TABLE public.db_slide ALTER COLUMN id_slide ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_slide_id_slide_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            �            1259    44107    db_user    TABLE     u   CREATE TABLE public.db_user (
    id_user bigint NOT NULL,
    us text,
    email text,
    sdt text,
    pa text
);
    DROP TABLE public.db_user;
       public         heap    postgres    false            �            1259    44113    db_user_id_user_seq    SEQUENCE     �   ALTER TABLE public.db_user ALTER COLUMN id_user ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.db_user_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    51267    home_author    VIEW     �   CREATE VIEW public.home_author AS
 SELECT db_tacgia.id_tacgia,
    db_tacgia.ten_tacgia,
    db_tacgia.avt_tacgia,
    db_tacgia.gioi_thieu
   FROM public.db_tacgia
  ORDER BY db_tacgia.id_tacgia
 LIMIT 3;
    DROP VIEW public.home_author;
       public          postgres    false    214    214    214    214            �            1259    44115    img_sach    TABLE     d   CREATE TABLE public.img_sach (
    id_img bigint NOT NULL,
    link_img text,
    id_sach bigint
);
    DROP TABLE public.img_sach;
       public         heap    postgres    false            �            1259    51262    home_featured    VIEW     �  CREATE VIEW public.home_featured AS
 SELECT db_sach.id_sach,
    db_sach.ten_sach,
    db_sach.id_tacgia,
    db_sach.gia_sach,
    db_sach.soluong,
    db_sach.so_sao,
    db_sach.mota,
    db_sach.trang_thai,
    db_sach.id_dm,
    db_tacgia.ten_tacgia,
    img_sach.link_img
   FROM ((public.db_sach
     JOIN public.db_tacgia ON ((db_sach.id_tacgia = db_tacgia.id_tacgia)))
     JOIN public.img_sach ON ((db_sach.id_sach = img_sach.id_sach)))
  ORDER BY db_sach.id_sach
 OFFSET 8
 LIMIT 8;
     DROP VIEW public.home_featured;
       public          postgres    false    208    208    214    214    217    208    208    208    208    208    208    217    208            �            1259    51257    home_new_arrivals    VIEW     �  CREATE VIEW public.home_new_arrivals AS
 SELECT db_sach.id_sach,
    db_sach.ten_sach,
    db_sach.id_tacgia,
    db_sach.gia_sach,
    db_sach.soluong,
    db_sach.so_sao,
    db_sach.mota,
    db_sach.trang_thai,
    db_sach.id_dm,
    db_tacgia.ten_tacgia,
    img_sach.link_img
   FROM ((public.db_sach
     JOIN public.db_tacgia ON ((db_sach.id_tacgia = db_tacgia.id_tacgia)))
     JOIN public.img_sach ON ((db_sach.id_sach = img_sach.id_sach)))
  ORDER BY db_sach.id_sach
 LIMIT 8;
 $   DROP VIEW public.home_new_arrivals;
       public          postgres    false    208    214    217    217    208    208    208    214    208    208    208    208    208            �            1259    51287 	   img_admin    VIEW     �   CREATE VIEW public.img_admin AS
 SELECT img_sach.id_img,
    img_sach.link_img,
    db_sach.ten_sach,
    img_sach.id_sach
   FROM (public.img_sach
     JOIN public.db_sach ON ((img_sach.id_sach = db_sach.id_sach)))
  ORDER BY img_sach.id_img;
    DROP VIEW public.img_admin;
       public          postgres    false    217    217    217    208    208            �            1259    44121    img_sach_id_img_seq    SEQUENCE     �   ALTER TABLE public.img_sach ALTER COLUMN id_img ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.img_sach_id_img_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    51271    products_admin    VIEW       CREATE VIEW public.products_admin AS
 SELECT db_sach.id_sach,
    db_sach.ten_sach,
    db_sach.id_tacgia,
    db_sach.gia_sach,
    db_sach.soluong,
    db_sach.so_sao,
    db_sach.mota,
    db_sach.trang_thai,
    db_sach.id_dm
   FROM public.db_sach
  ORDER BY db_sach.id_sach;
 !   DROP VIEW public.products_admin;
       public          postgres    false    208    208    208    208    208    208    208    208    208            �            1259    51275    products_author_admin    VIEW     |   CREATE VIEW public.products_author_admin AS
 SELECT db_tacgia.id_tacgia,
    db_tacgia.ten_tacgia
   FROM public.db_tacgia;
 (   DROP VIEW public.products_author_admin;
       public          postgres    false    214    214            �            1259    51295    products_categories_admin    VIEW     �   CREATE VIEW public.products_categories_admin AS
 SELECT db_danhmuc.id_dm,
    db_danhmuc.ten_dm,
    db_danhmuc.trang_thai
   FROM public.db_danhmuc
  ORDER BY db_danhmuc.id_dm;
 ,   DROP VIEW public.products_categories_admin;
       public          postgres    false    206    206    206            �            1259    51312    search_categories    VIEW     �  CREATE VIEW public.search_categories AS
 SELECT a.id_sach,
    a.ten_sach,
    a.id_tacgia,
    a.gia_sach,
    a.soluong,
    a.so_sao,
    a.mota,
    a.trang_thai,
    a.id_dm,
    db_tacgia.ten_tacgia,
    d.link_img
   FROM (((public.db_sach a
     JOIN public.db_tacgia ON ((a.id_tacgia = db_tacgia.id_tacgia)))
     JOIN public.img_sach d ON ((d.id_sach = a.id_sach)))
     JOIN public.db_danhmuc dm ON ((dm.id_dm = a.id_dm)));
 $   DROP VIEW public.search_categories;
       public          postgres    false    208    214    217    217    206    208    208    208    208    208    208    208    208    214            �            1259    51325    search_keyword    VIEW     �  CREATE VIEW public.search_keyword AS
 SELECT a.id_sach,
    a.ten_sach,
    a.id_tacgia,
    a.gia_sach,
    a.soluong,
    a.so_sao,
    a.mota,
    a.trang_thai,
    a.id_dm,
    c.ten_tacgia,
    img.link_img,
    b.ten_dm
   FROM (((public.db_sach a
     JOIN public.db_danhmuc b ON ((b.id_dm = a.id_dm)))
     JOIN public.db_tacgia c ON ((c.id_tacgia = a.id_tacgia)))
     JOIN public.img_sach img ON ((a.id_sach = img.id_sach)));
 !   DROP VIEW public.search_keyword;
       public          postgres    false    208    208    208    208    208    208    206    208    206    208    217    217    214    214    208            �            1259    51308    search_minmax_tacgia    VIEW     {  CREATE VIEW public.search_minmax_tacgia AS
 SELECT a.id_sach,
    a.ten_sach,
    a.id_tacgia,
    a.gia_sach,
    a.soluong,
    a.so_sao,
    a.mota,
    a.trang_thai,
    a.id_dm,
    db_tacgia.ten_tacgia,
    d.link_img
   FROM ((public.db_sach a
     JOIN public.db_tacgia ON ((a.id_tacgia = db_tacgia.id_tacgia)))
     JOIN public.img_sach d ON ((d.id_sach = a.id_sach)));
 '   DROP VIEW public.search_minmax_tacgia;
       public          postgres    false    208    208    214    214    217    217    208    208    208    208    208    208    208            �            1259    51299    shop    VIEW     k  CREATE VIEW public.shop AS
 SELECT a.id_sach,
    a.ten_sach,
    a.id_tacgia,
    a.gia_sach,
    a.soluong,
    a.so_sao,
    a.mota,
    a.trang_thai,
    a.id_dm,
    db_tacgia.ten_tacgia,
    d.link_img
   FROM ((public.db_sach a
     JOIN public.db_tacgia ON ((a.id_tacgia = db_tacgia.id_tacgia)))
     JOIN public.img_sach d ON ((d.id_sach = a.id_sach)));
    DROP VIEW public.shop;
       public          postgres    false    208    208    208    208    208    214    214    217    217    208    208    208    208            �            1259    44123    tac_gia_id_tacgia_seq    SEQUENCE     �   ALTER TABLE public.db_tacgia ALTER COLUMN id_tacgia ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tac_gia_id_tacgia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            �           2604    44125    db_sach soluong    DEFAULT     r   ALTER TABLE ONLY public.db_sach ALTER COLUMN soluong SET DEFAULT nextval('public.db_sach_soluong_seq'::regclass);
 >   ALTER TABLE public.db_sach ALTER COLUMN soluong DROP DEFAULT;
       public          postgres    false    211    208            �           2604    44126    db_sach so_sao    DEFAULT     q   ALTER TABLE ONLY public.db_sach ALTER COLUMN so_sao SET DEFAULT nextval('public."db_sach_soSao_seq"'::regclass);
 =   ALTER TABLE public.db_sach ALTER COLUMN so_sao DROP DEFAULT;
       public          postgres    false    210    208            �          0    44073 
   db_danhmuc 
   TABLE DATA           ?   COPY public.db_danhmuc (id_dm, ten_dm, trang_thai) FROM stdin;
    public          postgres    false    206   $L       �          0    44081    db_sach 
   TABLE DATA           s   COPY public.db_sach (id_sach, ten_sach, id_tacgia, gia_sach, soluong, so_sao, mota, trang_thai, id_dm) FROM stdin;
    public          postgres    false    208   _L       �          0    44093    db_slide 
   TABLE DATA           O   COPY public.db_slide (id_slide, ten_slide, id_dm, mota, img_slide) FROM stdin;
    public          postgres    false    212   �N       �          0    44101 	   db_tacgia 
   TABLE DATA           R   COPY public.db_tacgia (id_tacgia, ten_tacgia, avt_tacgia, gioi_thieu) FROM stdin;
    public          postgres    false    214   �N       �          0    44107    db_user 
   TABLE DATA           >   COPY public.db_user (id_user, us, email, sdt, pa) FROM stdin;
    public          postgres    false    215   �O       �          0    44115    img_sach 
   TABLE DATA           =   COPY public.img_sach (id_img, link_img, id_sach) FROM stdin;
    public          postgres    false    217   =P       �          0    43365    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    202   �Q       �           0    0    db_danhmuc_id_dm_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_danhmuc_id_dm_seq', 5, true);
          public          postgres    false    207            �           0    0    db_sach_id_sach_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_sach_id_sach_seq', 20, true);
          public          postgres    false    209            �           0    0    db_sach_soSao_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."db_sach_soSao_seq"', 2, true);
          public          postgres    false    210            �           0    0    db_sach_soluong_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_sach_soluong_seq', 1, false);
          public          postgres    false    211            �           0    0    db_slide_id_slide_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.db_slide_id_slide_seq', 1, false);
          public          postgres    false    213            �           0    0    db_user_id_user_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.db_user_id_user_seq', 1, true);
          public          postgres    false    216            �           0    0    img_sach_id_img_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.img_sach_id_img_seq', 19, true);
          public          postgres    false    218            �           0    0    tac_gia_id_tacgia_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tac_gia_id_tacgia_seq', 5, true);
          public          postgres    false    219            �           2606    44128    db_danhmuc db_danhmuc_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.db_danhmuc
    ADD CONSTRAINT db_danhmuc_pkey PRIMARY KEY (id_dm);
 D   ALTER TABLE ONLY public.db_danhmuc DROP CONSTRAINT db_danhmuc_pkey;
       public            postgres    false    206            �           2606    44130    db_sach db_sach_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.db_sach
    ADD CONSTRAINT db_sach_pkey PRIMARY KEY (id_sach);
 >   ALTER TABLE ONLY public.db_sach DROP CONSTRAINT db_sach_pkey;
       public            postgres    false    208            �           2606    44132    db_slide db_slide_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.db_slide
    ADD CONSTRAINT db_slide_pkey PRIMARY KEY (id_slide);
 @   ALTER TABLE ONLY public.db_slide DROP CONSTRAINT db_slide_pkey;
       public            postgres    false    212            �           2606    44134    db_user db_user_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.db_user
    ADD CONSTRAINT db_user_pkey PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public.db_user DROP CONSTRAINT db_user_pkey;
       public            postgres    false    215            �           2606    44136    img_sach img_sach_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.img_sach
    ADD CONSTRAINT img_sach_pkey PRIMARY KEY (id_img);
 @   ALTER TABLE ONLY public.img_sach DROP CONSTRAINT img_sach_pkey;
       public            postgres    false    217            �           2606    44138    db_tacgia tac_gia_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.db_tacgia
    ADD CONSTRAINT tac_gia_pkey PRIMARY KEY (id_tacgia);
 @   ALTER TABLE ONLY public.db_tacgia DROP CONSTRAINT tac_gia_pkey;
       public            postgres    false    214            �   +   x�3�,��LI5�4�2�,NL� 2�!b&@�	L�!���� ��3      �   g  x���O�@ǟ�����2�-�
*0"��������.�ݵ���N�&�/ R�$�˾���/Wfi��$���&q��k��,<PO������̲�d�h0��)@�
vަ�a/%Oa�BI@5E�^ZL�v�p�,Yj���B-��
�Q	Uҩ99Bh�W�v(�6��=���d�p� ���+��Ii
���׎C`��;��+O!���V��C�|H$GO�ff�Yf6�B�/�I�h9|�;e�4�)�o7�ge1��,ff)D���:㉭e�EM(�'v����h���G�17��#ؠ}[��!�]@�Q�H,��ޠ��[�$-;�{���G�v
���QH��\S�]Q1�0$P��;K�`�M:B5��Q@�d���QSq�h��T@$���� �`�65����V�|:�4|n^��6���A�No~�Ƒz/L�
=o�\�[����������ڈp���,�5zXGߩ���ՠ��0:
�0ZG�8
J�f���@�F�0z���]=hh�p�ڮ���J;�SqIlF���<�R��t
!O��[�8=�u$<���3�ǐj�"I+Sw>�q��~T8���[�K�d!�:�%�`�i��r�3�p~N'��;�ޕ�      �      x������ � �      �   �   x�퐱n�0D��+8�@ ò��c�,2��P���ؒ�߯,x�Pt����;^{�$�p�A�:D��k��P���:5�Z5���ݶ�[�^�J3|�B�|��L+�� 8V�p'�G���_-/���39B�[˚c2�`Kܒ8�bEΤy7s^`(Qڻ@K��=�'�p��1��M����6�{[��b�����~�<��8�!�A)��h�E�>����?�{Bۡ}���~ 5�J�      �   =   x�3�LL�����+I14040200pH�M���K���4�432�04�4�442615����� ���      �   M  x�e��r� ���)rL�� ��.� �+Y�����ǿT��@A���؍oIr���^��6\,�2U��Y]U�ʦ~���I�oo��G>+3RU��
���Pm�j��ّo�o��uk�y�PSx�ꕗi��/�⤻�����I`��~5�B��!�(X7�J�U��d�fC�Wׇ�:�޸@æA�x�`q��)�UE�bK�wd�1�#��#\;�G��@�"��<o��l���%�6#%P����-����yN����}�\`~�tQ�*�\�L�Osj�P
<U�Վ�%�f�-�ٵ�S_-?�ߛ����E��J˫�J����޲      �      x������ � �     