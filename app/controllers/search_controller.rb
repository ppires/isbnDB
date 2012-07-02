class SearchController < ApplicationController

  def index
    @years_for_select = "<option selected=\"selected\"></option>"
    1900.upto(2012) {|i| @years_for_select += "<option>#{i}</option>"}
    @genres = Genre.order('name').all
  end

  def books
    @results = Book.search params[:book]
    @result_type = 'book'
    render 'results'
  end

  def authors
    @results = Person.search params[:person]
    @result_type = 'person'
    render 'results'
  end
end
