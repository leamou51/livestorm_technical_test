require_relative "../models/round"
require_relative "../views/rounds_view"

class RoundsController
  def initialize
    @rounds_view = RoundsView.new
  end

  # PLAY A GAME
  def play(user)
    # first mission
    play_round(user)
    sleep(2)
    # if player still alive (HP > 0) -> second mission
    if user.health_point.positive?
      play_round(user)
      sleep(2)
      # if player still alive (HP > 0) -> last mission
      if user.health_point.positive?
        play_final_round(user)
      end
    end
  end

  # PLAY A ROUND (= 1 mission)
  def play_round(user)
    # enter in a room
    round = move(user)
    # dislay "Welcome in XXX"
    @rounds_view.display_welcome(round.room.name)
    # if room contains a safe -> ask player if he wants to open it
    safe_opening(user) if round.room.item == true
    # display "You will fight XXX"
    @rounds_view.display_fight_announcement(round.room.enemy.name)
    # player fight enemy until enemy dies (-> next mission) or player dies (-> GAME OVER)
    while round.room.enemy.health_point.positive? && user.health_point.positive?
      fight(user, round)
    end
  end

  def play_final_round(user)
    # create a round in the room guarded by the archy enemy (boss = true)
    final_enemy = Enemy.find_by(boss: true)
    final_room = Room.find_by(enemy: final_enemy)
    round = create(final_room, user)
    # display "Welcome XXX"
    @rounds_view.display_welcome(round.room.name)
    # display "You will fight your archy enemey"
    @rounds_view.display_fight_announcement_final(round.room.enemy.name)
    # player fight enemy until enemy dies (-> WIN) or player dies (-> GAME OVER)
    while round.room.enemy.health_point.positive? && user.health_point.positive?
      fight(user, round)
    end
  end

  def create(room, user)
    round = Round.new(room: room, user: user)
    round.save
    round
  end

  # ENTER A ROOM
  def move(user)
    running = true
    # display "Enter a direction" until the player enter right, left or forward
    while running == true
      # ask player to chose a direction
      direction = @rounds_view.ask_for("direction")
      # enter in a random room where the guardian's level depend on the direction chosen
      # the room cannot be the final room guarded by the archy enemy
      if direction == "left"
        round = create(select_room(3).sample, user)
      elsif direction == "right"
        round = create(select_room(2).sample, user)
      elsif direction == "forward"
        round = create(select_room(4).sample, user)
      else
        puts "Try again..."
      end
      running = false if %w(left right forward).include?(direction)
    end
    round
  end

  # OPEN A SAFE
  def safe_opening(user)
    # display "Want to pen it ?"
    # ask "Yes/No"
    @rounds_view.display_safe_opening
    choice = @rounds_view.ask_for("choice")
    # if player opens it -> win or lose HP depending on his luck
    if choice == "yes" && trap_proba(user)
      # lose 1 or 2 HP (random)
      user.health_point -= rand(1..2)
      user.health_point = 0 if user.health_point.negative?
      # if HP = 0 -> GAME OVER else display remaining HP
      user.health_point.zero? ? @rounds_view.display_lose : @rounds_view.display_safe_curse(user.health_point)
    elsif choice == "yes" && !trap_proba(user)
      # win 1 or 2 HP (random)
      user.health_point += rand(1..2)
      # display remaining HP
      @rounds_view.display_safe_healing(user.health_point)
    else
      @rounds_view.display_safe_unopening
    end
    user.save
    sleep(1)
  end

  # FIGHT AN ENEMY
  def fight(user, round)
    # display player's attacks
    # ask player to chose an attack
    @rounds_view.display_attacks(user.adventurer.attacks)
    @rounds_view.choose("weapon")
    # player win or lose depending on his skills and enemy's level
    if fight_proba(user, round)
      # player loses a random number of points between 1 and the enemy's level
      user.health_point -= rand(1..round.room.enemy.level)
      user.health_point = 0 if user.health_point.negative?
      # if player's HP = 0 -> GAME OVER else display remaining HP
      user.health_point.zero? ? @rounds_view.display_lose : @rounds_view.display_fight_lose(user.health_point)
    else
      # enemy loses a random number of points between 1 and player's strenght
      round.room.enemy.health_point -= rand(1..user.adventurer.strength)
      round.room.enemy.health_point = 0 if round.room.enemy.health_point.negative?
      # if enemy's HP = 0 -> fight is won else display remaining HP
      round.room.enemy.health_point.zero? ? @rounds_view.display_round_win : @rounds_view.display_fight_win(round.room.enemy.health_point)
    end
  end

  private

  # SELECT ROOMS DEPENDING ON THEIR GUARDIAN'S LEVEL
  def select_room(lvl)
    Room.all.to_a.reject { |room| room.enemy.level > lvl }
  end

  # CALCULATE THE PROBABILITY OF OPENING A CURSE/HEALING SAFE
  def trap_proba(user)
    arr_false = (0..user.adventurer.luck - 1).map { |n| n = false }
    arr_true = (0..4 - user.adventurer.luck).map { |n| n = true }
    # luck value ouf of 5 to open a healing safe
    arr_true.concat(arr_false).sample
  end

  # CALCULATE THE PROBABILITY THAT ATTACKS CAUSE DAMAGE
  def fight_proba(user, round)
    # weighted sum of skills
    skills = user.adventurer.strength * 4 + user.adventurer.sagacity + user.adventurer.trickery * 2 + user.adventurer.luck * 3
    # impact of player's skills
    u_arr_false = (0..skills - 1).map { |n| n = false }
    u_arr_true = (0..49 - skills).map { |n| n = true }
    user_weight = u_arr_true.concat(u_arr_false)
    # impact of enemey's level
    e_arr_true = (0..round.room.enemy.level * 10 - 1).map { |n| n = true }
    e_arr_false = (0..49 - round.room.enemy.level * 10).map { |n| n = false }
    enemy_weight = e_arr_true.concat(e_arr_false)
    user_weight.concat(enemy_weight).sample
  end
end
