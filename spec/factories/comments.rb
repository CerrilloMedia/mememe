FactoryBot.define do

  factory :comment do
    content "My rude comment should be deleted at "
    user nil
    post nil
  end
end
