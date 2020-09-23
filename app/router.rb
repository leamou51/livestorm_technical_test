require_relative "controllers/users_controller"
require_relative "controllers/rounds_controller"

class Router
  def initialize
    @users_controller = UsersController.new
    @rounds_controller = RoundsController.new
    @running = true
  end

  def run
    print_welcome
    user = login
    print_welcome_user(user)
    while @running == true
      print_menu
      action = gets.chomp.to_i
      route_action(action, user)
    end
  end

  private

  def route_action(action, user)
    if action == 1
    @users_controller.select_adventurer(user)
    @rounds_controller.play(user)
    elsif action == 2
      how_to_play
    elsif action == 3
      stop!
    else
      puts "Try again..."
    end
  end

  def actions
    [
      "New Game",
      "How to Play",
      "Exit"
    ]
  end

  def print_menu
    puts "\n"
    actions.each_with_index do |action, index|
      puts "#{index + 1} - #{action}"
    end
    print "> "
  end

  def stop!
    @running = false
  end

  def print_welcome
    puts "-------------------------------"
    puts "WELCOME TO THE KAAMELOTT'S GAME"
    puts "-------------------------------"
  end

  def login
    puts "\nEnter your name:"
    print "> "
    @users_controller.current_user
  end

  def print_welcome_user(user)
    puts "\n--\nHi #{user.name}! Welcome to the Kingdom of Logres"
    puts "Go on an adventure with Arthur and his Knights of the Round Table!\n--\n"
  end

  def how_to_play
    puts "\n----------------------------------------\nWelcome to Arthur's Pendragon's Kingdom!\n----------------------------------------\n"
    # Objectives
    puts "\nGAME'S PLOT"
    puts "--\nTo begin, you will have to choose a character from the Kamelott universe to embody in this game."
    puts "Be careful, each character has different skills that may weigh in the balance in the rest of the adventure."
    puts "You will have to accomplish 3 missions. Each mission will take place in a different room guarded by a ferocious guardian that you will have to fight."
    puts "Some rooms contain safes: some heal, some curse... it's up to you if you take the risk to open them!\n--\n"
    # How to win/lose
    puts "\nHOW TO WIN?"
    puts "--\nYou start with 5 health points and every enemy you meet on your way will have 5 as well."
    puts "Each time you are attacked, you lose a certain number of points depending on your skills and the level of the enemy you are facing."
    puts "Once you've lost health points, your only hope of getting them back is to find a healing safe..."
    puts "The game ends when you have beaten the guards of each of the 3 rooms, in this case you have won 🎉, or when you have no more health points, in this case you have lost 😞.\n--\n"
    # How to play
    puts "\nHOW TO PLAY?"
    puts "--\nWhen the '>' character is present at the beginning of the line, you will then have to:
- type one of the words proposed in parentheses in the instruction
- type the number corresponding to your choice in the list as an instruction\n--\n"
    sleep(1)
    puts "\nPress the Enter key to return to the main menu"
    gets.chomp
  end
end
