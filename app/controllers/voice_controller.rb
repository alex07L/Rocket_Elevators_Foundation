class VoiceController < ApplicationController

def profile
	if !params[:fullName].nil?
	url = URI("https://westus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles")

	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true

	request = Net::HTTP::Post.new(url)
	request["Ocp-Apim-Subscription-Key"] = ENV['AZURE']
	request["Content-Type"] = "application/json"
	request.body = '{ "locale": "'+params[:lang]+'"}'

	i = http.request(request)
	puts(i.read_body)
	Profil.create(fullName: params[:fullName], voice: JSON.parse(i.read_body)['profileId'], lang: params[:lang])
	end
redirect_to "/voice"

end

def train
	if !params[:audio_file].nil?
		url = URI("https://westus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/"+params[:profil]+"/enrollments")

			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(url)
			request["Ocp-Apim-Subscription-Key"] = ENV['AZURE']
			request["Content-Type"] = "multipart/form-data"
			request.body = params[:audio_file].read

			i = http.request(request)
			puts(i.read_body)
			if JSON.parse(i.read_body)['enrollmentStatus'] == 'Enrolled'
				Profil.find_by(voice: params[:profil]).update_attribute(:enrolled, true)
			end 
	end

end

	def ident
		# Version 2
		puts(params[:profil].join(","));
		if !params[:audio_file].nil?
			url = URI("https://westus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds="+params[:profil].join(","))

			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(url)
			request["Ocp-Apim-Subscription-Key"] = ENV['AZURE']
			request["Content-Type"] = "multipart/form-data"
			request.body = params[:audio_file].read

			i = http.request(request)
			puts(i.read_body)
			render "voice/resultat", :locals => { :scores => i.read_body }


			#Version 1
			#redirect_to "/result?result="+i.read_body
			
			#url = URI("https://westus.api.cognitive.microsoft.com/spid/v1.0/identify?identificationProfileIds=776e4795-4ddb-4445-b37d-e07a2bddef80,96d19a78-c81f-4942-b56a-b759129da6fe,f42e9cb9-5495-4a2d-a0d7-6e33ce318f5e&shortAudio=true")
#
			#http = Net::HTTP.new(url.host, url.port)
			#http.use_ssl = true
#
			#request = Net::HTTP::Post.new(url)
			#request["Ocp-Apim-Subscription-Key"] = ENV['AZURE']
			#request["Content-Type"] = "multipart/form-data"
			#request.body = params[:audio_file].read
#
			#i = http.request(request)
			#puts(i.header["operation-location"])
			#redirect_to i.header["operation-location"]
			
end
end


def toText

if !params[:audio_file].nil?
			url = URI("https://westus.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language="+params[:lang])

			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(url)
			request["Ocp-Apim-Subscription-Key"] = ENV['AZURE']
			request["Content-Type"] = "application/json"
			request["Accept"] = "application/json"
			request.body = params[:audio_file].read

			i = http.request(request)
			puts(i.read_body)
			render "voice/show", :locals => { :message => i.read_body }
			#redirect_to "/result?result="+i.read_body
end
end

end
