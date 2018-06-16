class CreateReusableAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :reusable_addresses do |t|
      t.string :currency_name
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
