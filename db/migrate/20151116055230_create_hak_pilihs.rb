class CreateHakPilihs < ActiveRecord::Migration
  def change
    create_table :hak_pilihs do |t|
    	t.string :nama
    	t.string :category
    	t.integer :jumlah

      t.timestamps
    end
  end
end
