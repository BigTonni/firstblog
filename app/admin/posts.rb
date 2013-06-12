ActiveAdmin.register Post do
  config.per_page = 10
  #scope :unreleased
  filter :title

  index do
    column :id
    column :title
    column :body
    column :user_id
    column "Agree ?" do |post|
      if post.agree == 0
        "not"
      elsif post.agree == 1
        "yes"
      elsif post.agree = 2
        "in progress"
      end
    end
    default_actions
  end

  action_item :only => :edit do
    link_to('Add tag','javascript:void(0)',onclick:'ChangeAdminForm()')

  end

  action_item :only => :edit do
    link_to('Delete tag','javascript:void(0)',onclick:'DeleteAdminForm()')
  end

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.inputs "Agree ?" do
      f.input :agree, :as => :select ,:collection =>{'No'=>0, 'Yes'=>1,"Contact the author of the post"=>2}
    end
    f.inputs "Tags" do
      f.fields_for :tags, post.tags.empty? ? Tag.new : post.tags do |tag|
        tag.text_field :name,style:'width:100px;',  class:'tag-name'
      end

    end
    f.actions

  end


end