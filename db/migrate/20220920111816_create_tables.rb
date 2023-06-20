class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :fields do |t|
      t.string :name, unique: true
      
      t.timestamps
    end

    create_table :universities do |t|
      t.string :name

      t.timestamps
    end

    create_table :school_years do |t|
      t.string :name
      t.boolean :current_year

      t.timestamps
    end

    create_table :statistics do |t|
      t.float :sold
      t.float :collected_amount
      t.float :pending_payout

      t.timestamps
    end

    create_table :field_options do |t|
      t.string :name, unique: true
      t.references :field, foreign_key: true

      t.timestamps
    end
  end
end
