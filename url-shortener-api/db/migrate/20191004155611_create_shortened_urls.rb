class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      t.string :url
      t.string :slug

      t.timestamps
    end
  end
end
