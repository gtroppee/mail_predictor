desc "initialize/reset the projet"
namespace :mp do
  task  setup: :environment do
    RACK_ENV = 'development' 
    Rake.application['ar:setup'].invoke
    Rake.application['db:seed'].invoke
  end

  task  test_prepare: :environment do
    RACK_ENV = 'test' 
    Rake.application['ar:setup'].invoke
  end
end
