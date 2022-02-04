require 'spec_helper'
require "grid"
require "ai"

RSpec.describe Morpion::Scoring do
  subject { described_class.evaluate(grid)}
  let(:grid) { Morpion::Grid.new }
  
  context "when it is a draw" do
    before do
      grid.cells = ["x", "o", "x", "o", "x", "o", "o", "x", "o"]
    end
    it {is_expected.to eq(0)}
  end
  
  context "when player wins" do
    before do
      grid.cells = ["x", "o", "x", "o", "x", "o", "x", "o", "x"]
    end
    it {is_expected.to eq(-10)}
  end
  
  context "when computer wins" do
    before do
      grid.cells = ["x", "o", "o", "x", "x", "o", "o", " ", "o"]
    end
    it {is_expected.to eq(10)}
  end
end

RSpec.describe Morpion::Scoring do
  subject { described_class.min_max(grid)}
  let(:grid) { Morpion::Grid.new }
  
  context "finds the proper next moove in a winning situation" do
    before do
      grid.cells = ["o", "x", "x", "o", "o", "x", " ", " ", " "]
    end
    it {is_expected.to eq(8)}
  end
  
  context "finds the proper next moove in a losing situation" do
    before do
      grid.cells = ["o", "x", "x", "o", "o", "x", " ", " ", " "]
    end
    it {is_expected.to eq(8)}
  end
end
