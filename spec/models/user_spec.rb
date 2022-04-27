require 'rails_helper'

#login Act
#login = User.find_by(email: 'ww@qmail.com').try(:authenticate, 'ww0000')


RSpec.describe User, type: :model do

  # Persistent user to compare uneiqueness
  before(:all) do
    @unique_user = User.new({
      first_name: 'Jesse',
      last_name: 'Pinkman',
      email: 'jp@qmail.com',
      password: 'jp0000',
      password_confirmation: 'jp0000'
      })
    @unique_user.save
  end
    
    after(:each) do
      @user.destroy
    end

  # -------------------------- end of setup tear-down -------------------------- #
    
  it "should save a user with proper form entry" do
    @user = User.new({
      first_name: 'Walter',
      last_name: 'White',
      email: 'ww@qmail.com',
      password: 'ww0000',
      password_confirmation: 'ww0000'
    })
    @successful_entry = @user.save
    expect(@successful_entry).to be true
  end
  
  # ----------------------------- Context: PASSWORD ---------------------------- #
  context ":password" do
    
    it 'should reject if the password field is empty' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'ww@qmail.com',
        password_confirmation: 'ww0000'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password can't be blank")
    end

    it "should reject if the password_confirmation is empty" do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'ww@qmail.com',
        password: 'ww0000'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password confirmation can't be blank")
    end

    it "should reject if the password_confirmation and password don't match" do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'ww@qmail.com',
        password: 'ww0000',
        password_confirmation: '0000'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password confirmation doesn't match Password")
    end
    

      
  end
    
    # ------------------------------ context: EMAIL ------------------------------ #
  context ":email" do
    
    it 'should not accept blank email' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        password: 'ww0000',
        password_confirmation: 'ww0000'
        })
      @user.save
      errors = @user.errors.full_messages
      expect(errors).to include("Email can't be blank")
        
    end
    
    it 'should accept a email of the correct format only' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'wwqmail.com',
        password: 'ww0000',
        password_confirmation: 'ww0000'
        })
      @successful_entry = @user.save          
      errors = @user.errors.full_messages
      expect(errors).to include("Email is invalid")
    end
      
    it 'should have a unique email address' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'jp@qmail.com',
        password: 'ww0000',
        password_confirmation: 'ww0000'
      })
      @user.save          
      errors = @user.errors.full_messages
      expect(errors).to include("Email has already been taken")
    end
    
    it 'should have a unique email address while case insensitive' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'JP@qmail.com',
        password: 'ww0000',
        password_confirmation: 'ww0000'
      })
        @user.save          
        errors = @user.errors.full_messages
        expect(errors).to include("Email has already been taken")
      end
      
    end
      
      # ---------------------------- context: USER NAME ---------------------------- #
    context "User Name" do
      it 'should have a first_name' do
        @user = User.new({
          last_name: 'White',
          email: 'ww@qmail.com',
          password: 'ww0000',
          password_confirmation: 'ww0000'
        })
        @user.save          
        errors = @user.errors.full_messages
        expect(errors).to include("First name can't be blank")
      end
      it 'should have a last_name' do
        @user = User.new({
          first_name: 'Walter',
          email: 'ww@qmail.com',
          password: 'ww0000',
          password_confirmation: 'ww0000'
        })
        @user.save          
        errors = @user.errors.full_messages
        expect(errors).to include("Last name can't be blank")
      end
    end
      
end
        