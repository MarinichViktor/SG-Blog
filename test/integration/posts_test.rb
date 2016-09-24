require "test_helper"

class PostsTest < ActiveSupport::TestCase

  def setup
    create_two_posts
    visit("/posts/1")
  end

  def test_each_post_show_page
      assert_equal 2, page.all("li.blog").count
  end

  def test_posts_page_has_only_her_own_title
      assert page.has_content?(posts[:one][:title])
  end

  def test_posts_page_hasnot_title_from_another_post
       assert page.has_no_content?(posts[:two][:title])
  end

  def test_posts_page_has_only_her_own_body
       assert page.has_content?(posts[:one][:body])
  end

  def test_posts_page_hasnot_body_from_another_post
       assert page.has_no_content?(posts[:two][:body])
  end

  def test_button_to_main_page
    page.click_button("  Main page  ")
    assert page.has_content?("SG Blog")
  end

  def create_two_posts
    Post.create(posts[:one])
    Post.create(posts[:two])
  end

  def posts
    {:one => {title: "Ubuntu MATE",
    body: "Ubuntu MATE is a free and open-source Linux distribution and an official derivative
    of Ubuntu. Its main differentiation from Ubuntu is that it uses the MATE desktop
    environment as its default user interface, based on GNOME 2 which was used for Ubuntu
    versions prior to 11.04, instead of the Unity graphical shell that is the default user
    interface for the Ubuntu desktop.",
    id: 1 },
    :two => {title: "Windows OS",
    body: "Microsoft Windows (or simply Windows) is a metafamily of graphical operating
    systems developed, marketed, and sold by Microsoft. It consists of several families
    of operating systems, each of which cater to a certain sector of the computing industry
    with the OS typically associated with IBM PC compatible architecture. ",
    id: 2 }}
  end
end
