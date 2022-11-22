FactoryBot.define do
  factory :gist do
    user_id { 1 }
    question_id { 1 }
    gist_url { "MyString" }
    string { "MyString" }
  end
end
