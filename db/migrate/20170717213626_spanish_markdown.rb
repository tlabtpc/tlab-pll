class SpanishMarkdown < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :markdown_content_es, :text
  end
end
