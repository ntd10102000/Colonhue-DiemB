import psycopg2

connection = psycopg2.connect(
    user="postgres",
    password="Hau23022000",
    host="127.0.0.1",
    port="5432",
    database="webgisB"
)

cursor = connection.cursor()