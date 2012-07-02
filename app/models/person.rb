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


  def self.search person_info
    @people = Person.unscoped
    @people = @people.where('name LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{person_info['name']}%", "%#{person_info['name']}%", "%#{person_info['name']}%") if person_info['name'].present?
#    @people = @people.where('birth > ? AND birth < ?', Date.new(person_info['birth_year'], 1, 1), Date.new(person_info['birth_year'], 12, 31)) if person_info['birth_year'].present?
    @people = @people.joins(:city).where('cities.name LIKE ?', "%#{person_info[:city]}%") if person_info[:city].present?
    @people = @people.joins(:city).joins(:country).where('countries.name LIKE ?', "%#{person_info[:country]}%") if person_info[:country].present?
    @people = @people.joins(:books).where('books.titulo LIKE ?', "%#{person_info[:book]}%")
  end
end
