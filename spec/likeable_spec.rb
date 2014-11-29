require 'spec_helper'

describe ActsAsLikeable::Likeable do
  it "should be likeable" do
  	expect(Likeable).to be_likeable
  end
end