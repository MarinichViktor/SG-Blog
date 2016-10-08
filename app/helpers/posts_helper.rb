module PostsHelper

  def body_article(body, length=100)
    return "#{body[0..length]}..." if /\s/=~body[length+1]
    return body_article(body,length+1) unless body[length+1].nil?
    "#{body[0..100]}..."
  end

end
