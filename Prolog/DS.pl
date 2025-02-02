:- discontiguous course/4.
:- discontiguous semester/2.

% Facts: Course Code, Course Title, Credit Hours, Prerequisites

% Semester 1
course(cc1021, 'Programming Fundamentals', 3, []).
course(cc1021l, 'Programming Fundamentals Lab', 1, [cc1021]).
course(ma100, 'Calculus and Analytical Geometry (Calculus 1)', 3, []).
course(it1091, 'Introduction to ICT', 2, []).
course(it1091l, 'Introduction to ICT Lab', 1, [it1091]).
course(en111, 'English Grammar and Comprehension', 3, []).
course(isl101, 'Islamic Studies', 3, []).

% Semester 2
course(en125, 'Communication & Presentation Skills', 3, [en111]).
course(cs2031, 'Digital Logic Design', 3, []).
course(cs2031l, 'Digital Logic Design Lab', 1, [cs2031]).
course(cc1022, 'Object Oriented Programming', 3, [cc1021]).
course(cc1022l, 'Object Oriented Programming Lab', 1, [cc1022]).
course(ma150, 'Probability & Statistics', 3, []).
course(cc1041, 'Discrete Structures', 3, []).

% Semester 3
course(cc2042, 'Data Structures and Algorithms', 3, [cc1022]).
course(cc2042l, 'Data Structures and Algorithms Lab', 1, [cc2042]).
course(pol101, 'Pakistan Studies', 3, []).
course(ds2136, 'Introduction to Data Science', 3, []).
course(cc3071, 'Computer Networks', 3, []).
course(cc3071l, 'Computer Networks Lab', 1, [cc3071]).
course(ma210, 'Linear Algebra', 3, [ma100]).

% Semester 4
course(cc2141, 'Database Systems', 3, []).
course(cc2141l, 'Database Systems Lab', 1, [cc2141]).
course(cs2032, 'Computer Organization and Assembly Language', 3, []).
course(cs2032l, 'Computer Organization and Assembly Language Lab', 1, [cs2032]).
course(en220, 'Technical & Business Writing', 3, [en125]).
course(ma230, 'Differential Equations', 3, []).
course(cs3151, 'Artificial Intelligence', 3, [cc2042]).
course(cs3151l, 'Artificial Intelligence Lab', 1, [cs3151]).

% Semester 5
course(cc3011, 'Operating Systems', 3, [cc2042]).
course(cc3011l, 'Operating Systems Lab', 1, [cc3011]).
course(cs458, 'Data Mining', 3, [ma150, ds2136]).
course(ds3052, 'Advance Statistics', 3, [ma150]).
course(ds_elective1, 'DS Elective 1', 3, []).
course(ds_elective2, 'DS Elective 2', 3, []).
course(ue1, 'University Elective 1', 3, []).

% Semester 6
course(hu4092, 'Professional Practices', 3, []).
course(cc2101, 'Software Engineering', 3, []).
course(ds3137, 'Data Warehousing & Business Intelligence', 3, []).
course(ds_elective3, 'DS Elective 3', 3, []).
course(ds_elective4, 'DS Elective 4', 3, []).
course(ue2, 'University Elective 2', 3, []).

% Semester 7
course(fyp1, 'Final Year Project - I', 3, []).
course(ds3139, 'Data Visualization', 3, [ds3137]).
course(ue3, 'University Elective 3', 3, []).
course(cs4134, 'Big Data Analytics', 3, [ds2136]).
course(cs3044, 'Analysis of Algorithms', 3, [cc2042]).
course(sd100, 'English Immersion', 0, []).

% Semester 8
course(fyp2, 'Final Year Project - II', 3, [fyp1]).
course(ue4, 'University Elective 4', 3, []).
course(cs4172, 'Parallel and Distributed Computing', 3, [cc3011]).
course(cc3121, 'Information Security', 3, []).
course(sd101, '21st Century', 0, []).

% Semester-wise course mapping
semester(1, [cc1021, cc1021l, ma100, it1091, it1091l, en111, isl101]).
semester(2, [en125, cs2031, cs2031l, cc1022, cc1022l, ma150, cc1041]).
semester(3, [cc2042, cc2042l, pol101, ds2136, cc3071, cc3071l, ma210]).
semester(4, [cc2141, cc2141l, cs2032, cs2032l, en220, ma230, cs3151, cs3151l]).
semester(5, [cc3011, cc3011l, cs458, ds3052, ds_elective1, ds_elective2, ue1]).
semester(6, [hu4092, cc2101, ds3137, ds_elective3, ds_elective4, ue2]).
semester(7, [fyp1, ds3139, ue3, cs4134, cs3044, sd100]).
semester(8, [fyp2, ue4, cs4172, cc3121, sd101]).

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

