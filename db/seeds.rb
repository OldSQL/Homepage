
# Here is the default roles used in authorization.
['owner', 'admin', 'moderator', 'normal'].each do |role|
  Role.find_or_create_by({name: role})
end