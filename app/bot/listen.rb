# app/bots/listen.rb
require "facebook/messenger"
include Facebook::Messenger
# message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
# message.sender      # => { 'id' => '1008372609250235' }
# message.sent_at     # => 2016-04-22 21:30:36 +0200
# message.text        # => 'Hello, bot!'
Bot.on :referral do |referral|
  referral.sender    # => { 'id' => '1008372609250235' }
  referral.recipient # => { 'id' => '2015573629214912' }
  referral.sent_at   # => 2016-04-22 21:30:36 +0200
  referral.ref       # => 'MYPARAM'

  User.find_by_key(referral.ref.split('-')[1]).update(mid: referral.sender["id"], bot_subscription: true)
end


Bot.on :message do |message|
  if message.text == 'Trắng'
    Bot.deliver(
        {
            recipient: message.sender,
            message: {
                text: 'Tối'
            }
        }, access_token: ENV["ACCESS_TOKEN"])
  else

    searcher = DeepSearch.new(User.find_by_mid(message.sender))

    Bot.deliver(
        {
            recipient: message.sender,
            message: {
                text: searcher.deep_search(message.text)
            }
        }, access_token: ENV["ACCESS_TOKEN"])
  end

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
                        text: "안녕하세요! '연동해줘' 버튼을 누르면 사이트에서 내가 참여한 게시판의 새글 알림을 받아볼 수 있습니다. '검색할래' 를 누르면 메신저에서 바로 원하는 정보를 검색해서 찾아볼 수 있습니다. uid: " + postback.referral.ref + 'mid: ' + postback.sender.to_s,
                        buttons: [
                            {type: 'postback', title: '연동해줘', payload: 'SYNC_PAYLOAD'}
                        ]
                    }
                }
            }
        }, access_token: ENV["ACCESS_TOKEN"])

    User.find_by_key(postback.referral.ref.split('-')[1]).update(mid: postback.sender["id"], bot_subscription: true)

  end

  if postback.payload == 'SYNC_PAYLOAD'
    Bot.deliver(
        {
            recipient: postback.sender,
            message: {
                text: '연동이 완료되었습니다 !'
            }
        }
    )
  end

end

