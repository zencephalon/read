
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

    m = TactfulTokenizer::Model.new
    sentences = []

    book.each_page_on_spine do |page|
      page = page.content_document.nokogiri
      page.search('p').each{|el| el.before ' '}
      sentences << m.tokenize_text(page.text)
    end

    p sentences
    
    redirect_to '/'
  end
end
