module ActsAsLikeable
  module Likeable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_likeable
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