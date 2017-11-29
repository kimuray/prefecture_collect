require 'open-uri'
require 'json'

class ResasApi
  attr_reader :api_key

  def initialize
    @api_key = ENV['RESAS_API_KEY']
  end

  def collect_prefectures
    target = 'https://opendata.resas-portal.go.jp/api/v1/prefectures'
    access_api(target)
  end

  def collect_cities(pref_code: nil)
    target = 'https://opendata.resas-portal.go.jp/api/v1/cities'
    unless pref_code.nil?
      target = "#{target}?prefCode=#{pref_code}"
    end
    access_api(target)
  end

  private

  def access_api(target)
    res = open(target, 'X-API-KEY' => api_key) { |io| io.read }
    JSON.parse(res)['result']
  end
end
