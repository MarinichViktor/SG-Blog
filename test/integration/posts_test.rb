require "test_helper"

class PostsTest < ActiveSupport::TestCase

  def setup
    create_posts
    @post=Post.first
    visit("/posts/#{@post.id}")
  end

  def test_home_page_with_with_five_posts
      visit("/")
      assert page.has_selector?("div.post-intro", :count=> 5)
  end

  def test_click_new_post_and_see_form_for_new_post
      click_on("New Post")
      assert page.has_selector?("form.new_post")
  end

  def test_creating_new_post
    click_on("New Post")
    assert_difference  "Post.all.count", 1 do
      page.fill_in "post_name", :with => "a"*10
      page.fill_in "post_val", :with => "a"*200
      page.find('input[id="post_send"]').click
    end
  end

  def test_post_show_page
    assert page.has_content? (@post.title)
    assert page.has_content? (@post.body)
  end

  def test_updating_new_post
    click_on("Edit")
    page.fill_in "post_name", :with => "b"*10
    page.find('input[id="post_send"]').click
    assert Post.first.title!= @post.title
    assert_equal  Post.first.id, @post.id
  end

  def test_deleting_post
    assert_difference  "Post.all.count", -1 do
      click_on("Delete")
    end
  end
  def test_deleting_post_with_all_dependences
    ["aa","bb","cc"].each {|t| Post.first.comments.create(text: t)}
    assert_difference  "Comment.all.count", -3 do
      click_on("Delete")
    end
  end

  def create_posts
    10.times do |x|
      Post.create(title: "a#{x}"*5, body: "U#{x}"*100)
    end
  end
end
