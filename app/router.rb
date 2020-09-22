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
    puts "\n--\nHi #{user.name}! Welcome to the kingdom of Logres"
    puts "Go on an adventure with Arthur and his Knights of the Round Table!\n--\n"
  end

  def how_to_play
    # TO DO: context + instructions
    puts "\n--\nTO DO\n--\n"
    puts "Press the Enter key to return to the main menu"
    gets.chomp
  end
end
