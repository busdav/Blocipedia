class AddMarkdownContentToWikis < ActiveRecord::Migration[5.1]
  def change
    add_column :wikis, :markdown_content, :text
  end
end
