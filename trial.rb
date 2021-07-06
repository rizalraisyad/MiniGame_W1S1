class Player
  attr_accessor :name, :hitPoint, :damage
  def initialize(name,hitPoint,damage)
    self.name, = name
    self.hitPoint = hitPoint
    self.damage = damage
  end

  def haveAttack(damage)
    self.hitPoint -= damage
  end

  def to_s
    "#{self.name} has #{self.hitPoint} and #{self.damage}"
  end

  def checkHitpoint()
   self.hitPoint
  end
end

class Arena
  attr_accessor :player1, :player2
  def initialize(player1,player2)
    self.player1 = player1
    self.player2 = player2
  end
  def onAttack(playerAttack, playerTarget)
    playerTarget.haveAttack(playerAttack.damage)
    puts "#{playerAttack.name} attacks #{playerTarget.name} with #{playerAttack.damage} damage \n"
    puts "#{playerTarget.name} has #{playerTarget.hitPoint} hitpoint and #{playerTarget.damage} damage"
  end
end

player1 = Player.new("Sakai", 100,50)
player2 = Player.new("Khotun Khan", 500,50)

arena = Arena.new(player1,player2)
$playerAttack = player1
$playerdefens = player2
while player1.hitPoint> 0 || player2.hitPoint> 0
  arena.onAttack($playerAttack,$playerdefens)
  $temp = $playerAttack
  $playerAttack = $playerdefens
  $playerdefens = $temp
end
if player1.hitPoint == 0 
  puts "Player 2 Win"
elsif
  puts "Player 1 Win"
end