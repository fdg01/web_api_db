const express = require('express');
const router = express.Router();
const { login, register, getMe } = require('../controllers/authController');
const { protect } = require('../middleware/auth');
const { loginValidation, registerValidation } = require('../middleware/validators');

router.post('/login', loginValidation, login);
router.post('/register', registerValidation, register);
router.get('/me', protect, getMe);

module.exports = router;
