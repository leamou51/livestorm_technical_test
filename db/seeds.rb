require_relative "../app/models/user"
require_relative "../app/models/adventurer"
require_relative "../app/models/enemy"
require_relative "../app/models/room"

puts "Cleaning DB..."

User.destroy_all
Adventurer.destroy_all
Enemy.destroy_all
Room.destroy_all

puts "DB cleaned!"

puts "Creating adventurers..."

Adventurer.new(name: "Karadoc de Vannes", strength: 2, sagacity: 2, luck: 4, trickery: 1, attacks: "sausage_rosary ham", shields: "shield1 shield2", quote: "Fat is life").save
Adventurer.new(name: "Perceval de Galles", strength: 2, sagacity: 1, luck: 5, trickery: 1, attacks: "fennel redundant_object", shields: "shield1 shield2", quote: "In life, I had two enemies: vocabulary and spinach.").save
Adventurer.new(name: "Bohort de Gaunes", strength: 1, sagacity: 4, luck: 3, trickery: 1, attacks: "fruit_basket fine_fabric", shields: "shield1 shield2", quote: "MISCREEEEEEEAAAAAANT").save
Adventurer.new(name: "Leodagan de Carmelide", strength: 4, sagacity: 3, luck: 2, trickery: 3, attacks: "ballista stake", shields: "shield1 shield2", quote: " Well, I learned to read, and I wouldn't wish that on anyone!").save
Adventurer.new(name: "Loth d'Orcanie", strength: 2, sagacity: 4, luck: 2, trickery: 5, attacks: "lightning your_wife", shields: "shield1 shield2", quote: "When you want to be sure of your shot...you plant turnips. We don't practice putsch").save

puts "Adventurers created!"

puts "Creating enemies..."

snake = Enemy.new(name: "Giant snake", level: 2, health_point: 5)
snake.save
dragon = Enemy.new(name: "Airain's Dragon", level: 2, health_point: 5)
dragon.save
elias = Enemy.new(name: "Elias de Kelliwic'h", level: 3, health_point: 5)
elias.save
Enemy.new(name: "6-headed Hydra", level: 4, health_point: 5, boss: true).save
attila = Enemy.new(name: "Attila", level: 1, health_point: 5)
attila.save
burgonde_king = Enemy.new(name: "Burgonde King", level: 1, health_point: 5)
burgonde_king.save

puts "Enemy created!"

puts "Creating rooms..."

Room.new(name: "Burgonde Kingdom", item: [true,false].sample, enemy: burgonde_king).save
Room.new(name: "Attila's Kingdom", item: [true,false].sample, enemy: attila).save
Room.new(name: "The Wizards' Land", item: [true,false].sample, enemy: elias).save
Room.new(name: "The Shadow Lake", item: [true,false].sample, enemy: snake).save
Room.new(name: "The Lost Temple", item: [true,false].sample, enemy: dragon).save
Room.new(name: "The Haunted Cave", item: [true,false].sample, enemy: Enemy.find_by(boss: true)).save

puts "Rooms created!"
