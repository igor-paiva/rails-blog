module UserHelper
  def relation_to_hash_array(users_array)
    result = []

    users_array.each do |user|
      result << { 'id' => user.id, 'name' => user.name, 'email' => user.email }
    end

    result
  end
end