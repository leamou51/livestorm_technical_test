require_relative "controllers/users_controller"

class Router
  def initialize
    @users_controller = UsersController.new
    @running = true
  end

  def run
    print_welcome
    login
    while @running == true
      print_menu
      action = gets.chomp.to_i
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then puts "action1"
    when 2 then puts how_to_play
    when 3 then stop!
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
    @users_controller.create
  end

  def how_to_play
    # TO DO: context + instructions
    puts "\n--\nTO DO\n--\n"
    puts "Press the Enter key to return to the main menu"
    gets.chomp
  end
end
