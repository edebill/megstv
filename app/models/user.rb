class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name

  defaults :display_name => "e.g. mom", :email => "e.g. you@somewhere.com"

  belongs_to :family

  has_many :entered_minutes, :class_name => "Minute", :foreign_key => "user_id", :source => :creator
  has_many :minutes, :foreign_key => "child_id", :source => :child

  
  before_validation :blank_defaults

  def latest_minutes
    Minute.where(:child_id => self.id).order('created_at desc').limit(10).reverse
  end

  def calculate_current_minutes
    self.minutes.reload.collect { |m| m.amount }.sum
  end

  def update_current_minutes
    self.current_minutes = self.calculate_current_minutes
  end

  def can_edit?(minute)
    if self.family.member?(minute.child)
      if self.parent
        return true
      elsif self.id == minute.user_id
        if minute.created_at > (Time.now - 5.minutes)
          return true
        end
      end
    end
    false
  end

  private

  def blank_defaults
    defaults = self.class.new
    
    self.attributes.keys.each do |attribute|
      if((! self.attributes[attribute].blank?) &&
         self.attributes[attribute].to_s.starts_with?( "e.g." ) &&
         ( self.attributes[attribute] == defaults.attributes[attribute]) )

        self.attributes= { attribute => "" }
      end
    end
  end

end
