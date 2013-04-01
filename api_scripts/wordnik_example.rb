require 'rubygems'
gem 'wordnik'
require 'wordnik'
require 'pp'

%w(rubygems wordnik).each {|lib| require lib}

Wordnik.configure do |config|
    config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'
end

	word = Wordnik.word.get_definitions('Team',
                                     partOfSpeech='verb',
                                     sourceDictionaries='wiktionary',
                                     limit=1)

puts word[0]["text"]