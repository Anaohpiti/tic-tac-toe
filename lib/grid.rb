class Grid
  attr_accessor :cells
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6] 
  ]
  
  def initialize
    @cells = Array.new(9, " ")
  end
  
  def print
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end
  
  def insert_token(position, player)
    raise "L'emplacement n'est pas valide. Veuillez saisir des chiffres entre 1 et 9." unless valid_location?(position) 
    raise "L'emplacement contient un jeton. Veuillez réessayer avec un emplacement vide." if @cells[position] != " "
    
    @cells[position] = player
  end
  
  def computer_play
    available_positions = find_available_positions
    return unless available_positions
            
    winning_situation = find_winning_situation(available_positions)
    losing_situation = find_losing_situation(available_positions)
    
    if winning_situation
      insert_token(winning_situation, "o")
    elsif losing_situation
      insert_token(losing_situation, "o") 
    else

    insert_token(available_positions.sample, "o") 
    end
  end
  
  def status
    return "over" if grid_is_full?
    
    if winner?
      "winner"
    end
  end
  
  private
  
  def winner?
    return WIN_COMBINATIONS.find { |combination| combination.map { |index| cells[index]}.join().match?(/(xxx|ooo)/)}
    return 
  end
  
  def valid_location?(position)
    (0..8).include?(position)
  end
  
  def grid_is_full?
    !@cells.include?(" ")
  end
  
  def find_available_positions
    available_positions = @cells.map.with_index { |cell, index| index if cell == " " }.compact
  end
                                  
  def find_winning_situation(available_positions)
    available_positions.find do |position| 
      test_grid = Marshal.load(Marshal.dump(self))
      test_grid.insert_token(position, "o")
      test_grid.status == "winner"
    end
    ## piste 1 : sérialiser les objets pour les lires en fonction, module MARSHALL, non sûre, Marshall.dump / Marshall.load
    ## piste 2 : ne pas appeler dup sur self qui est un objet, mais sur la variable @cells avec map, mais le résultat serait une liste de liste
    ## donc il faut que insert_token puisse transformer une liste, an ajoutant un argument dans la méthode
  end
  
  def find_losing_situation(available_positions)
    available_positions.find do |position| 
      test_grid = Marshal.load(Marshal.dump(self))
      test_grid.insert_token(position, "x")
      test_grid.status == "winner"
    end
  end
  
  def min_max(available_positions)
    score = 0
    player = "o"
      
    until winner? || grid_is_full? do
      available_positions.each do |available_position|
        test_grid = Marshal.load(Marshal.dump(self))
        test_grid.insert_token(available_position, player)   
        if winner? 
          score = 10
        else
        available_positions - available_position
        end
        player == "x" ? player = "o" : player = "x"
      end
    end
  end
end

# Notes 21/01
## SRP = faire des méthodes avec une action 

## jusqu'à ce que la grille soit complète
# initaliser une variable score à 0 et une liste de coup
# faire le test au coup prochain, 
# si situation de victoire + 10 le jeu s'arrête
# sinon, 0 et le jeu continue

# fare le test au coup suivant, si le score n'est pas changé, marquer 0
# faire le test au dernier 
# faire le test au dernier 
# L'ordinateur peut gagner -> score += [position, 10] et la boucle se termine

# Sinon le joeur joue dans une des positions disponibles (7)
  # Si le joueur peut gagner -> score += [position, -10] et la boucle se termine
  # Sinon l'ordinateur joue dans une des positions disponibles (5)
    # Si il peut gagner -> score += [position, 10] et le jeu se termine
    # Sinon le joeur joue dans une des positions disponibles (3)
      # Si le joueur peut gagner -> score += [position, -10] et la boucle se termine
      # Sinon l'ordinateur dans la dernière positions disponibles (1)
        # Si il peut gagner -> score += [position, 10] et le jeu se termine
        # sinon le jeu se termine sur une égalité
