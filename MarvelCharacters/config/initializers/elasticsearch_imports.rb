require "json"

puts "Importing models for elasticsearch (assuming it is running on port 9200. Change config/initializers/elasticsearch_imports.rb otherwise!"

begin
    # Clear index
    keys = JSON.parse(`curl http://localhost:9200/_mapping`).keys
    keys.each {|key| `curl -XDELETE http://localhost:9200/#{key}`}

    # Setup elasticsearch
    Character.__elasticsearch__.create_index!
    Comic.__elasticsearch__.create_index!

    # Import models
    Character.import
    Comic.import
rescue
    puts "Failed to import models for elasticsearch! Make sure elasticsearch service is up and running!"
end