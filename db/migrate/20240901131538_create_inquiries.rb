class CreateInquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :email
      t.text :message
      t.string :status

      t.timestamps
    end
  end
end
