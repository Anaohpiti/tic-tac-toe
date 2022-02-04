require "grid"

RSpec.describe Morpion::Grid do
  let(:grid) { described_class.new }
  
  context "when game starts" do
    it { expect { grid.print }.to output("   |   |   \n   |   |   \n   |   |   \n").to_stdout }
  end
  
  context "when the player insert a token" do
    before {grid.insert_token(0, "x")}
    it { expect { grid.print }.to output(" x |   |   \n   |   |   \n   |   |   \n").to_stdout }
  end
  
  context "when a player insert tokens at an unvailable locations" do
    before do 
      grid.insert_token(0, "x")
    end
    
    it { expect { grid.insert_token(0, "x") }.to raise_error("L'emplacement contient un jeton. Veuillez réessayer avec un emplacement vide.")}   
  end
  
  context "the computeur identifies a winning situation" do
    before do 
      grid.cells = ["x", " ", "x", "o", "o", " ", " ", " ", "x"]
      grid.computer_play
    end
    
    it { expect { grid.print }.to output(" x |   | x \n o | o | o \n   |   | x \n").to_stdout }
  end
  
  context "the computeur identifies a losing situation" do
    before do 
      grid.cells = ["x", " ", " ", "o", "x", " ", " ", " ", " "]
      grid.computer_play
    end
    
    it { expect { grid.print }.to output(" x |   |   \n o | x |   \n   |   | o \n").to_stdout }
  end
  
  # context "the computeur identifies the best move " do
  #   before do 
  #     grid.insert_token(1, 1, "x")
  #     grid.insert_token(2, 1, "o")
  #     grid.computer_play
  #   end
  #   it {is_expected.to eq([
  #     ["x", "o", " "],
  #     ["o", " ", " "],
  #     [" ", " ", " "]
  #   ]
  #   )}
  # end
end
