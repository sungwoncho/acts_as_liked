require "acts_as_likeable/version"
require "active_support"

module ActsAsLikeable
  require 'acts_as_likeable/likeable.rb'
end

ActiveSupport.on_load(:active_record) do
  include ActsAsLikeable::Likeable
end
