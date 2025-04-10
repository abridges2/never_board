ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :price_cents, :category_id, :image

  # Removing filters set on Ransack internal stuff.
  remove_filter :image_attachment
  remove_filter :image_blob

  form do |f|
    f.inputs "Product Details" do
      f.input :title
      f.input :price_cents
      f.input :category
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :price_cents
      row :description
      row :category
      row :image do |product|
        image_tag url_for(product.image.variant(resiz_to_limit: [ 200, 200 ])) if product.image.attached?
      end
    end
    active_admin_comments
  end
end
