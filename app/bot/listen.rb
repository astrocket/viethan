# app/bots/listen.rb
require "facebook/messenger"
include Facebook::Messenger
# message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
# message.sender      # => { 'id' => '1008372609250235' }
# message.sent_at     # => 2016-04-22 21:30:36 +0200
# message.text        # => 'Hello, bot!'
Bot.on :referral do |referral|
  referral.sender # => { 'id' => '1008372609250235' }
  referral.recipient # => { 'id' => '2015573629214912' }
  referral.sent_at # => 2016-04-22 21:30:36 +0200
  referral.ref # => 'MYPARAM'

  User.find_by_key(referral.ref.split('-')[1]).update(mid: referral.sender["id"], bot_subscription: true)
end


Bot.on :message do |message|

  searcher = DeepSearch.new(User.find_by_mid(message.sender["id"]))

  Bot.deliver(
      {
          recipient: message.sender,
          message: {
              text: searcher.deep_search(message.text)
          }
      }, access_token: ENV["ACCESS_TOKEN"])

end


Bot.on :postback do |postback|
  postback.sender # => { 'id' => '1008372609250235' }
  postback.recipient # => { 'id' => '2015573629214912' }
  postback.sent_at # => 2016-04-22 21:30:36 +0200
  postback.payload # => 'EXTERMINATE'

  # Welcome Message
  if postback.payload == 'GET_STARTED_PAYLOAD'
    Bot.deliver(
        {
            recipient: postback.sender,
            message: {
                attachment: {
                    type: 'template',
                    payload: {
                        template_type: 'button',
                        text: "Rất vui được gặp bạn !",
                        buttons: [
                            {type: 'postback', title: '챗봇에 대한 설명 보기', payload: 'HOW_TO_USE'}
                        ]
                    }
                }
            }
        }, access_token: ENV["ACCESS_TOKEN"])

    User.find_by_key(postback.referral.ref.split('-')[1]).update(mid: postback.sender["id"], bot_subscription: true)

  end

  if postback.payload == 'START_SUBSCRIPTION'
    msg = 'Subscription failed.'
    msg = "알림 신청이 완료되었습니다.\nVisit https://#{ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'}" if User.find_by_mid(postback.sender["id"]).update(bot_subscription: true)
    Bot.deliver(
        {
            recipient: postback.sender,
            message: {
                text: msg
            }
        }, access_token: ENV["ACCESS_TOKEN"]
    )
  end

  if postback.payload == 'STOP_SUBSCRIPTION'
    msg = 'Unsubscription failed.'
    msg = "알림이 꺼졌습니다. 언제든지 메뉴를 통해서 재신청이 가능합니다." if User.find_by_mid(postback.sender["id"]).update(bot_subscription: false)
    Bot.deliver(
        {
            recipient: postback.sender,
            message: {
                text: msg
            }
        }, access_token: ENV["ACCESS_TOKEN"]
    )
  end

  if postback.payload == 'HOW_TO_USE'
    Bot.deliver(
        {
            recipient: postback.sender,
            message: {
                text: "한국 베트남 유학생 커뮤니티 챗봇입니다.\n 이 챗봇과 커뮤니티 사이트를 통해서 유학생활에 필요한 정보들을 얻어갈 수 있습니다.(https://#{ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'})\n 사이트에 자신이 올린 글에 답변이 달리면, 알림 메시지를 받아볼 수 있습니다. 만약 알림을 받기를 원하지 않는다면, 아래의 메뉴 -> Đăng ký -> Dừng đăng ký 를 눌러서 알림을 중지할 수 있습니다."
            }
        }, access_token: ENV["ACCESS_TOKEN"]
    )
  end

end

