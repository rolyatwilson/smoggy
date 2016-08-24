module Smoggy
  class Airnow
    attr_accessor :base_url
    attr_accessor :data_format
    attr_accessor :api_key
    attr_accessor :time_format
    attr_accessor :parameters

    def initialize
      @api_key     = Environment.new.token
      @base_url    = 'http://www.airnowapi.org'
      @data_format = 'format=application/json'
      @time_format = '%Y-%m-%dT%H'
      @parameters  = default_parameters
    end

    def aqi_with_bounding_box(bbox, start_date = DateTime.now - (1 / 24.0), end_date = DateTime.now)
      raise 'expected a DateTime object' unless start_date.is_a?(DateTime)
      raise 'expected a DateTime object' unless end_date.is_a?(DateTime)
      start_date  = start_date.strftime(time_format)
      end_date    = end_date.strftime(time_format)
      date_range = "startDate=#{start_date}&endDate=#{end_date}"

      path = '/aq/data/'
      uri  = URI.parse("#{base_url}#{path}"\
                      "?#{date_range}"\
                      "&parameters=#{parameters}"\
                      "&BBOX=#{bbox.to_str}"\
                      "&dataType=B&#{data_format}"\
                      "&verbose=1&API_KEY=#{api_key}")
      resp = Net::HTTP.get_response(uri)
      data = parse_data(uri, resp, "aqi_with_bounding_box: #{bbox}")
      data
    end

    def aqi_with_coordinates(lat, lng, distance = 50)
      path = '/aq/observation/latLong/current/'
      uri  = URI.parse("#{base_url}#{path}"\
                      "?#{data_format}"\
                      "&latitude=#{lat}"\
                      "&longitude=#{lng}"\
                      "&distance=#{distance}"\
                      "&API_KEY=#{api_key}")
      resp = Net::HTTP.get_response(uri)
      data = parse_data(uri, resp, "aqi_with_coordinates: #{lat}, #{lng}")
      data
    end

    def aqi_with_zipcode(zipcode, distance = 50)
      path = '/aq/observation/zipCode/current/'
      uri  = URI.parse("#{base_url}#{path}"\
                      "?#{data_format}"\
                      "&zipCode=#{zipcode}"\
                      "&distance=#{distance}"\
                      "&API_KEY=#{api_key}")
      resp = Net::HTTP.get_response(uri)
      data = parse_data(uri, resp, "aqi_with_zipcode: #{zipcode}")
      data
    end

    def parse_data(uri, response, exp)
      raise "Did not receive 200 response for #{exp} for URI: #{uri}" unless response.code == '200'
      data = JSON.parse(response.body)
      data = symbolize_array_elements(data)
      data
    end

    def default_parameters
      params = 'O3,PM25,PM10,CO,NO2,SO2'
      params
    end

    def symbolize_array_elements(array)
      raise 'symbolize_array_elements expects an Array' unless array.is_a?(Array)
      array.each do |hash|
        hash.deep_symbolize_keys! if hash.is_a?(Hash)
      end
      array
    end
  end
end
