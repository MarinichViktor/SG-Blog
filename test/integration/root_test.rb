require "test_helper"

class RootTest < ActiveSupport::TestCase
  def setup
    create_two_posts
    visit "/"
  end

  def test_visit_home_page_and_see_blog_title
    assert page.has_content?("SG Blog")
  end

  def test_visit_home_page_and_see_two_post_titles
    assert_equal 2, page.all("a.post-title").count
  end

  def test_link_from_main_page_to_post_page
       page.click_link("Ubuntu MATE")
       assert page.has_content?("Ubuntu MATE is a free and open-source Linux distribution")
  end

  def create_two_posts
        Post.create(title: "Ubuntu MATE",
       body: "Ubuntu MATE is a free and open-source Linux distribution and an official derivative
        of Ubuntu. Its main differentiation from Ubuntu is that it uses the MATE desktop
        environment as its default user interface, based on GNOME 2 which was used for Ubuntu
        versions prior to 11.04, instead of the Unity graphical shell that is the default user
        interface for the Ubuntu desktop.",
       id: 1 )
      Post.create(title: "Windows OS",
        body: "Microsoft Windows (or simply Windows) is a metafamily of graphical operating
        systems developed, marketed, and sold by Microsoft. It consists of several families
        of operating systems, each of which cater to a certain sector of the computing industry
         with the OS typically associated with IBM PC compatible architecture. ",
        id: 2 )
  end


end
