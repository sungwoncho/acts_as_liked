require 'spec_helper'

describe ActsAsLiked::Liker do

	let(:liker) { User.create(name: "Charlie") }
	let(:likeable) { Post.create(name: "cheese") }
	
	it "should be likeable" do
		expect(User).to be_likeable
	end

	describe "instance methods" do
		it "should be defined" do
			expect(liker).to respond_to(:like)
			expect(liker).to respond_to(:unlike)
			expect(liker).to respond_to(:liked?)
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
				create_like(liker, likeable)
				expect(liker.liked?(likeable)).to be true
			end
		end

		context "when liker hasn't liked likeable" do
			it "should return false" do
				expect(liker.liked?(likeable)).to be false
			end
		end
	end

	describe "#like" do
		it "should create a like record" do
			expect {
				liker.like(likeable)
			}.to change(Like, :count).by(1)
		end

		it "should set association of the like record" do
			liker.like(likeable)
			like = Like.find_by(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name, liker_id: liker.id)
			expect(like.liker).to eq liker
			expect(like.likeable).to eq likeable
		end
	end

	describe "#unlike" do
		context "when liker has liked likeable" do
			it "should destroy the like record" do
				create_like(liker, likeable)
				expect {
					liker.unlike(likeable)
				}.to change(Like, :count).by(-1)
			end
		end

		context "when liker has not liked likeable" do
			it "should do nothing" do
				expect {
					liker.unlike(likeable)
				}.to change(Like, :count).by(0)
			end
		end
	end
end