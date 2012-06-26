require 'uri'

class BookCrawler
  @@base_url = "http://isbndb.com/api/books.xml"
  @@access_key = "9KRK69K3"
  @@index1 = "title"
  @@value1 = "bancos+de+dados"

  cattr_reader :base_url, :access_key
  cattr_accessor :index1, :value1

  def self.search_by_title str, &block
    page = 0
    loop do
      page += 1
      url = "#{@@base_url}?access_key=#{@@access_key}&results=texts,prices,authors&page_number=#{page.to_s}&index1=title&value1=#{URI.encode(str)}"
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
    url = "#{@@base_url}?access_key=#{@@access_key}&&index1=book_id&value1=#{URI.encode(str)}"
    resp = HTTParty.get(url).parsed_response
    pp resp
  end

  def self.get_all_infos isbn, &block
    page = 0
    loop do
      page += 1
      url = "#{base_url}?access_key=#{access_key}&results=texts,prices,authors&page_number=#{page.to_s}&index1=isbn&value1=#{isbn}"
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

end
