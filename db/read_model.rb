ActiveRecord::Schema.define(version: 20171023080355) do
  create_table 'users', force: :cascade do |t|
    t.string 'uuid'
    t.string 'name'
    t.string 'email'
    t.string 'encrypted_password'
  end
end
