module Mutations
  class Register < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
    argument :full_name, String, required: false  # optional

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:, password_confirmation:, full_name: nil)
      user = ::User.new(
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        full_name: full_name
      )

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        { token: token, user: user, errors: [] }
      else
        { token: nil, user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
