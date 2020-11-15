json.array! @followeds do |followed|
  json.extract! followed, 'user_id', 'name', 'email'
end
