# Weather Info

A small dockerized node.js application, getting the current temperature from openweathermap for the given city.

Usage:
```
docker build -t node_weatherinfo .
docker run -p 8080:8080 -e APIKEY=<YOUR_API_KEY> -t node_weatherinfo
```
