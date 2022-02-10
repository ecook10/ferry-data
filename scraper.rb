require 'net/http'
require 'nokogiri'

ROOT_URL = 'wsdot.com'
URL_PATH = '/ferries/schedule/scheduledetailbyroute.aspx?route=ed-king'

RESULT_FILE = '/mnt/c/Users/evanc/Dev/ferry-data/data/history.txt'

uri = URI("https://#{ROOT_URL}#{URL_PATH}")

nbsp = Nokogiri::HTML("&nbsp;").text

page = Nokogiri::HTML.parse(
    Net::HTTP.get(uri)
)
headerCount = 0
topTimes = Array.new
bottomTimes = Array.new
page.css('table.schedgridbyroute tr').each do |tableRow|
    if tableRow['class'] == 'leftnavbox'
        headerCount += 1
    else
        currTimes = headerCount < 2 ? topTimes : bottomTimes
        tableRow.css('div.am, div.pm').to_a.each_with_index do |timeDiv, i|
            timeString = "#{timeDiv.content.gsub(nbsp, "")}#{timeDiv['class']}"
            if currTimes[i].nil?
                currTimes[i] = [timeString]
            else
                currTimes[i] << timeString
            end
        end
    end
end

open(RESULT_FILE, 'a') do |f|
    f.puts "Kingston-Edmonds Ferry Schedule"
    f.puts "Pulled at #{Time.now}"
    f.puts "Edmonds Times - #{topTimes.flatten.inspect}"
    f.puts "Kingston Times - #{bottomTimes.flatten.inspect}"
    f.puts
end