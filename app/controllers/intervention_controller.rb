class InterventionController < ApplicationController

def customer
	b = Building.where(customer_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def building
	b = Battery.where(building_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def battery
	b = Column.where(battery_id: params[:id])
	respond_to do |r|
		r.json {render :json =>b}
	end
end

def column
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
	#Intervention.create!(author_id: Employee.where(:user_id => current_user.id).first.id,:customer_id => to_number(params[:customer]), :building_id => to_number(params[:building]), :battery_id => to_number(params[:battery]), :column_id => nil, :elevator_id => nil, :employee_id => params[:employee], :rapport => params[:description])
	i = Intervention.create(author_id: Employee.where(:user_id => current_user.id).first.id,:customer_id => to_number(params[:customer]), :building_id => to_number(params[:building]), :battery_id => to_number(b), :column_id => to_number(c), :elevator_id => to_number(e), :employee_id => params[:employee], :rapport => params[:description]) 
	ZendeskAPI::Ticket.create!($client, :type => "Problem", :subject => "Intervention needed", :comment => { :value => "#{Employee.where(id: i.author_id).first.firstName} create intervention for #{i.customer.entrepriseName} in the building #{i.building_id} on battery #{params[:battery]}, the elevator #{e} on column #{c} need to be fixed by #{i.employee.firstName}. The description is: #{i.rapport} " },:priority => "urgent")
end	

  def to_number(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end

end
