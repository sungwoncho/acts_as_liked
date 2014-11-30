require "acts_as_liked/version"
require "active_support"

module ActsAsLiked
  require 'acts_as_liked/likeable.rb'
  require 'acts_as_liked/liker.rb'
end

ActiveSupport.on_load(:active_record) do
  include ActsAsLiked::Likeable
  include ActsAsLiked::Liker
end
