require 'rubygems'
require 'twitter'

client = Twitter::Streaming::Client.new do |config|
	config.consumer_key = "yRDGd1lkfrJzZdB7pXbrCivqc"
	config.consumer_secret = "Bj3bkXgX7K6kD8OTe27d9Jx1ef0gIOH8COmqQgrM69laJnFBMo"
	config.access_token = "3018200030-T50O2E7B5L3jXMNH6xmHvpAEvZZTwS07HzBC9ZC"
	config.access_token_secret = "pbOvS7d8ZUutnbMTrQY4bfhQxHsxrGnvGh5r188Use2JM"
end

string = ''
fiveMinuteTimer = Time.now + 300

#client.sample(lang: "en") do |tweet|
client.filter(locations: "-126.75,32.8,-115.75,42.8") do |tweet|
	string << tweet.text
	break if Time.now > fiveMinuteTimer
end

stopWords = IO.readlines("/RubyProjects/stop_words.txt")
stopWords.each {|a| a.strip! if a.respond_to? :strip! }
wordFrequency = Hash.new(0)

string.gsub!(/[^a-zA-Z' ]/, "")
#puts string
string = string.downcase.split(/\s+/)
string -= stopWords
string.each do |word|
	if word !~ /^[0-9]*\.?[0-9]+$/ 
		wordFrequency[word] += 1
	end
end

counter = 0
while counter < 10 do
	mostCommonWord = wordFrequency.max_by{|k,v| v}
	puts "#{mostCommonWord[0]}: #{mostCommonWord[1]} occurrences"
	wordFrequency.delete(mostCommonWord[0])
	counter += 1
end