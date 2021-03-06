require "spec_helper"

describe HarvesterCore::XmlMethods do

  let(:klass) { HarvesterCore::Xml::Base }
  let(:record) { klass.new("http://google.com") }

  describe "#fetch" do
    let(:document) { Nokogiri.parse("<doc><item>1</item><item>2</item></doc>") }

    before do
      record.stub(:document) { document }
    end

    it "should fetch a xpath result from the document" do
      record.fetch("//item").to_a.should eq ["1", "2"]
    end

    it "should return a AttributeValue" do
      record.fetch("//item").should be_a HarvesterCore::AttributeValue
    end

    it "should be backwards compatible with xpath option" do
      record.fetch(xpath: "//item").to_a.should eq ["1", "2"]
    end

    it "should fetch a value with a namespace" do
      klass.namespaces dc: "http://purl.org/dc/elements/1.1/"
      record.stub(:document) { Nokogiri.parse(%q{<doc><dc:item xmlns:dc="http://purl.org/dc/elements/1.1/">1</dc:item></doc>}) }
      record.fetch("//dc:item", "dc").to_a.should eq ["1"]
    end
  end
  
  describe "#node" do
    let(:document) { Nokogiri::XML::Document.new }
    let(:xml_nodes) { double(:xml_nodes) }

    before { record.stub(:document) { document } }

    it "extracts the XML nodes from the document" do
      document.should_receive(:xpath).with("//locations") { xml_nodes }
      record.node("//locations").should eq xml_nodes
    end

    context "xml document not available" do
      before { record.stub(:document) {nil} }

      it "returns an empty attribute_value" do
        nodes = record.node("//locations")
        nodes.should be_a(HarvesterCore::AttributeValue)
        nodes.to_a.should eq []
      end
    end
  end

  describe "full_raw_data" do
    before { record.stub(:raw_data) { "<record/>" } }

    context "with namespaces" do
      before { klass._namespaces = {"xmlns:foo" => "bar" } }

      it "should add the root node with namespaces" do
        record.full_raw_data.should eq "<root xmlns:foo='bar'><record/></root>"
      end
    end

    context "without namespaces" do
      before { klass._namespaces = nil }

      it "should return the raw_data" do
        record.full_raw_data.should eq "<record/>"
      end
    end

  end
end