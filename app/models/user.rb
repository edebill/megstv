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
