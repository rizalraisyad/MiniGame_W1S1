require_relative 'person'

jin = Person.new("Jin Sakai", 100, 50, 80)
# puts jin

khotun = Person.new("Khotun Khan", 500, 50, 0)
$playerAtt = jin
$playerDef = khotun
while jin.hitpoint >0 and khotun.hitpoint >0
  $temporary = $playerAtt
  $playerAtt.attack($playerDef)
  puts $playerDef
  if $playerDef.die? 
    puts "#{$playerAtt.name} Wins"
  end
  $playerAtt = $playerDef
  $playerDef = $temporary
end

# RESULT EXAMPLE
# Jin Sakai attacks Khotun Khan with 50 damage 
# Khotun Khan has 450 hitpoint and 50 attack damage

# Khotun Khan attacks Jin Sakai with 50 damage 
# Jin Sakai has 50 hitpoint and 50 attack damage

# Jin Sakai attacks Khotun Khan with 50 damage 
# Khotun Khan has 400 hitpoint and 50 attack damage

# Khotun Khan attacks Jin Sakai with 50 damage 
# Jin Sakai deflects the attack 
# Jin Sakai has 50 hitpoint and 50 attack damage

# Jin Sakai attacks Khotun Khan with 50 damage 
# Khotun Khan has 350 hitpoint and 50 attack damage

# Khotun Khan attacks Jin Sakai with 50 damage 
# Jin Sakai has 0 hitpoint and 50 attack damage
# Jin Sakai dies
# Khotun Khan Wins