ActiveAdmin.register Sensor do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
  permit_params :sens_id, :organization_id, :sens_name
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form title: 'Add A Sensor' do |f|
    inputs 'Details' do
      input :sens_id, label: 'Sensor ID'
      input :organization
      input :sens_name, label: 'Sensor Name'

    end
    para "Press cancel to return to the list without saving."
    actions
end

end
