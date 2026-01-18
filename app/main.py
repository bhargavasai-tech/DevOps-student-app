from flask import Flask, render_template, request
import sqlite3
import core
import schema   # DB created automatically

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def home():
    if request.method == "POST":
        name = request.form.get("name")
        rollno = request.form.get("rollno")
        branch = request.form.get("branch")

        python = int(request.form.get("python"))
        oops = int(request.form.get("oops"))
        dbms = int(request.form.get("dbms"))
        dsa = int(request.form.get("dsa"))
        machine_learning = int(request.form.get("machine_learning"))

        marks = [python, oops, dbms, dsa, machine_learning]
        cgpa = core.calculate_cgpa(marks)

        connection = sqlite3.connect("students.db")
        cursor = connection.cursor()
        cursor.execute("""
        INSERT INTO students 
        (name, rollno, branch, python, oops, dbms, dsa, machine_learning, cgpa)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (name, rollno, branch, python, oops, dbms, dsa, machine_learning, cgpa))

        connection.commit()
        connection.close()

    connection = sqlite3.connect("students.db")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM students")
    students = cursor.fetchall()
    connection.close()

    return render_template("index.html", students=students)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
