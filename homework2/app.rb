require_relative 'hero'
require_relative 'mongol_archer'
require_relative 'mongol_spearman'
require_relative 'mongol_swordsman'
require_relative 'villain'
require_relative 'support'

jin = Support.new("Jin Sakai", 100,50,80,50)
yuna = Hero.new("Yuna", 100,30,0)
sensei = Hero.new("Sensei Ishikawa", 100,35,0)
mongol_archer = MongolArcher.new("Mongol Archer", 80,40)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120,60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100,50)
heroes = [jin,yuna,sensei]
villains = [mongol_archer,mongol_spearman,mongol_swordsman]


i = 1
until (heroes.empty?|| villains.empty?) do
  puts"=============== Turn #{i} ============="
  puts "\n"

  heroes.each do |hero|
    puts hero
  end

  puts "\n"

  villains.each do |villain|
   puts villain
  end

  puts "\n"

  heroes.each_with_index do |hero,index|
    $villain_index = rand(villains.size)
    if hero.class.name.to_s == "Hero"
      hero.attack(villains[$villain_index])
      villains.delete_at($villain_index) if villains[$villain_index].die? || villains[$villain_index].flee?
    else
      loop do
        puts "Choice your attack"
        puts "[1]. Attack the villain"
        puts "[2]. Heal friend / self"
        $input = gets.chomp.to_i
        if $input == 1
          hero.attack(villains[$villain_index])
          break
        elsif $input == 2
          if heroes.size > 1
            loop do
              random_number = rand(heroes.size)
              if(random_number != index)
                hero.heal(heroes[random_number])
                break
              end
            end
            break
          end
          hero.heal(heroes[rand(heroes.size)])
          break
        else
          puts "Pilihan yang anda masukkan salah!"
        end
      end
    end
  end

  puts "\n"

  villains.each do |villain|
    $hero = rand(heroes.size)
    villain.attack(heroes[$hero])
    heroes.delete_at($hero) if heroes[$hero].die?
  end


  puts "\n"
  i +=1
end




#EXAMPLE Attempt1
# Jin Sakai has 100 hitpoint and 50 attack damage
# Yuna has 100 hitpoint and 30 attack damage
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Mongol Archer has 80 hitpoint and 40 attack damage
# Mongol Spearman has 120 hitpoint and 60 attack damage
# Mongol Swordsman has 100 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 1
# Jin Sakai attacks Mongol Swordsman with 50 damage 
# Mongol Swordsman has 50 hitpoint and 50 attack damage

# Yuna attacks Mongol Swordsman with 30 damage 
# Mongol Swordsman has fled the battlefield with 20 hitpoint left
# Mongol Swordsman has 20 hitpoint and 50 attack damage

# Sensei Ishikawa attacks Mongol Archer with 35 damage 
# Mongol Archer has fled the battlefield with 45 hitpoint left
# Mongol Archer has 45 hitpoint and 40 attack damage


# Mongol Spearman thrusts Yuna with 60 damage
# Yuna has 40 hitpoint and 30 attack damage


# =============== Turn 2 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Yuna has 40 hitpoint and 30 attack damage
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Mongol Spearman has 120 hitpoint and 60 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 1
# Jin Sakai attacks Mongol Spearman with 50 damage 
# Mongol Spearman has 70 hitpoint and 60 attack damage

# Yuna attacks Mongol Spearman with 30 damage 
# Mongol Spearman has 40 hitpoint and 60 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has fled the battlefield with 5 hitpoint left
# Mongol Spearman has 5 hitpoint and 60 attack damage



#Attempt 2 Example
# =============== Turn 1 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Yuna has 100 hitpoint and 30 attack damage
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Mongol Archer has 80 hitpoint and 40 attack damage
# Mongol Spearman has 120 hitpoint and 60 attack damage
# Mongol Swordsman has 100 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 150 hitpoint and 35 attack damage

# Yuna attacks Mongol Swordsman with 30 damage 
# Mongol Swordsman has 70 hitpoint and 50 attack damage

# Sensei Ishikawa attacks Mongol Archer with 35 damage 
# Mongol Archer has fled the battlefield with 45 hitpoint left
# Mongol Archer has 45 hitpoint and 40 attack damage


# Mongol Spearman thrusts Yuna with 60 damage
# Yuna has 40 hitpoint and 30 attack damage

# Mongol Swordsman slashes Yuna with 50 damage
# Yuna has 0 hitpoint and 30 attack damage


# =============== Turn 2 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 150 hitpoint and 35 attack damage

# Mongol Spearman has 120 hitpoint and 60 attack damage
# Mongol Swordsman has 70 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 200 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has 85 hitpoint and 60 attack damage


# Mongol Spearman thrusts Jin Sakai with 60 damage
# Jin Sakai deflects the attack 
# Jin Sakai has 100 hitpoint and 50 attack damage

# Mongol Swordsman slashes Sensei Ishikawa with 50 damage
# Sensei Ishikawa has 150 hitpoint and 35 attack damage


# =============== Turn 3 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 150 hitpoint and 35 attack damage

# Mongol Spearman has 85 hitpoint and 60 attack damage
# Mongol Swordsman has 70 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 200 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Swordsman with 35 damage 
# Mongol Swordsman has 35 hitpoint and 50 attack damage


# Mongol Spearman thrusts Jin Sakai with 60 damage
# Jin Sakai deflects the attack 
# Jin Sakai has 100 hitpoint and 50 attack damage

# Mongol Swordsman slashes Sensei Ishikawa with 50 damage
# Sensei Ishikawa has 150 hitpoint and 35 attack damage


# =============== Turn 4 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 150 hitpoint and 35 attack damage

# Mongol Spearman has 85 hitpoint and 60 attack damage
# Mongol Swordsman has 35 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 200 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has 50 hitpoint and 60 attack damage


# Mongol Spearman thrusts Sensei Ishikawa with 60 damage
# Sensei Ishikawa has 140 hitpoint and 35 attack damage

# Mongol Swordsman slashes Sensei Ishikawa with 50 damage
# Sensei Ishikawa has 90 hitpoint and 35 attack damage


# =============== Turn 5 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 90 hitpoint and 35 attack damage

# Mongol Spearman has 50 hitpoint and 60 attack damage
# Mongol Swordsman has 35 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 140 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Swordsman with 35 damage 
# Mongol Swordsman has 0 hitpoint and 50 attack damage


# Mongol Spearman thrusts Jin Sakai with 60 damage
# Jin Sakai has 40 hitpoint and 50 attack damage


# =============== Turn 6 =============

# Jin Sakai has 40 hitpoint and 50 attack damage
# Sensei Ishikawa has 140 hitpoint and 35 attack damage

# Mongol Spearman has 50 hitpoint and 60 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 190 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has 15 hitpoint and 60 attack damage


# Mongol Spearman thrusts Sensei Ishikawa with 60 damage
# Sensei Ishikawa has 130 hitpoint and 35 attack damage


# =============== Turn 7 =============

# Jin Sakai has 40 hitpoint and 50 attack damage
# Sensei Ishikawa has 130 hitpoint and 35 attack damage

# Mongol Spearman has 15 hitpoint and 60 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 180 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has 0 hitpoint and 60 attack damage



#Attempt 3
# =============== Turn 1 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Yuna has 100 hitpoint and 30 attack damage
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Mongol Archer has 80 hitpoint and 40 attack damage
# Mongol Spearman has 120 hitpoint and 60 attack damage
# Mongol Swordsman has 100 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Yuna with 50 heal point
# Yuna has 150 hitpoint and 30 attack damage

# Yuna attacks Mongol Spearman with 30 damage 
# Mongol Spearman has 90 hitpoint and 60 attack damage

# Sensei Ishikawa attacks Mongol Archer with 35 damage 
# Mongol Archer has 45 hitpoint and 40 attack damage


# Mongol Archer shoots an arrow at Jin Sakai with 40 damage
# Jin Sakai deflects the attack 
# Jin Sakai has 100 hitpoint and 50 attack damage

# Mongol Spearman thrusts Yuna with 60 damage
# Yuna has 90 hitpoint and 30 attack damage

# Mongol Swordsman slashes Yuna with 50 damage
# Yuna has 40 hitpoint and 30 attack damage


# =============== Turn 2 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Yuna has 40 hitpoint and 30 attack damage
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Mongol Archer has 45 hitpoint and 40 attack damage
# Mongol Spearman has 90 hitpoint and 60 attack damage
# Mongol Swordsman has 100 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 150 hitpoint and 35 attack damage

# Yuna attacks Mongol Spearman with 30 damage 
# Mongol Spearman has 60 hitpoint and 60 attack damage

# Sensei Ishikawa attacks Mongol Archer with 35 damage 
# Mongol Archer has 10 hitpoint and 40 attack damage


# Mongol Archer shoots an arrow at Sensei Ishikawa with 40 damage
# Sensei Ishikawa has 110 hitpoint and 35 attack damage

# Mongol Spearman thrusts Yuna with 60 damage
# Yuna has 0 hitpoint and 30 attack damage

# Mongol Swordsman slashes Sensei Ishikawa with 50 damage
# Sensei Ishikawa has 60 hitpoint and 35 attack damage


# =============== Turn 3 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 60 hitpoint and 35 attack damage

# Mongol Archer has 10 hitpoint and 40 attack damage
# Mongol Spearman has 60 hitpoint and 60 attack damage
# Mongol Swordsman has 100 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 110 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Archer with 35 damage 
# Mongol Archer has 0 hitpoint and 40 attack damage


# Mongol Spearman thrusts Jin Sakai with 60 damage
# Jin Sakai deflects the attack 
# Jin Sakai has 100 hitpoint and 50 attack damage

# Mongol Swordsman slashes Jin Sakai with 50 damage
# Jin Sakai deflects the attack 
# Jin Sakai has 100 hitpoint and 50 attack damage


# =============== Turn 4 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 110 hitpoint and 35 attack damage

# Mongol Spearman has 60 hitpoint and 60 attack damage
# Mongol Swordsman has 100 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 160 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Swordsman with 35 damage 
# Mongol Swordsman has 65 hitpoint and 50 attack damage


# Mongol Spearman thrusts Sensei Ishikawa with 60 damage
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Mongol Swordsman slashes Sensei Ishikawa with 50 damage
# Sensei Ishikawa has 50 hitpoint and 35 attack damage


# =============== Turn 5 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 50 hitpoint and 35 attack damage

# Mongol Spearman has 60 hitpoint and 60 attack damage
# Mongol Swordsman has 65 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 100 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has 25 hitpoint and 60 attack damage


# Mongol Spearman thrusts Sensei Ishikawa with 60 damage
# Sensei Ishikawa has 40 hitpoint and 35 attack damage

# Mongol Swordsman slashes Jin Sakai with 50 damage
# Jin Sakai deflects the attack 
# Jin Sakai has 100 hitpoint and 50 attack damage


# =============== Turn 6 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 40 hitpoint and 35 attack damage

# Mongol Spearman has 25 hitpoint and 60 attack damage
# Mongol Swordsman has 65 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 90 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Spearman with 35 damage 
# Mongol Spearman has 0 hitpoint and 60 attack damage


# Mongol Swordsman slashes Sensei Ishikawa with 50 damage
# Sensei Ishikawa has 40 hitpoint and 35 attack damage


# =============== Turn 7 =============

# Jin Sakai has 100 hitpoint and 50 attack damage
# Sensei Ishikawa has 40 hitpoint and 35 attack damage

# Mongol Swordsman has 65 hitpoint and 50 attack damage

# Choice your attack
# [1]. Attack the villain
# [2]. Heal friend / self
# 2
# Jin Sakai healing Sensei Ishikawa with 50 heal point
# Sensei Ishikawa has 90 hitpoint and 35 attack damage

# Sensei Ishikawa attacks Mongol Swordsman with 35 damage 
# Mongol Swordsman has fled the battlefield with 30 hitpoint left
# Mongol Swordsman has 30 hitpoint and 50 attack damage