require 'aws-sdk'

Aws.config.update({
  region: "us-west-3",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

table_name = "Movies"

params = {
  table_name: table_name,
  projection_expression: "#yr, title, info.genres, info.actors[0]",
  key_condition_expression: "#yr = :yyyy and title between :letter1 and :letter2",
  expression_attribute_names: {
    "#yr" => "year"
  },
  expression_attribute_values: {
    ":yyyy" => 1992,
    ":letter1" => "A",
    ":letter2" => "L"
  }
}

puts "Querying for movies from 1992 - titles A-L, with genres and lead actor"

begin
  result = dynamodb.query(params)
  puts "Query successful\n"

  result.items.each do |movie|
    print "#{movie["year"].to_i}: #{movie["title"]} ... "

    movie["info"]["genres"].each { |gen| print gen + " " }

    print " ... #{movie["info"]["actors"][0]}\n"
  end
rescue Aws::DynamoDB::Errors::ServiceError => error
  puts "Unable to query table"
  puts "#{error.message}"
end
