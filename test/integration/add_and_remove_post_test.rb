require "test_helper"

class AddAndRemovePostTest < ActiveSupport::TestCase
  def setup
    visit "/posts/new"
    @post=Post.create(title: params[:validtitle],body: params[:validbody])
  end

  def test_creating_new_post_with_uploading_image_and_see_post_with_medium_version_of_this_image
      page.fill_in "post_name", :with => @post.title
      page.fill_in "post_val", :with => @post.body
      attach_file("img",File.absolute_path("./app/assets/images/backround.jpeg"))
      page.find('input[id="post_send"]').click
      assert_equal page.find('.img-rounded')['src'], "/uploads/post/image/2/medium_backround.jpeg"
  end
  def test_creating_new_post_without_image_and_see_post_with_default_image
      click_on_create_with_params(params[:validtitle], params[:validbody])
      assert_equal page.find('.img-rounded')['src'], "/images/fallback/medium_default.png"
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
    visit "/posts/#{@post.id}"
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



end
