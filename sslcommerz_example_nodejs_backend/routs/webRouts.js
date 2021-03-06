const express = require('express')
const router = express.Router()

const {
    getHomeView,
} = require('../controllers/homeController')

const {
    getPaymentSuccessView,
    getPaymentFailedView,
    getPaymentCancelView,
} = require('../controllers/paymentController')

router.get("/", getHomeView);
router.post("/payment-success", getPaymentSuccessView);
router.post("/payment-failed", getPaymentFailedView);
router.post("/payment-cancel", getPaymentCancelView);

module.exports = router;