require './user_service'


create_user 1 do |result|
  result.success   { puts "responding with 200" }
  result.not_found { puts "responding with 404" }
  result.missing_data { puts "responding with 400" }
end
