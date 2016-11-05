require 'test_helper'
class CommentTest < ActiveSupport::TestCase
  fixtures :users, :posts

  def setup
    @user= users(:user1)
    @post= posts(:one)
  end

  def test_comment_belongs_to_user_and_post
    comment = Comment.new(text: "hello",post_id: @post.id, user_id: @user.id)
    assert comment.save
  end

  def test_comment_doesnt_exist_without_user_or_post
    comment = Comment.new(text: "hello")
    assert_not comment.save
    comment = Comment.new(text: "hello",post_id: @post.id)
    assert_not comment.save
    comment = Comment.new(text: "hello", user_id: @user.id)
    assert_not comment.save
  end

  def test_comment_must_be_longer_than_1_character
      assert_difference( 'Comment.count', 0 ){ Comment.create(text: "a",post_id: @post.id, user_id: @user.id)}
  end

  def test_comment_cant_be_url
      assert_difference( 'Comment.count', 0 ){ Comment.create(text: "https://google.com",post_id: @post.id, user_id: @user.id)}
  end

  def test_comment_cant_be_First_post!
      assert_difference( 'Comment.count', 0 ){ Comment.create(text: "First post!",post_id: @post.id, user_id: @user.id)}
  end


end
