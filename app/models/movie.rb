class Movie < ActiveRecord::Base
  attr_accessible :language, :name, :release_date, :actor_id
  belongs_to :actor
  belongs_to :user

  def self.languages
  	["English","Hindi"]
  end

  self.per_page = 10
end
