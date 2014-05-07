FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/support/fixture_builder.rb", "db/migrate/*"]

  fbuilder.factory do
    # users
    @kevin = User.create!(email: 'kevinwo@orchardpie.com', password: 'password', password_confirmation: 'password')
    @randall = User.create!(email: 'tripleLI@orchardpie.com', password: 'password', password_confirmation: 'password')

    # messages
    @kevin_to_randall = Message.create!(sender: @kevin, receiver_email: @randall.email, body: "Hey Randall, old buddy, old pal.  I'd gladly pay you Tuesday for a hamburger today")
    @kevin_to_new_user = Message.create!(sender: @kevin, receiver_email: 'fhqwgahds@example.com', body: "I've hated you since the first time I saw you.  If you ever get this, meet me at high noon with pistols ready.")
  end
end

