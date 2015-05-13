FactoryGirl.define do

  factory :movie do
    title {Faker::Lorem.word}
    country "USA"
    short_descrip {Faker::Lorem.sentence(1)}
    long_descrip {Faker::Lorem.sentence(3)}
    collection_price "9.99"
    image {Faker::Lorem.word}
  end

end

