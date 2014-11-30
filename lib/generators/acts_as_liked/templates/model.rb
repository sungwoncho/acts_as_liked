class Like < ActiveRecord::Base
  belongs_to :liker
  belongs_to :likeable
end