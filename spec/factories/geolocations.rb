FactoryBot.define do
  factory :geolocation do
    latitude { FFaker::Geolocation.lat }
    longitude { FFaker::Geolocation.lng }
  end
end
