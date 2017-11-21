#!/usr/bin/env ruby

require_relative '../lib/smoggy'

# ENV[Smoggy::Constants::SECRETS] = '../config/secrets_file.yml'
ENV['AIRNOW_API_KEY'] = '02901529-8336-4C8E-B387-34E585652592'
data = Smoggy::Airnow.new.aqi_with_coordinates(40.724917, -112.024692)
puts data

sw = Smoggy::Coordinate.new(37.043937, -114.013062)
ne = Smoggy::Coordinate.new(42.120376, -109.179077)
bbox = Smoggy::BoundingBox.new(sw, ne)

data = Smoggy::Airnow.new.aqi_with_bounding_box(bbox)
puts data

data = Smoggy::Airnow.new.aqi_with_zipcode('94937')
puts data
