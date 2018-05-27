class DefaultWikiPrivateToFalse < ActiveRecord::Migration[5.1]
  def change
    change_table :wikis do |t|
      t.remove :private
      t.boolean :private, default: false
    end
  end
end
