namespace :mp do

  desc "initialize/reset the projet"
  task  setup: :environment do
    Rake.application['ar:drop:all'].invoke
    Rake.application['ar:create:all'].invoke
    Rake.application['ar:migrate'].invoke
    Rake.application['db:seed'].invoke
  end
end
