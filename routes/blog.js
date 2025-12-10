const express = require('express');
const { body, validationResult } = require('express-validator');
const pool = require('../db');

const router = express.Router();

// Get all blog posts
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM blog_posts ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch blog posts' });
  }
});

// Get single blog post
router.get('/:slug', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM blog_posts WHERE slug = $1', [req.params.slug]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Blog post not found' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch blog post' });
  }
});

// Create blog post (admin only)
router.post(
  '/',
  [
    body('title').notEmpty(),
    body('slug').notEmpty(),
    body('summary').optional(),
    body('content').notEmpty(),
    body('image_url').optional(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    try {
      const { title, slug, summary, content, image_url } = req.body;

      const result = await pool.query(
        'INSERT INTO blog_posts (title, slug, summary, content, image_url) VALUES ($1, $2, $3, $4, $5) RETURNING *',
        [title, slug, summary, content, image_url]
      );

      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to create blog post' });
    }
  }
);

module.exports = router;
