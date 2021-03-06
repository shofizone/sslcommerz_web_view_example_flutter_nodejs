const express = require('express')
const router = express.Router()

const {
    handleSSLCzIpn,
} = require('../controllers/paymentController')
router.post("/ssl-ipn", handleSSLCzIpn);

module.exports = router;