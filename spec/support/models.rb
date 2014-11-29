class Liker < ActiveRecord::Base
end

class Likeable < ActiveRecord::Base
  acts_as_likeable
end

class NonLiker < ActiveRecord::Base
end

class NonLikeable < ActiveRecord::Base
end