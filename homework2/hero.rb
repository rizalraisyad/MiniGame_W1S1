require_relative 'person'
class Hero < Person
  def initialize(name, hitpoint, attack_damage, deflect_percentage)
    super(name,hitpoint,attack_damage)
    @deflect_percentage = deflect_percentage
  end

  def take_damage(damage)
    if(miss?)
      puts "#{@name} deflects the attack "
    else
      @hitpoint -= damage
      @hitpoint = 0 if @hitpoint <0
    end
  end

  def miss?
    $rangeMax = 100 - @deflect_percentage 
    if ( rand(0..@deflect_percentage) >= rand(1..$rangeMax)) # REVISED by participant
      true
    else
      false
    end
  end

  def take_heal(heal_point)
    @hitpoint += heal_point
  end
end