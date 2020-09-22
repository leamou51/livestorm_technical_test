class RoundsView
  def aks_for(something)
    puts "\nEnter your #{something}:"
    print "> "
    gets.chomp
  end

  def display_welcome(roomname)
    puts "\n--\nWelcome to #{roomname}!"
  end

  def display_safe_opening
    puts "There is a safe! Would you like to open it? But be careful, it might be a trap...(yes/no)\n--\n"
  end

  def display_safe_unopening
    puts "\n--\nYou are reasonable, but you will not be able to escape the fight that awaits you with the guardian of the room..."
    puts "Let's kick some ass!!\n--\n"
  end

  def display_safe_curse(health_point)
    puts "\n--\nOh noooo! It was a trap!! You've been put under a curse and you only have #{health_point} healing points left..."
    puts "But the mission is not over, you still have to fight the guardian of the room!"
    puts "Let's kick some ass!!\n--\n"
  end

  def display_safe_healing(health_point)
    puts "\n--\nLucky bastard, it was a healing safe!! You now have #{health_point} healing points!"
    puts "But The mission is not over, you still have to fight the guradian of the room!"
    puts "Let's kick some ass!!\n--\n"
  end
end
