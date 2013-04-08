require File.join(Rails.root, "lib/scramble_helper.rb")

begin
	testUser = User.new(:name => "Derp", :phone_number => "1234567890", :password => "password", :password_confirmation => "password")

	playGame(testUser, "derp")
end