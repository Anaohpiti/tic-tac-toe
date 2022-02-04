module Morpion
  class Scoring
    def self.evaluate(grid)
      case grid.winner
      when "player"
        -10
      when "computer"
        10
      else
        0
      end
    end
    
    def self.min_max(grid)
      return if grid.grid_is_full?
      
      available_positions = grid.find_available_positions
      score = 0
      player = "o"
      next_move = ""
      
      until !score.zero? do
        available_positions.each do |available_position|
          test_grid = Marshal.load(Marshal.dump(grid))
          test_grid.insert_token(available_position, player) 
          if !evaluate(test_grid).zero? 
            score = evaluate(test_grid)
            next_move = available_position
          else
            if available_positions.size > 1
              player == "x" ? player = "o" : player = "x"
              available_positions - [available_position]
            end
          end
        end
      end
      
      next_move
    end
  end
end
