require 'spec_helper'

describe User do

	let(:charlie) { User.create(name: "Charlie") }
	let(:cheese) { Food.create(name: "cheese") }
	
	it "should be a liker" do
		expect(User).to be_liker
	end

	describe "instance methods" do
		it "should be defined" do
			expect(charlie).to respond_to(:like)
			expect(charlie).to respond_to(:unlike)
			expect(charlie).to respond_to(:liked?)
		end
	end

	describe "Association" do
		it "should have many likes" do
			association = User.reflect_on_association(:likes)
			expect(association.macro).to eq :has_many
		end

		it "should have many likes with dependent destroy" do
			association = User.reflect_on_association(:likes)
			expect(association.options).to include :dependent => :destroy
		end
	end

	describe "#liked?" do
		context "when liker has liked likedable" do
			it "should return true" do
				create_like(charlie, cheese)
				expect(charlie.liked?(cheese)).to be true
			end
		end

		context "when liker hasn't liked likeable" do
			it "should return false" do
				expect(charlie.liked?(cheese)).to be false
			end
		end
	end

	describe "#like" do
		context "when liker hasn't liked likeable" do
			it "should create a like record" do
				expect {
					charlie.like(cheese)
				}.to change(Like, :count).by(1)
			end

			it "should set association of the like record" do
				charlie.like(cheese)
				like = Like.find_by(likeable_id: cheese.id, likeable_type: cheese.class.base_class.name, liker_id: charlie.id)
				expect(like.liker).to eq charlie
				expect(like.likeable).to eq cheese
			end
		end

		context "when liker has liked likeable already" do
			it "should do nothing" do
				create_like(charlie, cheese)
				expect { 
					charlie.like(cheese)
				}.to change(Like, :count).by(0)
			end
		end
	end

	describe "#unlike" do
		context "when liker has liked likeable" do
			it "should destroy the like record" do
				create_like(charlie, cheese)
				expect {
					charlie.unlike(cheese)
				}.to change(Like, :count).by(-1)
			end
		end

		context "when liker has not liked likeable" do
			it "should do nothing" do
				expect {
					charlie.unlike(cheese)
				}.to change(Like, :count).by(0)
			end
		end
	end
end