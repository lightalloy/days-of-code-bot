ROM::SQL.migration do
  change do
    create_table :users do
      primary_key :id
      column :telegram_id, Integer, null: false
      column :username, String, null: true
      column :fullname, String, null: true
    end
  end
end
