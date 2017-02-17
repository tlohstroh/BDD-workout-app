require "rails_helper"
require "spec_helper"

describe User do

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it "is invalid without a firstname" do
    expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
  end

  it "is invalid without a lastname" do
    expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
  end

  it "returns a contact't full name as a string" do
    user = FactoryGirl.create(:user, first_name: "John", last_name: "Doe" )
    expect(user.full_name).to eq("John Doe")
  end

end
