desc "Launch all DB commands"
task  custom_setup: :environment do
  %x(
    padrino rake ar:drop:all &&
    padrino rake ar:create:all &&
    padrino rake ar:migrate &&
    padrino rake seed &&
    rake ar:migrate RACK_ENV=test
    )
end