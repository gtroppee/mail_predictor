JSON.parse(File.read('data/emails.json')).each do |_, val|

  names       = val.partition('@').first
  first_name  = names.split('.').first
  last_name   = names.split('.').last
  domain_name = val.partition('@').last

  Email.create(
    first_name: first_name,
    last_name: last_name,
    domain_name: domain_name
    )
end