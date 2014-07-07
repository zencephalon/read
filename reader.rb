require 'epub/parser'
require 'tactful_tokenizer'

book = EPUB::Parser.parse('rationality.epub')

page = book.each_page_on_spine.drop(10)[9].content_document.nokogiri
page.search('p').each{|el| el.before ' '}
text = page.text

m = TactfulTokenizer::Model.new

m.tokenize_text(text).each do |line|
  puts line
end
