class User < ActiveRecord::Base
  acts_as_liker
end

class Food < ActiveRecord::Base
  acts_as_likeable
end

class Like < ActiveRecord::Base
  belongs_to :liker, polymorphic: true
  belongs_to :likeable, polymorphic: true
end