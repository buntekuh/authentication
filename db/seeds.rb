# create sample user
# disabled in production for user credentials are visible on githob
unless Rails.env.production?
  email = 'test@test.de'
  unless User.where(email: email).present?
    Users::CreateCommand.execute(Users::CreateForm.new(
      first_name: 'Test', 
      last_name:  'User', 
      email:      email, 
      password:   'MorgenSt3rn'
    ))
  end
end