//Configuración inicial
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var expressSanitizer = require('express-sanitizer');


// Pone en variables las rutas de aplicación
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
//agregando un sanitizador para las variables que ingresan los usuarios
app.use(expressSanitizer());
app.use(express.static(path.join(__dirname, 'public')));
//agregando jQuery
app.use('/jquery', express.static(__dirname + '/node_modules/jquery/dist/'));
//agregando ajax
app.use('/ajax', express.static(__dirname + '/node_modules/ajax/lib/'));
//agregando Bootstrap
app.use('/bootstrap', express.static(__dirname + '/node_modules/bootstrap/dist/'));

//app.use('nodemailer', express.static(__dirname + 'node_modules/nodemailer'));

// RUTEO de los archivos a direcciones en la aplicación
app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
