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
    
    redirect_to '/'
  end
end
