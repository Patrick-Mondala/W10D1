require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
        it "renders sign-up page" do
            get :new
            expect(response).to render_template(:new)
            expect(response).to have_http_status(200)
        end
    end

    describe "POST #create" do
        context "with valid input" do 
            it "redirects if form is valid" do
                post :create, params: { user: { username: 'Filbert2000', password: 'corn40' } }
                expect(response).to redirect_to(users_url)
            end
        end

        context "with invalid input" do 
            it "re-renders new if username is invalid" do
                post :create, params: {user: { username: '', password: 'corn40' }}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end

            it "re-renders new if password is shorter than six characters" do
                post :create, params: {user: { username: 'Filbert2000', password: 'co' }}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
        end
    end

    describe "GET #index" do 
        it "renders index page" do
           get :index
           expect(response).to render_template(:index) 
        end
    end


end