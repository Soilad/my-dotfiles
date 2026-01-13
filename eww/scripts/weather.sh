#!/bin/sh

# weather.sh - Get weather with emoji icons

curl -s "wttr.in/$1?format=j1" | jq -r '
  def get_emoji(code):
    {
      "113": "☀️",   # Sunny
      "116": "⛅",   # Partly cloudy
      "119": "☁️",   # Cloudy
      "122": "☁️",   # Overcast
      "143": "🌫️",   # Mist
      "176": "🌦️",   # Patchy rain
      "179": "🌨️",   # Patchy snow
      "182": "🌨️",   # Patchy sleet
      "185": "🌨️",   # Patchy freezing drizzle
      "200": "⛈️",   # Thundery outbreaks
      "227": "🌨️",   # Blowing snow
      "230": "❄️",   # Blizzard
      "248": "🌫️",   # Fog
      "260": "🌫️",   # Freezing fog
      "263": "🌦️",   # Patchy light drizzle
      "266": "🌦️",   # Light drizzle
      "281": "🌧️",   # Freezing drizzle
      "284": "🌧️",   # Heavy freezing drizzle
      "293": "🌦️",   # Patchy light rain
      "296": "🌦️",   # Light rain
      "299": "🌧️",   # Moderate rain
      "302": "🌧️",   # Heavy rain
      "305": "🌧️",   # Light heavy rain
      "308": "🌧️",   # Heavy rain at times
      "311": "🌧️",   # Light freezing rain
      "314": "🌧️",   # Moderate/Heavy freezing rain
      "317": "🌨️",   # Light sleet
      "320": "🌨️",   # Moderate/Heavy sleet
      "323": "🌨️",   # Patchy light snow
      "326": "🌨️",   # Light snow
      "329": "❄️",   # Patchy moderate snow
      "332": "❄️",   # Moderate snow
      "335": "❄️",   # Patchy heavy snow
      "338": "❄️",   # Heavy snow
      "350": "🌨️",   # Ice pellets
      "353": "🌦️",   # Light rain shower
      "356": "🌧️",   # Moderate/Heavy rain shower
      "359": "🌧️",   # Torrential rain shower
      "362": "🌨️",   # Light sleet showers
      "365": "🌨️",   # Moderate/Heavy sleet showers
      "368": "🌨️",   # Light snow showers
      "371": "❄️",   # Moderate/Heavy snow showers
      "374": "🌨️",   # Light showers of ice pellets
      "377": "🌨️",   # Moderate/Heavy showers of ice pellets
      "386": "⛈️",   # Patchy light rain with thunder
      "389": "⛈️",   # Moderate/Heavy rain with thunder
      "392": "❄️⛈️", # Patchy light snow with thunder
      "395": "❄️⛈️"  # Moderate/Heavy snow with thunder
    }[code] // "🌀";
  
  .current_condition[0] as $cc |
  {
    icon: get_emoji($cc.weatherCode),
    description: $cc.weatherDesc[0].value,
    temperature: "\($cc.temp_C)°C",
    feels_like: "Feels like \($cc.FeelsLikeC)°C",
    wind: "\($cc.windspeedKmph) km/h",
    humidity: "\($cc.humidity)%",
    pressure: "\($cc.pressure) hPa",
    visibility: "\($cc.visibility) km"
  }
'
