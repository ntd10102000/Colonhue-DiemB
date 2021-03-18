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

# @app.route("/")
# def index():
#     ma_sv = request.args.get("ma_sv", type = int)
#     sql = "select * from sinhvien order by ma_sv ASC"
#     cursor.execute(sql)
#     record = cursor.fetchall()
#     return render_template("home.html", dssv = record, ma_sv = ma_sv)

# @app.route("/insert")
# def insert():
#     return render_template("insert.html")

# @app.route("/inserted", methods=["POST"])
# def inserted():
#     ten_sv = request.form.get("ten_sv")
#     email = request.form.get("email")
#     dia_chi = request.form.get("dia_chi")

#     sql = f"insert into sinhvien(ten_sv, email, dia_chi) values(N'{ten_sv}', N'{email}', N'{dia_chi}')"
#     cursor.execute(sql)
#     connection.commit()
#     return redirect("/")

# @app.route("/delete")
# def delete():
#     ma_sv = request.args.get("ma_sv", type = int)
#     sql = f"delete from sinhvien where ma_sv = {ma_sv}" 
#     cursor.execute(sql)
#     connection.commit()
#     return redirect("/")

# @app.route("/updated", methods=["POST"])
# def updated():
#     ma_sv = request.args.get("ma_sv", type = int)
#     ten_sv = request.form.get("ten_sv")
#     email = request.form.get("email")
#     dia_chi = request.form.get("dia_chi")

#     print(ten_sv)

#     sql = f"update sinhvien set ten_sv = N'{ten_sv}', email = N'{email}', dia_chi = N'{dia_chi}' where ma_sv = {ma_sv}"
#     cursor.execute(sql)
#     connection.commit()
#     return redirect("/")

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
