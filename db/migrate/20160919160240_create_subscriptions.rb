class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :blog, foreign_key: true
      t.boolean :receive_news

      t.timestamps
    end
  end
end
