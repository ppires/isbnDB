class Book < ActiveRecord::Base
  validates_uniqueness_of :ISBN

  has_one :additional_info
  belongs_to :genre
  has_many :authorships
  has_many :authors, :through => :authorships, :source => :person
  #has_many :editors, :through => :authorships, :class_name => 'Person'

  def self.create_by_title_search str
    BookCrawler.search_by_title(str) do |book_info|
      book = Book.find_or_create_by_ISBN book_info['isbn13'], :titulo => book_info['Title']
      add_info = AdditionalInfo.create :book_id => book.id,
                                       :summary => book_info['Summary'],
                                       :notes => book_info['Notes'],
                                       :related_urls => book_info['UrlsText'],
                                       :awards => book_info['Awardstext']

      if book_info['Authors']
        author_info = BookCrawler.get_first_author_by_name book_info['Authors']['Person']
        author = Person.find_or_create_by_isbndb_person_id author_info['person_id']
        author.update_attributes :name => author_info['Name'],
                                 :first_name => author_info['Details']['first_name'],
                                 :last_name => author_info['Details']['last_name']
        authorship = Authorship.find_or_create_by_person_id_and_book_id author.id, book.id, :role => "Author"
      else
        if book_info['AuthorsText']
          author_info = BookCrawler.get_first_author_by_name book_info['AuthorsText']
          author = Person.find_or_create_by_isbndb_person_id author_info['person_id']
          author.update_attributes :name => author_info['Name'],
                                   :first_name => author_info['Details']['first_name'],
                                   :last_name => author_info['Details']['last_name']
          authorship = Authorship.find_or_create_by_person_id_and_book_id author.id, book.id, :role => "Author"
        end
      end

      price = 0
      total = 0
      if book_info['Prices']['Price']
        if (book_info['Prices']['Price'].is_a? Array)
          book_info['Prices']['Price'].each do |price_info|
            puts "\n"
            pp price_info
            if price_info['price']
              total += 1
              price += price_info['price'].to_f
            end
          end
        else
            puts "\n"
            pp book_info['Prices']['Price']
            if book_info['Prices']['Price']['price']
              total += 1
              price += book_info['Prices']['Price']['price'].to_f
            end
        end
        price = price / total
      end

      Purchase.create :book_id => book.id,
                      :price => price,
                      :quantity => 50 - rand(50) + rand(1000)


    end
  end



  def self.update_infos
    Book.find_each do |book|
      book.update_info
    end
  end

  def update_info
    BookCrawler.get_all_infos(self.ISBN) do |book_info|
      book_info['Authors'].each do |author|
        puts "\nauthor:\n"
        pp author
      end
    end
  end

end
