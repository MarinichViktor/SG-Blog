require "test_helper"

class AddAndRemovePostTest < ActiveSupport::TestCase
  def setup
      visit "/posts/new"
      create_two_posts
  end

  def test_link_to_new_page_and_creating_new_post
      visit '/'
      click_on("New Post")
      click_on_create_with_params(params[:validtitle], params[:validbody])
      assert page.has_content?(params[:validtitle])
  end

  def test_click_on_create_with_valid_values_and_see_one_more_post
      assert_difference  'Post.count', 1 do
      click_on_create_with_params(params[:validtitle], params[:validbody])
    end
  end

  def test_click_on_create_with_invalid_values_and_see_that_post_wasnt_created
      assert_difference  'Post.count', 0 do
      click_on_create_with_params(params[:invalidtitle], params[:invalidbody])
    end
  end

  def test_creating_new_post_with_invalid_values_and_see_error_message
      click_on_create_with_params(params[:invalidtitle], params[:invalidbody])
      assert page.has_content?("Something goes wrong")
  end
  def test_click_on_delete_button_and_see_that_post_was_deleted
    visit "/posts/1"
      assert_difference  'Post.count', -1 do
      click_on("Delete")
    end
  end

  def params
      { :validtitle => "Valid val",
        :validbody => "Valid"*40,
        :invalidtitle => "Nam",
        :invalidbody => "Notvalid"
      }
  end

  def click_on_create_with_params(val1, val2)
      page.fill_in "post_name", :with => val1
      page.fill_in "post_val", :with => val2
      page.find('input[id="post_send"]').click
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
