RailsAdmin.config do |config|
	config.parent_controller = 'ApplicationController' 
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  config.authorize_with :cancancan
  config.main_app_name = ["Rocket Elevator", "BackOffice"]
  # or something more dynamic
  config.main_app_name = Proc.new { |controller| [ "Rocket Elevator", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }
  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true


#config.excluded_models= ['Dwhquote','Dwhcustomer','Dwhlead']
require Rails.root.join('lib', 'config', 'actions', 'rails_admin.rb')

  config.current_user_method(&:current_user)

  config.actions do
    dashboard  do
    except ['Dwhquote','Dwhcustomer','Dwhlead']
  end                    # mandatory
    index                         # mandatory
    new do
    except ['Dwhquote','Dwhcustomer','Dwhlead']
  end
    export do
    except ['Dwhquote','Dwhcustomer','Dwhlead']
  end
    bulk_delete
    show
    edit do
    except ['Dwhquote','Dwhcustomer','Dwhlead']
  end
    delete do
    except ['Dwhquote','Dwhcustomer','Dwhlead']
  end
    show_in_app do
    except ['Dwhquote','Dwhcustomer','Dwhlead']
  end
	charts
	weather
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
end
