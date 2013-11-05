require 'spec_helper'

describe Tag do
  let(:tag) { Tag.new(name: 'ruby') }

  describe "#to_param" do
    it "should return the name attribute" do
      tag.to_param.should eq 'ruby'
    end
  end
end