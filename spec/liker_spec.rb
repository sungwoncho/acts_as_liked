require 'spec_helper'

describe ActsAsLikeable::Liker do
	it "should be likeable" do
		expect(Liker).to be_likeable
	end

	describe "Association" do
		it "should have many likes" do
			association = Liker.reflect_on_association(:likes)
			expect(association.macro).to eq :has_many
		end

		it "should have many likes with dependent destroy" do
			association = Liker.reflect_on_association(:likes)
			expect(association.options).to include :dependent => :destroy
		end
	end
end