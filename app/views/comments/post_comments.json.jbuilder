json.array! @comments do |comment|
  json.extract! comment, :id, :content, :user_id, :post_id
end
