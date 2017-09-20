ActiveAdmin.register Organization do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
 permit_params :org_id, :name, :phone, :org_type
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form title: 'Add Data' do |f|
    inputs 'Details' do
      input :org_id, label: 'Organization ID'
      input :name
      input :phone
      input :org_type , label: 'Organization Type(Enter Seperating Commas)'

    end
    para "Press cancel to return to the list without saving."
    actions
end

end
