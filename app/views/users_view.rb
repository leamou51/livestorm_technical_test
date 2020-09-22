class UsersView
  def ask_for_username
    gets.chomp
  end

  def welcome(username)
    puts "\n--\nHi #{username}! Welcome to the kingdom of Logres"
    puts "Go on an adventure with Arthur and his Knights of the Round Table!\n--\n"
  end
end
