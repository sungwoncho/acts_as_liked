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

	describe "#liked_by" do
		context "when liker has not liked likabled" do
			it "should create Like" do
				expect{
					cheese.liked_by(charlie)
				}.to change(Like, :count).by(1)
			end

			it "should set Like to belong to liker" do
				cheese.liked_by(charlie)
				like = Like.find_by(likeable_id: cheese.id, likeable_type: cheese.class.base_class.name, liker_id: charlie.id, liker_type: charlie.class.base_class.name)

				expect(like.liker).to eq charlie
			end

			it "should set Like to belong to likeable" do
				cheese.liked_by(charlie)
				like = Like.find_by(likeable_id: cheese.id, likeable_type: cheese.class.base_class.name, liker_id: charlie.id, liker_type: charlie.class.base_class.name)

				expect(like.likeable).to eq cheese				
			end
		end

		context "when liker has already liked likeable" do
			it "should not create Like" do
				create_like(charlie, cheese)

				expect { 
					cheese.liked_by(charlie)
				}.to change(Like, :count).by(0)
			end
		end
	end

	describe "#unliked_by" do
		context "when liker has liked likedable" do
			it "should destroy the like record" do
				create_like(charlie, cheese)

				expect { 
					cheese.unliked_by(charlie)
				}.to change(Like, :count).by(-1)
			end
		end

		context "when liker has not liked likeable" do
			it "should not destroy any Likes" do
				expect { 
					cheese.unliked_by(charlie)
				}.to change(Like, :count).by(0)
			end
		end
	end
end