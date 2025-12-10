# Node.js Installation - Next Steps

## Node.js Installed But Not Recognized

Node.js was installed, but your system needs to be restarted for the PATH to update.

### IMPORTANT: Restart Your Computer

After installing Node.js, you **MUST restart your computer** for the system to recognize the `node` and `npm` commands.

### Steps:

1. **Save all your work**
2. **Restart your computer** (click Start → Power → Restart)
3. **Wait for restart to complete**
4. **Open PowerShell again**
5. **Verify installation**:
   ```powershell
   node --version
   npm --version
   ```
   You should see version numbers

6. **Then run these commands**:
   ```powershell
   cd c:\Users\Acer\Documents\GitHub\stock
   npm install
   npm run dev
   ```

You should see:
```
Server running on port 5000
```

7. **Open browser** and visit:
   ```
   http://localhost:5000/api/health
   ```

---

## Why Restart is Needed

When you install Node.js, it updates your system's PATH environment variable. PowerShell caches environment variables, so it doesn't see the new PATH until you:
- Close and reopen PowerShell, OR
- Restart your computer

A full computer restart guarantees it will work.

---

## Once Restarted

Come back and let me know, and I'll start the backend server for you!
