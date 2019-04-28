ROM::SQL.migration do
  change do
    alter_table(:challenge_comments) do
      add_column :created_at, DateTime, default: Time.now
    end
  end
end
