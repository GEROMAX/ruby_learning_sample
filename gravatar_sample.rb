require 'digest/md5'

def gravatar_uri(email)
  base_url = "http://gravatar.com/avatar/"
  hashed_email = Digest::MD5.hexdigest(email)
  [base_url, hashed_email].join
end

begin
  p gravatar_uri('tobita0112@gmail.com')
end