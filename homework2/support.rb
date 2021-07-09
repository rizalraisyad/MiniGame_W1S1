require_relative 'hero'
class Support < Hero
  def initialize(name, hitpoint, attack_damage, deflect_percentage, heal_point)
    super(name,hitpoint,attack_damage,deflect_percentage)
    @heal_point = heal_point
  end
  def heal(other_person)
    puts "#{@name} healing #{other_person.name} with #{@heal_point} heal point"
    other_person.take_heal(@heal_point)
    puts other_person
    puts "\n"
  end

end