const express = require("express");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const dotenv = require("dotenv");
const path = require('path');
const cors = require("cors");

const webRouts = require('./routs/webRouts');
const apiRouts = require('./routs/apiRouts');

dotenv.config();
const app = express();

if (process.env.NODE_ENV === "development") {
    app.use(cors({origin: `http://localhost:3000`}));
}


app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(express.static('./public'));

app.use(morgan("dev"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use('/', webRouts);
app.use('/api', apiRouts);


const port = process.env.PORT || "8000";
app.listen(port, () =>
    console.log(`Server listening at http://localhost:${port}`),
);





