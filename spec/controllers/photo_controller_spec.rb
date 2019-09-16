require 'rails_helper'
include ActionDispatch::TestProcess
RSpec.describe PhotosController, type: :controller do
	let(:testuser) { FactoryBot.create(:testuser) }
    describe 'GET #new' do
    #ログインしてなければ別のページに遷移する
	    context 'by anonymous user' do
	      before do
	        get :new
	      end
	      it { expect(response.status).to eq 302 }
	    end
	    #ログインしていれば
	    context 'by login user' do
	      before do
	        login_user testuser
	        get :new
	      end
	      it { is_expected.to render_template('new') }
    	end
  	end
  	
  	#画像閲覧が問題なく行えるか
  	describe 'GET #show' do
  		context 'show photo' do
  			subject { get :show, params }
    		let(:params) do
    		 {
    		 	id: 1
    		 }
  			end
  			it { expect(response.status).to eq 200 }
  		end
  	end

  	#新規投稿が問題なく行われるかどうか
  	describe 'POST #create' do
  		@photo = FactoryBot.create(:testphoto) 
  		context 'create one photo'do
  			#あらかじめログインおよび、投稿ページに遷移しておく
  			before do
  				login_user testuser
  				get :new
  			end
  			it do
  				expect do
  					post(:create, params: { photo: @photo})end.to change(Photo, :count).by(1)
  				end
  		end
  	end
end