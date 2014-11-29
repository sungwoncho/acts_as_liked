module ActsAsLikeable
  module Likeable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_likeable
        has_many :likes, as: :likeable, dependent: :destroy
        include ActsAsLikeable::Likeable::InstanceMethods
      end

      def likeable?
        true
      end
    end

    module InstanceMethods
      def like_count
        likes.count
      end

      def liked_by?(liker)
        likes.find_by(liker_id: liker.id, liker_type: liker.class.base_class.name).present?
      end
    end

  end
end