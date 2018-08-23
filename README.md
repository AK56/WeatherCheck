# README

WeatherCheck gives you weather statistics for anywhere in US by taking in a zipcode. Weather is consuming OpenWeather API to deliver the weather data. The App is using Rails model caching holding results in cache for upto 30 min. Run the following command to on/off caching in dev mode:
rails dev:cache

The App is configured to tak to PostGreSQL DB, so touch the database.yml file to configure to DB and run rake db:setup
Fire up rails server and get weather stats. Happy Forecasting!
