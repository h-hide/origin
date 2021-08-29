class AddDetailsToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :abstract, :text
    add_column :comments, :diversion, :text
  end
end
