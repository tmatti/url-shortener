class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :shortened_urls, :url, :redirect_url
  end
end
