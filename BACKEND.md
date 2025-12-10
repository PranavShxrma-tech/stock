# Stock Backend - alphaprime

A Node.js/Express backend for the alphaprime stock trading and learning platform.

## Features

- User Authentication (Register/Login with JWT)
- Course Management (CRUD operations)
- Course Enrollments
- Blog Posts
- PostgreSQL Database Integration

## Setup

### Prerequisites

- Node.js (v14+)
- PostgreSQL
- npm

### Installation

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file with your configuration:
```
DATABASE_URL=postgresql://user:password@localhost:5432/stock_db
PORT=5000
JWT_SECRET=your_jwt_secret_key_change_this
NODE_ENV=development
```

3. Create the database and run the schema:
```bash
psql -U your_user -d stock_db -f schema.sql
```

### Running the Server

**Development:**
```bash
npm run dev
```

**Production:**
```bash
npm start
```

The server will run on `http://localhost:5000`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login and get JWT token
- `GET /api/auth/me` - Get current user profile (requires token)

### Courses
- `GET /api/courses` - Get all courses
- `GET /api/courses/:id` - Get specific course
- `POST /api/courses` - Create course (requires authentication)

### Enrollments
- `GET /api/enrollments` - Get user's enrollments (requires token)
- `POST /api/enrollments/:courseId` - Enroll in a course (requires token)
- `DELETE /api/enrollments/:enrollmentId` - Unenroll from course (requires token)

### Blog
- `GET /api/blog` - Get all blog posts
- `GET /api/blog/:slug` - Get specific blog post
- `POST /api/blog` - Create blog post

### Health Check
- `GET /api/health` - Check if backend is running

## Authentication

API endpoints that require authentication need the JWT token in the Authorization header:

```
Authorization: Bearer <your_jwt_token>
```

## File Structure

```
stock/
├── server.js              # Main server file
├── db.js                  # Database connection
├── package.json           # Dependencies
├── .env                   # Environment variables
├── schema.sql             # Database schema
├── middleware/
│   └── authMiddleware.js  # JWT authentication middleware
└── routes/
    ├── auth.js            # Authentication routes
    ├── courses.js         # Course routes
    ├── enrollments.js     # Enrollment routes
    └── blog.js            # Blog routes
```

## License

MIT
