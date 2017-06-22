class GiphyService
  include HTTParty
  require 'open-uri'

  BASE_URI = 'http://api.giphy.com/v1/gifs'

  def self.search q
    service = self.new
    service.search(q)
  end

  def search q
    str = "#{BASE_URI}/search?q=#{q}&api_key=#{ENV['GIPHY_KEY']}"
    url = URI.escape str
    response = self.class.get(url)
    body = JSON.parse(response.body)
    body['data'].map{|h| "https://i.giphy.com/media/#{h['id']}/200w.gif"}
  end
end
