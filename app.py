import os
from connect import connection, cursor
from flask import Flask, render_template, request, redirect, session

app = Flask(__name__)
app.secret_key = "abc"


err = ''

@app.route('/')
def index():
    new_arrivals = "select * from home_new_arrivals;"
    cursor.execute(new_arrivals)
    result_na = cursor.fetchall()
    featured = "select * from home_featured;"
    cursor.execute(featured)
    result_featured = cursor.fetchall()
    author = "select * from home_author;"
    cursor.execute(author)
    result_author = cursor.fetchall()
    return render_template("home.html", rna = result_na, rf = result_featured, ra = result_author)

@app.route("/login")
def login():
    return render_template("login.html")

@app.route("/login_dn", methods=["POST"])
def login_dn():
    us = request.form.get("user_name")
    pa = request.form.get("pass_word")

    sql = "select * from db_user where us = '"+us+"' and pa='"+pa+"'"
    cursor.execute(sql)
    # Fetch result
    record = cursor.fetchall()
    if(len(record)==1):
        session["username"] = us
        return redirect("/")
    else:
        err = 'Mật khẩu hoặc tài khoản không đúng'
        return render_template("login.html", err = err)

@app.route("/signup")
def signup():
    return render_template("signup.html")

@app.route("/signup_dk", methods=["POST"])
def signup_dk():
    us = request.form.get("user_name")
    pa = request.form.get("pass_word")
    rpa = request.form.get("rpass_word")
    email = request.form.get("email")
    sdt = request.form.get("sdt")

    if len(pa) < 6:
        err = 'Mật khẩu phải lớn hơn 6 kí tự'
    elif pa != rpa:
        err = 'Mật khẩu không trùng nhau'
    else:
        sql = f"select * from db_user where us like '{us}'"
        cursor.execute(sql)
        connection.commit()
        record = cursor.fetchall()
        if len(record) == 0:
            sql_signup = f"insert into db_user(us, email, sdt, pa) values('{us}', '{email}', '{sdt}', '{pa}')"
            cursor.execute(sql_signup)
            connection.commit()
            return redirect("/login")
        else:
            err = 'Tài khoản đã tồn tại'
    return render_template("signup.html", err = err)


@app.route("/insert_product")
def insert_product():
    sql = "select * from products_author_admin"
    cursor.execute(sql)
    record = cursor.fetchall()
    print(record)
    sql1 = "select * from products_categories_admin"
    cursor.execute(sql1)
    record1 = cursor.fetchall()
    print(record1)
    return render_template("insert_product.html", ds=record,ds1=record1)

@app.route("/inserted_product", methods=["POST"])
def inserted_product():
    ten_sach = request.form.get("ten_sach")
    id_tacgia = request.form.get("id_tacgia")
    gia_sach = request.form.get("gia_sach")
    soluong = request.form.get("soluong")
    so_sao = request.form.get("so_sao")
    mota = request.form.get("mota")
    trang_thai = request.form.get("trang_thai")
    id_dm = request.form.get("id_dm")  
    sql = f"insert into db_sach(ten_sach,id_tacgia,gia_sach,soluong,so_sao,mota,trang_thai,id_dm) values(N'{ten_sach}', {id_tacgia}, {gia_sach},{soluong},{so_sao},'{mota}',{trang_thai},{id_dm})"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/delete_product")
def delete_product():
    id_sach = request.args.get("id_sach", type = int)
    sql = f"delete from db_sach where id_sach = {id_sach}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/updated_product", methods=["POST"])
def updated_product():
    id_sach = request.args.get("id_sach", type = int)
    ten_sach = request.form.get("ten_sach")
    id_tacgia = request.form.get("id_tacgia")
    gia_sach = request.form.get("gia_sach")
    soluong = request.form.get("soluong")
    so_sao = request.form.get("so_sao")
    mota = request.form.get("mota")
    trang_thai = request.form.get("trang_thai")
    id_dm = request.form.get("id_dm")  
    sql = f"update db_sach set ten_sach = N'{ten_sach}',id_tacgia={id_tacgia}, gia_sach={gia_sach}, soluong={soluong}, so_sao={so_sao}, mota=N'{mota}', trang_thai={trang_thai},id_dm={id_dm} where id_sach = {id_sach}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/inserted_author", methods=["POST"])
def inserted_actor():
    avt = ""
    for uploaded_file in request.files.getlist("avt_tacgia"):
        if uploaded_file.filename != "":
            avt = uploaded_file.filename
            print(uploaded_file.filename)
            uploaded_file.save(os.path.join("static/imgs", uploaded_file.filename))

    ten_tacgia = request.form.get("ten_tacgia")
    gioi_thieu = request.form.get("gioithieu")    
    sql = f"insert into db_tacgia(ten_tacgia, avt_tacgia, gioi_thieu) values(N'{ten_tacgia}', '../static/imgs/{avt}', N'{gioi_thieu}')"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/delete_author")
def delete():
    id_tacgia = request.args.get("id_tacgia", type = int)
    sql = f"delete from db_tacgia where id_tacgia = {id_tacgia}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/updated_author", methods=["POST"])
def updated():
    id_tacgia = request.args.get("id_tacgia", type = int)
    ten_tacgia = request.form.get("ten_tacgia")
    gioithieu = request.form.get("gioithieu")
    avt_tacgia = ""
    for uploaded_file in request.files.getlist("avt_tacgia"):
        if uploaded_file.filename != "":
            avt_tacgia = uploaded_file.filename
            print(uploaded_file.filename)
            uploaded_file.save(os.path.join("static/imgs", uploaded_file.filename))
    sql = f"update db_tacgia set ten_tacgia = N'{ten_tacgia}', avt_tacgia = '../static/imgs/{avt_tacgia}', gioi_thieu = N'{gioithieu}' where id_tacgia = {id_tacgia}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/inserted_img", methods=["POST"])
def inserted_img():
    img = ""
    id_sach = request.form.get("id_sach")
    for uploaded_file in request.files.getlist("link_img"):
        if uploaded_file.filename != "":
            img = uploaded_file.filename
            print(uploaded_file.filename)
            uploaded_file.save(os.path.join("static/imgs", uploaded_file.filename))
            sql = f"insert into img_sach(link_img, id_sach) values('../static/imgs/{img}', '{id_sach}')"
            cursor.execute(sql)
            connection.commit()
    return redirect("/admin")

@app.route("/delete_img")
def delete_img():
    id_img = request.args.get("id_img", type = int)
    sql = f"delete from img_sach where id_img = {id_img}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/updated_img", methods=["POST"])
def updated_img():
    id_img = request.args.get("id_img", type = int)
    id_sach = request.form.get("id_sach")
    img = ""
    for uploaded_file in request.files.getlist("link_img"):
        if uploaded_file.filename != "":
            img = uploaded_file.filename
            print(uploaded_file.filename)
            uploaded_file.save(os.path.join("static/imgs", uploaded_file.filename))
    sql = f"update img_sach set link_img = '../static/imgs/{img}', id_sach = '{id_sach}' where id_img = {id_img}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/category")
def category():
    if "username" in session:
        id_dm = request.args.get("id_dm", type = int)
        sql = "select * from products_categories_admin"
        cursor.execute(sql)
        record = cursor.fetchall()
        return render_template("admin_category.html", ds=record, id_dm=id_dm)
    else: 
        return redirect("/login")

@app.route("/insert_category")
def insert_category():
    return render_template("insert_category.html")

@app.route("/inserted_category", methods=["POST"])
def inserted_category():
    ten_dm = request.form.get("ten_dm")
    sql = f"insert into db_danhmuc(ten_dm) values(N'{ten_dm}')"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/delete_category")
def delete_category():
    id_dm = request.args.get("id_dm", type = int)
    sql = f"delete from db_danhmuc where id_dm = {id_dm}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/updated_category", methods=["POST"])
def updated_category():
    id_dm = request.args.get("id_dm", type = int)
    ten_dm = request.form.get("ten_dm")
    sql = f"update db_danhmuc set ten_dm = N'{ten_dm}'where id_dm = {id_dm}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/admin")

@app.route("/admin")
def admin():
    if "username" in session:
        id_tacgia = request.args.get("id_tacgia", type = int)
        sql_admin_author = "select * from db_tacgia ORDER BY id_tacgia DESC"
        cursor.execute(sql_admin_author)
        record_admin_author = cursor.fetchall()

        id_sach = request.args.get("id_sach", type = int)
        sql_admin_products = "select * from products_admin ORDER BY id_sach DESC"
        cursor.execute(sql_admin_products)
        record_admin_products = cursor.fetchall()
        sql_admin_products_author = "select * from products_author_admin"
        cursor.execute(sql_admin_products_author)
        record_products_author = cursor.fetchall()
        sql_admin_products_categories = "select * from products_categories_admin"
        cursor.execute(sql_admin_products_categories)
        record_products_categories = cursor.fetchall()

        id_img = request.args.get("id_img", type = int)
        sql_admin_img = "select * from img_admin ORDER BY id_img DESC;"
        cursor.execute(sql_admin_img)
        record_admin_img = cursor.fetchall()

        id_dm = request.args.get("id_dm", type = int)
        sql_admin_categories = "select * from products_categories_admin"
        cursor.execute(sql_admin_categories)
        record_admin_categories = cursor.fetchall()

        return render_template("admin.html", ds_author=record_admin_author, id_tacgia=id_tacgia, ds_products=record_admin_products, id_sach=id_sach,ds_products_author=record_products_author,ds_products_categories=record_products_categories, ds_img=record_admin_img, id_img=id_img, ds_categories=record_admin_categories, id_dm=id_dm)
    else: 
        return redirect("/login")

@app.route("/shop", methods=["GET"])
def shop():
    keyword = request.args.get("search", type = str)
    max_s = request.args.get("max", type = int)
    min_s = request.args.get("min", type = int)
    dm = request.args.get("dm", type = int)
    tg = request.args.get("tg", type = int)
    sql = f"SELECT * FROM shop;"
    if keyword != None:
        sql = f"select * from search_keyword WHERE ten_sach LIKE N'%{keyword}%' OR ten_dm LIKE N'%{keyword}%' OR ten_tacgia LIKE N'%{keyword}%';"
    elif max_s != None and min_s != None:
        sql = f"select * from search_minmax_tacgia WHERE gia_sach BETWEEN '{min_s}' AND '{max_s}';"
    elif dm != None:
        sql = f"select * from search_categories where id_dm = {dm};"
    elif tg != None:
        sql = f"select * from search_minmax_tacgia where id_tacgia = {tg};"
    cursor.execute(sql)
    record = cursor.fetchall()
    sql_tacgia = f"select * from db_tacgia;"
    cursor.execute(sql_tacgia)
    record_tacgia = cursor.fetchall()
    sql_count_tacgia = f"select * from count_author"
    cursor.execute(sql_count_tacgia)
    record_count_tacgia = cursor.fetchall()
    sql_danhmuc = f"select * from db_danhmuc;"
    cursor.execute(sql_danhmuc)
    record_danhmuc = cursor.fetchall()
    sql_count_danhmuc = f"select * from count_category"
    cursor.execute(sql_count_danhmuc)
    record_count_danhmuc = cursor.fetchall()
    connection.commit()
    return render_template("shop.html", record_tacgia = record_tacgia, record_count_tacgia = record_count_tacgia, record_danhmuc = record_danhmuc, record_count_danhmuc = record_count_danhmuc, record = record)
    
@app.route("/product", methods=["GET"])
def product():
    id_sach = request.args.get("id_sach", type = int)
    sql = f"SELECT * from search_categories where id_sach = {id_sach};"
    cursor.execute(sql)
    rs = cursor.fetchall()
    sql_lq = f"select * from search_minmax_tacgia WHERE id_dm IN (SELECT id_dm FROM db_sach WHERE id_sach = {id_sach}) or id_tacgia IN (SELECT id_tacgia FROM db_sach WHERE id_sach = {id_sach}) limit 4;"
    cursor.execute(sql_lq)
    lq = cursor.fetchall()
    connection.commit()
    return render_template("product.html", rs = rs, lq = lq)       


# @app.route("/file")
# def uploadFile():
#     return render_template("upload_file.html")

# @app.route("/upload", methods=["POST"])
# def uploaded():
#     for uploaded_file in request.files.getlist("file"):
#         if uploaded_file.filename != "":
#             print(uploaded_file.filename)
#             uploaded_file.save(os.path.join("static", uploaded_file.filename))
#     return redirect("/file")


#  if "username" in session:
#     else: 
#         return redirect("/login")
