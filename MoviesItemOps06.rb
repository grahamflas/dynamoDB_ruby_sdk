require "aws-sdk"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

table_name = "Movies"

year = 2015
title = "The Big New Movie"

params = {
  table_name: table_name,
  key: {
    year: year,
    title: title
  },
  
  # condition_expression: "info.rating <= :val",
  # expression_attribute_values: {
  #   ":val" => 5
  # }
}

begin
  dynamodb.delete_item(params)
  puts "Deleted item."
rescue Aws::DynamoDB::Errors::ServiceError => error
  puts "Unable to update item:"
  puts "#{error.message}"
end
