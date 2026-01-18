import sqlite3

connection = sqlite3.connect("students.db")
cursor = connection.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    rollno INTEGER,
    branch TEXT,
    python INTEGER,
    oops INTEGER,
    dbms INTEGER,
    dsa INTEGER,
    machine_learning INTEGER,
    cgpa REAL
)
""")

connection.commit()
connection.close()
