require 'cgi'
require 'json'
require 'active_support'

def verify_and_decrypt_session_cookie(cookie, secret_key_base)
  cookie = CGI::unescape(cookie)
  salt         = 'encrypted cookie'
  signed_salt  = 'signed encrypted cookie'
  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  secret = key_generator.generate_key(salt)[0, ActiveSupport::MessageEncryptor.key_len]
  sign_secret = key_generator.generate_key(signed_salt)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: JSON)

  encryptor.decrypt_and_verify(cookie)
end

puts verify_and_decrypt_session_cookie(
  'TC9xdjVzMU15MFFYbHNVa0l2SEFVMS9URWNEdWJ1Zk5ranB5ck94RUg5MWtGaU91Q0VHZm9sRjNPalVlSFJNWVpqL2VEelYybVRodlFZeVgxUTk3S0RNUjRBdnNLcXk2aXl2TGZYaks2MlN4d2pTeWVHOWh5blhLUkhiRTcvZFNKc3A4ZmlwSGJtVlF3WXV1UmovY3RaK0J0dWZ3WFZva240S0k2OWJBRThONGxKcXorQTFoVVAwdGlRMnNHMDdvLS1maE01eHVkVkVQYjV2OUJvMzVyRHhnPT0%3D--620f1c07068a4bef301905be3a323143a0e39364',
  'cdc69b1d87d2f6ba96e7c9ea4fa3e0477bd041a1e22f265973f0972b8c93fd7d90fb8db65ddab25c5ffd200afe9556594cdeb8020dd5f033f3e7c6a22bf6178f'
)
