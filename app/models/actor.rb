class Actor < ActiveRecord::Base
  attr_accessible :name
  has_many :movies, :dependent => :nullify

  self.per_page = 10
end
