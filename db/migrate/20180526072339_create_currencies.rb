class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
	  t.string :name, default: ''
      t.string :abbr, default: ''
      t.text :logo, default: ''
      t.float :rate, default: 0.0
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
