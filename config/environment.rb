# Load the rails application
require File.expand_path('../application', __FILE__)

# load BookCrawler
require File.expand_path("../../lib/crawler.rb", __FILE__)

# Initialize the rails application
IsbnDB::Application.initialize!
