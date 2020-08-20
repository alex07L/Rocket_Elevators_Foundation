require 'spec_helper'
require 'rails_helper'
describe PagesController, type: :controller do
	context "get if index can render" do
		it "return 200" do
			 get 'index'
			 expect(response).to have_http_status(:success)
		end
		it "return content_type" do
			 get 'index'
			 expect(response.content_type).to eq("text/html")
		end
	end
end