class CreateMethodNames < ActiveRecord::Migration
  def change
    create_table :method_names do |t|
      t.string :name
      t.string :fullname
      t.text :comment
      t.string :link
      t.string :kind
      t.boolean :sent, :default => false

      t.timestamps
    end
  end
end
