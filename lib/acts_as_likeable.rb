require "acts_as_likeable/version"
require "active_support"

module ActsAsLikeable
  require 'acts_as_likeable/likeable.rb'
  require 'acts_as_likeable/liker.rb'
end

ActiveSupport.on_load(:active_record) do
  include ActsAsLikeable::Likeable
  include ActsAsLikeable::Liker
end
