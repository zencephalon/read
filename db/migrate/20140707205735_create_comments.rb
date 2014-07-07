class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :sentence
      t.text :body
      t.references :book, index: true

      t.timestamps
    end
  end
end
