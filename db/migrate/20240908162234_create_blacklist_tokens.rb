class CreateBlacklistTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :blacklist_tokens do |t|
      t.string :token, null: false, index: { unique: true }
      t.datetime :blacklisted_at, null: false

      t.timestamps
    end
  end
end
