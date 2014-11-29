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
    end

  end
end