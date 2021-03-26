import psycopg2

connection = psycopg2.connect(
    user="postgres",
    password="nguyentienduong1",
    host="127.0.0.1",
    port="5432",
    database="colonhuediemb"
)

cursor = connection.cursor()