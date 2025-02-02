import os
from pyswip import Prolog
import re

# Get the absolute path for the Prolog files directory
current_dir = os.path.dirname(os.path.abspath(__file__))
PROLOG_FILES_DIR = os.path.join(current_dir, "Prolog")

# Initialize Prolog
prolog = Prolog()

def load_prolog_file(domain):
    file_path = os.path.join(PROLOG_FILES_DIR, f"{domain}.pl")
    file_path = file_path.replace("\\", "/")
    consult_query = f"consult('{file_path}')"
    try:
        list(prolog.query(consult_query))
    except Exception as e:
        return False
    return True

def query_prolog(query):
    try:
        result = list(prolog.query(query))
        return result
    except Exception:
        return []

def fetch_semester_roadmap(domain):
    if not load_prolog_file(domain):
        return "Error loading roadmap."

    query = "get_full_semester_roadmap(SemesterRoadmap)."
    try:
        results = query_prolog(query)
        if results:
            roadmap = []
            raw_roadmap = results[0].get('SemesterRoadmap', [])
            for semester_data in raw_roadmap:
                semester_data = re.sub(r"[(),']", '', semester_data)
                semester_parts = semester_data.split(', [')
                semester_number = semester_parts[0].strip()
                course_data = semester_parts[1].strip() if len(semester_parts) > 1 else ''
                courses = []
                for course_str in course_data.split('),'):
                    course_str = course_str.strip()
                    if course_str:
                        course_str = re.sub(r"^b'", '', course_str)
                        course_str = re.sub(r"'$", '', course_str)
                        course_details = [item.strip() for item in course_str.split(",")]
                        if len(course_details) >= 4:
                            course_code = course_details[0]
                            course_title = course_details[1]
                            credit_hours = course_details[2]
                            prerequisites = course_details[3] if course_details[3] else "None"
                            courses.append(
                                f"Code: {course_code}, Title: {course_title}, Credit Hours: {credit_hours}, Prerequisites: {prerequisites}")
                roadmap.append(f"Semester {semester_number}:\n" + "\n".join(courses))
            return "\n\n".join(roadmap)
        return "No roadmap found."
    except Exception:
        return "Error fetching roadmap."

def get_prerequisites_by_code(domain, code):
    if not load_prolog_file(domain):
        return "Error loading prerequisites."

    query = f"get_prerequisite_by_code({code}, Prerequisites)."
    results = query_prolog(query)
    prerequisites_list = []
    for result in results:
        prerequisites = result.get('Prerequisites', [])
        prerequisites_list.extend(prerequisites)
    if prerequisites_list:
        return f"Prerequisites for {code}: {', '.join(prerequisites_list)}"
    return f"No prerequisites found for course code {code}."

def list_courses_no_prerequisites(domain, semester):
    if not load_prolog_file(domain):
        return "Error loading courses."

    query = f"get_courses_no_prerequisite({semester}, Code, Title, CreditHours)."
    results = query_prolog(query)
    if results:
        output_lines = []
        for res in results:
            title = str(res['Title']).replace("b'", "").replace("'", "")
            output_lines.append(f"Code: {res['Code']}, Title: {title}, Credit Hours: {res['CreditHours']}")
        return "\n".join(output_lines)
    return f"No courses without prerequisites found for semester {semester}."

def calculate_total_credit_hours(domain, semester):
    if not load_prolog_file(domain):
        return "Error calculating credit hours."

    query = f"total_credit_hours({semester}, TotalCreditHours)."
    results = query_prolog(query)
    if results:
        return f"Total Credit Hours for semester {semester}: {results[0]['TotalCreditHours']}"
    return f"No credit hours information found for semester {semester}."

def get_all_courses(domain, semester):
    if not load_prolog_file(domain):
        return "Error loading courses."

    query = f"get_all_courses({semester}, CoursesList)."
    results = query_prolog(query)
    if results:
        courses_list_raw = results[0]['CoursesList']
        cleaned_courses = []
        for course_str in courses_list_raw:
            course_str = course_str.strip(",[]")
            course_str = course_str.replace("),(", ");(")
            course_str = re.sub(r"b'([^']*)'", r"'\1'", course_str)
            course_str = re.sub(r",\s*,", ",", course_str)
            cleaned_courses.append(f"({course_str})")
        return "[" + ", ".join(cleaned_courses) + "]"
    return "No courses found."

def check_prerequisites_by_name(domain, course_name):
    if not load_prolog_file(domain):
        return "Error loading prerequisites."

    query = f"get_prerequisite_by_name(\"{course_name}\", PrerequisiteName)."
    results = query_prolog(query)
    if results:
        prerequisites = [f"Prerequisite: {res['PrerequisiteName']}" for res in results]
        return "\n".join(prerequisites)
    return f"No prerequisites found for course {course_name}."
