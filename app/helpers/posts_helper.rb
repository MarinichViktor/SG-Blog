module PostsHelper

  def body_article(body, length=70)
    #return "#{body[0..length]}..." if /\s/=~body[length+1]
    #return body_article(body,length+1) unless body[length+1].nil?
    "#{body[0..70]}..."
  end
  def title_short(title)
    "#{title[0..15]}..."
  end

end
