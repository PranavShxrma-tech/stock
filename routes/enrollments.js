const express = require('express');
const pool = require('../db');
const authMiddleware = require('../middleware/authMiddleware');

const router = express.Router();

// Enroll in a course
router.post('/:courseId', authMiddleware, async (req, res) => {
  try {
    const { courseId } = req.params;
    const userId = req.userId;

    // Check if course exists
    const courseExists = await pool.query('SELECT id FROM courses WHERE id = $1', [courseId]);
    if (courseExists.rows.length === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }

    // Check if already enrolled
    const alreadyEnrolled = await pool.query(
      'SELECT id FROM enrollments WHERE user_id = $1 AND course_id = $2',
      [userId, courseId]
    );

    if (alreadyEnrolled.rows.length > 0) {
      return res.status(400).json({ error: 'Already enrolled in this course' });
    }

    // Enroll user
    const result = await pool.query(
      'INSERT INTO enrollments (user_id, course_id, status) VALUES ($1, $2, $3) RETURNING *',
      [userId, courseId, 'active']
    );

    res.status(201).json({ message: 'Enrolled successfully', enrollment: result.rows[0] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to enroll' });
  }
});

// Get user enrollments
router.get('/', authMiddleware, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT e.*, c.title, c.slug, c.image_url 
       FROM enrollments e 
       JOIN courses c ON e.course_id = c.id 
       WHERE e.user_id = $1 
       ORDER BY e.created_at DESC`,
      [req.userId]
    );

    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch enrollments' });
  }
});

// Unenroll from course
router.delete('/:enrollmentId', authMiddleware, async (req, res) => {
  try {
    const { enrollmentId } = req.params;

    // Verify ownership
    const enrollment = await pool.query(
      'SELECT user_id FROM enrollments WHERE id = $1',
      [enrollmentId]
    );

    if (enrollment.rows.length === 0) {
      return res.status(404).json({ error: 'Enrollment not found' });
    }

    if (enrollment.rows[0].user_id !== req.userId) {
      return res.status(403).json({ error: 'Unauthorized' });
    }

    await pool.query('DELETE FROM enrollments WHERE id = $1', [enrollmentId]);

    res.json({ message: 'Unenrolled successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to unenroll' });
  }
});

module.exports = router;
