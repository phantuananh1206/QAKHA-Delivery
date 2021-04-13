User.create!(name: "Admin",
  email: "admin@gmail.com",
  password: "Test123@",
  phone_number: "0123456789",
  role: 0
)

User.create!(name: "TuanAnh",
  email: "phantuananhltt@gmail.com",
  password: "Test123@",
  phone_number: "0396355253",
  role: 0
)

#Users
30.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n+1}@gmail.com",
    password: "Test123@",
    phone_number: Faker::Number.leading_zero_number(digits: 10)
  )
end


#Address
30.times do
  Address.create!(
    name: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user_id: User.pluck(:id).sample
  )
end

#Type
types = ["VEGE", "RICE BOX", "STREETFOOD"]
types.each do |type|
  Type.create!(name: type)
end

#Cities
names = ["Da Nang", "Ho Chi Minh", "Ha Noi"]
names.each do |name|
  City.create!(name: name)
end

#Partners
30.times do |n|
  Partner.create!(
    name: Faker::Name.name,
    email: "partner#{n+1}@gmail.com",
    password: "Test123@",
    address: Faker::Address.full_address,
    phone_number: Faker::Number.leading_zero_number(digits: 10),
    time_open: Time.zone.now,
    time_close: Faker::Time.forward(days: 15),
    status: 0,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    city_id: City.pluck(:id).sample,
    type_id: Type.pluck(:id).sample
  )
end

Partner.create!(
  name: Faker::Name.name,
  email: "partner50@gmail.com",
  password: "Test123@",
  address: "58 Dung Si Thanh Khe, Da Nang",
  phone_number: Faker::Number.leading_zero_number(digits: 10),
  time_open: Time.zone.now,
  time_close: Faker::Time.forward(days: 15),
  status: 0,
  latitude: 16.0746,
  longitude: 108.176,
  city_id: City.pluck(:id).sample,
  type_id: Type.pluck(:id).sample
)

# Categories
foods=["Korean","Japanese","Chinese","Vietnam","French"]
foods.each do |food|
  Category.create!(
    name: food,
    parent_id: Category.pluck(:id).sample,
    partner_id: Partner.pluck(:id).sample
  )
end

#Products
categories=Category.where(parent_id: nil)
subCategories= Category.all-categories
30.times do |n|
  Product.create!(
    category_id: subCategories.pluck(:id).sample,
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Number.decimal(l_digits: 2),
    quantity_sold: Faker::Number.non_zero_digit
  )
end

#Vouchers
5.times do |n|
  Voucher.create!(
    code: "Voucher#{n+1}",
    discount: Faker::Number.decimal(l_digits: 1, r_digits: 2),
    condition: Faker::Number.decimal(l_digits: 2),
    expiry_date: Faker::Time.forward(days: 5),
    usage_limit: Faker::Number.non_zero_digit,
    partner_id: Partner.pluck(:id).sample
  )
end

Driver.create!(
  name: Faker::Name.name,
  email: "driver1@gmail.com",
  password: "Test123@",
  address: Faker::Address.full_address,
  phone_number: Faker::Number.leading_zero_number(digits: 10),
  id_card: Faker::Number.number(digits: 10),
  license_plate: Faker::Code.asin,
  status: 2,
  latitude: 16.0721,
  longitude: 108.207
)

Driver.create!(
  name: Faker::Name.name,
  email: "driver2@gmail.com",
  password: "Test123@",
  address: Faker::Address.full_address,
  phone_number: Faker::Number.leading_zero_number(digits: 10),
  id_card: Faker::Number.number(digits: 10),
  license_plate: Faker::Code.asin,
  status: 2,
  latitude: 16.072,
  longitude: 108.174
)
