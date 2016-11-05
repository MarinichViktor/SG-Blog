require 'test_helper'
class PostTest < ActiveSupport::TestCase
  fixtures :users, :posts

  def setup
    @user= users(:user1)
    @post= posts(:one)
  end

  def test_post_must_have_owner
    post = Post.new(title: @post.title,body: @post.body)
    assert_not post.save
  end

  def test_create_post_with_user_id_that_doesn_exist
    post = Post.new(title: @post.title,body: @post.body, user_id: 10000)
    assert_not post.save
    post = Post.new(title: @post.title,body: @post.body, user_id: @user.id)
    assert post.save
  end

  def test_create_post_with_valid_user_id
    post = Post.new(title: @post.title,body: @post.body, user_id: @user.id)
    assert post.save
  end

  def test_user_with_invalid_title
    ["","low","too long"*5].each do |v|
      assert_difference( 'Post.count', 0 ){ Post.create(title: v,body: @post.body, user_id: @user.id)}
    end
  end

  def test_user_with_invalid_body
    ["","too short"].each do |v|
      assert_difference('Post.count', 0 ){Post.create(title: @post.title,body: v,user_id: @user.id)}
    end
  end

end
