# Course Loading Error - Complete Solution

## The Problem Explained

```
Browser (Frontend)          Network           Backend Server
                            ====
index.html    ----REQUEST---->    ERROR    <---- Not Running?
              <----NO DATA----    or       Not Configured?
                            
Result: "Error loading courses" (no helpful message)
```

## The Solution

### Step 1: Install Required Software
```
1. Node.js (for backend): https://nodejs.org/
2. PostgreSQL (for database): https://postgresql.org/

After installation, restart terminal and verify:
  node --version     (should show v14 or higher)
  npm --version      (should show 6 or higher)
  psql --version     (should show 12 or higher)
```

### Step 2: Setup Backend
```powershell
cd c:\Users\Acer\Documents\GitHub\stock

# Install dependencies
npm install

# Create .env file (use Notepad)
# Add these lines:
DATABASE_URL=postgresql://postgres:PASSWORD@localhost:5432/stock_db
PORT=5000
JWT_SECRET=my_secret_key
NODE_ENV=development

# Create database
psql -U postgres -c "CREATE DATABASE stock_db;"

# Setup tables
psql -U postgres -d stock_db -f schema.sql

# Add sample data (optional)
psql -U postgres -d stock_db -f seed-data.sql
```

### Step 3: Start Backend
```powershell
npm run dev

# Expected output:
# Server running on port 5000
```

### Step 4: Test Backend
Open browser and visit:
```
http://localhost:5000/api/health
```

Should see:
```json
{
  "status": "Backend is running",
  "timestamp": "2025-12-10T..."
}
```

### Step 5: Open Frontend
```
Open index.html in your browser
```

Courses should now load with no errors!

---

## Debugging Flowchart

```
Courses not loading?
│
├─> Open F12 (Developer Tools)
│   └─> Go to Console tab
│       └─> Look for red errors
│
├─> Is "Failed to fetch" showing?
│   └─> Backend not running
│       └─> Run: npm run dev
│
├─> Is "Cannot GET /api/courses" showing?
│   └─> Wrong API URL
│       └─> Check API_BASE in index.html
│
├─> Is "No courses available" showing?
│   └─> Database has no courses
│       └─> Run: psql -U postgres -d stock_db -f seed-data.sql
│
└─> Is something else?
    └─> Check TROUBLESHOOTING.md
```

---

## What the Fix Does

### Before (Hard to Debug)
```
Error loading courses.
```
❌ No idea what went wrong

### After (Easy to Debug)
```
⚠️ Error loading courses: Failed to fetch
Make sure the backend server is running on http://localhost:5000
```
✅ Clear explanation of what's wrong

### Console Logs Now Show
```javascript
Fetching: http://localhost:5000/api/courses
Success: /courses [
  { id: 1, title: "Stock Trading 101", ... },
  { id: 2, title: "Technical Analysis", ... }
]
```
✅ Exact API calls and responses

---

## System Architecture

```
┌─────────────────────────────────────────────────────┐
│                    Your Computer                    │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────┐    ┌──────────────────────┐   │
│  │   index.html    │    │   Backend Server     │   │
│  │  (Frontend)     │    │   (Node.js + Express)│   │
│  │                 │    │   Port: 5000         │   │
│  │ Displays:       │    │                      │   │
│  │ - Courses       │◄──►│ API Endpoints:       │   │
│  │ - Blog Posts    │    │ - /api/courses       │   │
│  │ - Forms         │    │ - /api/blog          │   │
│  │                 │    │ - /api/auth          │   │
│  └─────────────────┘    │ - /api/enrollments   │   │
│          │              └──────────┬───────────┘   │
│          │                         │               │
│          │              ┌──────────▼───────────┐   │
│          │              │ PostgreSQL Database │   │
│          └─────────────►│ (stock_db)          │   │
│                         │                     │   │
│                         │ Tables:             │   │
│                         │ - users             │   │
│                         │ - courses           │   │
│                         │ - blog_posts        │   │
│                         │ - enrollments       │   │
│                         └─────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## All Files You Need

```
stock/
├── index.html              ← Frontend (open in browser)
├── server.js               ← Backend entry point
├── package.json            ← NPM dependencies
├── .env                    ← Database config (create this!)
├── schema.sql              ← Database tables
├── seed-data.sql           ← Sample courses and posts
│
├── QUICK_START.md          ← Read this first!
├── TROUBLESHOOTING.md      ← If something breaks
├── FIXES_APPLIED.md        ← What was fixed
├── FRONTEND_API.md         ← API documentation
├── BACKEND.md              ← Backend documentation
│
├── middleware/
│   └── authMiddleware.js
│
└── routes/
    ├── auth.js
    ├── courses.js
    ├── enrollments.js
    └── blog.js
```

---

## Verification Checklist

- [ ] Node.js installed (`node --version` shows v14+)
- [ ] npm installed (`npm --version` shows 6+)
- [ ] PostgreSQL installed (`psql --version` shows 12+)
- [ ] Ran `npm install` in project folder
- [ ] Created `.env` file with correct credentials
- [ ] Created PostgreSQL database (`stock_db`)
- [ ] Ran schema.sql (`psql ... -f schema.sql`)
- [ ] Backend starts without errors (`npm run dev`)
- [ ] Health check works (`http://localhost:5000/api/health`)
- [ ] Courses load in browser (no error message)

If all checked ✅, you're good to go!

---

## Support

- See **QUICK_START.md** for setup
- See **TROUBLESHOOTING.md** for debugging
- See **FIXES_APPLIED.md** for what was changed
- Check browser console (F12) for exact errors
- Check terminal output where you ran `npm run dev`
