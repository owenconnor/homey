class CreateNewsItems < ActiveRecord::Migration[7.0]
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :body
      t.references :project, null: false, foreign_key: true
      t.references :news_itemable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
