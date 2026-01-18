def calculate_cgpa(marks_list):
    total = sum(marks_list)
    percentage = total / len(marks_list)

    cgpa = round(percentage / 9.5, 2)
    return cgpa
