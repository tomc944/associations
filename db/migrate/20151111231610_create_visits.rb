class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :short_url_id, null: false
      t.integer :visitor_id, null: false

      t.timestamps
    end

    add_index(:visits, [:short_url_id, :visitor_id])
  end
end
