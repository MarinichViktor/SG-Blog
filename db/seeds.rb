
def post_container
  [ "Operation Brevity was a limited offensive conducted in mid-May 1941, during
    the Western Desert Campaign of the Second World War. Conceived by the
    commander-in-chief of the British Middle East Command, General Archibald Wavell,
    Brevity was intended to be a rapid blow against weak Axis
    front-line forces in the Sollum–Capuzzo–Bardia area of the border between Egypt and Libya.",
      "Operation Skorpion or Unternehmen Skorpion, from 26–27 May 1941, was a military operation during
    the North African Campaign of World War II, fought between Axis forces under Colonel Maximilian
    von Herff and British forces under Lieutenant-General William  Gott. A counter-attack
    was made on British positions at Halfaya Pass in north-western Egypt, which had been captured
    during Operation Brevity (15–16 May).",
      "Operation Battleaxe was a British Army operation during the Second World War in June 1941,
    to clear eastern Cyrenaica of German and Italian forces and raise the Siege of Tobruk.
    It was the first time during the war that a significant German force fought on the defensive
    but the operation failed as British forces attacked strong defensive positions created by
    German General Erwin Rommel.",
      "Operation Crusader was a military operation by the British Eighth Army between 18 November–30
    December 1941 during the Second World War. The operation relieved the 1941 Siege of Tobruk.
    The Eighth Army's initial plan to destroy the Axis armoured force before advancing its infantry
    came apart when, after a number of inconclusive engagements, the British 7th Armoured Division were
    heavily defeated by the Afrika Korps at Sidi Rezegh.",
    "Operation Torch (initially called Operation Gymnast) was the British-American invasion of French North
    Africa during the North African Campaign of the Second World War which started on 8 November 1942.
    The Soviet Union had pressed the United States and United Kingdom to start operations in Europe
    and open a second front to reduce the pressure of German forces on the Soviet troops."]
end

def post_titles
  [
    "Brevity","Skorpion", "Battleaxe","Crusader","Torch"
  ]
end
User.delete_all
Post.delete_all
16.times do |n|
  x=rand(4)+1
    User.new(name: "User#{n}",email: "user#{n}@ukr.net",password: "aaaaaa",password_confirmation: "aaaaaa", profile_img: Rails.root.join("public/user-images/#{x}.jpg").open ).save
    user = User.find_by(email: "user#{n}@ukr.net")
    user.posts.create(title: post_titles[x-1]+"ww2",body: post_container[x-1], image: Rails.root.join("public/post-images/#{x}.jpg").open)
end
  Post.all.each do |post|
    User.all.each do |user|
      comment = post.comments.create(text:"Hello from #{user.name}",user_id: user.id)
    end
  end
