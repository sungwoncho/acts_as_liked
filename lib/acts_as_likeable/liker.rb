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

    end

  end
end