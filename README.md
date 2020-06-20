# Database "Students grade books"
This database allows you to store any information about student and his grade book, even info that are located directly in grade book(marks,faculty,institute,speciality,subjects, etc.). Functionallity of the database can be extended to solve some others problems.

---

##### Tables that database contains
- institutes
- institutes_has_faculties
- faculties
- specialities
- students
- institutes_has_students
- faculties_has_students
- specialities_has_students
- exam_books
- exams
- practices
- teachers
- graduate_work
- attestations
- exam_regulation
- exam_regulation_has_teachers
![](http://pixs.ru/images/2019/12/16/ER-diagram.png)
---
To see all info of grade book and exams use the following code:
```sql
SELECT * 
FROM exam_books 
join exams on exam_books_id = exam_books.id
```
To see all names and surnames of students of some speciality:
```sql
SELECT `name`,`surname` 
FROM students 
join specialities_has_students on specialities_id = 1
```
To take data of students name,surname, subjects(exams) name and its marks:
```sql
SELECT students.id,`name`,`surname`,exams.title,exams.number_of_points 
FROM students 
join exam_books on students_id = students.id 
join exams on exam_books_id = exam_books.id
```
To get all students who are studying in PNU:
```sql
SELECT students.*, institutes.name as institute_name FROM institutes_has_students
JOIN students ON students.id=institutes_has_students.students_id
JOIN institutes ON institutes.id=institutes_has_students.institutes_id
WHERE institutes.name = 'ПНУ'
```
To get all students who are studying in PNU, mathematics and informatics faculty:
```sql
SELECT students.*, institutes.name as institute_name, faculties.name as faculty_name FROM institutes_has_faculties
JOIN faculties ON faculties.id=institutes_has_faculties.faculties_id
JOIN institutes ON institutes.id=institutes_has_faculties.institutes_id
JOIN faculties_has_students ON faculties_has_students.faculties_id=faculties.id
JOIN students ON faculties_has_students.students_id=students.id
WHERE institutes.name = 'ПНУ' 
AND faculties.name = 'Математики та інформатики'
```
