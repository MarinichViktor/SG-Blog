require "test_helper"

class NewPostTest < ActiveSupport::TestCase
  def setup
  end

  def test_link_to_new_page
      visit '/'
      page.click_link("New Post")
      click_on_create_with_params(params[:validtitle], params[:validbody])
      assert page.has_content?(params[:validtitle])
  end


  def test_create_new_post_with_invalid_values_and_see_error_message
      visit '/'
      page.click_link("New Post")
      click_on_create_with_params(params[:invalidtitle], params[:invalidbody])
      assert page.has_content?("Title is too short")
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
