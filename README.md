# Mini Job Portal App (Flutter)

Implements the required interview task:

## Features
- Email + Password authentication (local only, using Hive) with sign up & login.
- Job list fetched from `https://dummyjson.com/products` (API items interpreted as job postings; product titles are replaced with curated job role titles e.g. Junior Software Engineer, SQL Analyst, CEO, etc.).
- Each job card shows: Role, Company, Location, Salary and an Apply button.
- Apply button saves (persists) the job locally (idempotent) – cannot unapply (aligns with interview spec: save when user clicks Apply).
- Detail screen shows full info, synthesized responsibilities & Apply button (disabled once applied).
- Saved (Applied) Jobs tab reading from local Hive box.
- Profile tab with dummy name, email of logged-in user, total applied jobs
