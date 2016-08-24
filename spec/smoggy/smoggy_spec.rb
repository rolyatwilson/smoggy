require_relative '../spec_helper'

module Smoggy
  describe Airnow do
    before(:all) do
      ENV[Constants::SECRETS] = 'config/secrets_file.yml'
      @air = Airnow.new
    end

    it 'gets data for bounding box' do
      sw = Coordinate.new(37.043937, -114.013062)
      ne = Coordinate.new(42.120376, -109.179077)
      bbox = BoundingBox.new(sw, ne)

      data = @air.aqi_with_bounding_box(bbox)
      expect(data).to be_a(Array)
      expect(data.length).to be > 0
    end

    it 'gets data for coordinates' do
      data = @air.aqi_with_coordinates(40.724917, -112.024692)
      expect(data).to be_a(Array)
      expect(data.length).to be > 0
    end

    it 'gets data for zipcode' do
      data = @air.aqi_with_zipcode('94937')
      expect(data).to be_a(Array)
      expect(data.length).to be > 0
    end
  end
end
