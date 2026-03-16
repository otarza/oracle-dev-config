# Oracle DB 23ai Free — Student Dev Environment

A zero-friction local Oracle environment for learning and experimentation.

## What's Included

| Service | URL / Port | Purpose |
|---|---|---|
| Oracle DB 23ai Free | `localhost:1521` | Database engine |
| SQL Developer Web (ORDS) | http://localhost:8181/ords/sql-developer | Browser-based IDE |
| Enterprise Manager Express | https://localhost:5500/em | DB monitoring |

---

## Quick Start

### 1. Accept Oracle's License
Go to https://container-registry.oracle.com, sign in, navigate to  
**Database → free** and click **Accept Agreement**.

### 2. Log In to Oracle's Registry
```bash
docker login container-registry.oracle.com
```

### 3. Create Your `.env` File
```bash
cp .env.example .env
# Edit .env and set your passwords
```

### 4. Start Everything
```bash
docker compose up -d
```

The **first startup takes 3–5 minutes** while Oracle initializes the database files.  
Watch progress with:
```bash
docker logs -f oracle-db
```
Wait until you see: `DATABASE IS READY TO USE!`

### 5. Open SQL Developer Web
Go to: http://localhost:8181/ords/sql-developer

**Login credentials:**
- Username: `student`
- Password: `Student123!` *(or whatever you set in the init script)*

> **Tip:** ORDS may need a restart on first run if it started before the DB was fully ready:
> ```bash
> docker compose restart ords
> ```

---

## Connecting with External Tools

Use these details in DBeaver, IntelliJ, SQL*Plus, or any JDBC client:

| Setting | Value |
|---|---|
| Host | `localhost` |
| Port | `1521` |
| Service Name | `FREEPDB1` |
| Username | `student` |
| Password | *(from init script)* |

**JDBC URL:**
```
jdbc:oracle:thin:@localhost:1521/FREEPDB1
```

---

## Adding More Init Scripts

Drop `.sql` files into `init-scripts/`. They run **once, on first boot**, in alphabetical order.  
To re-run them, you must wipe the volume first:
```bash
docker compose down -v
docker compose up -d
```

---

## Useful Commands

```bash
# Check status
docker compose ps

# Follow DB logs
docker logs -f oracle-db

# Open a SQL*Plus session inside the container
docker exec -it oracle-db sqlplus system@FREEPDB1

# Stop (data is preserved)
docker compose down

# Full reset — DELETES ALL DATA
docker compose down -v
```

---

## Key Concepts for Students

- **CDB vs PDB**: Oracle 23ai uses a container architecture. Always connect to `FREEPDB1` (the pluggable DB) for your work — not `CDB$ROOT`.
- **SYS / SYSTEM**: Admin accounts. Don't use for day-to-day practice — use the `student` account.
- **ORDS**: Oracle REST Data Services. Powers both the SQL Developer Web UI and lets you expose DB tables as REST endpoints — great for full-stack experimentation.
