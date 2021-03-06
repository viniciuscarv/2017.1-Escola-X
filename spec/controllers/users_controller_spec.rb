require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_inputs) { { name: "Michael Cera", phone:"61988885555",
                         address:"Rua Vida Casa 15,Taguatinga",
                         password: "12345678", gender:"M",
                         birth_date:"07/06/1988", permission:"Alumn"} }

  let(:invalid_inputs) { { name: "Ayu", phone:"25460", address:"Ali Casa 2",
                           password: "12345", gender:"adfsd",
                           birth_date:"50 abr", permission:" " } }



  describe "Creates a new user with a valid permission" do
    before(:each) do
      user = User.create(name:"jao",password:"13454366",permission:"Principal")
      cookies[:authorization_token] = user.authorization_token
    end
  end

  describe "Post create" do
    before(:each) do
      user = User.create(name: "Michael Cera", phone:"61988885555",
                          address:"Rua Vida Casa 15,Taguatinga",
                          password: "12345678", gender:"M",
                          birth_date:"07/06/1988", permission:"Principal")
      cookies[:authorization_token] = user.authorization_token
    end

    describe "with valid params" do
      it "Creates a new User" do
        expect{
          post :create, params: {:user => valid_inputs}
        }.to change(User, :count).by 1
      end

      it "assigns a new user to @user" do
        post :create, params: {:user => valid_inputs}
        expect(assigns(:user)).to be_a User
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to @user page" do
        post :create, params: {:user => valid_inputs}
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end

    describe "with invalid params" do
      it "does not create a new User" do
        expect{
          post :create, params: {:user => invalid_inputs}
        }.to change(User, :count).by 0
      end

      it "assigns a new user but no save to @user" do
        post :create, params: {:user => invalid_inputs}
        expect(assigns(:user)).not_to be_persisted
      end
    end
  end
end
