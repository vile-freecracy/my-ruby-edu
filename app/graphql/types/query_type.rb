module Types
  class QueryType < Types::BaseObject
    field :me, Types::UserType, null: true
    field :my_jobs, [Types::JobType], null: false
    field :job, Types::JobType, null: true do
      argument :id, ID, required: true
    end
    field :public_job, Types::JobType, null: true do
      argument :share_link, String, required: true
    end

    def me
      context[:current_user]
    end

    def my_jobs
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Unauthorized" unless user
      user.jobs.order(created_at: :desc)
    end

    def job(id:)
      user = context[:current_user]
      job = Job.find(id)
      policy = JobPolicy.new(user, job)
      unless user && policy.show?
        raise GraphQL::ExecutionError, "You are not authorized to view this job"
      end
      job
    end

    def public_job(share_link:)
      Job.find_by!(share_link: share_link)
    end
  end
end
