require 'ElevatorMedia'
require 'spec_helper'

describe ElevatorMedia do
	describe "Weather" do
		streamer = ElevatorMedia::Streamer.new("07112")
		context "test to get Streamer class" do
			it "return Streamer class" do
				expect(streamer).to be_a(ElevatorMedia::Streamer)
			end
		end
		context "test to get http request" do
			it "return JSON" do
				expect(streamer.call).to be_a(Hash)
			end
		end
		context "test to get building details" do
			it "return string" do
				content = streamer.getContent
				puts content
				expect(content).to include("<div>",  "</div>")
			end
		end
	end
end