class HealthPotion
  attr_reader :type

  def initialize
    @hp_increase = (1..30).to_a.sample
    @type = :potion
  end

  def drink(obj)
    # calculate attack point based on accuracy
    obj.health += @hp_increase
    puts "You found a mysterious potion in the dungeon"
    puts "Gulp..."
    puts "Drinking the potion has given you #{@hp_increase}HP increase"
  end
end
