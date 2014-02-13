require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.mathworks.com/help/matlab/functionlist.html'))

trs = doc.css('tr').select{ |tr| tr.css('td.term').length == 1 }

arr = trs.map do |tr|
  name = tr.css('td.term').text.gsub(/[\n\r]/, '').strip
  desc = tr.css('td.description').text.gsub(/[\n\r]/, '').strip
  /^(\S*)\s*\(([^\(\)]+)\)$/ =~ name
  if Regexp.last_match
    name = Regexp.last_match(1)
    type = Regexp.last_match(2)
    [name, type, desc]
  else
    [name, desc]
  end
end
arr << ['rat', 'Rational fraction approximation']
arr << ['rats', 'Rational fraction approximation']

exclusions = ['break', 'colon', 'continue', 'end', 'false', 'for', 'function', 'function_handle', 'i', 'if/elseif/else', 'is*', 'j', 'LogicalOperators: Elementwise', 'LogicalOperators: Short-circuit', 'parfor', 'pause', 'pi', 'rat, rats', 'RelationalOperators', 'return', 'Special Characters', 'switch/case/otherwise', 'true', 'try/catch', 'while']
File.open('functions.dict', 'w') do |f|
  arr.uniq.sort_by{ |item| item[0].downcase }.each do |item|
    f.puts item.join("\t") unless exclusions.include?(item[0])
  end
end
