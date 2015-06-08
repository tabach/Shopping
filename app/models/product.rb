class Product < ActiveRecord::Base
mount_uploader :image, ImageUploader
has_many :order_items
end
