class UsersView
  def ask_for_username
    gets.chomp
  end

  def go_on_mission(adventurername)
    puts "\n--\nCongratulation #{adventurername}, you are going on your first mission!"
    puts "You're about to leave Camelot, where do you go first? (right/left/foward)\n--\n"
  end
end
