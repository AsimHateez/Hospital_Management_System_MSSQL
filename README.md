# 🏥 Hospital Management System – SQL Server

A complete relational database project for managing hospital data and operations using **Microsoft SQL Server**. This system handles doctors, patients, departments, appointments, rooms, procedures, billing, and payment management.

---

## 📁 Database Tables

- **Doctor** – Stores doctor info with CNIC, phone, and specialization validation.
- **Patient** – Holds patient data, including contact and address.
- **Department** – Tracks departments, heads, and emails.
- **Affiliated_With** – Connects doctors to departments.
- **Nurse** – Nurse profiles and assigned roles.
- **Floor/Room** – Physical layout with room types and availability.
- **Procedure** – Medical treatments and costs.
- **Appointment** – Schedules between doctor, nurse, patient, and room.
- **Receipt & Payment** – Billing and payment tracking.

---

## ⚙️ Features

- ✅ Normalized schema with constraints for data integrity
- ✅ Use of `CHECK`, `UNIQUE`, `DEFAULT`, and foreign keys
- ✅ Advanced queries, joins, views, triggers, and procedures
- ✅ Sample data included for each table
- ✅ Triggers for appointment confirmation and updates
- ✅ Stored procedures with input/output and exception handling

---

## 🧪 Sample Operations

- Count total appointments per patient
- Track nurse room assignments
- Query doctors by department
- Update procedures with transaction handling
- Search available rooms
- View appointment history with patient name and date

---

## 🚀 Getting Started

1. Open the `.sql` file in SQL Server Management Studio (SSMS).
2. Execute the script to create tables and insert sample data.
3. Use the provided procedures and test queries to explore functionality.

---

## 👨‍⚕️ Author

**Muhammad Asim Hateez**  
BSSE – Superior University Lahore

---

## 📄 License

Free to use for learning and academic purposes. Please credit the author if reused.
