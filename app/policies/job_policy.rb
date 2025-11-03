class JobPolicy
  attr_reader :user, :job

  def initialize(user, job)
    @user = user
    @job = job
  end

  def show?
    user.present? && job.created_by_id == user.id
  end

  def create?
    user.present?
  end

  def update?
    user.present? && job.created_by_id == user.id
  end

  def destroy?
    user.present? && job.created_by_id == user.id
  end
end
