class Configuration
  attr_accessor :adapter

  def initialize
    @adapter = :activerecord
  end
end