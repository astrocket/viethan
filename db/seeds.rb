# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
    display_name: 'Admin',
    email: "admin@vietsinkorea.com",
    password: "gksruf0923!Y",
    admin: true
)

Thredded::Messageboard.create!(
    name: 'Hạng mục thông báo',
    slug: 'notice',
    description: 'Đây là bảng thông báo các thông tin liên quan đến hoạt động của website '
)

Thredded::Messageboard.create!(
    name: 'Khác',
    slug: 'general',
    description: ''
)

target_ls = Thredded::MessageboardGroup.create!(
    name: 'Đời sống sinh hoạt'
)

life_styles = [
    ['Nhà ở', 'residence', 'ký túc xá, nhà ở, share phòng'],
    ['Địa điểm ăn ngon', 'gourmet', 'Nhà hàng Gourmet tại Hàn Quốc'],
    ['Đổi tiền - Gửi tiền', 'monetary', 'ngân hàng, chuyển tiền quốc tế tại Hàn Quốc'],
    ['Chợ đồ cũ', 'buyandsell', 'Mua bán hàng hoá đã qua sử dụng'],
    ['Giao thông', 'transportation', 'Mẹo sử dụng phương tiện giao thông công cộng ở Hàn Quốc'],
    ['Du lịch', 'travel', 'Chia sẻ thông tin du lịch'],
    ['Tuyển dụng', 'find-employee', 'Tìm nhân viên bán thời gian'],
    ['Tìm việc', 'find-alba', 'tìm việc bán thời gian'],
    ['Câu hỏi về việc làm thêm', 'alba-qna', 'Q&A cho công việc bán thời gian'],
    ['Kinh nghiệm làm thêm', 'alba-diary', 'Nhật ký công việc bán thời gian']
]

life_styles.each do |ls|
  target_ls.messageboards.create!(
    name: ls[0],
    slug: ls[1],
    description: ls[2]
  )
end

target_yuhak = Thredded::MessageboardGroup.create!(
    name: 'Tư vấn du học'
)

yuhaks = [
    ['Tư vấn du học', 'yuhak-consulting', 'Tư vấn du học'],
    ['Thông tin về các trung tâm du học', 'yuhakwon', 'Thông tin về các trung tâm du học']
]

yuhaks.each do |ls|
  target_yuhak.messageboards.create!(
      name: ls[0],
      slug: ls[1],
      description: ls[2]
  )
end

target_daehak = Thredded::MessageboardGroup.create!(
    name: 'Giáo dục'
)

daehaks = [
    ['Trung tâm tiếng Hàn', 'language-school-vn', 'Các trung tâm đào tạo tiếng Hàn chất lượng ở Việt Nam'],
    ['Chương trình học tiếng ở Hàn Quốc','language-school-kr','Chương trình học tiếng ở Hàn Quốc'],
    ['Đại học& Sau đại học', 'universities', 'Chia sẻ cho bạn các thông tin hữu ích về chương trình Đại học và Sau đại học ở Hàn Quốc']
]

daehaks.each do |ls|
  target_daehak.messageboards.create!(
      name: ls[0],
      slug: ls[1],
      description: ls[2]
  )
end

target_visa = Thredded::MessageboardGroup.create!(
    name: 'Visa'
)

visas = [['Câu hỏi về Visa', 'visa', 'Các câu hỏi liên qua đến Visa']]

visas.each do |ls|
  target_visa.messageboards.create!(
      name: ls[0],
      slug: ls[1],
      description: ls[2]
  )
end


target_korean = Thredded::MessageboardGroup.create!(
    name: 'Học tiếng Hàn'
)

koreans = [
    ['Thắc mắc', 'question', 'Giải đáp các thắc mắc của bạn trong quá trình  tiếng Hàn'],
    ['Phương pháp học', 'know-how', 'Các phương pháp học tiếng Hàn hiệu quả'],
    ['Cùng học nhóm tiếng Hàn hiệu quả', 'find-study-group', 'Tại đây bạn có thể cùng một người bạn Việt Nam và cùng nhau chia sẻ kiến thức tiếng Hàn']
]

koreans.each do |ls|
  target_korean.messageboards.create!(
      name: ls[0],
      slug: ls[1],
      description: ls[2]
  )
end

target_univ = Thredded::MessageboardGroup.create!(
    name: 'Danh sách các trường Đại học tại Hàn Quốc'
)

univs = %w(
건국대학교
경기대학교
경동대학교
경민대학교
경상대학교
경성대학교
경인여자대학교
경주대학교
경희대학교
고려대학교
과학기술연합대학원대학교
구미대학교
국민대학교
남서울대학교
대경대학교
대구대학교
동국대학교
동신대학교
동아대학교
동원대학교
명지대학교
부경대학교
부산외국어대학교
상명대학교
서울대학교
서울시립대학교
선문대학교
성균관대학교
세종대학교
숙명여자대학교
숭실대학교
아주대학교
안양대학교
연세대학교
영남대학교
울산대학교
위덕대학교
전남대학교
전북대학교
중앙대학교
초당대학교
충남대학교
한국과학기술원
한국산업기술대학교
한국외국어대학교
한남대학교
한양대학교
호남대학교
)

univs.each_with_index do |ls, index|
  target_univ.messageboards.create!(
      name: ls,
      slug: "#{index}-daihoc",
      description: "#{ls} sinh viên"
  )
end


