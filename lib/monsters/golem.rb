require_relative '../sprite_actions/actions'

class Golem
  include Actions
  attr_accessor :health, :attack_power
  attr_reader :sprite_class, :accuracy

  def initialize(health = 50.0, attack_power = 15.0)
    @health = health
    @attack_power = attack_power
    # randomly select num from [1,2,3,4,5] and divide by size. ex.. 4/5 * attack_power = 4 attack pts
    @accuracy = (1..20).to_a
    @sprite_class = :Golem
  end
end
