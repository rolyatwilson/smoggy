module Smoggy
  class Coordinate
    attr_accessor :lat
    attr_accessor :lng

    def initialize(latitude, longitude)
      @lat = latitude
      @lng = longitude
    end
  end
end
