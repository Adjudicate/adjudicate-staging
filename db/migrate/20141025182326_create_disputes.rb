class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|
      t.string :url, null: false
      t.string :reason
      t.text :violating_content
    end
  end
end
