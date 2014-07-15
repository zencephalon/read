
class BooksController < ApplicationController
  def show
  end

  def new
  end

  def create
    uploaded_io = params[:book]
    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    book = EPUB::Parser.parse(filename)

    page = book.each_page_on_spine.drop(10)[9].content_document.nokogiri
    page.search('p').each{|el| el.before ' '}
    text = page.text

    m = TactfulTokenizer::Model.new

    p m.tokenize_text(text)
    
    redirect_to '/'
  end
end
