JSON.parse(File.read('data/emails.json')).each do |_, val|
  Email.create_from_string(val)
end