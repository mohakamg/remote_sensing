ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
  permit_params :username, :first_name, :last_name, :email, :password, :organization_id
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


form title: 'Add A User' do |f|
    inputs 'Details' do
      input :username
      input :first_name
      input :last_name
      input :email
      input :password
      input :organization

    end
    para "Press cancel to return to the list without saving."
    actions
end

end
