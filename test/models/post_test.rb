require "test_helper"

class PostTest < ActiveSupport::TestCase

  def test_title_can_contains_min_five_and_max_ten__characters
    Post.create(title:"Yau",body: "1"*200)
    assert_equal 0, Post.all.count
  end

  def test_body_should_be_longer_or_equilent_to_200_characters
    Post.create(title:"Hello",body: "1"*20)
    assert_equal 0, Post.all.count
  end

  def test_creating_title_with_five_characters_and_body_with_30
    Post.create(title:"Hello",body: "1"*200)
    assert_equal 1, Post.all.count
  end


end
