class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.references :target, null: false, polymorphic: true

      t.timestamps
    end
  end
end
