require 'rubygems'
gem 'wordnik'
require 'wordnik'
require 'pp'

%w(rubygems wordnik).each {|lib| require lib}

Wordnik.configure do |config|
    config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'
end

	word = Wordnik.word.get_definitions('school', :limit=>2, :source_dictionaries => 'webster')
	example = Wordnik.word.get_examples('school')
	related = Wordnik.word.get_related('sad', :type => 'synonym')
	pron = Wordnik.word.get_text_pronunciations('apple')
	#scrabble = Wordnik.word.get_scrabble_score('Score')
	wotd = Wordnik.words.get_word_of_the_day()
	random = Wordnik.words.get_random_word(:part_of_speech => 'verb', :part_of_speech => 'noun', :part_of_speech => 'adjective', :minLength => '3', :maxLength => '4')


puts word[0]["text"]
puts "---------------------"
puts example["examples"][0]["text"]
puts "---------------------"
related[0]["words"].each  do |temp|
puts temp
end
puts "------------------------"
puts wotd["word"]
puts wotd["examples"][0]["text"]
puts wotd["examples"][1]["text"]
puts "------------------------"
puts random["word"]
