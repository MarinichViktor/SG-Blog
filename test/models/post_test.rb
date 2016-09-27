require "test_helper"

class PostTest < ActiveSupport::TestCase

  def test_title_can_contains_min_five_and_max_ten__characters
    Post.create(title:"Yau",body: "123456789101112131415161718192")
    assert_equal 0, Post.all.count
  end

  def test_body_should_be_longer_than_30_characters
    Post.create(title:"Hello",body: "123456789101112131415161718")
    assert_equal 0, Post.all.count
  end

  def test_creating_title_with_five_characters_and_body_with_30
    Post.create(title:"Hello",body: "123456789101112131415161718192")
    assert_equal 1, Post.all.count
  end

  def test_title_can_contains_only_latin_latters_and_dot_question_or_exclamation_marks
    Post.create(title:"Привет",body: "123456789101112131415161718192")
    assert_equal 0, Post.all.count
  end

end
