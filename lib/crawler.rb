require 'uri'

class BookCrawler
  @@book_base_url = "http://isbndb.com/api/books.xml"
  @@author_base_url = "http://isbndb.com/api/authors.xml"
  @@access_key = "9KRK69K3"
  @@index1 = "title"
  @@value1 = "bancos+de+dados"

  cattr_reader :base_url, :access_key
  cattr_accessor :index1, :value1

  def self.search_by_title str, &block
    page = 0
    loop do
      page += 1
      url = "#{@@book_base_url}?access_key=#{@@access_key}&results=texts,prices,authors&page_number=#{page.to_s}&index1=title&value1=#{URI.encode(str)}"
      resp = HTTParty.get(url).parsed_response
      total_results = resp['ISBNdb']['BookList']['total_results'].to_i
      return nil if total_results == 0
      if total_results > 1
        resp['ISBNdb']['BookList']['BookData'].each { |book| pp book; yield book }
      else
        pp resp['ISBNdb']['BookList']['BookData']
        yield resp['ISBNdb']['BookList']['BookData']
      end
      break unless page * 10 < total_results
    end
  end

  def self.search_by_book_id str
    url = "#{@@book_base_url}?access_key=#{@@access_key}&&index1=book_id&value1=#{URI.encode(str)}"
    resp = HTTParty.get(url).parsed_response
    pp resp
  end

  def self.get_all_infos isbn, &block
    page = 0
    loop do
      page += 1
      url = "#{@@book_base_url}?access_key=#{@@access_key}&results=texts,prices,authors&page_number=#{page.to_s}&index1=isbn&value1=#{isbn}"
      resp = HTTParty.get(url).parsed_response
      total_results = resp['ISBNdb']['BookList']['total_results'].to_i
      return nil if total_results == 0
      if total_results > 1
        resp['ISBNdb']['BookList']['BookData'].each { |book| pp book; yield book }
      else
        pp resp['ISBNdb']['BookList']['BookData']
        yield resp['ISBNdb']['BookList']['BookData']
      end
      break unless page * 10 < total_results
    end
  end

  def self.search_by_author_name str
    page = 0
    loop do
      page += 1
      url = "#{@@author_base_url}?access_key=#{@@access_key}&results=details&page_number=#{page.to_s}&index1=name&value1=#{URI.encode(str)}"
      resp = HTTParty.get(url).parsed_response
      total_results = resp['ISBNdb']['AuthorList']['total_results'].to_i
      return nil if total_results == 0
      if total_results > 1
        resp['ISBNdb']['AuthorList']['AuthorData'].each { |author| puts "[CRAWLER] author:\n"; pp author; yield author }
      else
        pp resp['ISBNdb']['AuthorList']['AuthorData']
        yield resp['ISBNdb']['AuthorList']['AuthorData']
      end
      break unless page * 10 < total_results
    end
  end

  def self.get_first_author_by_name str
    url = "#{@@author_base_url}?access_key=#{@@access_key}&results=details&index1=name&value1=#{URI.encode(str)}"
    resp = HTTParty.get(url).parsed_response
    total_results = resp['ISBNdb']['AuthorList']['total_results'].to_i
    return nil if total_results == 0
    if resp['ISBNdb']['AuthorList']['total_results'].to_i > 1
      resp['ISBNdb']['AuthorList']['AuthorData'].first
    else
      resp['ISBNdb']['AuthorList']['AuthorData']
    end
  end

end
