require 'rails_helper'
# finder

RSpec.describe User, type: :model do
  
  before(:each) do
    # One persistent user entry
    @user = User.new({
      first_name: 'Walter',
      last_name: 'White',
      email: 'ww@qmail.com',
      password: 'ww0000',
      password_confirmation: 'ww0000'
      })
      @successful_entry = @user.save
    end
    
    after(:each) do
      @user.destroy
    end
    
    it "should have one user" do
      expect(@successful_entry).to be true
    end
    
    context ":password" do
      
      it 'should have a password' do
        login = User.find_by(email: 'ww@qmail.com').try(:authenticate, 'ww0000')
        # puts login["password_digest"].length.inspect
        expect(login[:password_digest]).to exist
      end

    # it should have a password_confirmation
    # it should have identical password and password_confirmation fields
  end

  context ":email" do
    # it should have an email
    # it should have a unique email address, case insensitive
  end

  context "User Name" do
    # it should have a first_name
    # it should have a last_name
  end
  
end
