class SearchController < ApplicationController

  def index
    @years_for_select = ""
    1900.upto(2012) {|i| @years_for_select += "<option>#{i}</option>"}
    @genres = Genre.order('name').all
  end

  def books

  end

  def authors

  end
end
