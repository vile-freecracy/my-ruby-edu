module Mutations
  class DeleteJob < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false

    def resolve(id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authenticated" unless user

      job = Job.find(id)
      policy = JobPolicy.new(user, job)
      raise GraphQL::ExecutionError, "Not authorized" unless policy.destroy?

      job.destroy
      { success: true }
    end
  end
end
