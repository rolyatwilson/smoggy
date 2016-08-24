# Smoggy

[![Build Status](https://travis-ci.org/rolyatwilson/smoggy.svg?branch=master)](https://travis-ci.org/rolyatwilson/smoggy)

Smoggy is a ruby library for fetching air quality data from 
[AirNow.gov](https://www.airnow.gov/). 

## Requirements

An API key is required to access the AirNow API. Getting an API key is
easy. Just create an account at [AirNowAPI](https://docs.airnowapi.org/)
and request an API key. Store the API key the *config/secrets_file.yml*
file or set the *ENV['AIRNOW_API_KEY']* variable.

## Setting the API key
    cp config/secrets_file.yml.example config/secrets_file.yml
    # save the API key in config/secrets_file.yml 
    
    # OR
    ENV['AIRNOW_API_KEY'] = <some_api_key>

## How to get Air Quality data
### By Bounding Box
    sw = Smoggy::Coordinate.new(37.043937, -114.013062)
    ne = Smoggy::Coordinate.new(42.120376, -109.179077)
    bbox = Smoggy::BoundingBox.new(sw, ne)

    data = Smoggy::Airnow.new.aqi_with_bounding_box(bbox)

### By GPS Coordinates
    data = Smoggy::Airnow.new.aqi_with_coordinates(40.724917, -112.024692)

### By Zipcode
    data = Smoggy::Airnow.new.aqi_with_zipcode('94937')