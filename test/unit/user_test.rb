require 'test_helper'

describe User do

  before do
    @user = User.new
    @default = User.new
  end

  describe "when being created" do

    it "should blank default attributes" do
      @user.valid?
      refute_match @default.display_name, @user.display_name  
    end

  end

end
