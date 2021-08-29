class CreateMemos < ActiveRecord::Migration[6.1]
  def change
    create_table :memos do |t|
      t.text :body

      t.timestamps
    end
  end
end
