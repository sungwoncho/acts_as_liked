require 'spec_helper'

describe Food, focus: true do

	let(:charlie) { User.create(name: "Charlie") }
	let(:cheese) { Food.create(name: "cheese") }

	it "should be likeable" do
		expect(Food).to be_likeable
	end

	describe "Association" do
		it "should have many likes" do
			association = Food.reflect_on_association(:likes)
			expect(association.macro).to eq :has_many
		end

		it "should have many likes with dependent destroy" do
			association = Food.reflect_on_association(:likes)
			expect(association.options).to include :dependent => :destroy
		end
	end

	describe "#like_count" do
		it "should count likes" do
			create_like(charlie, cheese)
			expect(cheese.like_count).to eq 1
		end
	end

	describe "#liked_by?" do
		context "when liker has liked likeable" do
			it "should return true" do
				create_like(charlie, cheese)
				expect(cheese.liked_by?(charlie)).to be true
			end
		end

		context "when liker hasn't liked likeable" do
			it "should return false" do
				expect(cheese.liked_by?(charlie)).to be false
			end
		end
	end
end