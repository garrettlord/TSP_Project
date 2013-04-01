<<<<<<< HEAD
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
=======
# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
>>>>>>> e720476d02c7fca50f96f5a0209f871bea3ed1a7
