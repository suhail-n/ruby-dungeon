# require "#{__dir__}/lib/potions"
# require "#{__dir__}/lib/sprites"
require_relative '../sprites'
require_relative '../potions'

class Game
  attr_accessor :board

  @@monsters = [Vampire, Golem]
  @@potions = [HealthPotion]

  def initialize(board_size = 5, num_monsters = 8, num_potions = 5)
    # create 5 x 5 game board
    @board = (1..board_size).map { |_| [false] * board_size }
    @game_over = false

    # fill up game board with monsters
    num_monsters.times do |_|
      x = rand(board_size)
      y = rand(board_size)
      while @board[x][y]
        x = rand(board_size)
        y = rand(board_size)
      end
      @board[x][y] = @@monsters.sample.new
    end

    # fill up game board with potions
    num_potions.times do |_|
      x = rand(board_size)
      y = rand(board_size)
      while @board[x][y]
        x = rand(board_size)
        y = rand(board_size)
      end
      @board[x][y] = @@potions.sample.new
    end
  end

  def roll_die
    puts 'press enter to roll die'
    _ = gets
    roll = rand(1..6)
    puts "you have rolled a #{roll}"
    roll
  end

  def move_spaces(x, y, n)
    # 0,0
    # p=2 + 5 = 7, 7 - 5 = 2
    # 0,1,2,3,4
    initial_x = x
    initial_y = y
    puts "press enter to move #{n} spaces"
    gets
    temp = y + n
    if y + n >= @board.length
      y = y + n - @board.length
      x += 1
    else
      y = temp
    end
    puts "you have moved from position [#{initial_x}, #{initial_y}] to [#{x}, #{y}]"
    [x, y]
  end

  def print_health(player, monster = false)
    puts '<*****************************************************>'
    puts "#{player.sprite_class}: HP #{player.health}"
    puts "#{monster.sprite_class}: HP #{monster.health}" if monster
    puts '<*****************************************************>'
  end

  def handle_space(player, x, y)
    monster = @board[x] ? @board[x][y] : nil
    if !monster
      puts 'You have landed on a safe space'
    elsif monster.type == :potion
      monster.drink(player)
    else
      puts '<=====================================================>'
      puts "A dangerous #{monster.sprite_class} has appeared in your path"
      while !player.dead && !monster.dead
        monster.attack(player)
        print_health(player, monster)
        puts "press enter to attack the #{monster.sprite_class}"
        gets
        player.attack(monster)
        print_health(player, monster)
        sleep(2)
      end
      if player.dead
        puts "you have been slain by the #{monster.sprite_class}"
      else
        puts "you have slain the #{monster.sprite_class}"
        puts '<=====================================================>'
      end
    end
  end

  def run
    puts 'Welcome to the Ruby Dungeon'
    puts 'Roll the die and take a chance'
    x = 0
    y = -1
    player = Warrior.new
    until @game_over
      print_health(player)
      x, y = move_spaces(x, y, roll_die)
      handle_space(player, x, y)
      @game_over = true if player.dead || (x >= board.length) || (y >= board.length)
    end
    puts 'Game Over!!'
    if player.dead
      puts 'You have died a pointless death'
    else
      puts 'You have completed the ruby dungeon'
    end
  end
end
