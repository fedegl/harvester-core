require "spec_helper"

describe HarvesterCore::Json::Base do
  
  let(:klass) { HarvesterCore::Json::Base }
  let(:document) { mock(:document) }
  let(:record) { mock(:record).as_null_object }

  after do
    klass._base_urls[klass.identifier] = []
    klass._attribute_definitions[klass.identifier] = {}
    klass._rejection_rules[klass.identifier] = nil
    klass._throttle = {}
  end

  describe ".record_selector" do
    it "stores the path to retrieve every record metadata" do
      klass.record_selector "&..items"
      klass._record_selector.should eq "&..items"
    end
  end

  describe ".records" do
    before { klass.stub(:records_json) { [{"title" => "Record1"}] } }

    it "initializes record for every json record" do
      klass.should_receive(:new).once.with({"title" => "Record1"}) { record }
      klass.records.should eq [record]
    end

    it "removes any record that it's reject_if block evaluates to false" do
      klass.reject_if { true }
      klass.records.should eq []
    end

    it "limits the number of records" do
      klass.stub(:records_json) { [{"title" => "Record1"}, {"title" => "Record2"}] }
      klass.records(limit: 1).size.should eq 1
    end
  end

  describe ".records_json" do
    let(:json) { %q{{"items": [{"title": "Record1"},{"title": "Record2"},{"title": "Record3"}]}} }

    it "returns an array of records with the parsed json" do
      klass.stub(:document) { json }
      klass.record_selector "$..items"
      klass.records_json.should eq [{"title" => "Record1"}, {"title" => "Record2"}, {"title" => "Record3"}]
    end
  end

  describe ".document" do
    let(:json) { %q{"description": "Some json!"} }

    it "stores the raw json" do
      klass.base_url "http://google.com"
      HarvesterCore::Request.should_receive(:get).with("http://google.com", {}) { json }
      klass.document.should eq json
    end
  end

  describe ".clear_definitions" do
    it "clears the _record_selector" do
      klass.record_selector "path"
      klass.clear_definitions
      klass._record_selector.should be_nil
    end
  end

  describe "#initialize" do
    it "initializes the record's attributes" do
      record = klass.new({"title" => "Dos"})
      record.json_attributes.should eq({"title" => "Dos"})
    end

    it "returns an empty hash when attributes are nil" do
      record = klass.new(nil)
      record.json_attributes.should eq({})
    end

    it "initializes from a json string" do
      data = {"title" => "Hi"}.to_json
      record = klass.new(data)
      record.document.should eq({"title" => "Hi"})
    end
  end

  describe "#full_raw_data" do
    let(:record) { klass.new({"title" => "Hi"}) }

    it "should convert the raw_data to json" do
      record.full_raw_data.should eq({"title" => "Hi"}.to_json)
    end
  end

  describe "#strategy_value" do
    let(:record) { klass.new({"dc:creator" => "John", "dc:author" => "Fede"}) }

    it "returns the value of a attribute" do
      record.strategy_value(path: "dc:creator").should eq "John"
    end

    it "returns the values from multiple paths" do
      record.strategy_value(path: ["dc:creator", "dc:author"]).should eq ["John", "Fede"]
    end

    it "returns nil without :path" do
      record.strategy_value(path: nil).should be_nil
    end
  end

  describe "#fetch" do
    let(:record) { klass.new({"dc:creator" => "John", "dc:author" => "Fede"}) }
    let(:document) { {"location" => 1234} }
    
    before { record.stub(:document) { document } }

    it "returns the value object" do
      value = record.fetch("location")
      value.should be_a HarvesterCore::AttributeValue
      value.to_a.should eq [1234]
    end
  end
end