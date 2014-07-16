
class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
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

    # m = TactfulTokenizer::Model.new
    sentences = ""

    book.each_page_on_spine do |page|
      page = page.content_document.nokogiri
      page.search('p').each{|el| el.before ' '}
      sentences << page.text
    end

    book = Book.create(title: params[:title], sentences: sentences)
    
    redirect_to books_path(book.id)
  end
end
