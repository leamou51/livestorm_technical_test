class RoundsView
  def ask_for(something)
    puts "\nEnter your #{something}:"
    print "> "
    gets.chomp
  end

  def choose(something)
    puts "\nChoose your #{something}:"
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
    puts "\n--\nYou are a reasonable man!"
  end

  def display_safe_curse(health_point)
    puts "\n--\nOh noooo! It was a trap!! You've been put under a curse and you only have #{health_point} health points left... 😱"
  end

  def display_safe_healing(health_point)
    puts "\n--\nLucky bastard, it was a healing safe!! You now have #{health_point} health points! 🌈"
  end

  def display_fight_announcement(enemyname)
    puts "You now have to fight #{enemyname} Guardian of the room!"
    puts "Let's kick some ass! 😎\n--\n"
  end

  def display_fight_announcement_final(enemyname)
    puts "Oh my god, you're facing #{enemyname}, your arch enemy!"
    puts "Respect and Robustness ✊\n--\n"
  end

  def display_attacks(attacks)
    attacks.split(" ").each_with_index do |attack, index|
      puts "\n#{index + 1} - #{attack}\n"
    end
  end

  def display_fight_win(health_point)
    puts "\n--\nNice move, he only have #{health_point} health points left! 👍\n--\n"
  end

  def display_fight_lose(health_point)
    puts "\n--\nOh nooooo, he blocked your attack and he inflicted damage on you. You only have #{health_point} health points left! 😱\n--\n"
  end

  def display_round_win
    puts "\n--\nWell done, you kicked the crap out of him! Let's leave for your next mission! 🚀\n--\n"
  end

  def display_lose
    puts "\n--\nGAME OVER 😞\n--\n"
  end

  def display_win
    puts "\n--\nYOU WIN 🎉\n--\n"
  end
end
