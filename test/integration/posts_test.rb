require "test_helper"

class PostsTest < ActionDispatch::IntegrationTest
fixtures :users,:posts
include SessionMethods
include Rails.application.routes.url_helpers
  def setup
    create_posts
    @post=Post.first
    @user= users(:user1)
    log_in(@user)
  end

  def test_home_page_with_with_nine_posts
    visit("/")
    assert page.has_selector?("div.thumbnail", count: 9)
  end

  def test_creating_new_post
    visit new_post_path
    assert_difference  "Post.all.count", 1 do
      page.fill_in "post_name", :with => "a"*10
      page.fill_in "post_val", :with => "a"*200
      page.find('input[id="post_send"]').click
    end
  end

  def test_post_show_page
    visit post_path(@post)
    assert page.has_content? (@post.title)
    assert page.has_content? (@post.body)
  end

  def test_edit_post
    visit edit_post_path(Post.last)
    page.fill_in "post_name", :with => "b"*10
    page.find('input[id="post_send"]').click
    assert Post.last.title!= @post.title
    assert_equal  Post.first.id, @post.id
  end

  def test_deleting_post
    @user.posts.create(title: "a"*10, body:"a"*200)
    visit post_path(@user.posts.last)
    assert_difference  "Post.all.count", -1 do
      click_on("Delete")
    end
  end


  def create_posts
    cities = ["odessa ukraine","kyiv ukraine","lviv ukraine","minsk belorussia","moscow russia","omsk russia","berlin german","london uk",'sidney',"warsaw","tbilisi georgia","madrid spain"]
    10.times do |x|
      User.new(name: "User#{x}",email: "user#{x}@ukr.net",city: "london",password: "aaaaaa",password_confirmation: "aaaaaa" ).save
      user= User.last
      user.posts.create(title: "a#{x}"*5, body: "U#{x}"*100)
    end
  end
end
