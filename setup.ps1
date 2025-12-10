#!/usr/bin/env pwsh
# Setup script for alphaprime backend

Write-Host "================================"
Write-Host "Alphaprime Backend Setup"
Write-Host "================================" -ForegroundColor Green

# Check Node.js
Write-Host ""
Write-Host "Checking Node.js..." -ForegroundColor Cyan
$nodeVersion = node --version 2>&1
Write-Host "✓ Node.js: $nodeVersion" -ForegroundColor Green

# Check npm
Write-Host ""
Write-Host "Checking npm..." -ForegroundColor Cyan
$npmVersion = npm --version 2>&1
Write-Host "✓ npm: $npmVersion" -ForegroundColor Green

# Install dependencies
Write-Host ""
Write-Host "Installing npm dependencies..." -ForegroundColor Cyan
npm install
Write-Host "✓ Dependencies installed" -ForegroundColor Green

# Done
Write-Host ""
Write-Host "================================"
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "================================"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Create .env file with your PostgreSQL database credentials"
Write-Host "2. Create PostgreSQL database: createdb stock_db"
Write-Host "3. Run schema: psql -U postgres -d stock_db -f schema.sql"
Write-Host "4. Load sample data: psql -U postgres -d stock_db -f seed-data.sql"
Write-Host "5. Start the backend server: npm run dev"
Write-Host "6. Open index.html in your browser"
Write-Host ""
Write-Host "Backend URL: localhost:5000"
Write-Host ""
