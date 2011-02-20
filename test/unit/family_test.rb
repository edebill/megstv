require 'test_helper'

describe Family do
  before do
    @family = Factory(:family)
  end

  describe "parents" do
    it "should return an empty array when no parents exist" do
      assert_empty @family.parents
    end

    it "should not include a child" do
      @child = Factory(:child_user, :family => @family)
      assert_empty @family.parents
    end

    it "should include a parent" do
      @parent = Factory(:parent_user, :family => @family)
      refute_empty @family.parents
    end

    it "should include more than one parent when present" do
      @parent = Factory(:parent_user, :family => @family)
      @parent = Factory(:parent_user, :family => @family)
      assert_equal 2, @family.parents.length
    end
  end

  describe "children" do
    it "should return an empty array when no children exist" do
      assert_empty @family.children
    end

    it "should not include a parent" do
      @parent = Factory(:parent_user, :family => @family)
      assert_empty @family.children
    end

    it "should include a child" do
      @child = Factory(:child_user, :family => @family)
      refute_empty @family.children
    end

    it "should include more than one child when present" do
      @child = Factory(:child_user, :family => @family)
      @child = Factory(:child_user, :family => @family)
      assert_equal 2, @family.children.length
    end
  end


  describe "member?" do
    it "is false when candidate is not in family" do
      @cand = Factory(:user)
      refute @family.member? @cand
    end

    it "is true when cacndidate is in family" do
      @cand = Factory(:user, :family => @family)
      assert @family.member? @cand
    end
  end
end
