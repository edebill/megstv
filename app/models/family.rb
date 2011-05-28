class Family < ActiveRecord::Base
  has_many :members, :class_name => 'User'

  def children
    @children ||= self.members.reject { |m| m.parent }.sort { |a,b| a.display_name <=> b.display_name }
  end

  def parents
    @parents ||= self.members.select { |m| m.parent }
  end

  def member?(candidate)
    self.members.include? candidate
  end

end
