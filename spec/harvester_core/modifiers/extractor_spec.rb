require "spec_helper"

describe HarvesterCore::Modifiers::Extractor do

  let(:klass) { HarvesterCore::Modifiers::Extractor }
  let(:original_value) { ["Pebble Beach ~ 5 Bed, 5 Full, 2 Half Bath\r\nMLS #: 81300818"] }
  let(:extractor) { klass.new(original_value, /MLS #: ([\d]+)/) }

  describe "modify" do
    it "returns the first matched group in the regexp" do
      extractor.modify.should eq ["81300818"]
    end

    it "returns an empty array when a match is not found" do
      extractor.stub(:regexp) { /FEDE/ }
      extractor.modify.should eq []
    end
  end
end