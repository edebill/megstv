class Scratch < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :integer_only => true
  
end
