require 'game'

RSpec.describe Game do
  subject(:game) { described_class.new }
  
  context "when a player has 3 adjacent coins in a row" do
    before do
      game.insert_token(1,1,"x")
      game.insert_token(1,2,"x")
      game.insert_token(1,3,"x")
    end

    it "it declares the player 1 winner " do
      expect(game.status).to eq("winner")
    end
  end
  
  context "when a player has 3 adjacent coins in a column" do
    before do
      game.insert_token(1,1,"o")
      game.insert_token(2,1,"o")
      game.insert_token(3,1,"o")
    end

    it "game is over " do
      expect(game.status).to eq("winner")
    end
  end
  
  context "when a player has 3 adjacent coins in diagonal" do
    before do
      game.insert_token(1,1,"o")
      game.insert_token(2,2,"o")
      game.insert_token(3,3,"o")
    end

    it "game is over " do
      expect(game.status).to eq("winner")
    end
  end
  
    
  context "when a player has 3 adjacent coins in diagonal" do
    before do
      game.insert_token(1,3,"o")
      game.insert_token(2,2,"o")
      game.insert_token(3,1,"o")
    end

    it "game is over " do
      expect(game.status).to eq("winner")
    end
  end
  
  context "when the grid is full" do
    before do
      game.insert_token(1,3,"o")
      game.insert_token(2,2,"o")
      game.insert_token(3,1,"o")
    end

    it "game is over " do
      expect(game.status).to eq("winner")
    end
  end
end
