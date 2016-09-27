require "test_helper"

class NewDefTest < ActiveSupport::TestCase
  def setup
  end

  def test_button_to_new_page
      visit '/'
      page.click_button("New Post")
      assert page.has_content?("New Post Page")
  end

  def test_create_new_post_and_visit_created_page_with_valid_values
      click_on_create_with_params(params[:validtitle], params[:validbody])
      assert page.has_content?("Show post page")
  end

  def test_create_new_post_with_invalid_values_and_see_same_page_with_error
      click_on_create_with_params(params[:invalidtitle], params[:invalidbody])
      assert page.has_content?("Something goes wrong:")
  end

  def test_create_new_post_with_invalid_values_and_see_error_message
      click_on_create_with_params(params[:invalidtitle], params[:invalidbody])
      assert page.has_content?("Title is invalid")
  end

  def params
      { :validtitle => "Valid val",
        :validbody => "Valid title with alot letters here",
        :invalidtitle => "Name10",
        :invalidbody => "Notvalid"
      }
  end

  def click_on_create_with_params(val1, val2)
      visit '/posts/new'
      page.fill_in "post_name", :with => val1
      page.fill_in "post_val", :with => val2
      page.find('input[id="post_send"]').click
  end
end
