ROM::SQL.migration do
  change do
    create_table :challenge_comments do
      primary_key :id
      # column :user_id, Bignum, null: false
      column :date, Date
      column :tag, String, null: false
      column :text, String, text: true
    end

    alter_table(:challenge_comments) do
      add_foreign_key :user_id, :users
      add_index :user_id
    end
  end
end
