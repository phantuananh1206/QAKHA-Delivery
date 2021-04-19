1.times do
  u = User.create!(name: "Admin",
    email: "phantuananh1206@gmail.com",
    password: "Test123@",
    phone_number: "0905109870",
    coins: 500000,
    role: 0
  )
  u.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618750460/qakha-driver_srmxd2.png")
end

1.times do
  u = User.create!(name: "TuanAnh",
    email: "phantuananhltt@gmail.com",
    password: "Test123@",
    phone_number: "0396355253",
    coins: 500000,
    role: 0
  )
  u.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618750460/qakha-driver_srmxd2.png")
end

#Users
10.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n+1}@gmail.com",
    password: "Test123@",
    phone_number: Faker::Number.leading_zero_number(digits: 10),
    coins: 1000000
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

# Driver

Driver.create!(
  name: Faker::Name.name,
  email: "driver1@gmail.com",
  password: "Test123@",
  address: Faker::Address.full_address,
  phone_number: Faker::Number.leading_zero_number(digits: 10),
  id_card: Faker::Number.number(digits: 10),
  license_plate: Faker::Code.asin,
  status: 2,
  coins: 100000,
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
  coins: 100000,
  latitude: 16.072,
  longitude: 108.174
)

#Type
types = ["VEGE", "RICE BOX", "STREETFOOD", "SUSHI", "DRINK"]
types.each do |type|
  Type.create!(name: type)
end

#Cities
names = ["Đà Nẵng", "Hồ Chí Minh", "Hà Nội"]
names.each do |name|
  City.create!(name: name)
end


#Partner 1
1.times do |n|
  p = Partner.new(
    name: "Cơm Gà Lương Tâm",
    email: "comgaluongtam70@gmail.com",
    password: "Luongtam123@",
    address: "Hoàng Minh Thảo, Quận Liên Chiểu, Đà Nẵng",
    phone_number: "0905078969",
    time_open: Time.at(28800.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(72000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.15959213218079,
    latitude: 16.052495079839225,
    city_id: 1,
    type_id: 2
  )
  p.save!
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618068130/image-9dcb6e3f-200910115811_qxymjb.jpg")
end

Category.create!(
  name: "CƠM",
  parent_id: 0,
  partner_id: 1
)

Category.create!(
  name: "NƯỚC UỐNG",
  parent_id: 0,
  partner_id: 1
)

#Products of Cơm gà Lương Tâm
1.times do |n|
  p = Product.create!(
    category_id: 1,
    name: "CƠM GÀ XÉ",
    description: "Gà ta luộc xé thơm ngon. Kèm dưa cà muối.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160194/Partner1/gaxe_zikn1u.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 1,
    name: "CƠM ĐÙI GÀ XỐI MỠ",
    description: "Gà ta xối mỡ giòn tan, thơm ngon. Kèm dưa rau.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160724/Partner1/duiga_nagbfo.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 1,
    name: "CƠM SƯỜN + TRỨNG ỐP LA",
    description: "Sườn non nướng, trứng ốp la nóng. Kèm rau quả tạo nên buổi cơm thật ngon miệng.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618161305/Partner1/suon_d7lqqf.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 1,
    name: "CƠM THỊT XÍU MẠI",
    description: "Cơm nóng cùng với thịt heo 3 chỉ xíu mềm, thơm. Ăn kèm rau quả cho thêm phần hấp dẫn.",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160146/Partner1/thitxaxiu_fbbd7b.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 1,
    name: "CƠM THÊM",
    description: "Cơm nóng cùng với thịt heo 3 chỉ xíu mềm, thơm. Ăn kèm rau quả cho thêm phần hấp dẫn.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160182/Partner1/comthem_sjcygg.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 2,
    name: "NƯỚC NGỌT COCA",
    description: "Thêm hương vị giải khác coca cho bữa cơm thêm đậm đà và hấp dẫn.",
    price: 15000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618161677/Partner1/cocaa_a3hgzm.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 2,
    name: "NƯỚC CAM ÉP",
    description: "Nạp thêm một chút vitamin C cho cơ thể được tươi mát nha.",
    price: 15000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618161820/Partner1/camep_l8duoc.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 2,
    name: "NƯỚC MÍA",
    description: "Mía tự nhiên nguyên chất, thơm ngon, bổ dưỡng. Nên dùng kèm với cơm để tăng thêm độ ngon của bữa cơm.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618161686/Partner1/mia_sny1tr.jpg")
end

# Partner 2----------------------------------------------------

1.times do |n|
  p = Partner.create!(
    name: "Cơm Tấm 1989",
    email: "comtam1989@gmail.com",
    password: "Comtam1898@",
    address: "345 Cách Mạng Tháng 8, Quận Cẩm Lệ, Đà Nẵng",
    phone_number: "0905078956",
    time_open: Time.at(32400.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(72000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.20247949655412,
    latitude: 16.016186161478572,
    city_id: 1,
    type_id: 2
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069914/comtaam_uppkse.jpg")
end

# Category of Cơm 1989
Category.create!(
  name: "CƠM 1989",
  parent_id: 0,
  partner_id: 2
)

Category.create!(
  name: "MÓN THÊM",
  parent_id: 0,
  partner_id: 2
)
Category.create!(
  name: "COMBO",
  parent_id: 0,
  partner_id: 2
)
Category.create!(
  name: "ĐỒ UỐNG",
  parent_id: 0,
  partner_id: 2
)

# Product of Cơm 1989
1.times do |n|
  p = Product.create!(
    category_id: 3,
    name: "Cơm sườn nướng",
    description: "1 lát sườn + 1 ốp la (hoặc 1 tàu hủ nhồi thịt, ram chả, cà tím, chả cá, tôm rim trứng cút) + món xào + xà lách lồng, dưa leo + canh.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618164422/Partner2/com1989_lnrvef.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 3,
    name: "Cơm cá kho tộ",
    description: "1 phần cá kho tộ+1 ốp la ( hoặc 1 tàu hủ nhồi thịt, ram chả,cà tím, chả cá , tôm rim trứng cút),món xào,xà lách lồng,dưa leo,canh",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618164422/Partner2/com1989_lnrvef.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 3,
    name: "Cơm gà xé",
    description: "Sử dụng nước luộc gà để nấu cơm siêu ngon, gà thả vườn thịt dai ngọt , bóp trộn cùng rau răm hành tây",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618164764/Partner2/gaxe_zhhpvd.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 3,
    name: "Cơm thịt xíu",
    description: "Thịt ba chỉ xíu giòn + ốp la + rau xào + canh.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618164927/Partner2/xaxiu_hk5xpr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 3,
    name: "Cơm đùi gà quay",
    description: "Đùi gà chiên + opla( hoặc tàu hủ nhồi thịt, ram chả, cà tím v.v) + món xào + canh.",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618165149/Partner2/gatrung_mmbbec.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 3,
    name: "Cơm thịt heo kho tàu",
    description: "Thịt heo kho trứng kèm( tàu hủ nhồi thịt, ram chả, cà tím v.v) + món xào + canh.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160146/Partner1/thitkho_mm0cyq.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Cơm thêm",
    description: "1 Chén cơm thêm.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160182/Partner1/comthem_sjcygg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Thịt heo kho trứng thêm",
    description: "1 Chén thịt.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160146/Partner1/thitkho_mm0cyq.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Canh khổ qua nhồi thịt",
    description: "1 tô canh ổ qua gồm 3 cục thơm ngon.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618165670/Partner2/khoqua_kqupvd.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Đậu khuôn nhồi thịt",
    description: "Đậu khuôn nhồi thịt thơm ngon, hấp dẫn, đậm đà.",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618165671/Partner2/daukhuon_z5azec.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Sườn nướng thêm",
    description: "Sườn non nướng gia vị thấm đậm đà, thơm ngon.",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618164404/Partner2/suonthem_j0fdni.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Cà tím",
    description: "Cà tím chiên dầm mắm tỏi.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618165706/Partner2/catim_lv19gc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 4,
    name: "Cá kho tộ thêm",
    description: "1 cá kho tộ (tùy cá mỗi ngày).",
    price: 12000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618164300/Partner2/ca1989_jsglqw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 5,
    name: "Combo 2 người",
    description: "Gồm 2 suất cơm (Sườn nướng + trứng ốp la) và (Cá kho tộ + cà tím). Thêm rau xào, canh,.v.v.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166334/Partner2/combo_maofow.gif")
end

1.times do |n|
  p = Product.create!(
    category_id: 5,
    name: "Combo đặc biệt",
    description: "Gồm 3 suất cơm (Sườn nướng + trứng ốp la) và (Cá kho tộ + cà tím) + gà xé bóp hành tây (Canh khổ qua nhồi thịt). Thêm rau xào, canh,.v.v.",
    price: 99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166334/Partner2/combo_maofow.gif")
end
1.times do |n|
  p = Product.create!(
    category_id: 6,
    name: "Trà bí đao hạt chia nhà làm",
    description: "Trà bí đao hạt chia nhà làm thơm ngon bổ dưỡng có lợi cho sức khoẻ.",
    price: 9000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166529/Partner2/trabidao_imnesv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 6,
    name: "Nước chanh dây",
    description: "Nước chanh dây nhà làm thơm ngon bổ dưỡng có lợi cho sức khoẻ.",
    price: 9000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166528/Partner2/chanhday_gk2j84.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 6,
    name: "Nước nha đam hạt chia",
    description: "Nước nha đam hạt chia nhà làm thơm ngon bổ dưỡng có lợi cho sức khoẻ.",
    price: 9000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166528/Partner2/chanhday_gk2j84.jpg")
end

# Partner 3---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Cơm Chiên 73 - Đệ Nhất Cơm Thố",
    email: "comchien73@gmail.com",
    password: "Comchien73@",
    address: "106 Lý Thái Tông, Quận Thanh Khê, Đà Nẵng",
    phone_number: "0905073456",
    time_open: Time.at(32400.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(72000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.1746160830595,
    latitude: 16.07386215224076,
    city_id: 1,
    type_id: 2
  )
  p.save_image!( "https://res.cloudinary.com/qakhadelivery/image/upload/v1618069913/comtho_x6pqd8.jpg")
end

Category.create!(
  name: "THỰC ĐƠN CƠM",
  parent_id: 0,
  partner_id: 3
)

Category.create!(
  name: "COMBO",
  parent_id: 0,
  partner_id: 3
)

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm ba chỉ giòn giòn",
    description: "Thịt ba chỉ quay giòn da, đậm đà thấm vị.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232818/Partner%203/heogionda_mxu6hv.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm thố xá xíu",
    description: "Thịt heo xá xíu, đậm đà thấm vị.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160159/Partner1/bokho_zeyvjd.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm thố gà xé",
    description: "Thịt gà thả vừa luộc xé bóp hành tây, rau răm đậm đà thơm ngon.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232485/Partner%203/thoga_fvrekj.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm thố bò",
    description: "Thịt bò được hầm mềm vớ rau củ đậm đà thơm ngon.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232483/Partner%203/thobo_jlpktz.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm thố gà quay",
    description: "Thịt gà thả vườn quay giòn, đậm đà thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232484/Partner%203/thogaquay_dsxi9s.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm thố sườn",
    description: "Thịt sườn kho mềm, đậm đà thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232486/Partner%203/thoheo_nn8wkt.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm Thố xíu Mại Vip",
    description: "Thịt heo xíu mại + trứng ốp la.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232617/Partner%203/xiumai_jsrvmw.jpg")
end


1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm thêm",
    description: "1 chén cơm thêm.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160182/Partner1/comthem_sjcygg.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Cơm chiên dương châu (nhỏ)",
    description: "Cơm chiên dương châu dĩa nhỏ.",
    price: 15000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160158/Partner1/chienduongchau_yaf3dq.jpg")
end


1.times do |n|
  p = Product.create!(
    category_id: 7,
    name: "Ba chỉ thêm",
    description: "1 chén ba chỉ thêm.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618233438/Partner%203/heobachi_hlee3a.jpg")
end


1.times do |n|
  p = Product.create!(
    category_id: 8,
    name: "Combo 1 (4 người)",
    description: "2 Cơm thố gà quay, 1 Cơm ba chỉ giòn giòn, 1 Cơm thố bò.",
    price: 95000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232616/Partner%203/combo1_e8swdr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 8,
    name: "Combo 3 (6 người)",
    description: "2 Cơm thố gà quay, 2 Cơm thố bò, 2 Cơm thố xá xíu.",
    price: 140000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618232614/Partner%203/combo2_g5bwrq.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 8,
    name: "Combo 2 (5 người)",
    description: "2 Cơm ba chỉ giòn giòn, 2 Cơm thố bò, 1 Cơm thố gà xé.",
    price: 125000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618233690/Partner%203/combo3_svqxlw.jpg")
end


# Partner 4---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Tiệm Cơm Bếp Nhà Quê",
    email: "bepque29@gmail.com",
    password: "Bepque29@",
    address: "17 Đường 2 Tháng 9, Quận Hải Châu, Đà Nẵng",
    phone_number: "0905077756",
    time_open: Time.at(32400.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(72000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.22434723888446,
    latitude: 16.030272763797754,
    city_id: 1,
    type_id: 2
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618068248/nagn4hdclvjfnbrmvxzf.jpg")
end

Category.create!(
  name: "CƠM BẾP NHÀ QUÊ",
  parent_id: 0,
  partner_id: 4
)
Category.create!(
  name: "ĐỒ UỐNG",
  parent_id: 0,
  partner_id: 4
)
Category.create!(
  name: "ĐỒ ĂN THÊM",
  parent_id: 0,
  partner_id: 4
)
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm sườn nướng sa tế",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618234543/Partner%203/suonvp_ngesdc.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm ba chỉ giòn da mắm nước",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618234517/Partner%203/bachi_bviimt.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm ba chỉ rim lá chanh",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618234801/Partner%203/ba-chi-chien-la-chanh_zi7kdf.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm cá chiên mắm xoài",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618234805/Partner%203/camamxoai_ls9i3w.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm ếch xào sả ớt",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618234807/Partner%203/ech_sdg9dp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm gà kho sả ớt",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618234808/Partner%203/gakho_y3dqo4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm thịt heo kho măng",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235097/Partner%203/heomang_bqrbun.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm cá sốt cà",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235300/Partner%203/ca_sykzr7.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm thịt heo luộc",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235301/Partner%203/heoluoc_fyo5gp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm mực chiên mắm tỏi ớt",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235301/Partner%203/muc_txlqt1.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm đậu khuôn độn thịt sốt cà chua",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618165671/Partner2/daukhuon_z5azec.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm cá kho xì dầu",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235304/Partner%203/cakho_hs9yzv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 9,
    name: "Cơm sườn non rim mặn ngọt",
    description: "Món ăn phụ thay đổi hằng ngày.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235589/Partner%203/suon_jyh8g5.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 10,
    name: "Nước chanh",
    description: "Mát lạnh cho bữa trưa ngon miệng.",
    price: 15000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235954/Partner%203/nuocchanh_v3cy2l.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 10,
    name: "Nước Cocacola",
    description: "Mát lạnh cho bữa trưa ngon miệng.",
    price: 12000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235915/Partner%203/cocaa_k4ppye.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 10,
    name: "Nước Sprite",
    description: "Mát lạnh cho bữa trưa ngon miệng.",
    price: 12000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618235917/Partner%203/sprite_poju9r.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 11,
    name: "Trứng ốp la",
    description: "Thêm trứng thêm vị thêm ngon cơm hơn.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618236180/Partner%203/opla_ky4h9k.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 11,
    name: "Đậu khuôn nhồi thịt",
    description: "Thêm món, thêm vị, thêm ngon cơm hơn.",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618165671/Partner2/daukhuon_z5azec.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 11,
    name: "Ba chỉ giòn da",
    description: "Thêm món, thêm vị, thêm ngon cơm hơn.",
    price: 15000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618233438/Partner%203/heobachi_hlee3a.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 11,
    name: "Cơm thêm",
    description: "Thêm cơm để no bụng hơn nè.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618160182/Partner1/comthem_sjcygg.jpg")
end

# Partner 5 ---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Duyên - Cơm Gà Xối Mỡ - Hoàng Diệu",
    email: "duyencomga@gmail.com",
    password: "Duyencomga12@",
    address: "262 Hoàng Diệu, Quận Hải Châu, Đà Nẵng",
    phone_number: "0905077798",
    time_open: Time.at(32400.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(72000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.21691959655463,
    latitude: 16.05960850188361,
    city_id: 1,
    type_id: 2
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618156841/comga_fp4iab.jpg")
end

Category.create!(
  name: "MENU CƠM",
  parent_id: 0,
  partner_id: 5
)
Category.create!(
  name: "COMBO",
  parent_id: 0,
  partner_id: 5
)

1.times do |n|
  p = Product.create!(
    category_id: 12,
    name: "Cơm gà xối mỡ",
    description: "Ngẫu nhiên đùi hoặc má đùi (Quý khách có thể “ghi chú“ yêu cầu theo ý) ăn kèm canh rong biển. ",
    price: 27000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618156841/comga_fp4iab.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 12,
    name: "Cơm gà xối mỡ - Đùi lớn",
    description: "Đùi lớn hoặc ghép từ đùi + má đùi (đùi lớn cắt đôi) trong trường hợp tại quán HẾT đùi lớn .",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618236819/Partner1/com-ga-xoi-mo_b5ktsx.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 12,
    name: "Cơm thêm",
    description: "1 chén cơm thêm.",
    price: 5000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618236955/Partner1/themcom_ftixly.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 13,
    name: "Combo 1: 5 cơm gà xối mỡ ( 27k) + 2 cơm thêm",
    description: "Gọi combo ăn cùng nhau để tiện lợi và vui vẻ hơn nhé.",
    price: 140000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166334/Partner2/combo_maofow.gif")
end
1.times do |n|
  p = Product.create!(
    category_id: 13,
    name: "Combo 2: 3 Cơm gà xối mỡ - đùi lớn ( 45k ) + 2 cơm thêm",
    description: "Gọi combo ăn cùng nhau để tiện lợi và vui vẻ hơn nhé.",
    price: 140000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166334/Partner2/combo_maofow.gif")
end
1.times do |n|
  p = Product.create!(
    category_id: 13,
    name: "Combo 3: 2 cơm gà xối mỡ ( 27k) + 2 Cơm gà xối mỡ - đùi lớn ( 45k )",
    description: "Gọi combo ăn cùng nhau để tiện lợi và vui vẻ hơn nhé.",
    price: 140000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166334/Partner2/combo_maofow.gif")
end

1.times do |n|
  p = Product.create!(
    category_id: 13,
    name: "Combo: 7 phần Cơm Gà Xối Mỡ",
    description: "Gọi combo ăn cùng nhau để tiện lợi và vui vẻ hơn nhé.",
    price: 140000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618166334/Partner2/combo_maofow.gif")
end

# Partner 6 ---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Trà Sữa Money - Lê Thanh Nghị",
    email: "moneymilktea@gmail.com",
    password: "Money111@",
    address: "111 Lê Thanh Nghị, P. Hòa Cường Bắc, Quận Hải Châu, Đà Nẵng",
    phone_number: "0905029498",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.21801833888463,
    latitude: 16.039899745660207,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069884/money_krip3o.jpg")
end

Category.create!(
  name: "ĐỒ UỐNG NÓNG",
  parent_id: 0,
  partner_id: 6
)
Category.create!(
  name: "TRÀ ĐÓNG CHAI",
  parent_id: 0,
  partner_id: 6
)
Category.create!(
  name: "TRÀ SỮA",
  parent_id: 0,
  partner_id: 6
)
Category.create!(
  name: "TRÀ TRÁI CÂY",
  parent_id: 0,
  partner_id: 6
)
Category.create!(
  name: "SƯÃ TƯƠI",
  parent_id: 0,
  partner_id: 6
)
Category.create!(
  name: "TOPPING",
  parent_id: 0,
  partner_id: 6
)
Category.create!(
  name: "ĐỒ ĂN VẶT",
  parent_id: 0,
  partner_id: 6
)

1.times do |n|
  p = Product.create!(
    category_id: 14,
    name: "Cacao Nóng Kem Bơ Trứng",
    description: "Chưa bao gồm thạch.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238016/MONEY/cacaotrung_tahd6q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 14,
    name: "Trà sữa Olong Kem Sữa Trân Châu Mini",
    description: "Chưa bao gồm thạch.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238015/MONEY/olongmilo_ejtidj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 14,
    name: "Cacao Nóng Kem Sữa",
    description: "Chưa bao gồm thạch.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238013/MONEY/cacaokemsua_wzkgxb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 15,
    name: "Trà sữa truyền thống (500ml)",
    description: "Chưa bao gồm thạch.",
    price: 50000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238176/MONEY/trasuanuong_zeqixg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 15,
    name: "Trà sữa nướng (500ml)",
    description: "Chưa bao gồm thạch.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238176/MONEY/trasuanuong_zeqixg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 15,
    name: "Trà thái xanh(500ml)",
    description: "Chưa bao gồm thạch.",
    price: 50000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238176/MONEY/trasuanuong_zeqixg.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Trà sữa nướng full thạch",
    description: "Best seller.",
    price: 37000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238364/MONEY/TSFull_dc4azb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Milo dầm flan",
    description: "Best seller! Thơm ngon vị béo flan trứng. Hãy thử ngay đi nào.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238362/MONEY/milodam_oe4ffi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Sữa tươi trân châu đường đen kem bơ trứng",
    description: "Best seller! Thơm ngon vị béo flan trứng. Hãy thử ngay đi nào.",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238361/MONEY/tckemtrung_jtvlgx.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Milo dầm đặc biệt (size L)",
    description: "Best seller! Thơm ngon vị béo milo. Hãy thử ngay đi nào.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238393/MONEY/milosizeL_kdhmfw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Ca cao kem bơ trứng",
    description: "Best seller! Thơm ngon của cacao. Hãy thử ngay đi nào.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618239436/MONEY/cacaokem_iwdxgn.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Trà sữa (full thạch)",
    description: "Best seller! Hãy thử ngay đi nào.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238554/MONEY/ts_ocpeaq.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Trà sữa nướng",
    description: "Best seller! Chưa bao gồm thạch.",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238550/MONEY/tsnuong_znxlb6.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 16,
    name: "Trà sữa full thạch + trân châu trắng",
    description: "Best seller!",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238546/MONEY/thaixanh_pd1dxz.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 17,
    name: "Trà đào kem sữa",
    description: "Chưa bao gồm thạch",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238545/MONEY/tradao_mhxam9.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 17,
    name: "Trà đào tươi",
    description: "Không thay đổi topping",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238637/MONEY/daotuoi_imfrxc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 17,
    name: "Trà vải",
    description: "Không thay đổi topping",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238635/MONEY/travai_stleuc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 17,
    name: "Trà táo tươi",
    description: "Không thay đổi topping",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238633/MONEY/taotuoi_ohobqv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 17,
    name: "Trà hoa hồng ổi",
    description: "Không thay đổi topping",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238671/MONEY/hoahongoi_jdacht.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 17,
    name: "Trà hoa hồng việt quốc",
    description: "Không thay đổi topping",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238671/MONEY/hoahongoi_jdacht.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 18,
    name: "Sữa tươi trân châu đường đen",
    description: "Best seller! Bán từ 10h sáng",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238672/MONEY/suattc_gpydwh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 18,
    name: "Sữa tươi trân châu đường đen kem sữa",
    description: "Best seller! Bán từ 10h sáng",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618240306/MONEY/tckemsua_fnswzf.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Khúc bạch phô mai",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618240465/MONEY/khucbach_fbit5h.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Flan",
    description: "",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238792/MONEY/flan_nploow.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Trân châu trắng",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238789/MONEY/ttctrang_mmuht5.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Rau câu phô mai",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238788/MONEY/pmraucau_aez2rj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Trân châu đen",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238786/MONEY/tcden_kwdcla.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Khúc bạch trà xanh",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238838/MONEY/kbxanh_yffpfg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Thạch nhà làm (pudding - rau câu - khúc bạch)",
    description: "",
    price: 17000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238834/MONEY/fullthach_ieyca1.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Khúc bạch socola",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238833/MONEY/kbachsocola_trhdjw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 19,
    name: "Thạch jelly táo",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618241447/MONEY/thach_mi3c1y.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 20,
    name: "Nem chua rán",
    description: "Bán từ 13h",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618241433/MONEY/nem_tc1toq.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 20,
    name: "Phô mai que",
    description: "Bán từ 13h",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618241550/MONEY/pmque_mncse0.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 20,
    name: "Xúc xích",
    description: "Bán từ 13h",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618241404/MONEY/xucxich_tulvtp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 20,
    name: "Hồ lô",
    description: "Bán từ 13h",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618241402/MONEY/H%E1%BB%93-L%C3%B4_yhbux4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 20,
    name: "Khô gà",
    description: "Bán từ 13h",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618241401/MONEY/khoga_pxxyqf.jpg")
end

# Partner 7 ---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Trà Sữa Money - Nguyễn Du",
    email: "moneymilktea17@gmail.com",
    password: "Money17@",
    address: "17 Nguyễn Du, Quận Hải Châu, Đà Nẵng",
    phone_number: "0905026298",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.22246602354546,
    latitude: 16.079041253862783,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069884/money_krip3o.jpg")
end

Category.create!(
  name: "ĐỒ UỐNG NÓNG",
  parent_id: 0,
  partner_id: 7
)
Category.create!(
  name: "TRÀ ĐÓNG CHAI",
  parent_id: 0,
  partner_id: 7
)
Category.create!(
  name: "TRÀ SỮA",
  parent_id: 0,
  partner_id: 7
)
Category.create!(
  name: "SỮA TƯƠI",
  parent_id: 0,
  partner_id: 7
)
Category.create!(
  name: "TOPPING",
  parent_id: 0,
  partner_id: 7
)

1.times do |n|
  p = Product.create!(
    category_id: 21,
    name: "Cacao Nóng Kem Bơ Trứng",
    description: "Chưa bao gồm thạch.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238016/MONEY/cacaotrung_tahd6q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 21,
    name: "Trà sữa Olong Kem Sữa Trân Châu Mini",
    description: "Chưa bao gồm thạch.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238015/MONEY/olongmilo_ejtidj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 21,
    name: "Cacao Nóng Kem Sữa",
    description: "Chưa bao gồm thạch.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238013/MONEY/cacaokemsua_wzkgxb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 22,
    name: "Trà sữa truyền thống (500ml)",
    description: "Chưa bao gồm thạch.",
    price: 50000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238176/MONEY/trasuanuong_zeqixg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 22,
    name: "Trà sữa nướng (500ml)",
    description: "Chưa bao gồm thạch.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238176/MONEY/trasuanuong_zeqixg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 22,
    name: "Trà thái xanh(500ml)",
    description: "Chưa bao gồm thạch.",
    price: 50000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238176/MONEY/trasuanuong_zeqixg.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Trà sữa nướng full thạch",
    description: "Best seller.",
    price: 37000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238364/MONEY/TSFull_dc4azb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Milo dầm flan",
    description: "Best seller! Thơm ngon vị béo flan trứng. Hãy thử ngay đi nào.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238362/MONEY/milodam_oe4ffi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Sữa tươi trân châu đường đen kem bơ trứng",
    description: "Best seller! Thơm ngon vị béo flan trứng. Hãy thử ngay đi nào.",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238361/MONEY/tckemtrung_jtvlgx.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Milo dầm đặc biệt (size L)",
    description: "Best seller! Thơm ngon vị béo milo. Hãy thử ngay đi nào.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238393/MONEY/milosizeL_kdhmfw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Ca cao kem bơ trứng",
    description: "Best seller! Thơm ngon của cacao. Hãy thử ngay đi nào.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618239436/MONEY/cacaokem_iwdxgn.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Trà sữa (full thạch)",
    description: "Best seller! Hãy thử ngay đi nào.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238554/MONEY/ts_ocpeaq.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Trà sữa nướng",
    description: "Best seller! Chưa bao gồm thạch.",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238550/MONEY/tsnuong_znxlb6.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 23,
    name: "Trà sữa full thạch + trân châu trắng",
    description: "Best seller!",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238546/MONEY/thaixanh_pd1dxz.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 24,
    name: "Sữa tươi trân châu đường đen",
    description: "Best seller! Bán từ 10h sáng",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238672/MONEY/suattc_gpydwh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 24,
    name: "Sữa tươi trân châu đường đen kem sữa",
    description: "Best seller! Bán từ 10h sáng",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618240306/MONEY/tckemsua_fnswzf.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 25,
    name: "Khúc bạch phô mai",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618240465/MONEY/khucbach_fbit5h.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 25,
    name: "Flan",
    description: "",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238792/MONEY/flan_nploow.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 25,
    name: "Trân châu trắng",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238789/MONEY/ttctrang_mmuht5.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 25,
    name: "Rau câu phô mai",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238788/MONEY/pmraucau_aez2rj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 25,
    name: "Trân châu đen",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238786/MONEY/tcden_kwdcla.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 25,
    name: "Khúc bạch trà xanh",
    description: "",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618238838/MONEY/kbxanh_yffpfg.jpg")
end

# Partner 8 ---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Trà Sữa Gong Cha - 貢茶 - Nguyễn Văn Linh",
    email: "gongchadn@gmail.com",
    password: "Gongcha25@",
    address: "25 - 29 Nguyễn Văn Linh, Quận Hải Châu, Đà Nẵng",
    phone_number: "0782398822",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.22126439655472,
    latitude: 16.06096179033302,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069884/gongcha_iztfkz.jpg")
end

Category.create!(
  name: "FRUIT TEA SERIES",
  parent_id: 0,
  partner_id: 8
)

Category.create!(
  name: "FRESH TARO SERIES",
  parent_id: 0,
  partner_id: 8
)
Category.create!(
  name: "WHITE XMAS SERIES",
  parent_id: 0,
  partner_id: 8
)

Category.create!(
  name: "THỨC UỐNG VỊ TRÁI CÂY",
  parent_id: 0,
  partner_id: 8
)
Category.create!(
  name: "TRÀ KEM SỮA GONG CHA",
  parent_id: 0,
  partner_id: 8
)
Category.create!(
  name: "MÓN MỚI",
  parent_id: 0,
  partner_id: 8
)
Category.create!(
  name: "TRÀ NGUYÊN CHẤT",
  parent_id: 0,
  partner_id: 8
)
Category.create!(
  name: "THỨC UỐNG ĐÁ XAY",
  parent_id: 0,
  partner_id: 8
)

1.times do |n|
  p = Product.create!(
    category_id: 26,
    name: "Trà Alisan trái cây",
    description: "",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247376/GONGCHA/tratc_wdgfgk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 26,
    name: "QQ Trà xanh trái cây",
    description: "",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247374/GONGCHA/traicay_cfpt2j.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 27,
    name: "Trà xanh sữa khoai môn (M)",
    description: "Chỉ có thức uống lạnh Khuyến khích không kết hợp với các loại Topping: Sương sáo, Đậu đỏ",
    price: 59000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247275/GONGCHA/sd_rhfbwc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 27,
    name: "Fresh Taro Latte",
    description: "Chỉ có thức uống lạnh Khuyến khích không kết hợp với các loại Topping: Sương sáo, Đậu đỏ",
    price: 59000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247278/GONGCHA/sdf_aj0tdn.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 28,
    name: "Okinawa Oreo Cream Milk Tea",
    description: "Lắc đều thức uống trước khi dùng. Thức uống sẽ ngọt hơn nếu order thêm topping.",
    price: 57000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247191/GONGCHA/hsd_ciy8gi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 28,
    name: "Okinawa Milk Foam Smoothie",
    description: "Lắc đều thức uống trước khi dùng. Thức uống sẽ ngọt hơn nếu order thêm topping.",
    price: 63000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247188/GONGCHA/shdf_gmcca4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 29,
    name: "Trà Xanh Đào",
    description: "Ngon hơn khi uống lạnh.",
    price: 44000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247047/GONGCHA/xanhdao_j808zw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 29,
    name: "Đào Hồng Mận và Hột É",
    description: "Ngon hơn khi uống lạnh.",
    price: 47000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247048/GONGCHA/hongdao_wz1xty.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 29,
    name: "Chanh Ai-Yu và Trân Châu Trắng",
    description: "Ngon hơn khi uống lạnh.",
    price: 47000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247049/GONGCHA/sdh_ka9aj6.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 29,
    name: "QQ Chanh Dây Trà Xanh",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247192/GONGCHA/chanhday_mmfedk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 29,
    name: "QQ Chanh Dây Trà Xanh",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247192/GONGCHA/chanhday_mmfedk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 30,
    name: "Trà Alisan Gong Cha",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248519/GONGCHA/hihi_cnzwcg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 30,
    name: "Trà Earl Grey Gong Cha",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248464/GONGCHA/tradenmil_gq3854.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 30,
    name: "Trà Đen Gong Cha",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248464/GONGCHA/tradenmil_gq3854.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 31,
    name: "Trà sữa xoài trân châu đen",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247125/GONGCHA/tchau_dh5l3z.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 31,
    name: "Mango Matcha Latte",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248700/GONGCHA/mago_jb4lum.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 31,
    name: "Sữa tươi Okinawa",
    description: "Có sẵn trân châu đen. Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247188/GONGCHA/shdf_gmcca4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 31,
    name: "Okinawa latte",
    description: "Có sẵn trân châu đen. Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247191/GONGCHA/hsd_ciy8gi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 31,
    name: "Strawberry Oreo Smoothie",
    description: "Ngon hơn khi uống lạnh.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247373/GONGCHA/kem_znqu3c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 32,
    name: "Trà Bí Đao",
    description: "Ngon hơn khi uống lạnh.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246509/GONGCHA/bidao_ag6vvw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 32,
    name: "Trà Alisan",
    description: "Ngon hơn khi uống lạnh.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247047/GONGCHA/xanhdao_j808zw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 32,
    name: "Trà Bí Đao Alisan",
    description: "Ngon hơn khi uống lạnh.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247047/GONGCHA/xanhdao_j808zw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 33,
    name: "Xoài đá xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246519/GONGCHA/xoaidaxay_jtz7dc.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 33,
    name: "Socola Đá Xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246512/GONGCHA/soccola_r0pggw.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 33,
    name: "Matcha Đá Xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246511/GONGCHA/matchaxay_tuvxiw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 33,
    name: "Khoai Môn Đá Xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246510/GONGCHA/khoaimon_kesrpv.jpg")
end

# Partner 9 ---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Trà Sữa Gong Cha - 貢茶 - Nguyễn Văn Thoại",
    email: "gongchanvtdn@gmail.com",
    password: "Gongcha132@",
    address: "132 Nguyễn Văn Thoại, Quận Ngũ Hành Sơn, Đà Nẵng",
    phone_number: "0782392122",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.2454053099604,
    latitude: 16.05585046822749,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618073120/gongcha_dbtk3a.jpg")
end

Category.create!(
  name: "FRUIT TEA SERIES",
  parent_id: 0,
  partner_id: 9
)

Category.create!(
  name: "FRESH TARO SERIES",
  parent_id: 0,
  partner_id: 9
)
Category.create!(
  name: "WHITE XMAS SERIES",
  parent_id: 0,
  partner_id: 9
)
Category.create!(
  name: "THỨC UỐNG VỊ TRÁI CÂY",
  parent_id: 0,
  partner_id: 9
)
Category.create!(
  name: "TRÀ KEM SỮA GONG CHA",
  parent_id: 0,
  partner_id: 9
)
Category.create!(
  name: "MÓN MỚI",
  parent_id: 0,
  partner_id: 9
)
Category.create!(
  name: "TRÀ NGUYÊN CHẤT",
  parent_id: 0,
  partner_id: 9
)
Category.create!(
  name: "THỨC UỐNG ĐÁ XAY",
  parent_id: 0,
  partner_id: 9
)
1.times do |n|
  p = Product.create!(
    category_id: 34,
    name: "Trà Alisan trái cây",
    description: "",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247376/GONGCHA/tratc_wdgfgk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 34,
    name: "QQ Trà xanh trái cây",
    description: "",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247374/GONGCHA/traicay_cfpt2j.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 35,
    name: "Trà xanh sữa khoai môn (M)",
    description: "Chỉ có thức uống lạnh Khuyến khích không kết hợp với các loại Topping: Sương sáo, Đậu đỏ",
    price: 59000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247275/GONGCHA/sd_rhfbwc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 35,
    name: "Fresh Taro Latte",
    description: "Chỉ có thức uống lạnh Khuyến khích không kết hợp với các loại Topping: Sương sáo, Đậu đỏ",
    price: 59000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247278/GONGCHA/sdf_aj0tdn.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 36,
    name: "Okinawa Oreo Cream Milk Tea",
    description: "Lắc đều thức uống trước khi dùng. Thức uống sẽ ngọt hơn nếu order thêm topping.",
    price: 57000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247191/GONGCHA/hsd_ciy8gi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 36,
    name: "Okinawa Milk Foam Smoothie",
    description: "Lắc đều thức uống trước khi dùng. Thức uống sẽ ngọt hơn nếu order thêm topping.",
    price: 63000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247188/GONGCHA/shdf_gmcca4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 37,
    name: "Trà Xanh Đào",
    description: "Ngon hơn khi uống lạnh.",
    price: 44000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247047/GONGCHA/xanhdao_j808zw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 37,
    name: "Đào Hồng Mận và Hột É",
    description: "Ngon hơn khi uống lạnh.",
    price: 47000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247048/GONGCHA/hongdao_wz1xty.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 37,
    name: "Chanh Ai-Yu và Trân Châu Trắng",
    description: "Ngon hơn khi uống lạnh.",
    price: 47000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247049/GONGCHA/sdh_ka9aj6.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 37,
    name: "QQ Chanh Dây Trà Xanh",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247192/GONGCHA/chanhday_mmfedk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 37,
    name: "QQ Chanh Dây Trà Xanh",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247192/GONGCHA/chanhday_mmfedk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 38,
    name: "Trà Alisan Gong Cha",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248519/GONGCHA/hihi_cnzwcg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 38,
    name: "Trà Earl Grey Gong Cha",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248464/GONGCHA/tradenmil_gq3854.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 38,
    name: "Trà Đen Gong Cha",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248464/GONGCHA/tradenmil_gq3854.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 39,
    name: "Trà sữa xoài trân châu đen",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247125/GONGCHA/tchau_dh5l3z.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 39,
    name: "Mango Matcha Latte",
    description: "Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618248700/GONGCHA/mago_jb4lum.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 39,
    name: "Sữa tươi Okinawa",
    description: "Có sẵn trân châu đen. Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247188/GONGCHA/shdf_gmcca4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 39,
    name: "Okinawa latte",
    description: "Có sẵn trân châu đen. Ngon hơn khi uống lạnh.",
    price: 51000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247191/GONGCHA/hsd_ciy8gi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 39,
    name: "Strawberry Oreo Smoothie",
    description: "Ngon hơn khi uống lạnh.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247373/GONGCHA/kem_znqu3c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 40,
    name: "Trà Bí Đao",
    description: "Ngon hơn khi uống lạnh.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246509/GONGCHA/bidao_ag6vvw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 40,
    name: "Trà Alisan",
    description: "Ngon hơn khi uống lạnh.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247047/GONGCHA/xanhdao_j808zw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 40,
    name: "Trà Bí Đao Alisan",
    description: "Ngon hơn khi uống lạnh.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618247047/GONGCHA/xanhdao_j808zw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 41,
    name: "Xoài đá xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246519/GONGCHA/xoaidaxay_jtz7dc.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 41,
    name: "Socola Đá Xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246512/GONGCHA/soccola_r0pggw.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 41,
    name: "Matcha Đá Xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246511/GONGCHA/matchaxay_tuvxiw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 41,
    name: "Khoai Môn Đá Xay",
    description: "Ngon hơn khi uống lạnh.",
    price: 58000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618246510/GONGCHA/khoaimon_kesrpv.jpg")
end

# Partner 10 ---------------------------------------------------------------------------------
1.times do |n|
  p = Partner.create!(
    name: "Bông Food & Drink - Điện Biên Phủ",
    email: "bongdbp@gmail.com",
    password: "Bong559@",
    address: "559 Điện Biên Phủ, Quận Thanh Khê, Đà Nẵng",
    phone_number: "0782394747",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.18439979655473,
    latitude: 16.065444985684575,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069894/bong_docugv.jpg")
end

Category.create!(
  name: "TRÀ SỮA",
  parent_id: 0,
  partner_id: 10
)
Category.create!(
  name: "SỮA TƯƠI",
  parent_id: 0,
  partner_id: 10
)
Category.create!(
  name: "TRÀ TRÁI CÂY",
  parent_id: 0,
  partner_id: 10
)
Category.create!(
  name: "ĐÁ XAY",
  parent_id: 0,
  partner_id: 10
)
Category.create!(
  name: "YAOURT",
  parent_id: 0,
  partner_id: 10
)
Category.create!(
  name: "SODA",
  parent_id: 0,
  partner_id: 10
)

1.times do |n|
  p = Product.create!(
    category_id: 42,
    name: "Trà sữa đặc biệt",
    description: "Thạch nhà làm, flan, popping.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323849/B%C3%94NG/ts_jvluq5.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 42,
    name: "Thái xanh đặc biệt",
    description: "Thạch nhà làm, flan, popping.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323847/B%C3%94NG/tx_msggyj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 42,
    name: "Trà sữa BÔNG",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323845/B%C3%94NG/bong_wqupae.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 42,
    name: "Trà sữa củ năng",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325582/B%C3%94NG/nag_dq3yck.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 42,
    name: "Ô long sữa đường đen đặc biệt",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325642/B%C3%94NG/olong_hbutxr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 42,
    name: "Trà sữa Rainbow",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325641/B%C3%94NG/rainbow_eowvok.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Sữa tươi trân châu đường đen",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323960/B%C3%94NG/trachau_mjw4ry.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Milo cốt dừa trân châu đường đen",
    description: "Mặc định đá chung.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323961/B%C3%94NG/milo_qpqrua.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Milo dằm trân châu đường đen đặc biệt",
    description: "Mặc định đá chung.",
    price: 34000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323962/B%C3%94NG/milot_z3arpp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Matcha latte trân châu đường đen",
    description: "Mặc định đá chung.",
    price: 27000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325964/B%C3%94NG/suongsao_nj5phy.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Sữa tươi sương sáo đường đen",
    description: "Mặc định đá chung.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325965/B%C3%94NG/ssduongden_bk3v4c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Chocolate latte trân châu đường đen",
    description: "Mặc định đá chung.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324401/B%C3%94NG/chocola_wblsgj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Latter đào",
    description: "Mặc định đá chung.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324400/B%C3%94NG/latterdao_rkv0m8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 43,
    name: "Ô long sữa sương sáo đường đen",
    description: "Mặc định đá chung.",
    price: 27000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324399/B%C3%94NG/dden_l2a09k.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 44,
    name: "Trà xoài nha đam",
    description: "Mặc định đá chung.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324479/B%C3%94NG/cam_mfecis.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 44,
    name: "Trà kiwi nha đam",
    description: "Mặc định đá chung.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324477/B%C3%94NG/kiwi_df8vsp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 44,
    name: "Trà chanh xí muội",
    description: "Mặc định đá chung.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324476/B%C3%94NG/chanh_boukgj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 44,
    name: "Trà việt quất nha đam",
    description: "Mặc định đá chung.",
    price: 22000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324630/B%C3%94NG/dao_dfd0xn.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 45,
    name: "Socola đá xay",
    description: "Mát lạnh thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324627/B%C3%94NG/trasuadao_matdff.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 45,
    name: "Matcha đá xay",
    description: "Mát lạnh thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326526/B%C3%94NG/daxay_fker74.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 45,
    name: "Cookie bạc hà đá xay",
    description: "Mát lạnh thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325065/B%C3%94NG/cmarrem_cjcdqr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 46,
    name: "Yaourt thạch đặc biệt",
    description: "Mát lạnh thơm ngon.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325058/B%C3%94NG/yout_aybiln.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 46,
    name: "Yaourt nha đam mứt việt quất",
    description: "Mát lạnh thơm ngon.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325057/B%C3%94NG/youtnhadam_rm7mih.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 46,
    name: "Yaourt đào tươi",
    description: "Mát lạnh thơm ngon.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325056/B%C3%94NG/daotuoi_gx4rxi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 47,
    name: "Soda việt quất",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326928/B%C3%94NG/soda_ds4sbo.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 47,
    name: "Soda táo",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326927/B%C3%94NG/soda3_m5hs7s.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 47,
    name: "Soda dâu",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326927/B%C3%94NG/soda2_c7yy8j.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 47,
    name: "Soda chanh dây",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618327042/B%C3%94NG/chanhday_shqlb8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 47,
    name: "Soda vải",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326927/B%C3%94NG/soda3_m5hs7s.jpg")
end

# Partner 11 ---------------------------------------------------------------------------------

1.times do |n|
  p = Partner.create!(
    name: "Bông Food & Drink - Tôn Đức Thắng",
    email: "bongtdt@gmail.com",
    password: "Bong840@",
    address: "840 Tôn Đức Thắng, Quận Liên Chiểu, Đà Nẵng",
    phone_number: "0782399656",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.1516768100501,
    latitude: 16.069568752516147,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069894/bong_docugv.jpg")
end

Category.create!(
  name: "TRÀ SỮA",
  parent_id: 0,
  partner_id: 11
)
Category.create!(
  name: "SỮA TƯƠI",
  parent_id: 0,
  partner_id: 11
)
Category.create!(
  name: "TRÀ TRÁI CÂY",
  parent_id: 0,
  partner_id: 11
)
Category.create!(
  name: "ĐÁ XAY",
  parent_id: 0,
  partner_id: 11
)
Category.create!(
  name: "YAOURT",
  parent_id: 0,
  partner_id: 11
)
Category.create!(
  name: "SODA",
  parent_id: 0,
  partner_id: 11
)

1.times do |n|
  p = Product.create!(
    category_id: 48,
    name: "Trà sữa đặc biệt",
    description: "Thạch nhà làm, flan, popping.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323849/B%C3%94NG/ts_jvluq5.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 48,
    name: "Thái xanh đặc biệt",
    description: "Thạch nhà làm, flan, popping.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323847/B%C3%94NG/tx_msggyj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 48,
    name: "Trà sữa BÔNG",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323845/B%C3%94NG/bong_wqupae.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 48,
    name: "Trà sữa củ năng",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325582/B%C3%94NG/nag_dq3yck.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 48,
    name: "Ô long sữa đường đen đặc biệt",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325642/B%C3%94NG/olong_hbutxr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 48,
    name: "Trà sữa Rainbow",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325641/B%C3%94NG/rainbow_eowvok.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Sữa tươi trân châu đường đen",
    description: "Thạch nhà làm, flan, popping, milkfoam.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323960/B%C3%94NG/trachau_mjw4ry.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Milo cốt dừa trân châu đường đen",
    description: "Mặc định đá chung.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323961/B%C3%94NG/milo_qpqrua.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Milo dằm trân châu đường đen đặc biệt",
    description: "Mặc định đá chung.",
    price: 34000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618323962/B%C3%94NG/milot_z3arpp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Matcha latte trân châu đường đen",
    description: "Mặc định đá chung.",
    price: 27000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325964/B%C3%94NG/suongsao_nj5phy.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Sữa tươi sương sáo đường đen",
    description: "Mặc định đá chung.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325965/B%C3%94NG/ssduongden_bk3v4c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Chocolate latte trân châu đường đen",
    description: "Mặc định đá chung.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324401/B%C3%94NG/chocola_wblsgj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Latter đào",
    description: "Mặc định đá chung.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324400/B%C3%94NG/latterdao_rkv0m8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 49,
    name: "Ô long sữa sương sáo đường đen",
    description: "Mặc định đá chung.",
    price: 27000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324399/B%C3%94NG/dden_l2a09k.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 50,
    name: "Trà xoài nha đam",
    description: "Mặc định đá chung.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324479/B%C3%94NG/cam_mfecis.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 50,
    name: "Trà kiwi nha đam",
    description: "Mặc định đá chung.",
    price: 23000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324477/B%C3%94NG/kiwi_df8vsp.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 50,
    name: "Trà chanh xí muội",
    description: "Mặc định đá chung.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324476/B%C3%94NG/chanh_boukgj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 50,
    name: "Trà việt quất nha đam",
    description: "Mặc định đá chung.",
    price: 22000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324630/B%C3%94NG/dao_dfd0xn.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 51,
    name: "Socola đá xay",
    description: "Mát lạnh thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618324627/B%C3%94NG/trasuadao_matdff.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 51,
    name: "Matcha đá xay",
    description: "Mát lạnh thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326526/B%C3%94NG/daxay_fker74.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 51,
    name: "Cookie bạc hà đá xay",
    description: "Mát lạnh thơm ngon.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325065/B%C3%94NG/cmarrem_cjcdqr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 52,
    name: "Yaourt thạch đặc biệt",
    description: "Mát lạnh thơm ngon.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325058/B%C3%94NG/yout_aybiln.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 52,
    name: "Yaourt nha đam mứt việt quất",
    description: "Mát lạnh thơm ngon.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325057/B%C3%94NG/youtnhadam_rm7mih.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 52,
    name: "Yaourt đào tươi",
    description: "Mát lạnh thơm ngon.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618325056/B%C3%94NG/daotuoi_gx4rxi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 53,
    name: "Soda việt quất",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326928/B%C3%94NG/soda_ds4sbo.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 53,
    name: "Soda táo",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326927/B%C3%94NG/soda3_m5hs7s.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 53,
    name: "Soda dâu",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326927/B%C3%94NG/soda2_c7yy8j.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 53,
    name: "Soda chanh dây",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618327042/B%C3%94NG/chanhday_shqlb8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 53,
    name: "Soda vải",
    description: "Mát lạnh thơm ngon.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618326927/B%C3%94NG/soda3_m5hs7s.jpg")
end

# Partner 12 ---------------------------------------------------------------------------------

1.times do |n|
  p = Partner.create!(
    name: "Cloudy - Nitrogen Ice Cream & Drinks - Phan Châu Trinh",
    email: "cloudy@gmail.com",
    password: "Cloudy91@",
    address: "91 Phan Châu Trinh, Quận Hải Châu, Đà Nẵng",
    phone_number: "0782394572",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.2203155677198,
    latitude: 16.066974035276612,
    city_id: 1,
    type_id: 5
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069871/cloudy2_gsybgb.jpg")
end
Category.create!(
  name: "TRÀ SỮA",
  parent_id: 0,
  partner_id: 12
)
Category.create!(
  name: "MILO DINO SERIES",
  parent_id: 0,
  partner_id: 12
)
Category.create!(
  name: "TRÀ SỮA NÓNG",
  parent_id: 0,
  partner_id: 12
)
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Matcha latte trân châu đường đen",
    description: "Bán từ 10h30.",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331005/CLOUDY/lattertxanh_kr9xv7.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Ca cao sữa tươi trân châu đường đen Cream Cheese",
    description: "Bán từ 10h30.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331006/CLOUDY/ccbanh_eshkmf.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Sữa tươi sương sáo trân châu đường đen",
    description: "Bán từ 10h30.",
    price: 34000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331141/CLOUDY/ssdden_pwum8l.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà Sữa Thái Xanh full thạch",
    description: "Bán từ 10h30.",
    price: 24000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331139/CLOUDY/tstt_zegrbw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà Sữa Socola ",
    description: "Chưa có thạch.",
    price: 19000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331137/CLOUDY/socola_gk7mhu.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà sữa khoai môn ",
    description: "Chưa có thạch.",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331135/CLOUDY/khoaimon_oydxzh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà Đào Sữa",
    description: "Chưa có thạch.",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331135/CLOUDY/khoaimon_oydxzh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà sữa thạch phô mai",
    description: "Thơm ngon ngọt ngào",
    price: 24000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331218/CLOUDY/thachpm_qtte6e.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà sữa khúc bạch phô mai",
    description: "Thơm ngon ngọt ngào",
    price: 24000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331219/CLOUDY/tskhucbach_uecvrk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 54,
    name: "Trà Sữa Truyền Thống (đặc biệt)",
    description: "Thêm thạch thêm bánh flan. Thơm ngon ngọt ngào",
    price: 30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618331255/CLOUDY/tsfthach_bkr45g.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 55,
    name: "Milo Dino Flan",
    description: "Đã bao gồm topping : Flan , kem sữa , bánh milo , bột milo Mặc định : không làm thức uống nóng hoặc không đá.",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330114/CLOUDY/milodam_puqpiu.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 55,
    name: "Milo Dino Trân Châu Đường đen",
    description: "Đã bao gồm topping : Trân châu đường đen , kem sữa , bánh milo , bột milo. Mặc định : không làm thức uống nóng hoặc không đá.",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330113/CLOUDY/milotcdd_y3livz.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 55,
    name: "Milo Dino Original",
    description: "Đã bao gồm topping : Trân châu đường đen , kem sữa , bánh milo , bột milo. Mặc định : không làm thức uống nóng hoặc không đá.",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330130/CLOUDY/miloorgin_jfho7t.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 55,
    name: "Milo Dino Creamcheese",
    description: "Đã bao gồm topping : Trân châu đường đen , kem sữa , bánh milo , bột milo. Mặc định : không làm thức uống nóng hoặc không đá.",
    price: 38000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330112/CLOUDY/milocream_gudxvi.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 56,
    name: "Trà sữa Hoa Nhài nóng",
    description: "Thơm ngon ngọt ngào.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330064/CLOUDY/hoanhai_k0yxjk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 56,
    name: "Hồng trà sữa nóng",
    description: "Thơm ngon ngọt ngào.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330064/CLOUDY/hoanhai_k0yxjk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 56,
    name: "Trà sữa Olong nóng",
    description: "Thơm ngon ngọt ngào.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618330064/CLOUDY/hoanhai_k0yxjk.jpg")
end

# Partner 13
1.times do |n|
  p = Partner.create!(
    name: "Phiphi - Sushi Nhật & Hàn Food",
    email: "sushiphiphi@gmail.com",
    password: "Sushi41@",
    address: "41 Lê Hồng Phong, Quận Hải Châu, Đà Nẵng",
    phone_number: "0782333572",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.2213034542245,
    latitude: 16.064131116788715,
    city_id: 1,
    type_id: 4
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069017/ljjbomwlcuobfjzxqqqv.jpg")
end
Category.create!(
  name: "SUSHI",
  parent_id: 0,
  partner_id: 13
)
Category.create!(
  name: "SALAD & CƠM",
  parent_id: 0,
  partner_id: 13
)
Category.create!(
  name: "HÀN FOOD",
  parent_id: 0,
  partner_id: 13
)

1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Sushi bò mỹ BBQ",
    description: "Thịt bò mỹ thơm ngon, mềm ngọt.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335756/SUSHI/SUSHI_rlbwp8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Sushi thanh cua",
    description: "Thanh cua thơm ngon, mềm ngọt.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335758/SUSHI/CUA_bu2dof.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Sushi trứng",
    description: "",
    price:18000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335758/SUSHI/CUA_bu2dof.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Sushi trứng cá chuồn",
    description: "",
    price:30000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335760/SUSHI/cachuong_uqowhg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "HỘP SUSHI F.A",
    description: "",
    price:99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335826/SUSHI/ss2_a77klv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "HỘP SUSHI F.A",
    description: "",
    price:99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335826/SUSHI/ss2_a77klv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "SET TAKE AWAY B",
    description: "Maki trứng tôm 8 viên, sushi trứng tôm 4 viên, sushi cá hồi 9 sốt cay",
    price:85000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335824/SUSHI/ss3_q8qtrb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Set cá hồi vs lươn tươi ngon",
    description: "Sushi cá hồi 5 viên Sushi cá hồi 9 4 viên Sushi lươn 5 viên",
    price: 149000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335823/SUSHI/susica_klk2ma.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Set cá hồi vs lươn tươi ngon",
    description: "Sushi cá hồi 5 viên Sushi cá hồi 9 4 viên Sushi lươn 5 viên",
    price: 149000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335823/SUSHI/susica_klk2ma.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Sashimi 3 loại",
    description: "",
    price: 149000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336063/SUSHI/ssmbt_ln2miv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 57,
    name: "Sashimi Bạch Tuộc",
    description: "",
    price: 149000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336063/SUSHI/ssmbt_ln2miv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 58,
    name: "Salad cá hồi chiên giòn",
    description: "Salmon Furai salad",
    price: 79000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336064/SUSHI/salad_aowtw8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 58,
    name: "Salad Cá Hồi vs Bơ",
    description: "Salmon Furai salad",
    price: 99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336135/SUSHI/slboca_chfgyd.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 58,
    name: "Salad Thanh Cua",
    description: "Salmon Furai salad",
    price: 99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336137/SUSHI/slcomcuon_mttyam.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 58,
    name: "Rong biển trộn mè",
    description: "Salmon Furai salad",
    price: 59000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336065/SUSHI/rongbien_fgajt7.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "Cuốn thập cẩm chiên",
    description: "",
    price: 79000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336138/SUSHI/kimbap_ofmma6.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "Bạch tuộc xào cay",
    description: "",
    price: 89000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618405677/SUSHI/btxao_k2wswr.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "Bánh gạo xúc xích",
    description: "",
    price: 69000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618405677/SUSHI/banhgao_xnk8bb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "Chân gà xào cay Hàn Quốc",
    description: "ĐỪNG BỎ LỠ MÓN CHÂN GÀ XÀO CAY TUYỆT ĐỈNH VỊ HÀN TẠI #PHIPHISUSHI Chân gà tươi ngon, được tẩm sốt ướp đậm đà, cái cảm giác mùa đông mà ăn cay xé từ miệng cho đến bao tử, ngon đến xuýt xoa lắm !!!",
    price: 89000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618405677/SUSHI/banhgao_xnk8bb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "COMBO Đặc biệt",
    description: "Set thuyền 1 Salad da cá hoặc cá hồi chiên Bánh gạo xúc xích Cơm cuộn thanh cua chiên phomai Lẫu thái nhỏ 2 ly ép cocs",
    price: 489000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406001/SUSHI/csdf_xkihgo.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "COMBO Đặc biệt 2",
    description: "Set thuyền 6 Salad da cá hồi hoặc cá hồi chiên Cơm bạch tuộc xào cay 2 miso soup 2 cóc ép.",
    price: 479000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336361/SUSHI/cb1_yhrtw8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 59,
    name: "COMBO Đặc biệt 2",
    description: "Set thuyền 5 Salad da cá hồi hoặc cá hồi chiên Lẫu thái nhỏ 2 ly ép cóc.",
    price: 499000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336360/SUSHI/cb2_qzdpm3.jpg")
end

# Partner 14
1.times do |n|
  p = Partner.create!(
    name: "Hana Sushi",
    email: "hanasushi@gmail.com",
    password: "Hanasushi99@",
    address: "27/11 Nguyễn Trường Tộ, P.Bình Hiên, Quận Hải Châu, Đà Nẵng",
    phone_number: "0782333575",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.21763426771967,
    latitude: 16.05844762356432,
    city_id: 1,
    type_id: 4
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618069002/t6cu5ulmztsyxd39lak6.jpg")
end

Category.create!(
  name: "SASHIMI",
  parent_id: 0,
  partner_id: 14
)
Category.create!(
  name: "SUSHI & CƠM CUỘN",
  parent_id: 0,
  partner_id: 14
)
Category.create!(
  name: "COMBO",
  parent_id: 0,
  partner_id: 14
)
1.times do |n|
  p = Product.create!(
    category_id: 60,
    name: "Sashimi cá hồi",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406350/SUSHI/ss5_ctjwtx.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 60,
    name: "Sashimi cá trích vàng",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406352/SUSHI/tt_kwo2fv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 60,
    name: "Sashimi cá trích đỏ",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406353/SUSHI/ttdo_fklzkw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 60,
    name: "Sashimi bạch tuộc",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406355/SUSHI/ssbtuoc_if3u2a.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 60,
    name: "Sashimi 5 Loại",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406430/SUSHI/ssdb_slz2qe.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 61,
    name: "Sushi Trứng Tôm",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335760/SUSHI/cachuong_uqowhg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 61,
    name: "Sushi thanh cua",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335756/SUSHI/SUSHI_rlbwp8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 61,
    name: "SALAD THANH CUA",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 79000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406428/SUSHI/bo_urbbro.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 61,
    name: "RONG BIỂN MUỐI",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336065/SUSHI/rongbien_fgajt7.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 61,
    name: "CƠM CUỘN TRỨNG",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406427/SUSHI/comcuon_rfssj4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 61,
    name: "CƠM CUỘN CÁ HỒI",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406427/SUSHI/comcuon_rfssj4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 62,
    name: "COMBO HANA 2",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 423000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406426/SUSHI/hanacb1_yqohuw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 62,
    name: "COMBO HANA 1",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 359000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406446/SUSHI/hanacb2_szazdh.jpg")
end
# Partner 15
1.times do |n|
  p = Partner.create!(
    name: "Paris Sushi - Sashimi & Cơm Cuộn - Hoàng Diệu",
    email: "parissushi@gmail.com",
    password: "Parisushi99@",
    address: "164/4 Hoàng Diệu, Quận Hải Châu, Đà Nẵng",
    phone_number: "0782333577",
    time_open: Time.at(25200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(79200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.21984551005004,
    latitude: 16.066362123927767,
    city_id: 1,
    type_id: 4
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335487/SUSHI/sushi_vwyads.jpg")
end

Category.create!(
  name: "SASHIMI",
  parent_id: 0,
  partner_id: 15
)
Category.create!(
  name: "SUSHI & CƠM CUỘN",
  parent_id: 0,
  partner_id: 15
)
1.times do |n|
  p = Product.create!(
    category_id: 63,
    name: "Sashimi cá hồi",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406350/SUSHI/ss5_ctjwtx.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 63,
    name: "Sashimi cá trích vàng",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406352/SUSHI/tt_kwo2fv.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 63,
    name: "Sashimi cá trích đỏ",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406353/SUSHI/ttdo_fklzkw.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 63,
    name: "Sashimi bạch tuộc",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406355/SUSHI/ssbtuoc_if3u2a.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 63,
    name: "Sashimi 5 Loại",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 96000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406430/SUSHI/ssdb_slz2qe.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 64,
    name: "Sushi Trứng Tôm",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 29000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335760/SUSHI/cachuong_uqowhg.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 64,
    name: "Sushi thanh cua",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618335756/SUSHI/SUSHI_rlbwp8.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 64,
    name: "SALAD THANH CUA",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 79000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406428/SUSHI/bo_urbbro.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 64,
    name: "RONG BIỂN MUỐI",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618336065/SUSHI/rongbien_fgajt7.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 64,
    name: "CƠM CUỘN TRỨNG",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 28000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406427/SUSHI/comcuon_rfssj4.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 64,
    name: "CƠM CUỘN CÁ HỒI",
    description: "Sashimi, sushi, cơm cuộn thơm ngon, tươi sống, bổ dưỡng. Thực phẩm đảm bảo chất lượng 100%.",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618406427/SUSHI/comcuon_rfssj4.jpg")
end

# Partner 16
1.times do |n|
  p = Partner.create!(
    name: "Phố Cổ Hà Nội - Triệu Nữ Vương",
    email: "phocohoian1@gmail.com",
    password: "Phocoha99@",
    address: "15 Phan Thanh, Quận Hải Châu, Đà Nẵng",
    phone_number: "0893728498",
    time_open: Time.at(34200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(81000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.2090656407292,
    latitude: 16.06192335954167,
    city_id: 1,
    type_id: 3
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618407998/STREETFOOD/pcha_nxfpwg.jpg")
end

Category.create!(
  name: "MENU FOOD",
  parent_id: 0,
  partner_id: 16
)
Category.create!(
  name: "COMBO",
  parent_id: 0,
  partner_id: 16
)
Category.create!(
  name: "ĐỒ UỐNG",
  parent_id: 0,
  partner_id: 16
)
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Nem chua rán lớn",
    description: "1 dĩa/ 8 xiên.",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/nemchua_r3orgy.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Hotdog phô mai Hàn Quốc",
    description: "1 cuộn 6-7 miếng.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409314/STREETFOOD/pmhq_wqum4p.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Bánh gạo sốt cay",
    description: "Bánh gạo dai mềm, thơm ngon, cay nồng đậm chất Hàn Quốc.",
    price: 22000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409312/STREETFOOD/banhgao_dcau8n.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Tokbokki nhân phô mai sốt cay",
    description: "Bánh gạo bên trong có phô mai thơm ngon, cay nồng đậm chất Hàn Quốc.",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409310/STREETFOOD/banhgaosotcay_ycwjtc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Phô mai que",
    description: "1 xiên.",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408597/STREETFOOD/phomai_a81sog.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Hồ lô",
    description: "1 xiên.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/holo_fttp4x.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Cá viên Singapore",
    description: "1 xiên.",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408599/STREETFOOD/cavien_yectvk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Hải sản viên Hàn Quốc",
    description: "1 xiên.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408599/STREETFOOD/cavienhq_noh6zc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Khoai Tây chiên",
    description: "1 dĩa.",
    price: 15000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/khoaitaychien_g3joi6.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Khoai tây lắc phomai",
    description: "",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409307/STREETFOOD/khoailang_lbz41a.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Mì Cay Trộn Hàn Quốc",
    description: "Có topping cá viên, mực xoắn.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409644/STREETFOOD/mitron_a7g6np.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 65,
    name: "Tokbokki thập cẩm",
    description: "Có topping cá viên, mực xoắn.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409647/STREETFOOD/toboki_zm4ymd.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 66,
    name: "Combo 1",
    description: "Nem nhỏ, Xúc xích Đức, 2 hải sản viên Hàn Quốc, 2 cá viên Singapore.",
    price: 66000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409884/STREETFOOD/combo_ixrm8c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 66,
    name: "Combo 2",
    description: "Nem lớn, 2 phô mai que, 2 cá viên Singapore, 2 hải sản viên Hà Quốc, 1 hồ lô.",
    price: 106000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409884/STREETFOOD/combo_ixrm8c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 66,
    name: "Combo 3",
    description: "Nem lớn, Khoai tây chiên, 2 hồ lô, 2 ốc nhồi, 2 hải sản viên Hàn Quốc, 2 cá viên Singapore, 1 xúc xích Đức.",
    price: 138000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409884/STREETFOOD/combo_ixrm8c.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 67,
    name: "Sữa chua nếp cẩm",
    description: "1 ly",
    price: 14000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408596/STREETFOOD/suachuanep_raltki.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 67,
    name: "Trà chanh",
    description: "1 ly",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408596/STREETFOOD/trachanh_wcjlgh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 67,
    name: "Mơ đá Hà Nội",
    description: "1 ly",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/moda_vxobe3.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 67,
    name: "Sữa chua đá",
    description: "1 ly",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408597/STREETFOOD/suachuada_yviba9.jpg")
end

# Partner 17
1.times do |n|
  p = Partner.create!(
    name: "Phố Cổ Hà Nội - Hoàng Văn Thái",
    email: "phocohoian2@gmail.com",
    password: "Phocoha2@",
    address: "Hoàng Văn Thái, Quận Liên Chiểu, Đà Nẵng",
    phone_number: "0793728343",
    time_open: Time.at(34200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(81000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.15905326443337,
    latitude: 16.05419767996894,
    city_id: 1,
    type_id: 3
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618407998/STREETFOOD/pcha_nxfpwg.jpg")
end

Category.create!(
  name: "MENU FOOD",
  parent_id: 0,
  partner_id: 17
)
Category.create!(
  name: "ĐỒ UỐNG",
  parent_id: 0,
  partner_id: 17
)

1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Nem chua rán lớn",
    description: "1 dĩa/ 8 xiên.",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/nemchua_r3orgy.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Phô mai que",
    description: "1 xiên.",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408597/STREETFOOD/phomai_a81sog.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Hồ lô",
    description: "1 xiên.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/holo_fttp4x.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Cá viên Singapore",
    description: "1 xiên.",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408599/STREETFOOD/cavien_yectvk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Hotdog phô mai Hàn Quốc",
    description: "1 cuộn 6-7 miếng.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409314/STREETFOOD/pmhq_wqum4p.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Bánh gạo sốt cay",
    description: "Bánh gạo dai mềm, thơm ngon, cay nồng đậm chất Hàn Quốc.",
    price: 22000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409312/STREETFOOD/banhgao_dcau8n.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Tokbokki nhân phô mai sốt cay",
    description: "Bánh gạo bên trong có phô mai thơm ngon, cay nồng đậm chất Hàn Quốc.",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409310/STREETFOOD/banhgaosotcay_ycwjtc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 68,
    name: "Khoai tây lắc phomai",
    description: "",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409307/STREETFOOD/khoailang_lbz41a.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 69,
    name: "Sữa chua nếp cẩm",
    description: "1 ly",
    price: 14000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408596/STREETFOOD/suachuanep_raltki.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 69,
    name: "Trà chanh",
    description: "1 ly",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408596/STREETFOOD/trachanh_wcjlgh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 69,
    name: "Mơ đá Hà Nội",
    description: "1 ly",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/moda_vxobe3.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 69,
    name: "Sữa chua đá",
    description: "1 ly",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408597/STREETFOOD/suachuada_yviba9.jpg")
end

# Partner 18
1.times do |n|
  p = Partner.create!(
    name: "Phố Cổ Hà Nội - Nguyễn Tri Phương",
    email: "phocohoian3@gmail.com",
    password: "Phocoha3@",
    address: "269 Nguyễn Tri Phương, Quận Liên Chiểu, Đà Nẵng",
    phone_number: "0893728476",
    time_open: Time.at(34200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(81000.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.21027665228847,
    latitude: 16.05291091965956,
    city_id: 1,
    type_id: 3
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618411269/STREETFOOD/cover_iz15s3.jpg")
end

Category.create!(
  name: "ĂN VẶT",
  parent_id: 0,
  partner_id: 18
)
Category.create!(
  name: "ĐỒ UỐNG",
  parent_id: 0,
  partner_id: 18
)

1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Nem chua rán lớn",
    description: "1 dĩa/ 8 xiên.",
    price: 49000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/nemchua_r3orgy.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Phô mai que",
    description: "1 xiên.",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408597/STREETFOOD/phomai_a81sog.jpg")
end

1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Hồ lô",
    description: "1 xiên.",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/holo_fttp4x.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Cá viên Singapore",
    description: "1 xiên.",
    price: 7000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408599/STREETFOOD/cavien_yectvk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Hotdog phô mai Hàn Quốc",
    description: "1 cuộn 6-7 miếng.",
    price: 25000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409314/STREETFOOD/pmhq_wqum4p.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Bánh gạo sốt cay",
    description: "Bánh gạo dai mềm, thơm ngon, cay nồng đậm chất Hàn Quốc.",
    price: 22000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409312/STREETFOOD/banhgao_dcau8n.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Tokbokki nhân phô mai sốt cay",
    description: "Bánh gạo bên trong có phô mai thơm ngon, cay nồng đậm chất Hàn Quốc.",
    price: 35000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409310/STREETFOOD/banhgaosotcay_ycwjtc.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 70,
    name: "Khoai tây lắc phomai",
    description: "",
    price: 20000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618409307/STREETFOOD/khoailang_lbz41a.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 71,
    name: "Sữa chua nếp cẩm",
    description: "1 ly",
    price: 14000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408596/STREETFOOD/suachuanep_raltki.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 71,
    name: "Trà chanh",
    description: "1 ly",
    price: 8000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408596/STREETFOOD/trachanh_wcjlgh.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 71,
    name: "Mơ đá Hà Nội",
    description: "1 ly",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408598/STREETFOOD/moda_vxobe3.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 71,
    name: "Sữa chua đá",
    description: "1 ly",
    price: 10000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618408597/STREETFOOD/suachuada_yviba9.jpg")
end

# Partner 19
1.times do |n|
  p = Partner.create!(
    name: "Cơm Chay Đà Nẵng",
    email: "comchaydn@gmail.com",
    password: "Comchay1@",
    address: "52 Hoàng Minh Thảo, Quận Liên Chiểu, Đà Nẵng",
    phone_number: "0893728412",
    time_open: Time.at(34200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(73800.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.16054556445076,
    latitude: 16.04971167897177,
    city_id: 1,
    type_id: 1
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412106/VEGA/chay2_tuxa4a.jpg")
end

Category.create!(
  name: "CƠM",
  parent_id: 0,
  partner_id: 19
)
Category.create!(
  name: "MÓN ĐẶC BIỆT",
  parent_id: 0,
  partner_id: 19
)
Category.create!(
  name: "LẨU",
  parent_id: 0,
  partner_id: 19
)
1.times do |n|
  p = Product.create!(
    category_id: 72,
    name: "Cơm chiên nấm",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412473/VEGA/comnam_xlasdj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 72,
    name: "Cơm chiên rong biển",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412950/VEGA/comb_ot8ovc.png")
end
1.times do |n|
  p = Product.create!(
    category_id: 72,
    name: "Cơm chiên Hàn Quốc",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 50000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412474/VEGA/comhq_cfndri.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 72,
    name: "Cơm rang muối sả",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412475/VEGA/comrang_mpw3uk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 73,
    name: "Gỏi Thái",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412622/VEGA/goithai_luk9cj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 73,
    name: "Tảo xoắn chile sả ớt",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 55000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412621/VEGA/taoxoan_ec0vgz.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 73,
    name: "Pizza rau củ (lớn)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 155000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412619/VEGA/piza_kizj13.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 73,
    name: "Đậu hủ Nhật sốt nấm",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 55000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412618/VEGA/daukhuon_suqdsb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 73,
    name: "Nấm nữ hoàng sốt hoa tiêu",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412724/VEGA/cachua_vsxqgb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 74,
    name: "Lẩu Thái (nhỏ)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 74,
    name: "Lẩu Thái (lớn)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 139000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 74,
    name: "Lẩu Nấm (nhỏ)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 119000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 74,
    name: "Lẩu Nấm (lớn)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 149000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end

# Partner 20

1.times do |n|
  p = Partner.create!(
    name: "Ẩm Thực Chay Bảo Long",
    email: "amthucchaydn@gmail.com",
    password: "Chaybaolong1@",
    address: "124 Lê Độ, Quận Thanh Khê, Đà Nẵng",
    phone_number: "0773722942",
    time_open: Time.at(34200.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    time_close: Time.at(73800.00).utc.strftime("%Y/%d/%d %H:%M:%S"),
    longitude: 108.20131549471039,
    latitude: 16.06785743178936,
    city_id: 1,
    type_id: 1
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412105/VEGA/chay1_ftxtnd.jpg")
end

Category.create!(
  name: "CƠM",
  parent_id: 0,
  partner_id: 20
)
Category.create!(
  name: "MÓN ĐẶC BIỆT",
  parent_id: 0,
  partner_id: 20
)
Category.create!(
  name: "LẨU",
  parent_id: 0,
  partner_id: 20
)
1.times do |n|
  p = Product.create!(
    category_id: 75,
    name: "Cơm chiên nấm",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412473/VEGA/comnam_xlasdj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 75,
    name: "Cơm chiên rong biển",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412950/VEGA/comb_ot8ovc.png")
end
1.times do |n|
  p = Product.create!(
    category_id: 75,
    name: "Cơm chiên Hàn Quốc",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 50000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412474/VEGA/comhq_cfndri.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 75,
    name: "Cơm rang muối sả",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 45000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412475/VEGA/comrang_mpw3uk.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 76,
    name: "Gỏi Thái",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 40000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412622/VEGA/goithai_luk9cj.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 76,
    name: "Tảo xoắn chile sả ớt",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 55000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412621/VEGA/taoxoan_ec0vgz.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 76,
    name: "Pizza rau củ (lớn)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 155000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412619/VEGA/piza_kizj13.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 76,
    name: "Đậu hủ Nhật sốt nấm",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 55000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412618/VEGA/daukhuon_suqdsb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 76,
    name: "Nấm nữ hoàng sốt hoa tiêu",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 65000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412724/VEGA/cachua_vsxqgb.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 77,
    name: "Lẩu Thái (nhỏ)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 99000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 77,
    name: "Lẩu Thái (lớn)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 139000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 77,
    name: "Lẩu Nấm (nhỏ)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 119000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end
1.times do |n|
  p = Product.create!(
    category_id: 77,
    name: "Lẩu Nấm (lớn)",
    description: "Các món ăn được làm từ những nguyên liệu tươi sạch, thơm ngon, đảm bảo chất lượng cho mọi người.",
    price: 149000,
    quantity_sold: Faker::Number.non_zero_digit,
  )
  p.save_image!("https://res.cloudinary.com/qakhadelivery/image/upload/v1618412738/VEGA/lau_uolk1q.jpg")
end

#Vouchers

Voucher.create!(
  code: "FSDN",
  discount: 15000,
  condition: 60000,
  expiry_date: Time.new(2021, 7, 30),
  usage_limit: 10,
  status: 1,
  partner_id: Partner.pluck(:id).sample
)
Voucher.create!(
  code: "ALLFREE",
  discount: 15000,
  condition: 40000,
  expiry_date: Time.new(2021, 8, 30),
  usage_limit: 20,
  status: 1,
  partner_id: Partner.pluck(:id).sample
)

# #Driver
# 15.times do |n|
#   Driver.create!(
#     name: Faker::Name.name,
#     email: "testdv#{n+1}@gmail.com",
#     password: "Test123@",
#     address: Faker::Address.full_address,
#     phone_number: Faker::Number.leading_zero_number(digits: 10),
#     id_card: Faker::Number.number(digits: 10),
#     license_plate: Faker::Code.asin,
#     status: 2,
#     coins: 100000,
#     latitude: 16.0721,
#     longitude: 108.207
#   )
# end
