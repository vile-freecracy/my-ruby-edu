module Types
  class JobType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :status, String, null: false
    field :published_date, GraphQL::Types::ISO8601DateTime, null: true
    field :share_link, String, null: true
    field :salary_from, Integer, null: true
    field :salary_to, Integer, null: true
    field :created_by_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end