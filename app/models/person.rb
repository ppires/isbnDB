class Person < ActiveRecord::Base

  validates_uniqueness_of :isbndb_person_id

  has_many :authorships
  has_many :books, :through => :authorships
  belongs_to :city
  has_one :country, :through => :city

  def update_info_by_name_search
    BookCrawler.search_by_author_name self.name do |author|
      p = Person.find_or_create_by_isbndb_person_id author['person_id']
      p.update_attributes :name => author['Name'],
                          :first_name => author['Details']['first_name'],
                          :last_name => author['Details']['last_name']

      self.authorships.each do |a|
        Authorship.create! :book_id => a.book_id,
                           :person_id => p.id,
                           :role => a.role
        a.destroy
      end
      self.destroy
    end
  end
end
