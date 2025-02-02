:- discontiguous course/4.
:- discontiguous semester/2.

% Facts for all semester courses

% Semester I
course(it1091, "Introduction to ICT", 2, []).
course(it1091l, "Introduction to ICT Lab", 1, []).
course(cc1021, "Programming Fundamentals", 3, []).
course(cc1021l, "Programming Fundamentals Lab", 1, []).
course(en111, "English Grammar and Comprehension", 3, []).
course(ma107, "Calculus and Analytical Geometry", 3, []).
course(pol101, "Pak Studies", 3, []).

% Semester II
course(cc1022, "Object Oriented Programming", 3, [cc1021]).
course(cc1022l, "Object Oriented Programming Lab", 1, [cc1021l]).
course(cs2031, "Digital Logic Design", 3, []).
course(cs2031l, "Digital Logic Design Lab", 1, []).
course(ma210, "Linear Algebra", 3, [ma107]).
course(en125, "Composition and Communication", 3, [en111]).

% Semester III
course(cc2042, "Data Structure & Algorithms", 3, [cc1022]).
course(cc2042l, "Data Structures & Algorithms Lab", 1, [cc1022l]).
course(cc2141, "Database Systems", 3, []).
course(cc2141l, "Database Systems Lab", 1, []).
course(ai2151, "Artificial Intelligence", 3, [cc1022]).
course(ai2151l, "Artificial Intelligence Lab", 1, [cc1022l]).
course(ma150, "Probability & Statistics", 3, [ma107]).
course(ma230, "Differential Equations", 3, [ma107]).

% Semester IV
course(cc3071, "Computer Networks", 3, []).
course(cc3071l, "Computer Networks Lab", 1, []).
course(cs2032, "Computer Organization and Assembly Language", 3, [cs2031]).
course(cs2032l, "Computer Organization and Assembly Language Lab", 1, [cs2031l]).
course(cs3044, "Analysis of Algorithms", 3, [cc2042]).
course(ai2101, "Programming for Artificial Intelligence", 2, [ai2151]).
course(ai2101l, "Programming for Artificial Intelligence Lab", 1, [ai2151]).

% Semester V
course(cc3011, "Operating System", 3, [cc2042]).
course(cc3011l, "Operating System Lab", 1, [cc2042l]).
course(cc2101, "Machine Learning", 2, [ai2151]).
course(cc2101l, "Machine Learning Lab", 1, [ai2151l]).
course(ai4152, "Deep Learning and Neural Networks", 3, [ai2151]).
course(cc3121, "Information Security", 3, []).
course(university_elective_1, "University Elective-1", 3, []).

% Semester VI
course(cs4172, "Parallel & Distributed Computing", 2, [cc1022, cc3011]).
course(cs4172l, "Parallel & Distributed Computing Lab", 1, [cc1022l, cc3011l]).
course(cs4013, "Computer Vision", 2, []).
course(cs4013l, "Computer Vision Lab", 1, []).
course(cs4156, "Natural Language Processing", 3, [ai2151]).
course(cs4172, "Knowledge Representation & Reasoning", 3, [ai2151]).
course(ai4165, "AI Elective-1", 3, []).

% Semester VII
course(cc4981, "Capstone Project Part I", 3, []).
course(en220, "Research Paper Writing and Presentation", 3, []).
course(sd100, "English Immersion", 0, []).
course(isl101, "Islamic Studies", 3, []).
course(ai4172, "AI Elective-2", 3, []).
course(ai4173, "AI Elective-3", 3, []).

% Semester VIII
course(cc4991, "Capstone Project Part II", 3, [cc4981]).
course(hu4092, "Professional Practices", 3, []).
course(university_elective_2, "University Elective-2", 3, []).
course(ai4174, "AI Elective-4", 3, []).
course(sd102, "21st Century Skills", 0, []).

% Semesters
semester(1, [it1091, it1091l, cc1021, cc1021l, en111, ma107, pol101]).
semester(2, [cc1022, cc1022l, cs2031, cs2031l, ma210, en125]).
semester(3, [cc2042, cc2042l, cc2141, cc2141l, ai2151, ai2151l, ma150, ma230]).
semester(4, [cc3071, cc3071l, cs2032, cs2032l, cs3044, ai2101, ai2101l]).
semester(5, [cc3011, cc3011l, cc2101, cc2101l, ai4152, cc3121, university_elective_1]).
semester(6, [cs4172, cs4172l, cs4013, cs4013l, cs4156, cs4172, ai4165]).
semester(7, [cc4981, en220, sd100, isl101, ai4172, ai4173]).
semester(8, [cc4991, hu4092, university_elective_2, ai4174, sd102]).

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

% Function to check prerequisites by course name and return the course name of the prerequisites
get_prerequisite_by_name(CourseName, PrerequisiteName) :-
    course(Code, CourseName, _, Prerequisites),
    member(PrerequisiteCode, Prerequisites),
    course(PrerequisiteCode, PrerequisiteName, _, _).
