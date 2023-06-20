class AddSlugToUniversities < ActiveRecord::Migration[7.0]
  def change
    add_column :universities, :slug, :string, unique: true
  end
end
