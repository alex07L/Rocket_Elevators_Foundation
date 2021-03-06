namespace :rocket_elevator do
  desc "send all data from mysql to postgresql"
  task sync: :environment do
	
	connection = PG.connect(dbname: 'AlexandreLevesque',host: 'codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com', user: 'codeboxx', password: 'Codeboxx1!')
	
	#fix the ' error
	connection.prepare('addFactQuotes', "INSERT INTO fact_quotes (quote_id,date_created,company_name,email,nb_elevators) VALUES ($1,$2,$3,$4,$5)")
	connection.prepare('addFactContact', "INSERT INTO fact_contact (contact_id,date_created,email,entreprise,project_name) VALUES ($1,$2,$3,$4,$5)")
	connection.prepare('addFactElevator', "INSERT INTO fact_elevator (serial_number,commissionning_date,building_id,customer_id, building_city) VALUES ($1,$2,$3,$4,$5)")
	connection.prepare('addDimCustomers', "INSERT INTO dim_customers (id,date_created,company_name,contact_name, contact_email,nb_elevators, customer_city) VALUES ($1,$2,$3,$4,$5,$6,$7)")
	

	connection.exec("TRUNCATE fact_quotes RESTART IDENTITY")
	Quote.all.each do |q|
		connection.exec_prepared('addFactQuotes',[q.id, q.created_at, q.companyName, q.email,q.shaft])
		#connection.exec("INSERT INTO fact_quotes (quote_id,date_created,company_name,email,nb_elevators) VALUES (#{q.id},'#{q.created_at}', '#{q.companyName}', '#{q.email}', #{q.shaft})")
	end
	
	connection.exec("TRUNCATE fact_contact RESTART IDENTITY")
	Lead.all.each do |l|
		connection.exec_prepared('addFactContact',[l.id, l.created_at, l.email,l.entrepriseName, l.projectName])
		#connection.exec("INSERT INTO fact_contact (contact_id,date_created,email,project_name) VALUES (#{l.id},'#{l.created_at}', '#{l.email}', '#{l.projectName}')")
	end

	connection.exec("TRUNCATE fact_elevator RESTART IDENTITY")
	Elevator.all.each do |e|
		connection.exec_prepared('addFactElevator',[e.serialNumber, e.installDate, e.column.battery.building_id, e.column.battery.building.customer_id, e.column.battery.building.address.city])
		#connection.exec("INSERT INTO fact_elevator (serial_number,commissionning_date,building_id,customer_id, building_city) VALUES ('#{e.serialNumber}','#{e.installDate}', #{e.column.battery.building_id}, #{e.column.battery.building.customer_id},'#{e.column.battery.building.address.city}')")
	end

	connection.exec("TRUNCATE dim_customers RESTART IDENTITY")
	
	Customer.all.each do |c|
		count = 0
		c.building.all.each do |b|
			b.battery.all.each do |batt|
				batt.column.all.each do |col|
					count +=col.elevator.count
				end
			end
		end
		connection.exec_prepared('addDimCustomers',[c.id, c.created_at, c.entrepriseName, c.nameContact, c.email, count, c.address.city])
		#connection.exec("INSERT INTO dim_customers (id,date_created,company_name,contact_name, contact_email,nb_elevators, customer_city) VALUES (#{c.id},'#{c.created_at}', '#{c.entrepriseName}', '#{c.nameContact}','#{c.email}',count,'#{c.address.city}')")
	end
  end
  
  task intervention: :environment do
	connection = PG.connect(dbname: 'ThierryHarvey',host: 'codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com', user: 'codeboxx', password: 'Codeboxx1!')
	#connection = PG.connect(dbname: 'allo',host: 'localhost', user: 'alex', password: 'alex')
	connection.exec("CREATE TABLE IF NOT EXISTS factintervention (
	id SERIAL,
  employee_id int NOT NULL,
  building_id int NULL,
  battery_id int,
  column_id int,
  elevator_id int,
  start_intervention timestamp NOT NULL,
  end_intervention timestamp,
  resultat VARCHAR(70) NOT NULL,
  rapport VARCHAR,
  status VARCHAR(70) NOT NULL);")
  
	connection.exec("TRUNCATE factintervention RESTART IDENTITY")
  
	10.times do
		connection.exec("INSERT INTO factintervention (employee_id,building_id,battery_id,start_intervention,end_intervention,resultat,rapport,status) VALUES (#{rand(1..50)},#{rand(1..50)}, #{rand(1..50)},'#{Faker::Date.between(from: '2019-07-23', to: '2019-09-23')}','#{Faker::Date.between(from: '2019-09-23', to: '2020-01-25')}', '#{["success", "failure", "incomplete"].sample}', '#{Faker::Types.rb_string}', '#{["pending", "inprogress", "interrupted", "Resumed", "Complete"].sample}')")
		connection.exec("INSERT INTO factintervention (employee_id,building_id,column_id,start_intervention,end_intervention,resultat,status) VALUES (#{rand(1..50)},#{rand(1..50)}, #{rand(1..50)},'#{Faker::Date.between(from: '2019-07-23', to: '2019-09-23')}','#{Faker::Date.between(from: '2019-09-23', to: '2020-01-25')}', '#{["success", "failure", "incomplete"].sample}', '#{["pending", "inprogress", "interrupted", "Resumed", "Complete"].sample}')")
		connection.exec("INSERT INTO factintervention (employee_id,building_id,elevator_id,start_intervention,end_intervention,resultat,rapport,status) VALUES (#{rand(1..50)},#{rand(1..50)}, #{rand(1..50)},'#{Faker::Date.between(from: '2019-07-23', to: '2019-09-23')}','#{Faker::Date.between(from: '2019-09-23', to: '2020-01-25')}', '#{["success", "failure", "incomplete"].sample}', '#{Faker::Types.rb_string}', '#{["pending", "inprogress", "interrupted", "Resumed", "Complete"].sample}')")
		connection.exec("INSERT INTO factintervention (employee_id,building_id,battery_id,start_intervention,resultat,rapport,status) VALUES (#{rand(1..50)},#{rand(1..50)}, #{rand(1..50)},'#{Faker::Date.between(from: '2019-07-23', to: '2020-01-23')}', '#{["success", "failure", "incomplete"].sample}', '#{Faker::Types.rb_string}', '#{["pending", "inprogress", "interrupted", "Resumed", "Complete"].sample}')")
		connection.exec("INSERT INTO factintervention (employee_id,building_id,column_id,start_intervention,resultat,rapport,status) VALUES (#{rand(1..50)},#{rand(1..50)}, #{rand(1..50)},'#{Faker::Date.between(from: '2019-07-23', to: '2020-01-23')}', '#{["success", "failure", "incomplete"].sample}', '#{Faker::Types.rb_string}', '#{["pending", "inprogress", "interrupted", "Resumed", "Complete"].sample}')")
		connection.exec("INSERT INTO factintervention (employee_id,building_id,elevator_id,start_intervention,resultat,status) VALUES (#{rand(1..50)},#{rand(1..50)}, #{rand(1..50)},'#{Faker::Date.between(from: '2019-08-23', to: '2020-01-23')}', '#{["success", "failure", "incomplete"].sample}', '#{["pending", "inprogress", "interrupted", "Resumed", "Complete"].sample}')")
	end
  
  end

end
