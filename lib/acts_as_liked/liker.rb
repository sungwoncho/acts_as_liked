module ActsAsLiked
  module Liker

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_liker
        has_many :likes, as: :liker, dependent: :destroy
        include ActsAsLiked::Liker::InstanceMethods
      end

      def likeable?
        true
      end
    end

    module InstanceMethods
      def liked?(likeable)
        self.likes.find_by(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name).present?
      end

      def like(likeable)
        unless self.liked?(likeable)
          self.likes.create(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name)
        end
      end

      def unlike(likeable)
        like_record = likes.find_by(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name)
        like_record.try(:destroy)
      end
    end

  end
end