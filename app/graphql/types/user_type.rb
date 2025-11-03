module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :full_name, String, null: true
    field :avatar_url, String, null: true

    # def avatar_url
    #   object.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.avatar, host: ENV.fetch('HOST','localhost:3000')) : nil
    # end
  end
end