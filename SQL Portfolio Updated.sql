/* ============================================================
   Business Problem 1:
   For each instructor, show how many total students they teach
   and the average grade those students have
   ============================================================ */

SELECT 
    i.first_name || ' ' || i.last_name AS instructor_name,
    COUNT(DISTINCT e.student_id) AS total_students,
    ROUND(AVG(g.numeric_grade), 2) AS average_grade
FROM instructor i
LEFT JOIN section sec ON i.instructor_id = sec.instructor_id
LEFT JOIN enrollment e ON sec.section_id = e.section_id
LEFT JOIN grade g ON e.student_id = g.student_id
GROUP BY i.first_name, i.last_name
ORDER BY instructor_name;



/* ============================================================
   Business Problem 2:
   Show each instructor’s name, the course they teach,
   and the names of the students enrolled
   ============================================================ */

SELECT 
    i.first_name || ' ' || i.last_name AS instructor_name,
    c.description AS course_name,
    s.first_name || ' ' || s.last_name AS student_name
FROM instructor i
LEFT JOIN section sec ON i.instructor_id = sec.instructor_id
LEFT JOIN course c ON sec.course_no = c.course_no
LEFT JOIN enrollment e ON sec.section_id = e.section_id
LEFT JOIN student s ON e.student_id = s.student_id
ORDER BY instructor_name, course_name, student_name;



/* ============================================================
   You need to know student #102’s grades for each grading category (homework, quiz, etc.) in
all of their courses. Display the section ID, grading category (i.e., the description of that grade
type, not the shorter grade type code!), grade code occurrence (e.g., was it homework 1, 2, 3,
or 4), and their numeric grade for that grading category and occurrence. Order the results by
section, category description, and grade code occurrence
   ============================================================ */

SELECT 
    g.section_id,
    gt.description,
    g.grade_code_occurrence,
    g.numeric_grade
FROM grade g
JOIN grade_type gt USING (grade_type_code)
WHERE g.student_id = 102
ORDER BY g.section_id, gt.description, g.grade_code_occurrence;



/* ============================================================
  Which courses meet in location L509? Display the course number, course description, and
location (as a check that your query is correct). Order the results by course number only.
   ============================================================ */

SELECT 
    c.course_no,
    c.description,
    s.location
FROM course c
JOIN section s USING (course_no)
WHERE s.location = 'L509'
ORDER BY c.course_no;



/* ============================================================
  What courses is student #270 enrolled in? Display the course name, section number (NOT
section ID!) and date they enrolled. Order the results by date enrolled (in case they didn’t
register for all of their courses on the same day), followed by course name and section number.
NOTE: This query will require joining THREE tables, not two!
   ============================================================ */

SELECT 
    c.description,
    s.section_no,
    e.enroll_date
FROM course c
JOIN section s ON c.course_no = s.course_no
JOIN enrollment e ON s.section_id = e.section_id
WHERE e.student_id = 270
ORDER BY e.enroll_date, c.description, s.section_no;




/* ============================================================
   List the names of all instructors whose records were entered into the system (i.e., created) on
March 11, 2007. Show their salutation, first and last names (concatenated together with a space in
between), and the record creation date (formatted exactly as shown here: “March 11, 2007”). Don’t
forget to clean up your column headings. Order results by name (alphabetical).
   ============================================================ */

SELECT 
    salutation || '. ' || first_name || ' ' || last_name AS "Instructor Name",
    TO_CHAR(created_date, 'fmMonth DD, YYYY') AS "Date"
FROM instructor
WHERE created_date = '11-MAR-2007'
ORDER BY last_name, first_name;



/* ============================================================
   Which courses have a prerequisite of Intro to SQL? Show the course number, description, and cost
of the course. Display the cost with a dollar sign, commas in the right locations, a period in the
right location, and always 2 decimal places. Order results by most expensive courses first, then by
course number.
   ============================================================ */

SELECT 
    description || ' has a prerequisite in Intro to SQL. The cost is ' || 
    TO_CHAR(cost, '$9,999.00') AS "Classes that require Intro to SQL as a Prerequisite"
FROM course
WHERE prerequisite = '204'
ORDER BY cost DESC;



/* ============================================================
 Originally I asked you to answer the following question: What is the lowest grade recorded in the
grade table? Now I would like for you to display the result exactly as follows (without the double
quotes):
“The minimum grade found in the GRADE table is a score of 70.”
   ============================================================ */

SELECT 
    'The minimum grade found in the GRADE table is a score of ' || 
    MIN(numeric_grade)
FROM grade;



/* ============================================================
   Originally I asked you to list all courses whose name (i.e., description) starts with “Intro” and only
cost $1095. This time, display all courses whose name (i.e., description) starts with Intro, and also
show the cost. Make sure the cost displays with a dollar sign, commas in the correct places, a
period in the correct place, and no decimal places if not needed
   ============================================================ */

SELECT 
    description || ' costs ' || TO_CHAR(cost, '$9,999') AS "Courses that start with Intro"
FROM course
WHERE description LIKE 'Intro%'
ORDER BY description, cost;



/* ============================================================
   Which classes has student #102 enrolled in? Show the student’s name (concatenated together with
a space between), the section ID, and the enrollment date for each section formatted as
MM/DD/YY. Don’t forget to clean up your column headings.

   ============================================================ */

SELECT 
    s.first_name || ' ' || s.last_name AS "Student Name",
    e.section_id AS "Section ID",
    TO_CHAR(e.enroll_date, 'MM/DD/YY') AS "Enrollment Date"
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
WHERE s.student_id = 102
ORDER BY e.section_id;
