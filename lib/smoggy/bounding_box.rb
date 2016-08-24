class BoundingBox
  attr_accessor :sw
  attr_accessor :ne

  def initialize(south_west, north_east)
    @sw = south_west
    @ne = north_east
  end

  def to_str
    str = "#{sw.lng},#{sw.lat},#{ne.lng},#{ne.lat}"
    str
  end
end
