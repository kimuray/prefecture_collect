require 'yaml'

prefecture_yaml = YAML.load_file('prefectures.yml')
city_yaml = YAML.load_file('cities.yml')

file = File.open('output/prefectures.rb', 'w') do |f|
  f.puts("Prefecture.seed(:id,\n")
  prefecture_yaml['prefectures'].each do |prefecture|
    f.puts("  { id: #{prefecture['pref_code']}, name: \"#{prefecture['pref_name']}\" },\n")
  end
  f.puts(")")
end

file = File.open('output/cities.rb', 'w') do |f|
  f.puts("City.seed(:id,\n")
  city_yaml['cities'].each.with_index(1) do |city, index|
    f.puts("  { id: #{index}, name: \"#{city['city_name']}\", prefecture_id: #{city['pref_code']}, city_code: \"#{city['city_code']}\", big_city_flag: #{city['big_city_flag']} },\n")
  end
  f.puts(")")
end
