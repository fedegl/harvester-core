require "spec_helper"

describe ActiveModel::Validations::ExclusionValidator do
  
  context "validates none of the values are part of a defined list" do
    class TestJsonExclusion < HarvesterCore::Json::Base
      attribute :dc_type, path: "dc_type"
      validates :dc_type, :exclusion => { :in => ["Images", "Videos"] }
    end

    it "should be valid when none of the values are part of the list" do
      record = TestJsonExclusion.new({"dc_type" => ["Photos", "Manuscripts"]})
      record.set_attribute_values
      record.valid?.should be_true
    end

    it "should not be valid when at least one value is part of the list" do
      record = TestJsonExclusion.new({"dc_type" => ["Videos", "Photos"]})
      record.set_attribute_values
      record.valid?.should be_false
    end
  end

end
