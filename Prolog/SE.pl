:- discontiguous course/4.
:- discontiguous semester/2.

% Facts for all semester courses

% Semester I
course(it1091, "Introduction to Info & Comm. Technologies", 2, []).
course(it1091l, "Introduction to Info & Comm. Technologies Lab", 1, []).
course(cc1021, "Programming Fundamentals", 3, []).
course(cc1021l, "Programming Fundamentals Lab", 1, []).
course(ma107, "Calculus and Analytical Geometry", 3, []).
course(en111, "English Grammar & Comprehension", 3, []).
course(isl101, "Islamic Studies", 3, []).

% Semester II
course(cc1022, "Object Oriented Programming", 3, [cc1021, cc1021l]).
course(cc1022l, "Object Oriented Programming Lab", 1, [cc1021, cc1021l]).
course(cc1041, "Discrete Structures", 3, []).
course(en125, "Composition & Communication", 3, [en111]).
course(ns125, "Applied Physics", 2, []).
course(ns125l, "Applied Physics Lab", 1, []).
course(pol101, "Pakistan Studies", 3, []).

% Semester III
course(cc2042, "Data Structures and Algorithms", 3, [cc1022, cc1022l]).
course(cc2042l, "Data Structures and Algorithms Lab", 1, [cc1022, cc1022l]).
course(ma210, "Linear Algebra", 3, []).
course(cc2101, "Software Engineering", 3, []).
course(en220, "Research Paper Writing & Presentation", 3, [en125]).
course(ge1, "GE/University Elective-I", 3, []).

% Semester IV
course(cc2141, "Database Systems", 3, [cc2042, cc2042l]).
course(cc2141l, "Database Systems Lab", 1, [cc2042, cc2042l]).
course(ma150, "Probability and Statistics", 3, []).
course(se2102, "Software Requirement Engineering (SRE)", 3, [cc2101]).
course(ge2, "GE/University Elective-II", 3, []).
course(supporting1, "Supporting Elective-I", 3, []).

% Semester V
course(se3103, "Software Design and Architecture", 2, [se2102]).
course(se3103l, "Software Design and Architecture Lab", 1, [se2102]).
course(cc3011, "Operating Systems", 3, [cc2042, cc2042l]).
course(cc3011l, "Operating Systems Lab", 1, [cc2042, cc2042l]).
course(cc3071, "Computer Networks", 3, []).
course(cc3071l, "Computer Networks Lab", 1, []).
course(sd100, "English Immersion", 0, []).
course(ge3, "GE/University Elective-III", 3, []).
course(tech1, "Technical Elective-I", 3, []).

% Semester VI
course(se3111, "Software Construction and Development", 2, [se3103, se3103l]).
course(se3111l, "Software Construction and Development Lab", 1, [se3103, se3103l]).
course(se3162, "Web Engineering", 3, []).
course(se4114, "Human Computer Interaction", 3, [cc2101]).
course(cc3121, "Information Security", 3, []).
course(sd102, "21st Century Skills", 0, []).
course(supporting2, "Supporting Elective-II", 3, []).
course(tech2, "Technical Elective-II", 3, []).

% Semester VII
course(cc4181, "Final Year Project-I", 3, []).
course(se4192, "Software Project Management", 3, [cc2101]).
course(se4112, "Software Quality Engineering", 3, [cc2101]).
course(se4113, "Software Re-Engineering", 3, [se3111, se3111l]).
course(tech3, "Technical Elective-III", 3, []).
course(tech4, "Technical Elective-IV", 3, []).

% Semester VIII
course(cc4182, "Final Year Project-II", 3, [cc4181]).
course(hu4092, "Professional Practices", 3, []).
course(supporting3, "Supporting Elective-III", 3, []).
course(ge4, "GE/University Elective-IV", 3, []).
course(tech5, "Technical Elective-V", 3, []).

% Semesters
semester(1, [it1091, it1091l, cc1021, cc1021l, ma107, en111, isl101]).
semester(2, [cc1022, cc1022l, cc1041, en125, ns125, ns125l, pol101]).
semester(3, [cc2042, cc2042l, ma210, cc2101, en220, ge1]).
semester(4, [cc2141, cc2141l, ma150, se2102, ge2, supporting1]).
semester(5, [se3103, se3103l, cc3011, cc3011l, cc3071, cc3071l, sd100, ge3, tech1]).
semester(6, [se3111, se3111l, se3162, se4114, cc3121, sd102, supporting2, tech2]).
semester(7, [cc4181, se4192, se4112, se4113, tech3, tech4]).
semester(8, [cc4182, hu4092, supporting3, ge4, tech5]).

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

% Function to calculate total credit hours per semester
total_credit_hours(Semester, TotalCreditHours) :-
    semester(Semester, Courses),
    findall(CreditHours, (member(Code, Courses), course(Code, _, CreditHours, _)), Credits),
    sum_list(Credits, TotalCreditHours).

% Function to list courses with no prerequisites
get_courses_no_prerequisite(Semester, Code, Title, CreditHours) :-
    semester(Semester, Courses),
    member(Code, Courses),
    course(Code, Title, CreditHours, []).

% Function to get all courses in a semester
get_all_courses(Semester, CoursesList) :-
    semester(Semester, Courses),
    findall((Code, Title, CreditHours), (member(Code, Courses), course(Code, Title, CreditHours, _)), CoursesList).

% Function to get only course names by semester
get_course_names_by_semester(Semester, CourseNames) :-
    semester(Semester, Courses),
    findall(Title, (member(Code, Courses), course(Code, Title, _, _)), CourseNames).
