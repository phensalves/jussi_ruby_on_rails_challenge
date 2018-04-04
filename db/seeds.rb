if Token.all.empty?
  token = SecureRandom.base64.tr('1234', 'abc')
  Token.create(token: token)
  puts '=> Token created'
end