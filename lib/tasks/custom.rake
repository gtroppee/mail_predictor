namespace :mp do

  desc "initialize/reset the projet"
  task  setup: :environment do
    Rake.application['ar:reset'].invoke
  end
end
