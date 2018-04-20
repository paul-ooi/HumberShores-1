CREATE TABLE departments (
    dept_id INT IDENTITY(1,1) NOT NULL UNIQUE,
    dept_name VARCHAR(20) NOT NULL UNIQUE,
    dept_head INT NOT NULL,
    dept_phone_ext VARCHAR(5) NOT NULL UNIQUE, 
    dept_desc VARCHAR(MAX) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_id),
    CONSTRAINT dept_id_check CHECK(dept_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT dept_name_check CHECK(dept_name NOT LIKE '%[^A-Za-z ]%'),
    CONSTRAINT dept_phone_check CHECK(dept_phone_ext NOT LIKE '%[^0-9]%')
);
CREATE TABLE site_roles (
    role_code CHAR(3) NOT NULL UNIQUE,
    role_name VARCHAR(15) NOT NULL UNIQUE,
    role_description VARCHAR(75) NOT NULL,
    CONSTRAINT pk_site_roles PRIMARY KEY (role_code)
);
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) NOT NULL UNIQUE,
    emp_position VARCHAR(20) NOT NULL,
    emp_email VARCHAR(50),
    user_id INT NOT NULL UNIQUE,
    dept_id INT NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_id),
    CONSTRAINT emp_id_check CHECK(emp_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT emp_dept_id_check CHECK(dept_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT emp_position_check CHECK(emp_position NOT LIKE '%[^A-Za-z ]%'),
    CONSTRAINT emp_email_check CHECK(emp_email LIKE '[a-zA-Z0-9]%@[a-zA-Z0-9]%.[a-z][a-z]%')
);
CREATE TABLE site_users (
    user_id INT IDENTITY(1,1) NOT NULL UNIQUE,
    emp_id INT,
    role_code CHAR(3) NOT NULL DEFAULT 'USR',
    user_first_name VARCHAR(15) NOT NULL,
    user_last_name VARCHAR(20) NOT NULL,
    user_dob DATE NOT NULL,
    user_gender VARCHAR(5),
    user_address VARCHAR(30) NOT NULL,
    user_city VARCHAR(15) NOT NULL,
    user_province CHAR(2) NOT NULL,
    user_postal_code CHAR(6) NOT NULL,
    user_email VARCHAR(30) NOT NULL UNIQUE,
    user_username VARCHAR(20) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_phone VARCHAR(15) UNIQUE,
    user_date_joined DATETIME NOT NULL DEFAULT getDate(),
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT user_id_check CHECK(user_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT user_first_check CHECK(user_first_name NOT LIKE '%[^a-zA-Z]%'),
    CONSTRAINT user_last_check CHECK(user_last_name NOT LIKE '%[^a-zA-Z]%'),
    CONSTRAINT user_gender CHECK(user_gender IN ('M', 'F', 'OTHER')),
    CONSTRAINT user_address CHECK(user_address NOT LIKE '%[^a-zA-Z0-9 ]%'),
    CONSTRAINT user_city CHECK(user_city NOT LIKE '%[^a-zA-Z ]%'),
    CONSTRAINT user_province CHECK(user_province IN ('AB', 'BC', 'MB', 'NB', 'NF', 'NS', 'NU', 'NT', 'ON', 'PEI', 'SK', 'QC', 'YK')),
    CONSTRAINT user_postal_code CHECK(user_postal_code NOT LIKE '%^[ABCEGHJ-NPRSTVXY][0-9][ABCEGHJ-NPRSTV-Z] ?[0-9][ABCEGHJ-NPRSTV-Z][0-9]$%'),
    CONSTRAINT user_email_check CHECK(user_email LIKE '[a-zA-Z0-9]%@[a-zA-Z0-9]%.[a-z][a-z]%'),
    CONSTRAINT user_username_check CHECK(user_username NOT LIKE '%[^a-zA-Z0-9]%'),
    CONSTRAINT user_phone_check CHECK(user_phone NOT LIKE '%[^0-9]%'),
    CONSTRAINT user_emp_id_check CHECK(emp_id NOT LIKE '%[^0-9]%')
);
CREATE TABLE announcements (
    ann_id INT IDENTITY(1,1) NOT NULL UNIQUE,
    ann_text VARCHAR(200) NOT NULL,
    ann_date DateTime2 NOT NULL DEFAULT getDate(),
    ann_severity VARCHAR(10) NOT NULL,
    ann_visible BIT NOT NULL DEFAULT 1,
    emp_id INT NOT NULL,
    CONSTRAINT pk_announcements PRIMARY KEY (ann_id),
    CONSTRAINT ann_id_check CHECK(ann_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT ann_severity_check CHECK(ann_severity IN ('Emergency', 'Important', 'Cautionary')),
    CONSTRAINT ann_emp_id_check CHECK(emp_id NOT LIKE '%[^0-9]%')
);
CREATE TABLE appointments (
    app_id INT NOT NULL IDENTITY(1,1) UNIQUE,
    patient_id INT NOT NULL,
    emp_id INT NOT NULL,
    app_date DATE NOT NULL,
    app_time TIME NOT NULL,
    app_reason VARCHAR(100) NOT NULL,
    app_comment VARCHAR(100),
    app_child BIT NOT NULL,
    app_child_first VARCHAR(15),
    app_child_last VARCHAR(20),
    app_child_dob DATE,
    app_child_gender VARCHAR(5),
    CONSTRAINT pk_appointments PRIMARY KEY (app_id),
    CONSTRAINT app_id_check CHECK(app_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT app_user_id_check CHECK(patient_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT app_emp_id_check CHECK(emp_id NOT LIKE '%[^0-9]%'),
    CONSTRAINT app_child CHECK(app_child IN (1, 0)),
    CONSTRAINT app_child_first_check CHECK(app_child_first NOT LIKE '%[^a-zA-Z]%'),
    CONSTRAINT app_child_last_check CHECK(app_child_last NOT LIKE '%[^a-zA-Z]%'),
    CONSTRAINT app_child_gender CHECK(app_child_gender IN ('M', 'F', 'OTHER'))
);
CREATE TABLE physicians (
    doctor_id INT IDENTITY(1,1) NOT NULL UNIQUE,
    emp_id INT NOT NULL UNIQUE,
    department_id INT NOT NULL,
    special1 INT,
    special2 INT,
    phone VARCHAR(30),
    email VARCHAR(50),
    website VARCHAR(100),
    street_address1 VARCHAR(100) NOT NULL,
    street_address2 VARCHAR(100),
    building_name VARCHAR(100),
    city VARCHAR(50),
    province CHAR(2),
    country VARCHAR(50),
    postal_code VARCHAR(7)
    CONSTRAINT pk_physicians PRIMARY KEY (doctor_id),
    CONSTRAINT doc_address1_check CHECK(street_address1 NOT LIKE '%[^a-zA-Z0-9 ]%'),
    CONSTRAINT doc_address2_check CHECK(street_address2 NOT LIKE '%[^a-zA-Z0-9 ]%'),
    CONSTRAINT doc_city_check CHECK(city NOT LIKE '%[^a-zA-Z ]%'),
    CONSTRAINT doc_province_check CHECK(province IN ('AB', 'BC', 'MB', 'NB', 'NF', 'NS', 'NU', 'NT', 'ON', 'PEI', 'SK', 'QC', 'YK')),
    CONSTRAINT doc_email_check CHECK(email LIKE '[a-zA-Z0-9]%@[a-zA-Z0-9]%.[a-z][a-z]%'),
    CONSTRAINT doc_phone_check CHECK(phone NOT LIKE '%[^0-9]%'),
    CONSTRAINT doc_postal_code CHECK(postal_code LIKE '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]' OR postal_code LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
);
CREATE TABLE specialties (
    special_id INT IDENTITY(1,1) NOT NULL UNIQUE,
    specialty_name VARCHAR(30) NOT NULL UNIQUE,
    CONSTRAINT pk_specialties PRIMARY KEY (special_id),
    CONSTRAINT spec_name_check CHECK(specialty_name NOT LIKE '%[^A-Za-z ]%')
);
CREATE TABLE VOLUNTEER (
    VOLUNTEER_ID INT  NOT NULL  PRIMARY KEY IDENTITY(1,1),
    FIRST_NAME VARCHAR(50) NOT NULL CHECK(FIRST_NAME NOT LIKE'%[^A-Z]%'),
    MIDDLE_NAME VARCHAR(50)CHECK(MIDDLE_NAME NOT LIKE '%[^A-Z]%'),   
    LAST_NAME VARCHAR(50) NOT NULL CHECK(LAST_NAME NOT LIKE '%[^A-Z]%'),
    OCCUPATION VARCHAR(50) NOT NULL,
    OPPORTUNITY_ID INT NOT NULL,
    PHONE_NUMBER VARCHAR(25) NOT NULL CHECK(PHONE_NUMBER LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    STREET_ADDRESS VARCHAR(255) NOT NULL ,
    CITY VARCHAR(30) NOT NULL CHECK(CITY NOT LIKE '%[^A-Z]%'),
    PROVINCE VARCHAR(25) NOT NULL CHECK(PROVINCE NOT LIKE '%[^A-Z]%'),
    POSTAL_CODE VARCHAR(10) NOT NULL CHECK(POSTAL_CODE LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]') ,
    EMAIL VARCHAR(50) CHECK(EMAIL LIKE '%@%.%' AND EMAIL NOT LIKE '@%' AND EMAIL NOT LIKE '%@%@%'),
    DATE_OF_BIRTH DATE NOT NULL,
    GENDER VARCHAR(10) NOT NULL CHECK(GENDER IN ('MALE', 'FEMALE')),
    LICENCE VARCHAR(5) NOT NULL CHECK(LICENCE IN ('YES', 'NO')),
    START_DATE DATE NOT NULL       
);
CREATE TABLE OPPORTUNITY (
    OPPORTUNITY_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    OPPORTUNITY_TITLE VARCHAR(50) NOT NULL,
    OPPORTUNITY_DESC VARCHAR(5000) NOT NULL,
    DEPT_ID INT NOT NULL,
    START_DATE DATE NOT NULL,
    CONTACT_FN VARCHAR(50) NOT NULL CHECK(CONTACT_FN NOT LIKE'%[^A-Z]%'),
    CONTACT_LN VARCHAR(50) NOT NULL CHECK(CONTACT_LN NOT LIKE'%[^A-Z]%'),     
    CONTACT_EMAIL VARCHAR(50) CHECK(CONTACT_EMAIL LIKE '%@%.%' AND CONTACT_EMAIL NOT LIKE '@%' AND CONTACT_EMAIL NOT LIKE '%@%@%')
);
CREATE TABLE PASS (
    PASS_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    USER_ID INT, 
    PASS_TYPE VARCHAR(25) NOT NULL, 
    PURCHASE_DATE DATE NOT NULL, 
    EXPIRY_DATE DATE NOT NULL
    PURCHASE_SUCCESS VARCHAR(25) NOT NULL CHECK(PURCHASE_SUCCESS IN ('YES', 'NO'))
);
CREATE TABLE VEHICLES (
    VEHICLE_ID INT IDENTITY(1,1) PRIMARY KEY,
    LICENSE_NUMBER VARCHAR(25) NOT NULL, 
    PROVINCE VARCHAR(25) NOT NULL, 
    USER_ID INT NOT NULL
);
CREATE TABLE HOSPITAL_VACANCY (
    vacancy_id INT CONSTRAINT vacancy_vacancy_id_pk PRIMARY KEY,
    job_title VARCHAR(20) NOT NULL,
    apply_due_date DATE NOT NULL,
    description VARCHAR(MAX) NOT NULL,
    description_id INT NOT NULL,
    job_type CHAR(2) NOT NULL,
    no_of_vacancy INT CHECK (no_of_vacacny > 0),
    contact_email VARCHAR(50) CHECK (contact_email LIKE '[a-zA-Z0-9_\-]+@([a-zA-Z0-9_\-]+\.)+(com|org|edu|nz|au)')
);
CREATE TABLE HOSPITAL_FEEDBACK (
    id_feedback INT IDENTITY(1,1) PRIMARY KEY,
    f_name VARCHAR(20),
    l_name VARCHAR(20),
    contact_email VARCHAR(50) NOT NULL,
    type_feedback VARCHAR(30) NOT NULL,
    depart_feedback VARCHAR(30) NOT NULL,
    comment_feedback VARCHAR(30) NOT NULL,
    date_feedback DATE NOT NULL,
    is_publish TINYINT NOT NULL DEFAULT 0
);

--INSERT INTO departments VALUES (1, 'General Administration');
--INSERT INTO departments VALUES (2, 'Physicians');

--INSERT INTO site_roles VALUES ('USR', 'User', 'A regular logged in user with no admin privileges');
--INSERT INTO site_roles VALUES ('ADM', 'Admin', 'An admin with privileges to delete and edit content');
--INSERT INTO site_roles VALUES ('SPA', 'Super Admin', 'An admin with edit and delete, as well as create admin privileges');

--INSERT INTO employees VALUES ('Head Administrator', 1);
--INSERT INTO employees VALUES ('Doctor', 2);

--INSERT INTO site_users (role_code, user_first_name, user_last_name, user_dob, user_gender, user_address, user_city, user_province, user_postal_code, user_email, user_username, user_password, user_phone) VALUES ('USR', 'Matt', 'Mawhinney', '1992/11/12', 'M', '64 Gadwall Ave', 'Barrie', 'ON', 'L4N8X5', 'matt@humber.ca', 'MattMawhinney', 'matt12345', '2439873402');
--INSERT INTO site_users (role_code, user_first_name, user_last_name, user_dob, user_gender, user_address, user_city, user_province, user_postal_code, user_email, user_username, user_password, user_phone) VALUES ('USR', 'Paul', 'Ooi', '1990/1/1', 'M', '123 Queen St', 'Toronto', 'ON', 'A1B2C3', 'paul@humber.com', 'PaulOoi', 'paul12345', '5563349087');
--INSERT INTO site_users (role_code, user_first_name, user_last_name, user_dob, user_gender, user_address, user_city, user_province, user_postal_code, user_email, user_username, user_password, user_phone) VALUES ('USR', 'Ehis', 'Idialu', '1995/2/2', 'M', '555 Main St', 'Montreal', 'QC', 'N2Z1X1', 'ehis@humber.ca', 'EhisIdialu', 'ehis12345', '2937864593');
--INSERT INTO site_users (emp_id, role_code, user_first_name, user_last_name, user_dob, user_gender, user_address, user_city, user_province, user_postal_code, user_email, user_username, user_password, user_phone) VALUES (1, 'SPA', 'Bernie', 'Monette', '1900/1/1', 'M', '123 Fake St', 'Toronto', 'ON', 'N6H9D9', 'bernie@humber.com', 'BernieMonette', 'bernie12345', '111222333444');
--INSERT INTO site_users (emp_id, role_code, user_first_name, user_last_name, user_dob, user_gender, user_address, user_city, user_province, user_postal_code, user_email, user_username, user_password, user_phone) VALUES (2, 'ADM', 'Lee', 'Situ', '1990/2/2', 'M', '555 Real St', 'North York', 'QC', 'L7D4T9', 'lee@humber.ca', 'LeeSitu', 'lee12345', '222333444555');

ALTER TABLE departments WITH CHECK ADD CONSTRAINT fk_departments_emp_id FOREIGN KEY (dept_head) REFERENCES employees (emp_id);
ALTER TABLE employees WITH CHECK ADD CONSTRAINT fk_employees_dept_id FOREIGN KEY (dept_id) REFERENCES departments (dept_id);
ALTER TABLE site_users WITH CHECK ADD CONSTRAINT fk_users_role_code FOREIGN KEY (role_code) REFERENCES site_roles (role_code);
ALTER TABLE site_users WITH CHECK ADD CONSTRAINT fk_users_emp_id FOREIGN KEY (emp_id) REFERENCES employees (emp_id);
ALTER TABLE announcements WITH CHECK ADD CONSTRAINT fk_announcements_emp_id FOREIGN KEY (emp_id) REFERENCES site_users (emp_id);

ALTER TABLE physicians WITH CHECK ADD CONSTRAINT fk_physician_special1_id FOREIGN KEY (special1) REFERENCES specialties (special_id);
ALTER TABLE physicians WITH CHECK ADD CONSTRAINT fk_physician_special2_id FOREIGN KEY (special2) REFERENCES specialties (special_id);
ALTER TABLE physicians WITH CHECK ADD CONSTRAINT fk_physician_dept_id FOREIGN KEY (department_id) REFERENCES departments (dept_id);
ALTER TABLE physicians WITH CHECK ADD CONSTRAINT fk_physician_emp_id FOREIGN KEY (emp_id) REFERENCES employees (emp_id);

ALTER TABLE volunteer WITH CHECK ADD CONSTRAINT fk_volunteer_opp FOREIGN KEY (opportunity_id) REFERENCES opportunity (opportunity_id);
ALTER TABLE opportunity WITH CHECK ADD CONSTRAINT fk_opportunity_dept FOREIGN KEY (dept_id) REFERENCES departments (dept_id);
ALTER TABLE pass WITH CHECK ADD CONSTRAINT fk_pass_user FOREIGN KEY (user_id) REFERENCES site_users (user_id);
ALTER TABLE vehicles WITH CHECK ADD CONSTRAINT fk_vehicle_user FOREIGN KEY (user_id) REFERENCES site_users (user_id);

ALTER TABLE appointments WITH CHECK ADD CONSTRAINT fk_appointments_patient_id FOREIGN KEY (patient_id) REFERENCES site_users (user_id);
ALTER TABLE appointments WITH CHECK ADD CONSTRAINT fk_appointments_emp_id FOREIGN KEY (emp_id) REFERENCES employees (emp_id);



