class CreateImportStudent < ActiveRecord::Migration[7.0]
  def change
    create_table :import_students do |t|

      t.timestamps
    end
  end
end
