use "Hospital Management System"
go

----DDL---
create table G1_doctor(
D_id int primary key identity(1,1),
D_name nvarchar(150) not null,
D_ph_no nvarchar(150) not null unique,
CONSTRAINT dchk_phone CHECK (D_ph_no like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
D_CNIC nvarchar(150) not null unique,
CONSTRAINT dchk_cnic CHECK (D_CNIC like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
D_specialization nvarchar(150) not null
)

create table G1_patient(
P_id int primary key identity (100,1),
P_name nvarchar(150) not null,
P_age int not null,
P_ph_no nvarchar(150) not null unique,
CONSTRAINT pchk_phone CHECK (P_ph_no like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
P_CNIC nvarchar(150) not null unique,
CONSTRAINT pchk_cnic CHECK (P_CNIC like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
P_address nvarchar(150) not null
)


create table G1_department(
dept_id int primary key identity (200,1),
dept_name nvarchar(150) not null,
dept_head nvarchar(150) not null,
head_email nvarchar(150) not null unique,
CONSTRAINT chk_email CHECK (head_email like ('%@%.com'))
)

create table G1_affiliated_with(
aff_id int primary key identity (300,1),
did int foreign key references G1_doctor(D_id) not null,
deptid int foreign key references G1_department (dept_id) not null
)

Create table G1_nurse (
N_id int primary key identity(400,1),
N_name nvarchar(150) not null,
N_ph_no nvarchar(150) not null unique,
CONSTRAINT chk_Nurse_phone CHECK (N_ph_no like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
N_CNIC nvarchar(150) not null unique,
CONSTRAINT chk_Nurse_cnic CHECK (N_CNIC like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')  
)
alter table G1_nurse 
add position nvarchar(150) check (position in ('head nurse','nurse')) 

create table G1_procedure(
  proc_id int primary key identity(500,1),
  proc_name nvarchar(150) not null,
  proc_cost money not null
)

create table G1_floor(
  F_id int primary key identity(600,1),
  F_no int not null,
  total_rooms int not null,
)

create table G1_room(
R_id int primary key identity(700,1),
R_no int not null,
R_type nvarchar(50) not null check(R_type in ('Consulting', 'Critical','Intensive treatment')),
availibility nvarchar(3) not null,
fid int foreign key references G1_floor(F_id) not null
)
alter table G1_room
add constraint avail_chk
check(availibility in ('yes', 'no'))

create table G1_appointment(
A_id int primary key identity (20,1),
A_date date not null,
adid int foreign key references G1_doctor(D_id) not null,
apid int foreign key references G1_patient (P_id) not null,
anid int foreign key references G1_nurse (n_id) not null,
aprocid int foreign key references G1_procedure (proc_id) not null,
arid int foreign key references G1_room (R_id) not null
)

create table G1_receipt(
recp_id int primary key identity (30,1),
recp_patient_name nvarchar(150) not null,
recp_date date default (getdate()) not null,
recp_stay int,
recp_status nvarchar(20) not null,
A_id int foreign key references G1_appointment (A_id) not null 
)

create table G1_payment(
Pay_id int primary key identity(40,1),
Pay_method nvarchar(150) not null,
rno int  foreign key references G1_receipt (recp_id) not null ,
ppid int foreign key references G1_patient(P_id) not null 
)

----DML-----
---Insert in Doctor table
insert into G1_doctor(D_name,D_ph_no,D_CNIC,D_specialization)
values('arif chaudary','03451276123','3520109123984','Child Specialist'),
('salman javed', '03331466123', '3520129873984','ENT Specialist'),
('afaq gillani', '03241746193', '3520159247994','Kidney Specialist'),
('tarq fiyaz','03315107603','3520139197026','Heart Specialist'),
('jalil ahmad','03345127654','3520151129982','Neuro Surgeon'),
('mumtaz chaudary','03301376145','3520162128987','DPT specialist'),
('wajahat saeed','03051576188','3520187125904','human nutrirtion and dietics'),
('ansar maqsood','03001234197','3520199122980','Liver specialist'),
('Abdul Rehman','03331916123','3520156123984','Heart Specialist'),
('Ali haider', '03451466198', '3520129873774','ENT Specialist'),
('Osama gillani', '03201742193', '3520159877994','ENT Specialist'),
('hanzla buggti','03035107303','3520139199026','Heart Specialist');

select * from G1_doctor
----Insert in Patient table 
insert into G1_patient(P_name,P_age,P_ph_no,P_CNIC,P_address)
values('anees rashid',38,'03335698712','3520139391123','Nishtar town lahore'),
('jibran ahmed',38, '03335369872',     '3520167081128','shahdra town lahore'),
('gufran ahmed',42, '03035368775','3520167231131','model town lahore'),
('tariq butt',62,   '03235238754','3520187791199','ali town lahore'),
('fiyaz khan',55,   '03349698743','3520167891123','Gawalmandi lahore'),
('ali amjad',29,    '03026698736','3520157151145','badami bagh lahore'),
('salman niazi',48, '03058698729','3520167891198','Gulberg lahore'),
('bashir cheema',32,'03135098718','3520167441177','Baharia town lahore');

select * from G1_patient

---Insert in  Department table
insert into G1_department(dept_name,dept_head,head_email)
values('General Surgery','Gazanfar Ali','gazanfar@gmail.com'),
('Orthopaedics','Mushtaq Khan','mushtaqkhan@gmail.com'),
('E N T','Aqib Faheem','faheem@gmail.com'),
('Urology','Attaullah chaudary','attaullahCh@gmail.com'),
('Gastroenterology','Salman Javed','salman@gmail.com'),
('Cardiology','sheryar khan','sheryarkhan@gmail.com'),
('Nephrology','Ali amin','aminali@gmail.com'),
('Neurology','kazim ali','kazim@gmail.com');

select * from G1_department
----Insert in affiliated_with table 
insert into G1_affiliated_with(did,deptid)
values(1,200),
(2,202),
(3,203),
(4,205),
(5,207),
(6,201),
(7,200),
(8,206),
(10,205),
(11,202),
(12,202),
(13,205);


select * from G1_affiliated_with
---Insert in G1_procedure table 
insert into G1_procedure(proc_name,proc_cost)
values('Joint Replacement',10000),
('Stent Procedure',125000),
('Cholecystectomy',192000),
('Broken Bone Repair',30000),
('kidney stone removal',45000),
('endoscopy',10000),
('gastric bypass',300000),
('Cup therapy',5000),
('Hijama therapy',10000),
('sinus surgery',70000),
('ERCP',100000),
('Deep brain stimulation.',3000000),
('Rhinoplasty',85000),
('Routine checkup',2000);


select * from G1_procedure

---Insert in table Floor
Insert into G1_floor(F_no,total_rooms)
values(1,25),
(2,15),
(3,10);

select * from G1_floor

----Insert in tale room
insert into G1_room(R_no,R_type,availibility,fid)
values
(1,'Consulting','yes',606),(2,'Consulting','yes',606),(3,'Consulting','yes',606),(4,'Consulting','yes',606),
(5,'Consulting','yes',606),(6,'Consulting','yes',606),(7,'Consulting','yes',606),(8,'Consulting','yes',606),(9,'Consulting','yes',606),
(10,'Critical','yes',606),(11,'Critical','no',606),(12,'Critical','no',606),(13,'Critical','yes',606),(14,'Critical','yes',606),
(15,'Intensive treatment','no',606),(16,'Intensive treatment','no',606),(17,'Intensive treatment','yes',606),
(18,'Intensive treatment','yes',606),(19,'Intensive treatment','yes',606),(20,'Intensive treatment','yes',606),
(21,'Intensive treatment','no',607),(22,'Consulting','no',607),(23,'Consulting','no',607),(24,'Consulting','no',607),
(25,'Critical','no',607),(26,'Consulting','no',607),(27,'Critical','no',607),(28,'Critical','no',607),(29,'Critical','no',607),
(30,'Critical','yes',607),(31,'Critical','yes',607),(32,'Consulting','yes',607),(33,'Consulting','yes',607),(34,'Critical','yes',607),
(35,'Intensive treatment','yes',607),
(36,'Consulting','yes',608),(37,'Consulting','yes',608),(38,'Consulting','yes',608),(39,'Consulting','yes',608),
(40,'Intensive treatment','no',608),(41,'Intensive treatment','yes',608),(42,'Consulting','yes',608),(43,'Consulting','yes',608),
(44,'Consulting','no',608),(45,'Critical','no',608);

select * from G1_room

---Insert in Nurse table
insert into G1_nurse(N_name,N_ph_no,N_CNIC,position)
values('aleena kazmi','03451276123','3520109223984','head nurse'),
('mahnoor nadeem', '03331455123','3520129873984','nurse'),
('uroob zaidi', '03241746783','3520159247994','nurse'),
('fiza jalil','03315107603','3520139197826','nurse'),
('noor amjad','03345127564','3520151129568','nurse'),
('naseem zahra','03301301145','3520162129987','nurse'),
('shumaila tariq','03051576188','3520187705904','nurse');

select * from G1_nurse


insert into G1_appointment(A_date,adid,apid,anid,aprocid,arid)
values('2-2-2022',13,107,409,501,(select R_id from G1_room where R_no = 20)),
('2-7-2022',12,106,408,509,(select R_id from G1_room where R_no = 17)),
('2-4-2022',4,100,407,505,(select R_id from G1_room where R_no = 41)),
('2-22-2022',6,104,405,503,(select R_id from G1_room where R_no = 10)),
('2-4-2022',6,102,408,500,(select R_id from G1_room where R_no = 13)),
('3-2-2022',6,103,411,500,(select R_id from G1_room where R_no = 18)),
('3-15-2022',3,106,406,504,(select R_id from G1_room where R_no = 35)),
('3-21-2022',7,103,405,1501,(select R_id from G1_room where R_no = 1)),
('3-28-2022',3,102,409,504,(select R_id from G1_room where R_no = 41)),
('4-1-2022',8,101,406,510,(select R_id from G1_room where R_no = 10)),
('4-2-2022',8,101,409,1501,(select R_id from G1_room where R_no = 4)),
('4-11-2022',7,104,405,1501,(select R_id from G1_room where R_no = 3));

select * from G1_appointment

select * from G1_doctor
select * from G1_patient
select * from G1_nurse
select * from G1_room
select * from G1_procedure
select * from G1_appointment


insert into G1_receipt(recp_patient_name,recp_date,recp_status,recp_stay,A_id)
values ('anees rashid','2-8-2022','paid',6,30),
('jibran ahmed','4-24-2022','pending',20,37),
('tariq butt','3-2-2022','paid',0,33),
('salman niazi','2-12-2022','paid',7,29),
('gufran ahmed','2-15-2022','paid',21,32),
('fiyaz khan','4-11-2022','paid',0,39),
('bashir cheema','2-6-2022','paid',26,28),
('fiyaz khan','2-24-2022','paid',8,31),
('salman niazi','3-20-2022','paid',9,34),
('jibran ahmed','4-2-2022','paid',0,38),
('tariq butt','3-26-2022','paid',11,35),
('gufran ahmad','4-4-2022','pending',25,36);
select * from G1_receipt

insert into G1_payment(Pay_method,rno,ppid)
values('credit card',30,100),
('cash',31,101),
('check ',32,103),
('mobile payment',33,106),
('credit card',34,102),
('credit card',35,104),
('cash',36,107),
('cash',37,104),
('mobile payment',38,106),
('credit card',39,101),
('credit card',40,103),
('mobile payment',41,102);

select * from G1_payment


-----------------Advanced Queries--------------------

---write a SQL query to count the number of patients who booked at least one appointment.
SELECT count(DISTINCT P_id) AS "No. of patients booked at least one appointment" from G1_patient p join
G1_appointment a on p.P_id = a.apid;


-----From the following table, write a SQL query to count the number available rooms. Return count as "Number of available rooms".
select count(R_no) as Total_no_of_rooms_availaible from G1_room 
where availibility = 'yes'


--- From the following tables, write a SQL query to find the Doctor and the departments they are affiliated with. Return Doctor name as "Doctor", and department name as "Department".
select D_name as 'Doctor',dept_name as 'Department' from G1_doctor p
inner join G1_affiliated_with a on p.D_id = a.did
inner join G1_department d on d.dept_id = a.deptid

---From the following tables, write a SQL query to find the name of the nurse 
--and the room scheduled, where they will assist the physicians. Return Nurse Name and room no. 
create procedure Nurse_info
@nurse_name nvarchar(50) = null
as
begin
if(@nurse_name is not null)
begin
select n.N_name  as 'Nurse Name',r.R_no as 'Room No', a.A_date as 'Assigned Date'  from G1_nurse n
join G1_appointment a on n.N_id = a.anid
join G1_room r on r.R_id = a.arid
where n.N_name = @nurse_name
end
else
print'No room assigned yet.....'
end

exec Nurse_info @nurse_name = 'noor amjad'

---From the following tables, write a SQL query to diplay all the details  of appointmnet
---if patients have booked its appointment by only taking name and date from the patient
---and if not then display the message "Sorry You have not booked any appointmnet yet.."
---Return Name of the patient as "Patient Name",
---Name of the doctor as "Doctor Name", Name of the nurse as "Assisting Nurse"
---and  room as "Room No." 

alter procedure appointment_details
@patient_name nvarchar(50) = null
,@date date = null
as
begin
if(@patient_name is not null and @date is not null)
begin
select p.P_name as 'Patient Name'
,d.D_name as 'Doctor Name',
n.N_name as 'Assisting Nurse',
r.R_no as 'Room No',
a.A_date as 'Appointment Date'
from 
G1_patient p join G1_appointment a
on a.apid = p.P_id
join G1_doctor d
on a.adid = d.D_id
join G1_nurse n 
on a.anid = n.N_id
join G1_room r
on a.arid = r.R_id
where p.P_name = @patient_name and a.A_date = @date
end
else
print'Sorry You have not booked any appointmnet yet..'
end


exec appointment_details @patient_name = 'tariq butt',@date = '3-2-2022'

----From the following table, write a SQL query to display the name of patients who got an appointment for Critical room "C".
----Return patients name as “Patients those who got appointment for Critical Room”
select P_name as 'Patients those who got appointment for Critical Room' from  G1_patient
inner join G1_appointment on P_id = apid
inner join  G1_room on R_id = arid
where R_type = 'Critical'


----Write a SQL query ,that whenever a patient books a appointmnet so a message was generated ----‘A new appointment is booked’--------

alter trigger appoinment_booking
on G1_appointment
after insert
as
begin
Print 'A new appointmnet is booked'
end

insert into G1_appointment(A_date,adid,apid,anid,aprocid,arid)
values('2-2-2022',13,107,409,501,(select R_id from G1_room where R_no = 20));


--------------------------------------------------------------------------------------
insert into G1_appointment(A_date,adid,apid,anid,aprocid,arid)
values('2-2-2022',13,107,409,501,(select R_id from G1_room where R_no = 20));



select top 50 PERCENt * from G1_patient

---print doctor name with departmnet name it affiliates with 
select concat(D_name,'-',dept_name) as 'Doctor with Department' from G1_department d
join G1_affiliated_with a on a.deptid = d.dept_id
join G1_doctor dd on a.did = dd.D_id

---Transaction with procedures and error handling 
 aLTER procedure update_record
 as
 begin
 begin try
 begin Transaction
   update G1_procedure set proc_cost = 200000 where proc_id = 'abc'
 commit Transaction  
 print 'Transaction commited' 
   end try
begin catch 
 rollback Transaction
 print 'Transaction rolled back'
 end catch
 end

 exec update_record

 select * from G1_procedure

 --- store procedure with output parameters
 create procedure total_doctors
 @total int output
 as
 begin
 select @total = count(D_id) from G1_doctor  
 end
--- executing 
declare @total_d int 
exec  total_doctors @total_d output
print @total_d



---triggers in sql 
create trigger trupdate
on G1_procedure
for update
as
begin
select * from deleted
select * from inserted
print 'Record from procedure is updated'
end

update G1_procedure set proc_cost  = 20000000 where proc_id = 500

---Views in sql
create view doctor_details
as
select * from G1_doctor

select * from doctor_details

---Indexes in sql 
create NONclustered index TBL_doctor on G1_doctor (D_name)

SELECT * FROM G1_doctor

select * from G1_procedure 


select * from G1_doctor 

select distinct(D_name) from G1_doctor
select * from G1_doctor where D_name like 'a%'