class CreateImage < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :name
      t.string :url
    end
  end

  def down
    drop table :images
  end
end
