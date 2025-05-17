class JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base

  def self.encode(payload, exp = 1.minute.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    payload = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(payload)
  rescue JWT::DecodeError
    { error: "Invalid token!" }
  end
end
