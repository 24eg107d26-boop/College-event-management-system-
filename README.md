# College Event Management System (CampusEvents)

A complete, production-ready full-stack web application built for college event organization, student registrations, and administrative management.

---

## 📌 Project Overview

- **Backend**: Java 21, Spring Boot 4 / Spring Framework 7
- **Database**: MySQL (with automatic table generation via Spring Data JPA / Hibernate) + Optional H2 In-Memory profile
- **Security**: Spring Security 7 with BCrypt password hashing & Role-Based Access Control (`ROLE_STUDENT`, `ROLE_ADMIN`)
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5.3, Bootstrap Icons
- **Template Engine**: Thymeleaf
- **Build Tool**: Apache Maven

---

## 🔑 Default Login Credentials (Pre-Seeded)

The system automatically initializes default accounts and 5 sample college events on the very first run:

| Role | Email | Password | Access Rights |
| :--- | :--- | :--- | :--- |
| **Administrator** | `admin@college.edu` | `admin123` | Full Admin Dashboard, Add/Edit/Delete Events, View Attendees, Manage Students |
| **Student (Golanukonda)** | `golanukonda@college.edu` | `student123` | Browse Events, Register for Events, View My Registrations, Cancel Bookings |

> **Tip for College Demo**: The Login page features **One-Click Demo Fill Buttons** to auto-fill these credentials instantly in front of professors or examiners!

---

## 🚀 How to Run the Project (Windows)

### Option 1: Running with MySQL (Recommended)

1. **Start MySQL Server**:
   - Open **XAMPP Control Panel** and click **Start** next to MySQL (or start your local MySQL service).
2. **Configure Password** (if different):
   - Open `src/main/resources/application.properties`.
   - Update `spring.datasource.password=root` to your MySQL password (leave empty `""` if using XAMPP default).
   - *Note*: You do **not** need to manually create tables; Hibernate creates `college_event_db` and all tables automatically! A standalone SQL script (`database_setup.sql`) is also provided in the project root if your college examiner requests it.
3. **Run the Application**:
   Open PowerShell or Command Prompt inside the project folder and run:
   ```powershell
   .\mvnw.cmd spring-boot:run
   ```
4. **Open in Web Browser**:
   Visit: [http://localhost:8080](http://localhost:8080)

---

### Option 2: Instant Offline Demo Mode (Zero Configuration / No MySQL Required)

If you are demonstrating at college without MySQL running, you can launch the app instantly using the built-in in-memory database:
```powershell
.\mvnw.cmd spring-boot:run -Dspring-boot.run.profiles=h2
```
Or run the packaged JAR:
```powershell
java -jar target\college-event-management-system-0.0.1-SNAPSHOT.jar --spring.profiles.active=h2
```
All sample events, security, registrations, and dashboards will load in memory with zero setup!

---

## 🌐 Website URLs & Navigation

- **Home Page**: [http://localhost:8080/](http://localhost:8080/)
- **Events Directory & Filter**: [http://localhost:8080/events](http://localhost:8080/events)
- **Student Sign In**: [http://localhost:8080/login](http://localhost:8080/login)
- **Student Registration**: [http://localhost:8080/register](http://localhost:8080/register)
- **My Registrations**: [http://localhost:8080/my-registrations](http://localhost:8080/my-registrations)
- **Admin Dashboard**: [http://localhost:8080/admin/dashboard](http://localhost:8080/admin/dashboard)
- **Admin Event Management**: [http://localhost:8080/admin/events](http://localhost:8080/admin/events)
- **Add New Event**: [http://localhost:8080/admin/events/new](http://localhost:8080/admin/events/new)
- **Enrolled Students Directory**: [http://localhost:8080/admin/students](http://localhost:8080/admin/students)
- **About CampusEvents**: [http://localhost:8080/about](http://localhost:8080/about)
- **Contact Us**: [http://localhost:8080/contact](http://localhost:8080/contact)

---

## 🎯 Sample College Events Included

1. **Aura 2026 - Annual College Fest** (Cultural extravaganza, DJ night, talent hunts)
2. **TechVenture 2026 - National Technical Symposium** (Paper presentation, robotics, project expo)
3. **CodeQuest 2026 - 24-Hour Hackathon & Coding Contest** (Algorithmic challenges, prizes)
4. **Rhythms of Unity - College Cultural Day** (Dance, music, drama, ethnic fashion walk)
5. **Spardha 2026 - Annual Inter-Department Sports Meet** (Athletics, football, cricket, tournaments)

---

## 💡 How to Explain During Your College Project Demonstration

When explaining this project to your examiner or professor, highlight these key architectural strengths:

1. **MVC Architecture (Model-View-Controller)**:
   - **Model**: JPA Entities (`User`, `Event`, `EventRegistration`) managing database relationships with primary and foreign keys.
   - **View**: Thymeleaf dynamic templates with responsive Bootstrap 5 styling and role-based fragment rendering.
   - **Controller**: RESTful and Spring MVC controllers routing traffic, handling form validations, and passing model data.

2. **Security & Data Integrity**:
   - Passwords are never stored in plain text; encrypted using **BCrypt** hashing.
   - Dual-layer duplicate registration prevention:
     - **Database level**: Unique constraint on `(user_id, event_id)`.
     - **Service level**: `RegistrationServiceImpl` validates prior to saving.
   - Capacity guarding: Prevents registrations when seats reach `capacity`.
   - Role-Based Access Control: `/admin/**` endpoints are strictly protected from unauthorized student access.
