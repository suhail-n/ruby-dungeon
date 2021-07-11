require_relative '../sprite_actions/actions'

class Vampire
  include Actions
  attr_accessor :health, :attack_power
  attr_reader :sprite_class, :accuracy

  def initialize(health = 20.0, attack_power = 4.0)
    @health = health
    @attack_power = attack_power
    # randomly select num from [1,2,3,4,5] and divide by size. ex.. 4/5 * attack_power = 4 attack pts
    @accuracy = (1..4).to_a
    @sprite_class = :Vampire
  end
end
