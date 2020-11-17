json.array! @followeds do |followed|
  json.extract! followed, 'id', 'name', 'email'
end
