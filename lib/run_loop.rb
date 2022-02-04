require_relative 'game'

game = Game.new

puts "....................."
puts "       Le jeu        "
puts "         de          "
puts "       Morpion       "
puts "....................."

player = ""

puts ""
puts "Bienvenue"
puts ""

until game.status
  puts ""
  puts "Etat de la grille : "
  puts ""
  game.print
    begin
      puts ""
      puts "Où souhaitez-vous jouer ?"
      print "-> "
      position = gets.chomp.to_i - 1
      game.insert_token(position, "x")
    rescue => error
      puts error.message
      retry
    end
    last_player = "player"
  unless game.status
    puts "L'ordinateur joue."
    game.computer_play
    last_player = "computer"
  end
end
puts ""
p "La partie est terminée."
puts ""
game.print
puts ""
p "Félications, vous avez battu l'ordinateur !" if game.status == "winner" && last_player != "computer"
p "Argh, l'ordinateur vous a battu, cette fois-ci !" if game.status == "winner" && last_player == "computer"
p "Match nul !" if game.status == "over"
p "....................."

# next step => améliorer l'IA
## faire un ordinateur imbattable
### (coup + 1) l'IA scan chaque possibilité et étudie pour chacune si elle permettrait de terminer le jeu pour l'ordinateur
### (coup + 1) l'IA scan chaque possibilité et étudie pour chacune si elle permettrait de terminer le jeu pour le joueur

### construire une boucle pour faire l'analyse des cas restants, et qu'il choisissent le meilleur cas, en fonction d'un score pour chaque point
### les cas précédents à répéter n fois 
