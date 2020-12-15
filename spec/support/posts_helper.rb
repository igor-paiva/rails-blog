module PostHelper
  def relation_to_hash_array(posts_array)
    result = []

    posts_array.each do |post|
      result << {
        'id' => post.id, 'title' => post.title,
        'content' => post.content, 'user_id' => post.user_id,
        'created_at' => post.created_at, 'updated_at' => post.updated_at
      }
    end

    result
  end
end
