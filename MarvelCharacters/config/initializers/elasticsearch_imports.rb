puts "Importing models for elasticsearch"
begin
  Character.import
  Comic.import
rescue
  puts "Failed to import models to elasticsearch. Make sure elasticsearch service is up and running!"
end
