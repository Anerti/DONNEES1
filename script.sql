CREATE DATABASE enterprise;

CREATE TABLE team (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name VARCHAR(50) NOT NULL);

CREATE TABLE employee (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
	first_name VARCHAR(100) NOT NULL, 
	last_name VARCHAR(100) NOT NULL, 
	contract_type VARCHAR(50) NOT NULL, 
	salary INT, 
	team_id UUID, 
	CONSTRAINT fk_team_id FOREIGN KEY (team_id) REFERENCES team(id));

CREATE TABLE leave (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
	start_date DATE NOT NULL, 
	end_date DATE NOT NULL, 
	employee_id UUID NOT NULL);

INSERT INTO team (id, name) VALUES
    ('ccea4dbd-ff9b-4f04-b25d-8f2475886e77', 'Développement'),         
    ('99ad01fa-411c-49fe-9af6-df8d59968788', 'Support Technique'),      
    ('362123e3-4078-42f7-9660-bd4de02e0ab4'), 'Ressources Humaines');   

INSERT INTO employee (
    id, first_name, last_name, contract_type, salary, team_id
) VALUES
    ('80150ae7-ab6c-47fb-968c-85d916e3ce58', 'Alice', 'Dupont',   'CDI',   55000, 'ccea4dbd-ff9b-4f04-b25d-8f2475886e77'),
    ('2b47231d-e0c4-45e3-8ca2-c91019bd6f30', 'Bob', 'Martin',   'CDD',   42000, '99ad01fa-411c-49fe-9af6-df8d59968788'),
    ('0d712070-9eb9-4381-9407-42ccf56c6928', 'Claire', 'Lefevre',  'CDI', 60000, '362123e3-4078-42f7-9660-bd4de02e0ab4'), 
    ('bf77aba9-dc99-4cbe-bdfa-7afb367626fb', 'David', 'Nguyen',   'Freelance', 48000, 'ccea4dbd-ff9b-4f04-b25d-8f2475886e77'), 
    ('f2ce3f59-93d2-4420-84d4-1ce72e92fe57', 'Emma', 'Kowalski', 'CDI', 53000, 'ccea4dbd-ff9b-4f04-b25d-8f2475886e77')
    ('8eafaafc-cf7e-4aa7-b5da-406c24da09a9', 'Kimi', 'Raikonen', 'CDI', 74000, NULL);

INSERT INTO leave (
    id, start_date, end_date, employee_id
) VALUES
    (gen_random_uuid(), '2025-06-01', '2025-06-10', '80150ae7-ab6c-47fb-968c-85d916e3ce58'),
    (gen_random_uuid(), '2025-07-15', '2025-07-20', '2b47231d-e0c4-45e3-8ca2-c91019bd6f30'),
    (gen_random_uuid(), '2025-08-05', '2025-08-12', '0d712070-9eb9-4381-9407-42ccf56c6928'),
    (gen_random_uuid(), '2025-09-01', '2025-09-03', '80150ae7-ab6c-47fb-968c-85d916e3ce58'),
    (gen_random_uuid(), '2025-12-24', '2026-01-02', '2b47231d-e0c4-45e3-8ca2-c91019bd6f30');

SELECT id, first_name, last_name from employee WHERE team_id IS NULL;

SELECT employee.id, employee.first_name, employee.last_name
FROM leave
RIGHT JOIN employee
ON leave.employee_id = employee.id where employee_id is null;

SELECT leave.id, leave.start_date, leave.end_date, employee.first_name, employee.last_name, team.name 
FROM employee 
INNER JOIN leave 
ON leave.employee_id = employee.id 
INNER JOIN team 
ON employee.team_id = team.id;

SELECT contract_type, COUNT(contract_type) FROM employee GROUP BY contract_type;

SELECT leave.start_date, leave.end_date, employee.first_name, employee.last_name, employee.id 
FROM employee INNER JOIN leave 
ON leave.employee_id = employee.id 
WHERE leave.start_date >= CURRENT_DATE AND leave.end_date <= CURRENT_DATE;

SELECT employee.id, employee.first_name, employee.last_name, team.name, leave.end_date 
FROM employee 
INNER JOIN team 
ON employee.team_id = team.id INNER JOIN leave 
ON leave.employee_id = employee.id 
WHERE leave.end_date <= CURRENT_DATE;
