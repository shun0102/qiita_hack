class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :url_name
      t.string :token
      t.string :repo_name
      t.datetime :qiita_update_at

      t.timestamps
    end
  end
end
