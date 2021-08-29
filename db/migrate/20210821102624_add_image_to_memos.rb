class AddImageToMemos < ActiveRecord::Migration[6.1]
  def change
    add_column :memos, :image, :string
  end
end
