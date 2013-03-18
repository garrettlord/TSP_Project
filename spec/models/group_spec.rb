require 'spec_helper'

describe Group do
  before { @group = Group.new(name: "Example Group") }

  subject { @group }

  it { should respond_to(:name) }

  describe "when name is not present" do
    before { @group.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @group.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      user_with_same_name = @group.dup
      user_with_same_name.save
    end

    it { should_not be_valid }
  end
end
