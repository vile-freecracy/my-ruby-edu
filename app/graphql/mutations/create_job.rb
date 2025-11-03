module Mutations
  class CreateJob < BaseMutation
    argument :title, String, required: true
    argument :status, String, required: false
    argument :published_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :salary_from, Integer, required: false
    argument :salary_to, Integer, required: false

    field :job, Types::JobType, null: true
    field :errors, [String], null: false

    def resolve(args)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authenticated" unless user
      args[:published_date] ||= Time.current

      job = user.jobs.build(args.to_h)
      authorize_job!(user, job, :create?)

      if job.save
        { job: job, errors: [] }
      else
        { job: nil, errors: job.errors.full_messages }
      end
    end

    private

    def authorize_job!(user, job, action)
      policy = JobPolicy.new(user, job)
      allowed = policy.send(action)
      raise GraphQL::ExecutionError, "Not authorized" unless allowed
    end
  end
end
