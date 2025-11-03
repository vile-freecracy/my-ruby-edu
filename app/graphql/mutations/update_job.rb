module Mutations
  class UpdateJob < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :status, String, required: false
    argument :published_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :salary_from, Integer, required: false
    argument :salary_to, Integer, required: false

    field :job, Types::JobType, null: true
    field :errors, [String], null: false

    def resolve(id:, **attrs)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authenticated" unless user

      job = Job.find(id)
      policy = JobPolicy.new(user, job)
      raise GraphQL::ExecutionError, "Not authorized" unless policy.update?

      if job.update(attrs.compact)
        { job: job, errors: [] }
      else
        { job: nil, errors: job.errors.full_messages }
      end
    end
  end
end
