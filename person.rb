class Person
  attr_reader :name, :hitpoint, :attack_damage, :deflect_percentage
  def initialize(name, hitpoint, attack_damage, deflect_percentage)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
    @deflect_percentage = deflect_percentage
  end

  def to_s
    "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage"
  end

  def attack(other_person)
    puts ""
    puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage "
    if(other_person.miss?)
      puts "#{other_person.name} deflects the attack "
    else
    other_person.take_damage(@attack_damage) 
    end
  end

  def take_damage(damage)
    @hitpoint -= damage
  end

# Imagine that attacker always have 100% chance rate, so if deflect% is 100, it means 1:1 from defend and att % so in this code rand will be 0-100 : 0-100
  def miss? 
    if ( rand(0..@deflect_percentage) >= rand(0..100)) 
      true
    else
      false
    end
    
  end

  def die?
    if @hitpoint <= 0
      puts "#{name} dies"
      true
    end
  end
end