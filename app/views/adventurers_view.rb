class AdventurersView
  def display_adventurers(adventurers)
    adventurers.each_with_index do |adventurer, index|
      puts "\n#{index + 1} - #{adventurer.name}\n-----------------\n"
      puts "Strength: #{repeat("x", adventurer.strength)}"
      puts "Sagacity: #{repeat("x", adventurer.sagacity)}"
      puts "Trickery: #{repeat("x", adventurer.trickery)}"
      puts "Luck: #{repeat("x", adventurer.luck)}"
      puts "War cry: '#{adventurer.quote}'"
    end
  end

  def ask_for_index(item)
    puts "\nChoose your #{item}:"
    print "> "
    gets.chomp.to_i
  end

  private

  def repeat(text, n)
    text * n
  end
end
