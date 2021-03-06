const siteDomain = process.env.SITE_DOMAIN || `http://192.168.0.186:8000`
const SSLCommerzPayment = require('sslcommerz');
const isLiveServer = process.env.NODE_ENV === "production";

exports.getPaymentSuccessView = (req, res) => {

    const paymentInfo = req.body;
    console.log(paymentInfo);
    res.render('pages/paymentSuccess', {paymentInfo: JSON.stringify(paymentInfo)});
}

exports.getPaymentFailedView = (req, res) => {
    const paymentInfo = req.body;
    console.log(paymentInfo);
    res.render('pages/paymentFailed', {paymentInfo: JSON.stringify(paymentInfo)});
}

exports.getPaymentCancelView = (req, res) => {
    const paymentInfo = req.body;
    console.log(paymentInfo);
    res.render('pages/paymentCancel', {paymentInfo: JSON.stringify(paymentInfo)});
}

exports.handleSSLCzIpn = async (req, res) => {

    // handle ipn here
    console.log(req.body);
    return res.sendStatus(200);
}




