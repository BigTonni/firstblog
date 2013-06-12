ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do

      end
    end

    columns do
      column do
        panel "Not selected" do
          ul do
            Post.waiting_to_approve.order("created_at DESC").map do |post|
              li link_to(post.title, [:admin, post])
            end
          end
        end
      end

      column do
        panel "In control" do
          ul do
            Post.waiting_warning.order("created_at DESC").map do |post|
              li link_to(post.title, [:admin, post])
            end
          end
        end
      end
    end

    section "Last 2 registered users" do
      div :class => "table_posts" do
        table_for User.order("created_at desc").limit(2) do
          column :email do |user|
            link_to user.email, [:admin, user]
          end
          column :created_at
        end
        strong { link_to "View All Users", admin_users_path }
      end
    end

    section "Last 5 Comments" do
      table_for Comment.order("created_at desc").limit(5) do
        column :body do |comment|
          link_to truncate(comment.body, :length =>30), [:admin, comment]
        end
        column :created_at
      end
      strong { link_to "View All Comments", admin_comments_path }
    end

    section "Recent Posts" do
      div :class => "table_posts" do
        table_for Post.order("created_at desc").limit(5) do
          column :title do |post|
            link_to post.title, [:admin, post]
          end
          column :created_at
          column :agree
        end
        strong { link_to "View All Posts", admin_posts_path }
      end
    end

    section "Answers from users" do
      div :class => "table_posts" do
        table_for Comment.where("commentable_type ='User'").limit(5).order("created_at desc") do
          column :title do |comment|
            link_to comment.body, [:admin, comment]
          end
        end
        strong { link_to "View comments of_user", admin_posts_path }
      end
    end

  end # content
end