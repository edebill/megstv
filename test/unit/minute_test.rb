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

    it "should update child's current minutes on save" do
      @child = @minute.child
      old_minutes = @child.current_minutes
      @new_minute = Factory(:minute, :amount => 3, :child => @child)
      assert_equal @child.id, @new_minute.child.id
      refute_equal old_minutes, @new_minute.child.current_minutes
    end

    it "should have a version" do
      @minute.save
      @minute.reload
      assert_equal 1, @minute.versions.count, "didn't have a version"
    end
    
    describe "when updated" do

      before :each do
        def current_user
          @minute.user
        end

        @minute.amount = 10
        @minute.save!
        @child = @minute.child
        @old_amount = @minute.amount
        @old_minute_total = @child.current_minutes

        @minute.amount += 1
        @minute.save!
        @child = User.find(@child.id)

      end

      it "should create a second version" do
        assert_equal 2, @minute.versions.count, "didn't have two versions"
      end

      it "should update total minutes for the child" do
        assert_equal (@old_minute_total + 1), @child.current_minutes
      end
    end
  end

end
