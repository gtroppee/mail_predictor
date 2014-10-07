def setup_environment
  %w(
    john.ferguson@alphasights.com
    damon.aw@alphasights.com
    linda.li@alphasights.com
    larry.p@google.com
    s.brin@google.com
    s.j@apple.com
  ).each do |email_string| Email.create_from_string email_string end   
end
