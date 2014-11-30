module ActsAsLikeable
  module Liker

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_liker
        has_many :likes, dependent: :destroy
        include ActsAsLikeable::Liker::InstanceMethods
      end

      def likeable?
        true
      end
    end

    module InstanceMethods
      def liked?(likeable)
        likes.find_by(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name).present?
      end

      def like(likeable)
        likes.create(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name)
      end

      def unlike(likeable)
        like_record = likes.find_by(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name)
        like_record.try(:destroy)
      end
    end

  end
end