class Minute < ActiveRecord::Base

  attr_accessor :user_id, :amount, :description

  belongs_to :user

  validates_presence_of :user_id, :amount



end
