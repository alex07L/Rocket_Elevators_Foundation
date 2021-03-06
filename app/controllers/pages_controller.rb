class PagesController < ApplicationController


	require 'sendgrid-ruby'
	include SendGrid
	require 'zendesk_api'
	require 'active_merchant'
	
  def home
  end
  def create
    if verify_recaptcha
    cat = ::Category.where(:name => params[:gamme]).first
    building = ::Type.where(:name => params[:building]).first
    quote = ::Quote.create(summary_FCost: params[:finalPrice], companyName: params[:companyName],email: params[:email],floor: to_number(params[:floor]),basement: to_number(params[:basement]),apartment: to_number(params[:apartment]),business: to_number(params[:commerce]),shaft: to_number(params[:shafts]),companie: to_number(params[:companie]),parking: to_number(params[:parking]),ocupant: to_number(params[:occupant]),open: to_number(params[:time]), category: cat, type: building)
    quote.save()
    redirect_to controller: 'pages'
    
    ZendeskAPI::Ticket.create!($client, 
          :subject => "#{params[:companyName]}", 
          :comment => { 
              :value => "The company #{params[:companyName]} 
                  can be reached at email #{params[:email]}. 
                  Building type selected is #{params[:building]} with product line #{params[:gamme]}. 
                  Number of suggested elevator is #{(params[:shafts])} and total price is #{(params[:fPrice])}. \n
                  "
          }, 
          :requester => { 
              "name": params[:companyName], 
              "email": params[:email] 
          },
          :priority => "normal",
          :type => "task"
          )

          if quote.save
            flash[:notice] = "Your quote has been sent "
            
          else
            flash[:notice] = "Something went wrong "
            redirect_to action:"new"
          end
    else
		redirect_to '/quote'
	end
  end


  def to_number(string)
    Integer(string || '')
  rescue ArgumentError
    0
  end
  require 'uri'
  require 'http'
  
  def createLead

  if verify_recaptcha
	cansend = true

	if !params[:contact][:attachment].nil?
		File.open("app/assets/images/"+params[:contact][:attachment].original_filename, 'wb') do |f|
			f.write(params[:contact][:attachment].read)
			f.close()
		end
		if MIME::Types.type_for("app/assets/images/"+params[:contact][:attachment].original_filename).first.try(:media_type) == "image"
			url = URI("https://nuditysearch.p.rapidapi.com/nuditySearch/image")

			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE

			request = Net::HTTP::Post.new(url)
			request["x-rapidapi-host"] = 'nuditysearch.p.rapidapi.com'
			request["x-rapidapi-key"] = ENV['RAPIDAPI']
			request["content-type"] = 'application/x-www-form-urlencoded'
			request.body = "setting=3&objecturl=https://rocket3levators.com/assets/"+params[:contact][:attachment].original_filename

			nudity = http.request(request)
			if JSON.parse(nudity.read_body)["classification"] != "CLEAN"
				cansend = false
			end
			File.delete("app/assets/images/"+params[:contact][:attachment].original_filename)
		end
	end
	
	if cansend
	
	if params[:contact][:attachment].nil?
		Lead.create(fullName: params[:contact][:name], entrepriseName: params[:contact][:entreprise], email: params[:contact][:email], cellPhone: params[:contact][:phone], projectName: params[:contact][:projectname], description: params[:contact][:describe], type: Type.where(:name => params[:contact][:department]).first, message: params[:contact][:message])
	else
		params[:contact][:attachment].rewind
		Lead.create(fullName: params[:contact][:name], entrepriseName: params[:contact][:entreprise], email: params[:contact][:email], cellPhone: params[:contact][:phone], projectName: params[:contact][:projectname], description: params[:contact][:describe], type: Type.where(:name => params[:contact][:department]).first, message: params[:contact][:message], file: params[:contact][:attachment].read, fileName: params[:contact][:attachment].original_filename)
	end
	from = Email.new(email: ENV['EMAIL_SENDGRID'])
	to = Email.new(email: params[:contact][:email])

	subject = "Rocket Elevator"
	content = Content.new(type: 'text/html', value: '<html><body><a href="http://www.relevator.ca" title="Rocket Elevators"><img src="http://www.relevator.ca'+ActionController::Base.helpers.image_url('R2-01.jpg')+'" width=300 height=221 alt="Rocket logo" /></a><br />Greetings '+params[:contact][:name]+'<br/>We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project'+params[:contact][:projectname]+'. <br> A representative from our team will be in touch with you very soon. <br> We look forward to demonstrate the value of our solutions and help you choose the appropriate product given your requirements. <br>

We’ll Talk soon <br>
<p style= "color:blue">The Rocket Team </p></body>
</html>')
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: ENV['SENDGRID'])

  response = sg.client.mail._('send').post(request_body: mail.to_json)
  
	ZendeskAPI::Ticket.create!($client, :type => "Question", :subject => " '#{params[:contact][:name]}' from #{params[:contact][:entreprise]}", :comment => { :value => "
      Comment: The contact '#{params[:contact][:name]}' from company '#{params[:contact][:entreprise]}'can be reached at email  '#{params[:contact][:email]}' and at 
      phone number #{params[:contact][:phone]}. #{params[:contact][:department]} has a project named #{params[:contact][:projectname]} which would require contribution from Rocket 
      Elevators. 
      #{params[:contact][:describe]}
      Attached Message: #{params[:contact][:message]}
      The Contact uploaded an attachment
      " },
      :priority => "urgent")
      flash[:notice] = "Your message has been sent "
      redirect_to "/index"
	else
		from = Email.new(email: ENV['EMAIL_SENDGRID'])
		to = Email.new(email: params[:contact][:email])

		subject = "Rocket Elevator"
		content = Content.new(type: 'text/html', value: '<html><body><a href="http://www.relevator.ca" title="Rocket Elevators"><img src="http://www.relevator.ca'+ActionController::Base.helpers.image_url('R2-01.jpg')+'" width=300 height=221 alt="Rocket logo" /></a><p>Hi, <br/>The following e-mail  is to advise you that you are being charged by the city  concerning the unwanted file you tried to send to our team. We care about the psychological health of our employees and it is unacceptable for us to  receive such files.<br/> Our legal team  has prepared a document explaining the  legal actions taken against you.<br/> You will be contacted shortly,<br/> Rocket Elevators</p></body></html>')
		mail = Mail.new(from, subject, to, content)

		sg = SendGrid::API.new(api_key: ENV['SENDGRID'])

    response = sg.client.mail._('send').post(request_body: mail.to_json)
    flash[:notice] = "Your can't send those type of files, it is outrageous!! "
      redirect_to "/index"
  end
	else
		redirect_to '/index#contact'
	end
  end
  
  

  def donateToMe
	    ActiveMerchant::Billing::Base.mode = :test
  paypal_options = {
    :login => ENV['PAYPALLOGIN'],
    :password => ENV['PAYPALPASSWORD'],
    :signature => ENV['PAYPALSIGNATURE']
  }
	 @gateway = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
	 response = @gateway.setup_purchase(params[:donate_number].to_i*100,
        ip: request.remote_ip,
        return_url: "https://rocket3levators.com/thankyou",
        cancel_return_url: "https://rocket3levators.com/", 
        currency: "USD",
        allow_guest_checkout: true,
        items: [{name: "Coffee", description: "Donate to Rocket Elevator ", quantity: "1", amount: params[:donate_number].to_i*100}]
    )
    redirect_to  @gateway.redirect_url_for(response.token)
  end
  
  def download
   lead = Lead.where(:id => params[:id]).first
   send_data lead.file, filename: lead.fileName
  end
  
end

