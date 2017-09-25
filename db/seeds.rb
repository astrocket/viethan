# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(
    display_name: 'Admin',
    email: "admin@vietsinkorea.com",
    password: "gksruf0923!Y",
    admin: true
)

messageboard = Thredded::Messageboard.create!(
    name: '자유게시판',
    slug: 'general',
    description: 'A board is not a board without some posts'
)

target_ls = Thredded::MessageboardGroup.create!(
    name: 'Đời sống sinh hoạt'
)

life_styles = [['Nhà ở', 'residence', 'ký túc xá, nhà ở, phòng chia sẻ'], ['Địa điểm ăn ngon', 'gourmet', 'Nhà hàng Gourmet tại Hàn Quốc'], ['Đổi tiền - Gửi tiền', 'monetary', 'ngân hàng, chuyển tiền quốc tế tại Hàn Quốc'], ['Chợ đồ cũ', 'buyandsell', 'Mua bán hàng hoá đã qua sử dụng'], ['Giao thông', 'transportation', 'Mẹo sử dụng phương tiện giao thông công cộng ở Hàn Quốc'], ['Du lịch', 'travel', 'Chia sẻ thông tin du lịch']]

life_styles.each do |ls|
  target_ls.messageboards.create!(
    name: ls[0],
    slug: ls[1],
    description: ls[2]
  )
end
