require "aws-sdk"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

table_name = "Movies"

year = 2015
title = "The Big New Movie"
item = {
  year: year,
  title: title,
  info: {
    plot: "Nothing happens at all",
    rating: 0
  }
}

params = {
  table_name: table_name,
  item: item
}

begin
  dynamodb.put_item(params)
  puts "Added item: #{year} - #{title}"
rescue Aws::DynamoDB::Errors::ServiceError => error
  puts "Unable to add item"
  puts "#{error.message}"
end
