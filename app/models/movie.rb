class Movie < ActiveRecord::Base
  attr_accessible :language, :name, :release_date, :actor_id, :id
  belongs_to :actor
  belongs_to :user

  validates_uniqueness_of :name

  def self.languages
  	["English","Hindi"]
  end

  self.per_page = 10
end
