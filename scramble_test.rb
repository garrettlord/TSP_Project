require File.join(Rails.root, "/lib/scramble_helper.rb")

include ScrambleHelper

begin
	testUser = User.new(:name => "Derp", :phone_number => "1234567890", :password => "password", :password_confirmation => "password")

	puts "TEST GAME\n"
	puts playGame(testUser, "")
	puts debug(testUser)
	puts "\n"

	puts "tacole\n"
	puts playGame(testUser, "tacole")
	#puts debug(testUser)
	puts "\n"
	
	puts "-hint\n"
	puts playGame(testUser, "-hint")
	#puts debug(testUser)
	puts "\n"
	
	puts "tacolegs\n"
	puts playGame(testUser, "tacolegs")
	#puts debug(testUser)
	puts "\n"

	puts "tacoleg\n"
	puts playGame(testUser, "tacoleg")
	#puts debug(testUser)
	puts "\n"
	
	puts "TEST GAME\n"
	puts playGame(testUser, "")
	#puts debug(testUser)
	puts "\n"
	
	puts "tacoleg\n"
	puts playGame(testUser, "tacoleg")
	#puts debug(testUser)
	puts "\n"
	
	
	

	puts "Everything went better than expected"
end