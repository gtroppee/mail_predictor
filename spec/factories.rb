FactoryGirl.define do

  factory :email do
    first_name "John"
    last_name  "Doe"
    domain_name "alphasights.com"
  end

  factory :registered_email, class: Email do
    first_name "John"
    last_name  "Ferguson"
    domain_name "alphasights.com"
  end

end
