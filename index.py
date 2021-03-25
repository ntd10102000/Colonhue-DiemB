import os
from connect import connection, cursor
from flask import Flask, render_template, request, redirect, session

app = Flask(__name__)
app.secret_key = "abc"


err = ''

@app.route('/')
def index():
    if "username" in session:
        sql = "select * from db_user"
        cursor.execute(sql)
        record = cursor.fetchall()
        return render_template("home.html", r=record, us=session["username"])
    else: 
        return redirect("/login")

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

@app.route("/product")
def product():
    if "username" in session:
        id_sach = request.args.get("id_sach", type = int)
        sql = "select * from db_sach order by id_sach ASC"
        cursor.execute(sql)
        record = cursor.fetchall()
        sql1 = "select id_tacgia, ten_tacgia from db_tacgia"
        cursor.execute(sql1)
        record1 = cursor.fetchall()
        sql2 = "select id_dm, ten_dm from db_danhmuc"
        cursor.execute(sql2)
        record2 = cursor.fetchall()
        return render_template("admin_product.html", ds=record, id_sach=id_sach,ds1=record1,ds2=record2)
    else: 
        return redirect("/login")
@app.route("/insert_product")
def insert_product():
    sql = "select id_tacgia, ten_tacgia from db_tacgia"
    cursor.execute(sql)
    record = cursor.fetchall()
    print(record)
    sql1 = "select id_dm, ten_dm from db_danhmuc"
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
    return redirect("/insert_product")

@app.route("/delete_product")
def delete_product():
    id_sach = request.args.get("id_sach", type = int)
    sql = f"delete from db_sach where id_sach = {id_sach}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/product")

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

    print(ten_sach)

    sql = f"update db_sach set ten_sach = N'{ten_sach}',id_tacgia={id_tacgia}, gia_sach={gia_sach}, soluong={soluong}, so_sao={so_sao}, mota=N'{mota}', trang_thai={trang_thai},id_dm={id_dm} where id_sach = {id_sach}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/product")

@app.route("/author")
def author():
    if "username" in session:
        id_tacgia = request.args.get("id_tacgia", type = int)
        sql = "select * from db_tacgia order by id_tacgia ASC"
        cursor.execute(sql)
        record = cursor.fetchall()
        return render_template("admin_author.html", ds=record, id_tacgia=id_tacgia)
    else: 
        return redirect("/login")


@app.route("/insert_author")
def insert():
    return render_template("insert_author.html")

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
    return redirect("/insert_author")

@app.route("/delete")
def delete():
    id_tacgia = request.args.get("id_tacgia", type = int)
    sql = f"delete from db_tacgia where id_tacgia = {id_tacgia}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/author")

@app.route("/updated", methods=["POST"])
def updated():
    id_tacgia = request.args.get("id_tacgia", type = int)
    ten_tacgia = request.form.get("ten_tacgia")
    gioithieu = request.form.get("gioithieu")
    avt_tacgia = request.form.get("avt_tacgia")

    print(ten_tacgia)

    sql = f"update db_tacgia set ten_tacgia = N'{ten_tacgia}', gioi_thieu = N'{gioithieu}', avt_tacgia = N'{avt_tacgia}' where id_tacgia = {id_tacgia}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/author")

@app.route("/img_sach")
def img_sach():
    if "username" in session:
        id_img = request.args.get("id_img", type = int)
        sql = "select img_sach.id_img, img_sach.link_img, db_sach.ten_sach, img_sach.id_sach from img_sach inner join db_sach on img_sach.id_sach = db_sach.id_sach order by id_img ASC"
        cursor.execute(sql)
        record = cursor.fetchall()
        sql1 = "select * from db_sach order by id_sach ASC"
        cursor.execute(sql1)
        record1 = cursor.fetchall()
        return render_template("admin_img.html", ds=record, id_img=id_img, ds1=record1)
    else: 
        return redirect("/login")

@app.route("/insert_img")
def insert_img():
    sql1 = "select id_sach, ten_sach from db_sach order by id_sach ASC"
    cursor.execute(sql1)
    record1 = cursor.fetchall()
    return render_template("insert_img.html", ds=record1)

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

    return redirect("/insert_img")

@app.route("/delete_img")
def delete_img():
    id_img = request.args.get("id_img", type = int)
    sql = f"delete from img_sach where id_img = {id_img}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/img_sach")

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
    return redirect("/img_sach")

@app.route("/category")
def category():
    if "username" in session:
        id_dm = request.args.get("id_dm", type = int)
        sql = "select * from db_danhmuc order by id_dm ASC"
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
    trang_thai_dm = request.form.get("trang_thai_dm")    
    sql = f"insert into db_danhmuc(ten_dm,trang_thai_dm) values(N'{ten_dm}', '{trang_thai_dm}')"
    cursor.execute(sql)
    connection.commit()
    return redirect("/insert_category")

@app.route("/delete_category")
def delete_category():
    id_dm = request.args.get("id_dm", type = int)
    sql = f"delete from db_danhmuc where id_dm = {id_dm}" 
    cursor.execute(sql)
    connection.commit()
    return redirect("/category")

@app.route("/updated_category", methods=["POST"])
def updated_category():
    id_dm = request.args.get("id_dm", type = int)
    ten_dm = request.form.get("ten_dm")
    trang_thai_dm = request.form.get("trang_thai_dm")
    
    print(ten_dm)

    sql = f"update db_danhmuc set ten_dm = N'{ten_dm}', trang_thai_dm = '{trang_thai_dm}' where id_dm = {id_dm}"
    cursor.execute(sql)
    connection.commit()
    return redirect("/category")

@app.route("/admin")
def admin():
    return render_template("admin.html")


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
