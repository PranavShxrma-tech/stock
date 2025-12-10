# Getting Node.js Installed - Quick Guide

## You Need to Install Node.js First

Node.js is not installed on your computer yet. That's why `npm run dev` doesn't work.

### Step 1: Download Node.js

Go to: https://nodejs.org/

**Choose LTS (Long Term Support)** - it's the stable version recommended for production.

Click the big blue button to download.

### Step 2: Install Node.js

1. Open the downloaded installer
2. Click "Next" through all the screens
3. Make sure "npm package manager" is checked
4. Click "Install"
5. **IMPORTANT: Restart your computer after installation**

### Step 3: Verify Installation

Open a new PowerShell window and run:

```powershell
node --version
npm --version
```

You should see version numbers like:
```
v18.17.0
9.6.7
```

### Step 4: Start Backend Server

Once Node.js is installed:

```powershell
cd c:\Users\Acer\Documents\GitHub\stock
npm install
npm run dev
```

You should see:
```
Server running on port 5000
```

### Step 5: Test Backend

Open your browser and visit:
```
http://localhost:5000/api/health
```

You should see JSON:
```json
{"status":"Backend is running","timestamp":"2025-12-10T..."}
```

---

## Why You Need Node.js

Your backend server (`server.js`) is written in Node.js. To run it, you need:
- **Node.js** - JavaScript runtime
- **npm** - Package manager (comes with Node.js)

Think of it like:
- Python code needs Python installed
- Java code needs Java installed
- Node.js code needs Node.js installed

---

## Still Need Help?

After installing Node.js:
1. Restart your computer
2. Open a NEW PowerShell window
3. Run: `npm run dev`
4. Open index.html in browser

The backend will be running on http://localhost:5000
