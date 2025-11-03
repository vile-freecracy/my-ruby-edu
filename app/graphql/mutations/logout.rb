module Mutations
  class Logout < BaseMutation
    field :success, Boolean, null: false

    def resolve
      header = context[:request]&.headers&.[]('Authorization') || context[:authorization]
      token = header&.split(' ')&.last
      raise GraphQL::ExecutionError, "Not authenticated" unless token
      decoded = JsonWebToken.decode(token)
      RevokedToken.create!(jti: decoded['jti'], exp: Time.at(decoded['exp']))
      { success: true }
    rescue => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
