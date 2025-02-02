:- discontiguous course/4.
:- discontiguous semester/2.

% Facts for all semester courses

% Semester 1
course(cc120, "Application of Information & Communication Technologies", 2, []).
course(cc120l, "Application of Information & Communication Technologies Lab", 1, []).
course(cc111, "Programming Fundamentals", 3, []).
course(cc111l, "Programming Fundamentals Lab", 1, []).
course(ma107, "Calculus and Analytical Geometry", 3, []).
course(en110, "English-I", 3, []).
course(isl112, "Islamic Thought and Perspectives", 3, []).
course(pol121, "Pakistan: Ideology, Constitution, and Society", 3, []).

% Semester 2
course(ns125, "Applied Physics", 2, []).
course(ns125l, "Applied Physics Lab", 1, []).
course(cc112, "Object Oriented Programming", 3, [cc111]).
course(cc112l, "Object Oriented Programming Lab", 1, [cc111l]).
course(ma108, "Multivariable Calculus", 3, [ma107]).
course(en123, "English-II", 3, [en110]).
course(cc121, "Digital Logic Design", 2, []).
course(cc121l, "Digital Logic Design Lab", 1, []).
course(cc141, "Quantitative Reasoning – 1 (Discrete Structures)", 3, []).

% Semester 3
course(cc213, "Data Structures", 3, [cc112]).
course(cc213l, "Data Structures Lab", 1, [cc112l]).
course(cc222, "Computer Organization and Assembly Language", 2, [cc121]).
course(cc222l, "Computer Organization and Assembly Language Lab", 1, [cc121l]).
course(cc281, "Software Engineering", 3, []).
course(sd210, "Civics and Community Engagement", 2, []).
course(ma150, "Probability and Statistics", 3, []).
course(ma210, "Linear Algebra", 3, [ma107]).

% Semester 4
course(cc230, "Database Systems", 3, []).
course(cc230l, "Database Systems Lab", 1, []).
course(cc251, "Computer Networks", 2, []).
course(cc251l, "Computer Networks Lab", 1, []).
course(technical_elective_1, "Open-Source Software Development", 3, []).
course(hu201, "Professional Practices", 3, []).
course(it291, "Web Technologies", 2, []).
course(it291l, "Web Technologies Lab", 1, [it291]).
course(university_elective_1, "University Elective 1", 3, []).

% Semester 5
course(it331, "Database Administration and Management", 2, [cc230]).
course(it331l, "Database Administration and Management Lab", 1, [cc230]).
course(cc361, "Information Security", 3, []).
course(cc371, "Artificial Intelligence", 3, [cc213]).
course(cc323, "Operating Systems", 3, []).
course(cc323l, "Operating Systems Lab", 1, []).
course(mg224, "Innovation and Entrepreneurship", 3, []).
course(technical_elective_2, "Technical Elective 2", 3, []).
course(sd100, "English Immersion", 0, []).

% Semester 6
course(it321, "System and Network Administration", 2, [cc251]).
course(it321l, "System and Network Administration Lab", 1, [cc251]).
course(cy361, "Cyber Security", 2, [cc361]).
course(cy361l, "Cyber Security Lab", 1, [cc361]).
course(cc342, "Analysis of Algorithms", 3, [cc213]).
course(en220, "Technical & Business Writing", 3, []).
course(technical_elective_3, "Technical Elective 3", 3, []).
course(technical_elective_4, "Technical Elective 4", 3, []).
course(sd102, "21st Century Skills", 0, []).

% Semester 7
course(it451, "Information Technology Infrastructure", 3, []).
course(cc425, "Parallel & Distributed Computing", 3, [cc323]).
course(technical_elective_5, "Technical Elective 5", 3, []).
course(technical_elective_6, "Technical Elective 6", 3, []).
course(cc491, "Final Year Project – I / COOP-I", 2, []).

% Semester 8
course(university_elective_2, "University Elective 2", 3, []).
course(technical_elective_7, "Technical Elective 7", 3, []).
course(cc492, "Final Year Project – II / COOP-II", 4, [cc491]).

% Semesters
semester(1, [cc120, cc120l, cc111, cc111l, ma107, en110, isl112, pol121]).
semester(2, [ns125, ns125l, cc112, cc112l, ma108, en123, cc121, cc121l, cc141]).
semester(3, [cc213, cc213l, cc222, cc222l, cc281, sd210, ma150, ma210]).
semester(4, [cc230, cc230l, cc251, cc251l, technical_elective_1, hu201, it291, it291l, university_elective_1]).
semester(5, [it331, it331l, cc361, cc371, cc323, cc323l, mg224, technical_elective_2, sd100]).
semester(6, [it321, it321l, cy361, cy361l, cc342, en220, technical_elective_3, technical_elective_4, sd102]).
semester(7, [it451, cc425, technical_elective_5, technical_elective_6, cc491]).
semester(8, [university_elective_2, technical_elective_7, cc492]).

% Rules remain the same as in the previous implementation.

% Rules

% Rule to fetch complete semester-wise roadmap
get_full_semester_roadmap(SemesterRoadmap) :-
    findall((Semester, CourseDetails),
            (semester(Semester, Courses),
             findall((Code, Title, CreditHours, Prerequisites),
                     (member(Code, Courses), 
                      course(Code, Title, CreditHours, Prerequisites)),
                     CourseDetails)),
            SemesterRoadmap).


% Function to get prerequisites by course code
get_prerequisite_by_code(Code, Prerequisites) :-
    course(Code, _, _, Prerequisites).

% Function to list courses with no prerequisites
get_courses_no_prerequisite(Semester, Code, Title, CreditHours) :-
    semester(Semester, Courses),
    member(Code, Courses),
    course(Code, Title, CreditHours, []).

% Function to calculate total credit hours per semester
total_credit_hours(Semester, TotalCreditHours) :-
    semester(Semester, Courses),
    findall(CreditHours, (member(Code, Courses), course(Code, _, CreditHours, _)), Credits),
    sum_list(Credits, TotalCreditHours).

% Function to get all courses in a semester
get_all_courses(Semester, CoursesList) :-
    semester(Semester, Courses),
    findall((Code, Title, CreditHours), (member(Code, Courses), course(Code, Title, CreditHours, _)), CoursesList).

% Rule to get all courses by entering a semester number
get_courses_by_semester(Semester, CoursesList) :-
    semester(Semester, Courses),
    findall((Code, Title, CreditHours, Prerequisites),
            (member(Code, Courses), course(Code, Title, CreditHours, Prerequisites)),
            CoursesList).

% Rule to get only course names by entering a semester number
get_course_names_by_semester(Semester, CourseNames) :-
    semester(Semester, Courses),
    findall(Title, (member(Code, Courses), course(Code, Title, _, _)), CourseNames).

% Function to get the course name and the prerequisites (course names) by a given course name
get_prerequisite_by_name(CourseName, PrerequisiteName) :-
    course(Code, CourseName, _, Prerequisites),
    member(PrerequisiteCode, Prerequisites),
    course(PrerequisiteCode, PrerequisiteName, _, _).

