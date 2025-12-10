# Troubleshooting Course Loading Issues

## Problem: "Error loading courses"

### Step 1: Check if Backend is Running

Open a terminal and run:
```bash
cd c:\Users\Acer\Documents\GitHub\stock
npm run dev
```

You should see:
```
Server running on port 5000
```

### Step 2: Verify the Health Endpoint

Open your browser and visit:
```
http://localhost:5000/api/health
```

You should see a JSON response like:
```json
{"status":"Backend is running","timestamp":"2025-12-10T..."}
```

If not, the backend isn't running properly.

### Step 3: Check Database Connection

Make sure PostgreSQL is running and the database is set up:

```bash
# Check if PostgreSQL is running
psql --version

# Connect to the database
psql -U postgres -d stock_db

# List tables (should show users, courses, blog_posts, etc.)
\dt

# Check if there are any courses
SELECT * FROM courses;

# Exit
\q
```

### Step 4: Seed Sample Data

If the database is empty, load sample courses:

```bash
psql -U postgres -d stock_db -f seed-data.sql
```

### Step 5: Check Network Error

Open your browser's Developer Tools (F12) and:

1. Go to **Console** tab - look for red errors
2. Go to **Network** tab - click "Fetch/XHR"
3. Refresh the page
4. Look for the `/api/courses` request
5. Check the response status (should be 200)

### Common Errors and Solutions

#### Error: "Cannot connect to http://localhost:5000"
- **Solution**: Make sure backend is running (see Step 1)
- **Solution**: Check PORT in `.env` file matches (should be 5000)

#### Error: "Failed to fetch"
- **Solution**: Check if backend is accessible: `http://localhost:5000/api/health`
- **Solution**: Check browser console for CORS errors
- **Solution**: Verify CORS is enabled in `server.js`

#### Error: "Database connection failed"
- **Solution**: Check PostgreSQL is running
- **Solution**: Verify `DATABASE_URL` in `.env` is correct
- **Solution**: Ensure database user has correct permissions

```bash
# Grant permissions
psql -U postgres -d stock_db
GRANT ALL PRIVILEGES ON DATABASE stock_db TO your_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_user;
\q
```

#### Error: "relation 'courses' does not exist"
- **Solution**: Run the schema file to create tables:
```bash
psql -U postgres -d stock_db -f schema.sql
```

#### Error: "No courses available at the moment"
- **Solution**: Insert sample data:
```bash
psql -U postgres -d stock_db -f seed-data.sql
```

### Step 6: Verify Frontend API Configuration

Open `index.html` in browser and check:

1. Press F12 to open Developer Tools
2. Go to **Console** tab
3. Type: `API_BASE`
4. It should show: `http://localhost:5000/api`

If it's different, update this line in `index.html`:
```javascript
const API_BASE = 'http://localhost:5000/api';
```

### Step 7: Test API Endpoints Directly

Use PowerShell to test API endpoints:

```powershell
# Health check
Invoke-WebRequest -Uri "http://localhost:5000/api/health" -Method GET | Select-Object -Expand Content

# Get courses
Invoke-WebRequest -Uri "http://localhost:5000/api/courses" -Method GET | Select-Object -Expand Content

# Get blog posts
Invoke-WebRequest -Uri "http://localhost:5000/api/blog" -Method GET | Select-Object -Expand Content
```

### Step 8: Check .env File

Verify `.env` has correct values:

```
DATABASE_URL=postgresql://username:password@localhost:5432/stock_db
PORT=5000
JWT_SECRET=your_jwt_secret_key_change_this
NODE_ENV=development
```

Replace `username:password` with your PostgreSQL credentials.

### Debugging Mode

Enable detailed logging by checking browser console:

1. Open `index.html` in browser
2. Press F12 (Developer Tools)
3. Go to **Console** tab
4. You should see logs like:
   - `Fetching: http://localhost:5000/api/courses`
   - `Success: /courses [Array(5)]`

This helps identify exactly where the error occurs.

### Complete Reset

If nothing works, try a complete reset:

```bash
# Stop any running Node processes
# Stop PostgreSQL

# Clear database
psql -U postgres -c "DROP DATABASE stock_db;"
psql -U postgres -c "CREATE DATABASE stock_db;"

# Create fresh tables
psql -U postgres -d stock_db -f schema.sql

# Add sample data
psql -U postgres -d stock_db -f seed-data.sql

# Start backend
npm run dev
```

Then refresh your browser.

### Still Having Issues?

1. Check terminal output for error messages
2. Check `npm` installation: `npm --version`
3. Check Node.js version: `node --version` (should be v14+)
4. Check PostgreSQL version: `psql --version`
5. Look at database logs: PostgreSQL service logs
6. Check Express server logs in terminal running `npm run dev`

### Additional Resources

- Check `BACKEND.md` for detailed backend setup
- Check `FRONTEND_API.md` for API documentation
- View network requests in browser Developer Tools (F12 > Network tab)
- Check server terminal for `console.log` output
