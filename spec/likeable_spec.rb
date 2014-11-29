require 'spec_helper'

describe ActsAsLikeable::Likeable do

	it "should be likeable" do
		expect(Likeable).to be_likeable
	end

	describe "Association" do
		it "should have many likes" do
			association = Likeable.reflect_on_association(:likes)
			expect(association.macro).to eq :has_many
		end

		it "should have many likes with dependent destroy" do
			association = Likeable.reflect_on_association(:likes)
			expect(association.options).to include :dependent => :destroy
		end
	end
end