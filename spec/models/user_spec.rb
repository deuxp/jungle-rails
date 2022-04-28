require 'rails_helper'

#login Act
#login = User.find_by(email: 'ww@qmail.com').try(:authenticate, 'ww0000')


RSpec.describe User, type: :model do

  # Persistent user to compare uneiqueness
  before(:all) do
    @unique_user = User.new({
      first_name: 'Kim',
      last_name: 'Wexler',
      email: 'KW@qmail.com',
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
  
  # ----------------------------- Context: #password ---------------------------- #
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

    it 'should reject if the password has less than 6' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'ww@qmail.com',
        password: 'ww0',
        password_confirmation: 'ww0'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password is too short (minimum is 6 characters)")
    end
    
  end
    
    # ------------------------------ context: #email ------------------------------ #
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

    it 'should still login while email address is wrong case' do
      @user = User.new({
        first_name: 'Gus',
        last_name: 'Fring',
        email: 'gf@qMAIl.com',
        password: 'gf0000',
        password_confirmation: 'gf0000'
      })
        saved = @user.save
        login = User.authenticate_with_credentials('GF@qmail.coM', 'gf0000')
        expect(saved).to be true       
        expect(login.id).to eq(@user.id)
      end

      it "should still login even with surrounding whitespace" do
        @user = User.new({
          first_name: 'Gus',
          last_name: 'Fring',
          email: 'gf@qmail.com',
          password: 'gf0000',
          password_confirmation: 'gf0000'
        })
          saved = @user.save
          login = User.authenticate_with_credentials('  gf@qmail.coM ', 'gf0000')
          expect(saved).to be true       
          expect(login).to_not be nil
          expect(login.id).to eq(@user.id)
      end
      
      
      
    end
      
  # ---------------------------- context: #user ---------------------------- #
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

  # ---------------------------------------------------------------------------- #
  #                        .authenticate_with_credentials                        #
  # ---------------------------------------------------------------------------- #
  describe ".authenticate_with" do
    
    it 'should login with correct credentials' do
      login_email = 'sg@qmail.com'
      login_password = 'sg0000'

      @user = User.new({
        first_name: 'Saul',
        last_name: 'Goodman',
        email: login_email,
        password: login_password,
        password_confirmation: login_password
      })
      saved = @user.save     
      login = User.authenticate_with_credentials(login_email, login_password)
      database_user_id = User.find_by(email: login_email).id
      expect(saved).to be true
      expect(login.id).to eq(database_user_id)
    end

    it 'should reject with incorrect password' do
      login_email = 'sg@qmail.com'
      login_password = 'sg0000'

      @user = User.new({
        first_name: 'Saul',
        last_name: 'Goodman',
        email: login_email,
        password: login_password,
        password_confirmation: login_password
      })
      saved = @user.save     
      login = User.authenticate_with_credentials(login_email, 'wrong_login_password')
      database_user_id = User.find_by(email: login_email).id
      expect(saved).to be true
      expect(login).to be false
    end

    it 'should reject with incorrect email' do
      login_email = 'sg@qmail.com'
      login_password = 'sg0000'

      @user = User.new({
        first_name: 'Saul',
        last_name: 'Goodman',
        email: login_email,
        password: login_password,
        password_confirmation: login_password
      })
      saved = @user.save     
      login = User.authenticate_with_credentials('login_email@qmail.com', login_password)
      database_user_id = User.find_by(email: login_email).id
      expect(saved).to be true
      expect(login).to be nil
    end
    
  end
      
end
        