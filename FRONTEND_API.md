# Alphaprime - Full Stack Setup Guide

## Project Structure

```
stock/
├── index.html              # Frontend with API integration
├── server.js               # Express backend
├── db.js                   # Database connection
├── package.json            # Dependencies
├── schema.sql              # Database schema
├── .env                    # Environment variables
├── .env.example            # Example configuration
├── BACKEND.md              # Backend documentation
├── FRONTEND_API.md         # This file
├── middleware/
│   └── authMiddleware.js   # JWT authentication
└── routes/
    ├── auth.js             # Authentication endpoints
    ├── courses.js          # Course endpoints
    ├── enrollments.js      # Enrollment endpoints
    └── blog.js             # Blog endpoints
```

## Setup Instructions

### 1. Backend Setup

#### Prerequisites
- Node.js (v14+)
- PostgreSQL (v12+)
- npm

#### Installation

1. Navigate to project directory:
```bash
cd c:\Users\Acer\Documents\GitHub\stock
```

2. Install dependencies:
```bash
npm install
```

3. Create a PostgreSQL database:
```bash
psql -U postgres
CREATE DATABASE stock_db;
\q
```

4. Update `.env` with your database credentials:
```
DATABASE_URL=postgresql://username:password@localhost:5432/stock_db
PORT=5000
JWT_SECRET=your_secure_random_string_here
NODE_ENV=development
```

5. Run the database schema:
```bash
psql -U username -d stock_db -f schema.sql
```

6. Start the backend server:
```bash
# Development (with auto-reload)
npm run dev

# Production
npm start
```

The backend will run on `http://localhost:5000`

### 2. Frontend Setup

The frontend is already integrated with the backend API.

1. Update the `API_BASE` in `index.html` (line ~6) if your backend runs on a different URL:
```javascript
const API_BASE = 'http://localhost:5000/api';
```

2. Open `index.html` in a web browser (or serve it with a local server):
```bash
# Using Python 3
python -m http.server 8000

# Using Node.js
npx http-server

# Or just open directly in browser
start index.html
```

3. The frontend will automatically:
   - Load courses from `/api/courses`
   - Load blog posts from `/api/blog`
   - Handle registration via `/api/auth/register`
   - Support course enrollment (when authenticated)

## API Integration Features

### Courses
- **Automatic Loading**: Courses are loaded from the backend and displayed dynamically
- **Course Cards**: Display title, description, and image from database
- **Enrollment Modal**: Click "Enroll Now" to open enrollment form

### Blog Posts
- **Dynamic Content**: Blog posts loaded from backend
- **Read More**: Click "Read More" to open full post content in modal

### User Registration
- **Form Validation**: Frontend validates input before submission
- **API Integration**: Sends registration data to `/api/auth/register`
- **OTP Verification**: Demo OTP (1234) for testing
- **Success Handling**: Shows confirmation and allows login

### Authentication (Future)
- **JWT Tokens**: Backend uses JWT for authentication
- **Secure Endpoints**: Protected routes require `Authorization: Bearer <token>` header
- **Local Storage**: Auth token can be stored in browser

## Testing the API

### Using cURL or Postman

#### Register User
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "John Doe",
    "email": "john@example.com",
    "phone": "1234567890",
    "password": "secure123"
  }'
```

#### Login
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "secure123"
  }'
```

#### Get Courses
```bash
curl http://localhost:5000/api/courses
```

#### Get Blog Posts
```bash
curl http://localhost:5000/api/blog
```

#### Enroll in Course (requires token)
```bash
curl -X POST http://localhost:5000/api/enrollments/1 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Database Schema

### Users Table
- `id` - Primary key
- `full_name` - User's full name
- `email` - Unique email address
- `phone` - Unique phone number
- `password_hash` - Encrypted password
- `is_verified` - Account verification status
- `created_at` - Registration timestamp

### Courses Table
- `id` - Primary key
- `title` - Course title
- `slug` - URL-friendly name
- `description` - Course description
- `image_url` - Course image
- `created_at` - Creation timestamp

### Blog Posts Table
- `id` - Primary key
- `title` - Post title
- `slug` - URL-friendly name
- `summary` - Brief summary
- `content` - Full content
- `image_url` - Featured image
- `created_at` - Publication timestamp

### Enrollments Table
- `id` - Primary key
- `user_id` - Foreign key to users
- `course_id` - Foreign key to courses
- `status` - Enrollment status
- `created_at` - Enrollment timestamp

### OTPs Table
- `id` - Primary key
- `user_id` - Foreign key to users
- `code` - 4-digit OTP code
- `purpose` - 'register' or 'enroll'
- `expires_at` - Expiration timestamp
- `used` - Whether OTP has been used
- `created_at` - Creation timestamp

## Environment Variables

### Backend (.env)
```
DATABASE_URL=postgresql://user:password@localhost:5432/stock_db
PORT=5000
JWT_SECRET=your_secure_secret_key
NODE_ENV=development
```

### Frontend (in index.html script)
```javascript
const API_BASE = 'http://localhost:5000/api';
```

## Troubleshooting

### Backend won't start
- Check if port 5000 is in use
- Verify PostgreSQL is running
- Check `.env` file has correct credentials

### Frontend can't connect to backend
- Ensure backend is running on http://localhost:5000
- Check browser console for CORS errors
- Verify API_BASE URL in index.html

### Database errors
- Make sure PostgreSQL service is running
- Check database exists: `psql -l`
- Verify user has correct permissions

### API returns 401 Unauthorized
- Check if JWT token is being sent correctly
- Verify token hasn't expired
- Check JWT_SECRET matches between frontend and backend

## Next Steps

1. **Add Admin Panel**: Create endpoints for creating courses and blog posts
2. **Email OTP**: Implement real OTP sending via Nodemailer
3. **Payment Integration**: Add payment gateway for premium courses
4. **User Dashboard**: Build dashboard to show user enrollments
5. **Advanced Authentication**: Add social login (Google, GitHub)
6. **Course Progress**: Track user progress within courses
7. **Certificate Generation**: Auto-generate certificates on completion

## Support

For issues or questions, check:
- Backend logs in terminal
- Browser console (F12) for frontend errors
- Database logs for SQL errors
