# 🧑‍💼 Online Job Portal

A fully functional job portal web application built with **ASP.NET Web Forms**, **C#**, and **MySQL**, designed to connect job seekers and job providers through a secure, user-friendly platform. This system allows users to search and apply for jobs, while employers can post and manage job listings. The portal includes a responsive UI, admin panel, resume upload, application tracking, and role-based access control.

---

## 🔍 Features

### 👤 User Side (Job Seeker)
- Register/Login as Job Seeker
- Build and upload resumes (PDF format)
- Browse and filter job listings
- View detailed job descriptions
- Apply to jobs directly
- Preview uploaded resume
- "Already Applied" status detection

### 🏢 Employer Side (Job Provider)
- Register/Login as Job Provider
- Post new job openings
- View and manage posted jobs
- View candidates who applied

### 🔐 Admin Panel
- View, edit, delete job listings
- Manage job applications
- View contact form messages
- Role-based access control

### 🧰 Other Features
- Dynamic filters: location, job type, salary, experience, country
- Responsive layout using Bootstrap
- Contact form with database storage
- MySQL views for simplified queries

---

## 🛠️ Technologies Used

| Tech | Description |
|------|-------------|
| ASP.NET Web Forms | Backend web framework using C# |
| C# | Programming language for server-side logic |
| MySQL | Relational database for storing job data, users, resumes |
| ADO.NET | Data access layer for database operations |
| HTML, CSS, Bootstrap | Frontend and responsive UI |
| GridView, DataList | ASP.NET controls for displaying and managing data |

---

## 🗂️ Database Structure

### Main Tables:
- `User` – Stores job seeker/provider data with roles
- `Jobs` – Stores job postings with full details
- `AppliedCandidates` – Stores application records
- `Contact` – Stores contact form submissions
- `Country` – Country list for dropdowns
- `ViewAppliedCandidates` – MySQL view to simplify join queries

---

## 📸 Screenshots

![Screenshot 2025-05-04 205717](https://github.com/user-attachments/assets/22dd5a26-75ed-4770-914d-b23af93c974a)




![Screenshot 2025-05-04 205717](https://github.com/user-attachments/assets/9f32df36-5ebd-4a0f-b64a-79a0f72934d3)




![Screenshot 2025-05-04 205830](https://github.com/user-attachments/assets/bb813040-c883-4151-8174-c7e3bf1eaa3c)


---


