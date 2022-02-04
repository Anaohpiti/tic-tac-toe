module Morpion
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
              
      winning_situation = min_max(available_positions)
      losing_situation = min_max(available_positions)
      
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
      winner
    end
    
    def winner
      return "player" if WIN_COMBINATIONS.find { |combination| combination.map { |index| cells[index]}.join().match?(/xxx/)}
      return "computer" if WIN_COMBINATIONS.find { |combination| combination.map { |index| cells[index]}.join().match?(/ooo/)}
    end
    
    def evaluate
      case winner
      when "player"
        -10
      when "computer"
        10
      else
        0
      end
    end
    
    def grid_is_full?
      !@cells.include?(" ")
    end
            
    def valid_location?(position)
      (0..8).include?(position)
    end
    
    def find_available_positions
      available_positions = @cells.map.with_index { |cell, index| index if cell == " " }.compact
    end
                                    
    def find_winning_situation(available_positions)
      available_positions.find do |position| 
        test_grid = Marshal.load(Marshal.dump(self))
        test_grid.insert_token(position, "o")
        test_grid.status == "computer"
      end
      ## piste 1 : sérialiser les objets pour les lires en fonction, module MARSHALL, non sûre, Marshall.dump / Marshall.load
      ## piste 2 : ne pas appeler dup sur self qui est un objet, mais sur la variable @cells avec map, mais le résultat serait une liste de liste
      ## donc il faut que insert_token puisse transformer une liste, an ajoutant un argument dans la méthode
    end
    
    def find_losing_situation(available_positions)
      available_positions.find do |position| 
        test_grid = Marshal.load(Marshal.dump(self))
        test_grid.insert_token(position, "x")
        test_grid.status == "player"
      end
    end
    
    
    def min_max(available_positions)
      score = 0
      player = "o"
      
      available_positions.find do |available_position|
        test_grid = Marshal.load(Marshal.dump(self))
        test_grid.insert_token(available_position, player)
        test_grid.evaluate == 10
      end
      
    end
  end
end
