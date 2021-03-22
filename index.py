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
        return render_template("admin_product.html", ds=record, id_sach=id_sach)
    else: 
        return redirect("/login")

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
    sql = f"insert into db_tacgia(ten_tacgia, avt_tacgia, gioi_thieu) values(N'{ten_tacgia}', '../public/imgs/{avt}', N'{gioi_thieu}')"
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
