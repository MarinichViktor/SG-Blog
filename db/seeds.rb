
def post_container
  [ "Operation Overlord, the D-Day landings of June 1944, was the beginning of the end for Hitler
    and his army in Europe. The German forces were under increasing pressure from all sides and the
     great effort by Allied     forces proved decisive. Many hard battles, now etched in the
     collective memory of the nation,  were fought along the route to the German heartland. This
     account is about the amphibious phase of the D-Day landings codenamed Operation Neptune when
    the three services of the Allied nations worked together in the largest Combined Operation in
    history.Immediately after the Japanese attack on Pearl Harbour the Allies created the  (CCS)
    comprising the United States Joint Chiefs of Staff and the British Chiefs of Staff. Their
    function was to assist and advise President Roosevelt and Prime Minister Churchill on the
    direction and conduct of the war. The CCS confirmed a previous policy of  and, from March 1942,
    their planning group began work on an outline plan for a full-scale invasion of Europe. They
    initially hoped to invade Europe in 1943 but the realities of insufficient materials and
    manpower, and the demands of other operations agreed upon, delayed this effort until 1944 -
    this despite persistent agitation from Stalin to open a second front to relieve pressure in
    the East.The CCS planning group, taking into account the experience provided by the ill fated
    Dieppe raid, quickly ruled out a frontal attack on a fortified port and looked for alternative
    landing sites. The requirements for a suitable landing site were for it; to be within range of
    fighter aircraft based in southern England, to have at least one major port within easy reach,
    to have landing beaches suitable for prolonged support operations, with adequate exits and backed
    by a good road network, to have beach defences capable of being suppressed by naval bombardment or
    bombing. The planners decided the Normandy coast between Caen and Cherbourg met these requirements
    and they prepared a basic outline paper which was later approved by the CCS British Lieutenant
    General Sir Frederick Morgan was appointed, in March 1943, as Chief of Staff to the Supreme Allied
    Commander (COSSAC). His assignment was to prepare detailed plans for an invasion of Europe to be
    conducted the following year. Morgan was an excellent choice. In November 1942 he was a task force
    commander in the invasion of North Africa and he had just completed the preliminary planning for the invasion of Sicily which was to take place in July 1943.
    The ultimate goal was the destruction of German forces and the defeat of Germany. Morgan had to work
    backwards from that result to determine what manpower and material forces were required to complete
    the task. There had never been an amphibious invasion of this size and Morgan and his staff had to
    plan the detail of the operation – a monumental task. The eventual invasion plan was given the
    codename .", "Operation Battleaxe was a British Army operation during the Second World War in June 1941,
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
    "Overlord","Skorpion", "Battleaxe","Crusader","Torch"
  ]
end
cities = ["odessa ukraine","kyiv ukraine","lviv ukraine","minsk belorussia","moscow russia","omsk russia","berlin german","london uk",'sidney',"warsaw","tbilisi georgia","madrid spain"]
Comment.delete_all
Post.all.each do |p|
  p.destroy
end
User.all.each do |u|
  u.destroy
end

16.times do |n|
  z=rand(12)
  x=rand(4)+1
    User.new(name: "User#{n}",email: "user#{n}@ukr.net",city: cities[z],password: "aaaaaa",password_confirmation: "aaaaaa", profile_img: Rails.root.join("public/user-images/#{x}.jpg").open ).save
    user = User.find_by(email: "user#{n}@ukr.net")
    user.posts.create(title: post_titles[x-1]+"ww2",body: post_container[x-1], image: Rails.root.join("public/post-images/#{x}.jpg").open)
end
  Post.all.each do |post|
    User.all.each do |user|
      comment = post.comments.create(text:"Hello from #{user.name}",user_id: user.id)
    end
  end
