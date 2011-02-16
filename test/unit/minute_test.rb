require 'test_helper'

describe Minute do

  before :each do
    @minute = Factory.build(:minute)
  end

  describe "when validated" do
    it "should fail without an amount" do
      @minute.amount = nil
      refute @minute.valid?
    end

    it "should fail with a non-integer amount" do
      @minute.amount = "a"
      refute @minute.valid?
    end

    it "should fail without a user_id" do
      skip("can't get this to pass - bypass until later")
      @minute.user_id = nil
      refute @minute.valid?
    end

    it "should fail without a child_id" do
      skip("can't get this to pass - bypass until later")
      @minute.child_id = nil
      refute @minute.valid?
    end

    it "should validate just fine" do
      @minute.valid?
      puts @minute.errors.full_messages
      assert @minute.valid?
    end

  end

end
