class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, null: true, foreign_key: { on_delete: :nullify }
      t.references :post, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
