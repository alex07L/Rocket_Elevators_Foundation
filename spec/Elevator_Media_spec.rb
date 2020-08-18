require 'ElevatorMedia'

describe ElevatorMedia do
	describe "building" do
		context "test to get building details" do
			it "return string" do
				expect(ElevatorMedia::Streamer.getContent).to eq("<div></div>")
			end
		end
	end
end