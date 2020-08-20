require 'spec_helper'
require 'rails_helper'

describe InterventionController, type: :controller do
	context "get if intervention is not go" do
		
		it "should get index" do
			get 'intervention'
			expect(response).to redirect_to "/index"
		end
		it "return content_type" do
			get 'intervention'
			expect(response.content_type).to eq("text/html")
		end		
	end
end