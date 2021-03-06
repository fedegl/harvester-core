require "spec_helper"

describe HarvesterCore::Modifiers::HtmlStripper do

  let(:klass) { HarvesterCore::Modifiers::HtmlStripper }
  let(:stripper) { klass.new(" cats ") }

  describe "#initialize" do
    it "assigns the original_value" do
      stripper.original_value.should eq [" cats "]
    end
  end

  describe "#modify" do
    let(:html_string) { "<div id='top'>Stripped</div>" }

    it "strips html characters from a string" do
      stripper.stub(:original_value) { [html_string] }
      stripper.modify.should eq ["Stripped"]
    end

    it "doens't try to strip_html from non strings" do
      node = double(:node)
      stripper.stub(:original_value) { [node] }
      stripper.modify.should eq [node]
    end
  end
end