module Actions
  def type
    :sprite
  end

  def attack(obj)
    # calculate attack point based on accuracy
    atk_points = (accuracy.sample / accuracy.length.to_f) * attack_power
    puts "<----------------------------------------------------->"
    puts "#{sprite_class} attacks #{obj.sprite_class} with #{atk_points} damage"
    puts "<----------------------------------------------------->"
    obj.health -= atk_points
  end

  def dead
    health <= 0
  end
end
