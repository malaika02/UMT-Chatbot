% Ensure discontiguous predicates to avoid warnings
:- discontiguous course/4.
:- discontiguous semester/2.

% ------------------------------
% Facts: Course Code, Course Title, Credit Hours, Prerequisites
% ------------------------------

% 1st Semester Courses
course(cc120, 'Application of Information & Communication Technologies', 2, []).
course(cc120l, 'Application of Information & Communication Technologies Lab', 1, []).
course(cc111, 'Programming Fundamentals', 3, []).
course(cc111l, 'Programming Fundamentals Lab', 1, []).
course(ma107, 'Calculus and Analytical Geometry', 3, []).
course(en111, 'English-I', 3, []).
course(isl104, 'Islamic Thought and Perspectives', 3, []).
course(pol106, 'Pakistan: Ideology, Constitution, and Society', 3, []).

% 2nd Semester Courses
course(ns125, 'Applied Physics', 2, []).
course(ns125l, 'Applied Physics Lab', 1, []).
course(cc112, 'Object Oriented Programming', 3, [cc111, cc111l]).
course(cc112l, 'Object Oriented Programming Lab', 1, [cc111, cc111l]).
course(ma108, 'Multivariable Calculus', 3, [ma107]).
course(en125, 'English-II', 3, [en111]).
course(ma150, 'Probability and Statistics', 3, []).
course(cc141, 'Quantitative Reasoning - 1 (Discrete Structures)', 3, []).

% 3rd Semester Courses
course(cc213, 'Data Structures', 3, [cc112, cc112l]).
course(cc213l, 'Data Structures Lab', 1, [cc112, cc112l]).
course(cc121, 'Digital Logic Design', 2, []).
course(cc121l, 'Digital Logic Design Lab', 1, []).
course(cc281, 'Software Engineering', 3, []).
course(ss103, 'Civics and Community Engagement', 2, []).
course(cc361, 'Information Security', 3, []).
course(ma210, 'Linear Algebra', 3, [ma107]).

% 4th Semester Courses
course(cc230, 'Database Systems', 3, []).
course(cc230l, 'Database Systems Lab', 1, []).
course(cc222, 'Computer Organization and Assembly Language', 2, [cc121, cc121l]).
course(cc222l, 'Computer Organization and Assembly Language Lab', 1, [cc121, cc121l]).
course(te1, 'Technical Elective 1 (Open-Source Software Development)', 3, []).
course(hu201, 'Professional Practices', 3, []).
course(cy261, 'Information Assurance', 2, []).
course(cy261l, 'Information Assurance Lab', 1, []).
course(cc251, 'Computer Networks', 2, []).
course(cc251l, 'Computer Networks Lab', 1, []).

% 5th Semester Courses
course(cy361, 'Cyber Security', 2, [cc361]).
course(cy361l, 'Cyber Security Lab', 1, [cc361]).
course(cc323, 'Operating Systems', 3, []).
course(cc323l, 'Operating Systems Lab', 1, []).
course(cc371, 'Artificial Intelligence', 3, [cc213, cc213l]).
course(te2, 'Technical Elective 2', 3, []).
course(en220, 'Technical & Business Writing', 3, [en125]).
course(mg365, 'Innovation and Entrepreneurship', 3, []).
course(sd100, 'English Immersion', 0, []).

% 6th Semester Courses
course(cy391, 'Secure Software Design and Development', 2, [cy361, cy361l]).
course(cy391l, 'Secure Software Design and Development Lab', 1, [cy361, cy361l]).
course(cy351, 'Network Security', 3, [cy361, cy361l]).
course(cc342, 'Analysis of Algorithms', 3, [cc213, cc213l]).
course(ue1, 'University Elective 1', 3, []).
course(te3, 'Technical Elective 3', 3, []).
course(te4, 'Technical Elective 4', 3, []).
course(sd101, '21st Century Skills', 0, []).

% 7th Semester Courses
course(cy461, 'Digital Forensics', 3, [cy361, cy361l]).
course(cc425, 'Parallel & Distributed Computing', 3, [cc323, cc323l]).
course(te5, 'Technical Elective 5', 3, []).
course(te6, 'Technical Elective 6', 3, []).
course(cc491, 'Final Year Project - I / COOP-I*', 2, []).

% 8th Semester Courses
course(ue2, 'University Elective 2', 3, []).
course(te7, 'Technical Elective 7', 3, []).
course(cc492, 'Final Year Project - II / COOP-II*', 4, [cc491]).

% ------------------------------
% Semester-wise Course Mapping
% ------------------------------
semester(1, [cc120, cc120l, cc111, cc111l, ma107, en111, isl104, pol106]).
semester(2, [ns125, ns125l, cc112, cc112l, ma108, en125, ma150, cc141]).
semester(3, [cc213, cc213l, cc121, cc121l, cc281, ss103, cc361, ma210]).
semester(4, [cc230, cc230l, cc222, cc222l, te1, hu201, cy261, cy261l, cc251, cc251l]).
semester(5, [cy361, cy361l, cc323, cc323l, cc371, te2, en220, mg365, sd100]).
semester(6, [cy391, cy391l, cy351, cc342, ue1, te3, te4, sd101]).
semester(7, [cy461, cc425, te5, te6, cc491]).
semester(8, [ue2, te7, cc492]).

% ------------------------------
% Rules
% ------------------------------

% Rule to fetch complete semester-wise roadmap
get_full_semester_roadmap(SemesterRoadmap) :-
    findall((Semester, CourseDetails),
            (semester(Semester, Courses),
             findall((Code, Title, CreditHours, Prerequisites),
                     (member(Code, Courses), 
                      course(Code, Title, CreditHours, Prerequisites)),
                     CourseDetails)),
            SemesterRoadmap).


% Rule to get prerequisites by course code
get_prerequisite_by_code(Code, Prerequisites) :-
    course(Code, _, _, Prerequisites).

% Rule to calculate total credit hours per semester
total_credit_hours(Semester, TotalCreditHours) :-
    semester(Semester, Courses),
    findall(CreditHours, (member(Code, Courses), course(Code, _, CreditHours, _)), Credits),
    sum_list(Credits, TotalCreditHours).

% Rule to list courses with no prerequisites
get_courses_no_prerequisite(Semester, Code, Title, CreditHours) :-
    semester(Semester, Courses),
    member(Code, Courses),
    course(Code, Title, CreditHours, []).

% Rule to get all courses in a semester (code, title, credit hours)
get_all_courses(Semester, CoursesList) :-
    semester(Semester, Courses),
    findall((Code, Title, CreditHours), 
            (member(Code, Courses), course(Code, Title, CreditHours, _)), 
            CoursesList).

% Rule to get only course names by semester
get_course_names_by_semester(Semester, CourseNames) :-
    semester(Semester, Courses),
    findall(Title, (member(Code, Courses), course(Code, Title, _, _)), CourseNames).
