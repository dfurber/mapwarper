class AddPublicToMap < ActiveRecord::Migration[4.2]
  def self.up
    	add_column :maps, :public,  :boolean, :default => true
  end

  def self.down
     remove_column :maps,  :public
  end
end
