const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const port = 8080;
const request = require('request');
let apiKey = process.env.APIKEY;
app.set('apiKey', apiKey);

app.use(bodyParser.urlencoded({ extended: true }));
app.use('/public', express.static(process.cwd() + '/public'));
app.set('view engine', 'ejs');

app.get('/', function (req, res) {
  res.render('pages/index', {weather: null, error: null});
})

app.post('/', function (req, res) {
  let city = req.body.city;
  let url = `http://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${apiKey}`
request(url, function (err, response, body) {
    if(err){
      res.render('pages/index', {weather: null, error: 'Error, please try again'});
    } else {
      let weather = JSON.parse(body)
      if(weather.main == undefined){
        res.render('pages/index', {weather: null, error: 'Error, please try again'});
      } else {
        var iconCode = weather.weather[0].icon;
        var iconUrl = "http://openweathermap.org/img/w/" + iconCode + ".png";
        //console.log("weather:"+iconCode+" "+iconUrl)
        let weatherText = `It's ${weather.main.temp} degrees in ${weather.name}!`;
        res.render('pages/index', {weather: weatherText, weatherIcon: iconUrl, error: null});
      }
    }
  });
})

app.listen(port, function () {
  console.log('Example app listening on port 8080!')
})
