require 'spec_helper'

describe ActsAsLiked::Likeable, focus: true do

	let(:liker) { User.create(name: "Charlie") }
	let(:likeable) { Post.create(name: "cheese") }

	it "should be likeable" do
		expect(User).to be_likeable
	end

	describe "Association" do
		it "should have many likes" do
			association = Post.reflect_on_association(:likes)
			expect(association.macro).to eq :has_many
		end

		it "should have many likes with dependent destroy" do
			association = Post.reflect_on_association(:likes)
			expect(association.options).to include :dependent => :destroy
		end
	end

	describe "#like_count" do
		it "should count likes" do
			create_like(liker, likeable)
			expect(likeable.like_count).to eq 1
		end
	end

	describe "#liked_by?" do
		context "when liker has liked likeable" do
			it "should return true" do
				create_like(liker, likeable)
				expect(likeable.liked_by?(liker)).to be true
			end
		end

		context "when liker hasn't liked likeable" do
			it "should return false" do
				expect(likeable.liked_by?(liker)).to be false
			end
		end
	end
end