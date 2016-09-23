10.times do |n|
  Post.create(title: "My Blog №#{n}",
   body: "Yours blogs text typed here , please read this",
   id: n)
end
