require './resas_api'
require 'yaml'

module PrefectureYaml
  def self.generate(data, file_name)
    YAML.dump(data, File.open(file_name, 'w'))
  end
end
