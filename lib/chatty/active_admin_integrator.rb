class Chatty::ActiveAdminIntegrator
  def self.integrate!
    ActiveAdmin.register Chatty::Chat do
      index do
        selectable_column
        id_column
        column :user
        column :resource
        column :state
        column :created_at
        actions
      end

      show do
        attributes_table do
          row :id
          row :user
          row :resource
          row :state
          row :created_at
          row :updated_at
        end

        panel Chatty::Message.model_name.human(count: 2) do
          table do
            thead do
              tr do
                th Chatty::Message.human_attribute_name(:id)
                th Chatty::Message.human_attribute_name(:user)
                th Chatty::Message.human_attribute_name(:message)
                th Chatty::Message.human_attribute_name(:created_at)
              end
            end
            tbody do
              resource.messages.each do |message|
                tr do
                  td message.id
                  td message.user.name
                  td message.message
                  td message.created_at
                end
              end
            end
          end
        end

        active_admin_comments
      end
    end
  end
end
