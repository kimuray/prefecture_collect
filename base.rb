require './resas_api'
require './prefecture_yaml'

class Base
  attr_reader :prefectures, :cities

  def initialize
    @prefectures = trancerate_snake_case(ResasApi.new.collect_prefectures)
    @cities = trancerate_snake_case(ResasApi.new.collect_cities)
  end

  def execute
    PrefectureYaml.generate({ 'prefectures' => prefectures }, 'prefectures.yml')
    PrefectureYaml.generate({ 'cities' => cities }, 'cities.yml')
  end

  def trancerate_snake_case(data)
    data.map do |item|
      item.map { |k, v| [k.to_snake, v] }.to_h
    end
  end
end

class String
  def to_snake
    self
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("-", "_")
      .downcase
  end
end

Base.new.execute
