ActiveAdmin.register Comment do
  config.per_page = 10

  index do
    column :body
    column :post_id
    column :commenter
    column :user_id
    default_actions
  end
end
