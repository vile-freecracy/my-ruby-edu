class JsonWebToken
  SECRET = ENV.fetch('JWT_SECRET') { Rails.application.credentials.jwt_secret || 'please_change_me' }

  def self.encode(payload, exp = 24.hours.from_now)
    payload = payload.dup
    payload[:exp] = exp.to_i
    payload[:jti] = SecureRandom.uuid
    JWT.encode(payload, SECRET, 'HS256')
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new(body)
  end
end