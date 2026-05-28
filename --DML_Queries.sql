--DML 
--Displaying all columns from students table 
SELECT * FROM STUDENTS;

--Display only:
    -- - student_name
    -- - gpa GPA > 3.5

SELECT STUDENT_NAME, GPA FROM STUDENTS
WHERE GPA > 3.5;

--Inner Join
SELECT STUDENT_NAME, COURSE_ID,SEMESTER,GPA, GRADE
FROM ENROLLMENTS INNER JOIN STUDENTS
              --FK                   --PK
on ENROLLMENTS.STUDENT_ID = STUDENTS.STUDENT_ID;

--Inner Join -Courses which students enrolled in only 
SELECT DISTINCT COURSE_NAME
FROM ENROLLMENTS INNER JOIN COURSES
   --table where the  foreign appears.FK = table where the PK appears.PK 
ON ENROLLMENTS.COURSE_ID = COURSES.COURSE_ID;

---Left outer Join 
SELECT COURSE_NAME, INSTRUCTOR, SEMESTER
FROM COURSES  LEFT JOIN ENROLLMENTS
ON ENROLLMENTS.COURSE_ID = COURSES.COURSE_ID;


--Displaying all courses names:
SELECT COURSE_NAME FROM COURSES;


-- Display all enrollments from `Fall 2025`. 
SELECT * FROM ENROLLMENTS
WHERE SEMESTER = 'Fall 2025';

--Display all students older than 21.
SELECT * FROM STUDENTS
WHERE AGE >21;


SELECT * FROM COURSES
WHERE CREDIT_HOURS = 4;

SELECT * FROM STUDENTS
WHERE MAJOR = 'Engineering';


--Below 2 Queries are the same but, the first ordered ascendingly and the 2nd Descendingly(DESC)
SELECT * FROM STUDENTS
WHERE 20 <= AGE  AND AGE <= 22
ORDER BY AGE;

SELECt * FROM STUDENTS
WHERE AGE BETWEEN 20 AND 22
ORDER BY AGE DESC;


 --Students + their Enrolled Courses only

SELECT c.course_name,
       x.student_name
FROM
(
    SELECT e.course_id,
           s.student_name
    FROM students s
    INNER JOIN enrollments e
    ON e.student_id = s.student_id
) x --I gave the yielded table a name to use it with the 2nd inner Join 
INNER JOIN courses c
ON x.course_id = c.course_id;



--Only extract the courses names of the Student Ahmed 
SELECT COURSE_NAME, STUDENT_NAME
FROM 
--The previous SQL Block but, gave this a table alias: 'T'
    (SELECT c.course_name,
        x.student_name
    FROM
    (
        SELECT e.course_id,
            s.student_name
        FROM students s
        INNER JOIN enrollments e
        ON e.student_id = s.student_id
    ) x --I gave the yielded table a name to use it with the 2nd inner Join 
    INNER JOIN courses c
    ON x.course_id = c.course_id) T --Table Alias to the yielded table.
WHERE STUDENT_NAME = 'Ahmed Hassan';


--Query: Show all students even if they're not enrolled
--Students(left table) -- Enrollements(Right table)
--All students(focusing on outer left Join)
SELECT   STUDENT_NAME, ENROLLMENT_ID, COURSE_ID, grade
FROM STUDENTS LEFT JOIN ENROLLMENTS
ON ENROLLMENTS.STUDENT_ID = STUDENTS.STUDENT_ID;

---Show all enrollments even if student data is missing.
SELECT ENROLLMENT_ID, STUDENT_NAME, COURSE_ID, grade
FROM STUDENTS RIGHT JOIN ENROLLMENTS
ON ENROLLMENTS.STUDENT_ID = STUDENTS.STUDENT_ID;


---FULL OUTER JOIN (Show ALL students and ALL enrollments. unmatched students - unmatched enrollments)
SELECT ENROLLMENT_ID, STUDENT_NAME, COURSE_ID, grade
FROM STUDENTS FULL OUTER JOIN ENROLLMENTS
ON ENROLLMENTS.STUDENT_ID = STUDENTS.STUDENT_ID;

--Students WITHOUT enrollments

SELECT STUDENT_NAME, ENROLLMENT_ID FROM
(SELECT STUDENT_NAME, ENROLLMENT_ID
FROM STUDENTS LEFT JOIN ENROLLMENTS
ON ENROLLMENTS.STUDENT_ID = STUDENTS.STUDENT_ID) 
WHERE ENROLLMENT_ID IS NULL;

--Courses WITHOUT students 
SELECT COURSE_NAME, ENROLLMENT_ID 
FROM 
(SELECT  COURSE_NAME, ENROLLMENT_ID
FROM ENROLLMENTS RIGHT JOIN COURSES
ON ENROLLMENTS.COURSE_ID = COURSES.COURSE_ID)
WHERE ENROLLMENT_ID IS NULL;

--Count Enrollement Per Course
SELECT COURSE_NAME, COUNT(ENROLLMENT_ID) AS Total_Enrollments
FROM ENROLLMENTS RIGHT JOIN COURSES
ON ENROLLMENTS.COURSE_ID = COURSES.COURSE_ID
GROUP BY COURSE_NAME;

--Show only courses with more than 1 enrollment: (JOIN, GROUP BY, HAVING Together)
SELECT COURSE_NAME, COUNT(ENROLLMENT_ID) AS Total_Enrollments
FROM ENROLLMENTS RIGHT JOIN COURSES
ON ENROLLMENTS.COURSE_ID = COURSES.COURSE_ID
GROUP BY COURSE_NAME
HAVING COUNT(ENROLLMENT_ID) > 1;

