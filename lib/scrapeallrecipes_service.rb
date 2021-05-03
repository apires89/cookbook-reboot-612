require 'nokogiri'
require 'open-uri'
require 'byebug'

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    top5 = []
    #call the service
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    doc = Nokogiri::HTML(URI.open(url), nil, 'utf-8')

    doc.search('.card__detailsContainer-left').first(5).each do |element|
      name = element.search('.card__title').text.strip
      description = element.search('.card__summary').text.strip
      a = element.search('.review-star-text').text
      rating = a.match(/\d\.?\d*/)[0].to_f
      ingredient_url = element.search(".card__titleLink").attribute("href").value.strip
      ingredient_doc = Nokogiri::HTML(URI.open(ingredient_url), nil, 'utf-8')
      prep_time = ingredient_doc.search(".recipe-meta-item-body").first.text.strip
      top5 << Recipe.new(name: name,description: description,rating: rating, prep_time: prep_time)
    end
    #IMPORTANT to return an array
    return top5
    #return an array of the top5 recipes
  end
end
