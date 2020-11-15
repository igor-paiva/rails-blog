# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  joao = User.find_by(
    name: 'Joao',
    email: 'joao@mail.com'
  )

  paulo = User.find_by(
    name: 'Paulo',
    email: 'paulo@mail.com'
  )

  pedro = User.find_by(
    name: 'Pedro',
    email: 'pedro@mail.com'
  )

  marcos = User.find_by(
    name: 'Marcos',
    email: 'marcos@mail.com'
  )

  joao = joao || User.create!(
    name: 'Joao', email: 'joao@mail.com',
    password: 'joao123', password_confirmation: 'joao123'
  )

  paulo = paulo || User.create!(
    name: 'Paulo', email: 'paulo@mail.com',
    password: 'paulo123', password_confirmation: 'paulo123'
  )

  pedro = pedro || User.create!(
    name: 'Pedro', email: 'pedro@mail.com',
    password: 'pedro123', password_confirmation: 'pedro123'
  )

  marcos = marcos || User.create!(
    name: 'Marcos', email: 'marcos@mail.com',
    password: 'marcos123', password_confirmation: 'marcos123'
  )

  follower1 = Follower.find_or_create_by!(follower_id: joao.id, followed_id: paulo.id)

  follower2 = Follower.find_or_create_by!(follower_id: joao.id, followed_id: pedro.id)

  follower3 = Follower.find_or_create_by!(follower_id: pedro.id, followed_id: marcos.id)

  follower4 = Follower.find_or_create_by!(follower_id: marcos.id, followed_id: joao.id)

  post1_paulo = Post.find_or_create_by!(
    title: 'post do paulo 1', content: 'post do paulo 1', user_id: paulo.id
  )

  post2_paulo = Post.find_or_create_by!(
    title: 'post do paulo 2', content: 'post do paulo 2', user_id: paulo.id
  )

  post1_pedro = Post.find_or_create_by!(
    title: 'post do pedro 1', content: 'post do pedro 1', user_id: pedro.id
  )

  post2_pedro = Post.find_or_create_by!(
    title: 'post do pedro 2', content: 'post do pedro 2', user_id: pedro.id
  )

  post1_marcos = Post.find_or_create_by!(
    title: 'post do marcos 1', content: 'post do marcos 1', user_id: marcos.id
  )

  post2_marcos = Post.find_or_create_by!(
    title: 'post do marcos 2', content: 'post do marcos 2', user_id: marcos.id
  )
end
