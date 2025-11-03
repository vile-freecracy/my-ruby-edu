module Types
  class RegisterInput < Types::BaseInputObject
    description "Attributes for registering a new user"

    # Required fields
    argument :email, String, required: true, description: "User email for login"
    argument :password, String, required: true, description: "Password for login"
    argument :password_confirmation, String, required: true, description: "Confirm password"

    # Optional profile fields
    argument :full_name, String, required: false, description: "User full name"
    # argument :avatar, Types::Upload, required: false, description: "Profile picture"

    # Future-proofing: optional fields
    # argument :username, String, required: false
    # argument :phone_number, String, required: false
    # argument :bio, String, required: false
  end
end
