json.rooms @rooms do |room|
  json.id room.id
  json.name room.name
  json.user_first room.user.first_name
  json.user_last room.user.last_name
  json.salt Hashids.new('lol', 8).encode(room.id)
  json.rickroll room.rickroll
end
