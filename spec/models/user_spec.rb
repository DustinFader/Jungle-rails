require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
      
      let!(:user) { User.create!(first_name: 'Jane', last_name: 'Doe', email: 'test@blast.com', password: 'randinton', password_confirmation: 'randinton') }
      
      it 'pass all validations' do
        user = User.new(first_name: 'rand', last_name: 'rand', email: 'TEST@TEST.com', password: 'randinton', password_confirmation: 'randinton')
        expect(user).to be_valid
      end

      it 'password invalidation when no password given' do
        user = User.new(first_name: 'rand', last_name: 'rand', email: 'TEST@TEST.com', password: nil, password_confirmation: 'randinton')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password minimum length not fulfilled' do
        user = User.new(first_name: 'rand', last_name: 'rand', email: 'TEST@TEST.com', password: 'pa', password_confirmation: 'pa')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Password confirmation is too short (minimum is 6 characters)")
      end

      it 'Email must be unique' do
        user = User.new(first_name: 'rand', last_name: 'rand', email: 'TEST@blast.com', password: 'randinton', password_confirmation: 'randinton')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Email has already been taken")
      end

      it 'password confirmation invalidation when not the same as password' do
        user = User.new(first_name: 'rand', last_name: 'rand', email: 'TEST@TEST.com', password: 'randinton', password_confirmation: 'radinton')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it 'email invalidation' do
        user = User.new(first_name: 'rand', last_name: 'rand', email: nil, password: 'randinton', password_confirmation: 'randinton')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'first name invalidation' do
        user = User.new(first_name: nil, last_name: 'rand', email: 'TEST@TEST.com', password: 'randinton', password_confirmation: 'randinton')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last name invalidation' do
        user = User.new(first_name: 'rand', last_name: nil, email: 'TEST@TEST.com', password: 'randinton', password_confirmation: 'randinton')
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    describe '.authenticate_with_credentials' do
      let!(:user) { User.create!(first_name: 'Jane', last_name: 'Doe', email: 'test@blast.com', password: 'randinton', password_confirmation: 'randinton') }
      
      it 'authenticate user with valid credentials' do
        authenticated_user = User.authenticate_with_credentials('test@blast.com', 'randinton')
        expect(authenticated_user).to eq(user)
      end

      it 'authenticate user with valid credentials with different email case' do
        authenticated_user = User.authenticate_with_credentials('tEst@Blast.com', 'randinton')
        expect(authenticated_user).to eq(user)
      end

      it 'authenticate user with valid credentials despite white space' do
        authenticated_user = User.authenticate_with_credentials('  test@blast.com', 'randinton')
        expect(authenticated_user).to eq(user)
      end

      it 'fails to authenticate user with valid email' do
        authenticated_user = User.authenticate_with_credentials('test@porch.com', 'randinton')
        expect(authenticated_user).to_not eq(user)
      end

      it 'fails to authenticate user with valid password' do
        authenticated_user = User.authenticate_with_credentials('test@blast.com', 'password123')
        expect(authenticated_user).to_not eq(user)
      end
    end
end
