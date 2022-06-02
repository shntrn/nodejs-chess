var app = require('./app');
var server = require('./server');
require('./sockets');

var bodyParser = require('body-parser');

var ping = require('./ping');
var auth = require('./auth');
var api = require('./api');

var checkAuth = require('./auth/checkAuth');

server.listen(80);

app.use(bodyParser.json());

app.use('/ping', ping);
app.use('/', auth);
app.use('/api', checkAuth, api);
