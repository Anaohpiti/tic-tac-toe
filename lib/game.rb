require_relative "grid"

class Game 
  def initialize
    @grid = Grid.new
  end
  
  def insert_token(position, player)
    @grid.insert_token(position, player)
  end
  
  def computer_play
    @grid.computer_play
  end
  
  def status
    @grid.status
  end
  
  def print
    @grid.print
  end
  
  def grid
    @grid
  end
end
