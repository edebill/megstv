class Minute < ActiveRecord::Base

  belongs_to :user
  belongs_to :child, :class_name => 'User', :foreign_key => 'child_id'

# looks like this is a bit of known bug :(
#  validates_presence_of :user, :child

  validates_presence_of :amount
  validates_numericality_of :amount, :only_integer => true

  after_save :update_totals

  def update_totals
    self.child.update_current_minutes
    self.child.save
  end
end
