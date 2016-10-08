module PostsHelper

  def body_article(body, length=100)
    return "#{body[0..length]}..." if /\s/=~body[length+1]
    body_article(body,length+1)
  end

end
