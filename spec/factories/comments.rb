FactoryBot.define do
  factory :comment do
    content "My rude comment should be deleted"
    user nil
    post nil
  end
end
