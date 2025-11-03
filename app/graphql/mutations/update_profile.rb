module Mutations
  class UpdateProfile < BaseMutation
    argument :full_name, String, required: false
    # argument :avatar, Types::Upload, required: false

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(full_name: nil, avatar: nil)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authenticated" unless user

      user.full_name = full_name if full_name
      if avatar
        # avatar is an ActionDispatch::Http::UploadedFile from multipart form
        user.avatar.attach(avatar)
      end

      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
