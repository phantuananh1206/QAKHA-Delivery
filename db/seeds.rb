User.create!(name: "Admin",
  email: "admin@gmail.com",
  password: "Test123@",
  phone_number: "0123456789",
  address: "Phan Thanh Thanh Khe Da Nang",
  role: 0
)

User.create!(name: "TuanAnh",
  email: "phantuananhltt@gmail.com",
  password: "Test123@",
  phone_number: "0396355253",
  address: "Dung si thanh khe Da Nang",
  role: 0
)

#Users
30.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n+1}@gmail.com",
    password: "Test123@",
    address: Faker::Address.full_address,
    phone_number: Faker::Number.leading_zero_number(digits: 10)
  )
end

#Categories
Category.create!(name: "Foods")
Category.create!(name: "Drinks")
foods=["Korean","Japanese","Chinese","Vietnam","French"]
foods.each do |food|
  Category.create!(
    name: food,
    parent_id: Category.pluck(:id).sample
  )
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
    city_id: City.pluck(:id).sample
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
    quantity_sold: Faker::Number.non_zero_digit,
    partner_id: Partner.pluck(:id).sample
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
