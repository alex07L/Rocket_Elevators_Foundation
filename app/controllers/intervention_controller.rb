class InterventionController < ApplicationController

def intervention
	if current_user.nil? || Employee.find_by(user_id:current_user.id).nil?
		redirect_to '/index'
	end
end

def customer
headers['Access-Control-Allow-Origin'] = '*'
headers['Access-Control-Allow-Methods'] = 'GET'
headers['Access-Control-Request-Method'] = '*'
headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	b = Building.where(customer_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def building
headers['Access-Control-Allow-Origin'] = '*'
headers['Access-Control-Allow-Methods'] = 'GET'
headers['Access-Control-Request-Method'] = '*'
headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	b = Battery.where(building_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def battery
headers['Access-Control-Allow-Origin'] = '*'
headers['Access-Control-Allow-Methods'] = 'GET'
headers['Access-Control-Request-Method'] = '*'
headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	b = Column.where(battery_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def column
headers['Access-Control-Allow-Origin'] = '*'
headers['Access-Control-Allow-Methods'] = 'GET'
headers['Access-Control-Request-Method'] = '*'
headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	b = Elevator.where(column_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def create
	puts params
	e = params[:elevator]
	c = params[:column]
	b = params[:battery]
	if e != 'select'
		b = nil
		c = nil
	elsif c != 'select'
		b = nil
		e = nil
	elsif b != 'select'
		a = nil
		c = nil
	end
	flash[:notice] = "Your message has been sent "
	redirect_to "/intervention"
	#Intervention.create!(author_id: Employee.where(:user_id => current_user.id).first.id,:customer_id => to_number(params[:customer]), :building_id => to_number(params[:building]), :battery_id => to_number(params[:battery]), :column_id => nil, :elevator_id => nil, :employee_id => params[:employee], :rapport => params[:description])
	i = Intervention.create(author_id: Employee.where(:user_id => current_user.id).first.id,:customer_id => to_number(params[:customer]), :building_id => to_number(params[:building]), :battery_id => to_number(b), :column_id => to_number(c), :elevator_id => to_number(e), :employee_id => params[:employee], :rapport => params[:description]) 
	ZendeskAPI::Ticket.create!($client, :type => "Problem", :subject => "Intervention needed", :comment => { :value => "#{Employee.where(id: i.author_id).first.firstName} #{Employee.where(id: i.author_id).first.lastName} create intervention for #{i.customer.entrepriseName} in the building #{i.building_id} on battery #{params[:battery]}, the elevator #{params[:elevator]} on column #{params[:column]} need to be fixed by #{i.employee.firstName} #{i.employee.lastName}. The description is: #{i.rapport} " },:requester => { 
               "name": Employee.where(:user_id => current_user.id).first.firstName, 
               "email": Employee.where(:user_id => current_user.id).first.email
           },:priority => "urgent")
	
end	

  def to_number(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end

end
