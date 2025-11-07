# Create students table
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    enrollment_date DATE
);

# Populate table with provided data
INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-09-01'),
('Jim', 'Beam', 'jim.beam@example.com', '2023-09-02');

# Retrieves and displays all records from the students table.
CREATE OR REPLACE FUNCTION getAllStudents()
RETURNS TABLE (
    student_id INT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    enrollment_date DATE
)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT *
    FROM students;
END;
$$;

# Inserts a new student record into the students table.
CREATE OR REPLACE FUNCTION addStudent(fname TEXT, lname TEXT, new_mail TEXT, new_date DATE)
RETURNS VOID AS $$
BEGIN
    INSERT INTO students (first_name, last_name, email, enrollment_date)
    VALUES (fname, lname, new_mail, new_date);
END;
$$ LANGUAGE plpgsql;

# Updates the email address for a student with the specified student_id.
CREATE OR REPLACE FUNCTION updateStudentEmail(stu_id INTEGER, new_email TEXT)
RETURNS VOID AS $$
BEGIN
    UPDATE students
    SET email = new_email
    WHERE student_id = stu_id;
END;
$$ LANGUAGE plpgsql;

# Deletes the record of the student with the specified student_id.
CREATE OR REPLACE FUNCTION deleteStudent(stu_id INTEGER)
RETURNS VOID AS $$
BEGIN
    DELETE FROM students
    WHERE student_id = stu_id;
END;
$$ LANGUAGE plpgsql;

SELECT addStudent('Gee', 'Gee', 'g@geemail.com', '2023-08-08');
SELECT updateStudentEmail(1, 'johnny@mail.com');
SELECT deleteStudent(3);
SELECT * FROM getAllStudents()
    ORDER BY student_id;