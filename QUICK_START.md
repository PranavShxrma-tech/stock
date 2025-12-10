# Quick Setup Guide

## Course Loading Error - Solution

The error "Error loading courses" occurs when the backend is not running or not properly configured.

### Prerequisites
Before you start, install:
1. **Node.js** (includes npm): https://nodejs.org/
2. **PostgreSQL**: https://www.postgresql.org/

After installation, restart your terminal and verify:
```powershell
node --version
npm --version
psql --version
```

### Step-by-Step Setup

#### 1. Install Backend Dependencies
```powershell
cd c:\Users\Acer\Documents\GitHub\stock
npm install
```

#### 2. Create .env File
Create a file named `.env` in the stock folder with:
```
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/stock_db
PORT=5000
JWT_SECRET=your_secret_key_here
NODE_ENV=development
```

Replace `your_password` with your PostgreSQL password.

#### 3. Create Database
```powershell
# Open PostgreSQL
psql -U postgres

# In PostgreSQL command line, type:
CREATE DATABASE stock_db;
\q
```

#### 4. Create Tables
```powershell
psql -U postgres -d stock_db -f schema.sql
```

#### 5. Load Sample Data (Optional but Recommended)
```powershell
psql -U postgres -d stock_db -f seed-data.sql
```

#### 6. Start Backend Server
```powershell
npm run dev
```

You should see:
```
Server running on port 5000
```

#### 7. Test Backend
Open your browser and visit:
```
http://localhost:5000/api/health
```

You should see JSON response.

#### 8. Open Frontend
Open `index.html` in your browser.

Courses should now load automatically!

---

## Troubleshooting

### "npm: The term 'npm' is not recognized"
- Install Node.js from https://nodejs.org/
- Restart your terminal

### "Failed to load courses: Cannot connect"
- Make sure backend is running: `npm run dev`
- Check if port 5000 is open
- Press F12 in browser to see console errors

### "Database connection failed"
- Verify PostgreSQL is running
- Check .env DATABASE_URL is correct
- Verify stock_db database exists: `psql -U postgres -l`

### "relation 'courses' does not exist"
- Run schema file: `psql -U postgres -d stock_db -f schema.sql`

### "No courses available"
- Load sample data: `psql -U postgres -d stock_db -f seed-data.sql`
- Check courses exist: `psql -U postgres -d stock_db -c "SELECT * FROM courses;"`

---

## Complete Working Setup

```powershell
# 1. Install Node.js from nodejs.org (restart terminal after)
# 2. Install PostgreSQL from postgresql.org

# 3. Go to project
cd c:\Users\Acer\Documents\GitHub\stock

# 4. Install npm packages
npm install

# 5. Create .env file with your PostgreSQL credentials
# (use text editor, save as .env)

# 6. Create database
psql -U postgres -c "CREATE DATABASE stock_db;"

# 7. Create tables
psql -U postgres -d stock_db -f schema.sql

# 8. Add sample data
psql -U postgres -d stock_db -f seed-data.sql

# 9. Start server
npm run dev

# 10. Open index.html in browser
```

---

## Next: Frontend Testing

Once backend is running:

1. Open `index.html` in your browser (or run with `python -m http.server 8000`)
2. Press F12 to open Developer Tools
3. Go to Console tab
4. You should see logs like:
   - `Fetching: http://localhost:5000/api/courses`
   - `Success: /courses [...]`
5. Courses should display on page

---

## Helpful Files

- **BACKEND.md** - Detailed backend documentation
- **FRONTEND_API.md** - API integration guide
- **TROUBLESHOOTING.md** - Detailed troubleshooting
- **schema.sql** - Database structure
- **seed-data.sql** - Sample data to load
- **.env** - Database configuration (create this yourself)
- **package.json** - NPM dependencies

---

Let me know if you need help with any step!
