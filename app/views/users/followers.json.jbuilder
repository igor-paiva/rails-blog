json.array! @followers do |follower|
  json.extract! follower, 'user_id', 'name', 'email'
end
