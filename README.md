# README

## This application is not about authentication, although authenticate is all it does.

## This application demonstrates how I organize my code to keep it modular, clean and reusable.

### Commands

I believe in thin controllers. A controller should only have to deal with routes, the session, params, etc.

All business logic is encapsulated within commands.  
All commands have an execute method that is very easy to read and understand.  
If a command fails it raises an exception.  
Commands are extremely useful for defining APIs  

Please refer to

* _app/commands/base_command.rb_ for the command base class

* _app/commands/_ for implementation thereof

### Private and protected attribute accessors

Attribute accessors are easy to use. However they are public by default. 
As commands should be secure and self contained, attributes should not be accessible from without.  
Therefore I have written a simple ScopedAttrAccessor class that defines methods for both private and protected attributes.

Please refer to _config/initializers/scoped_attr_accessors.rb_

Please refer to

* _app/controllers/auth/concerns/session_methods.rb_ for controller methods like sign_in_user and current_user

* _app/controllers/auth/sessions_controller.rb_ The authentification controller

* _app/commands/auth/user_password_authentication_command.rb_ For the command that finds and 

### Presenters

To keep the view layer as clean as possible I use presenters to keep logic out of the view.

please refer to 

* _app/presenters/base_presenter.rb_ for the presenter base class

* _app/presenters/_ for implementations thereof

### Models

I believe in thin models. A model is concerned with representing database records in ruby.  
Forms are used to encapsulate data used within the application.  
Forms are concerned with data and validatitions.  
Commands are concerned with persisting form data.  
There are no more callbacks, instead there are methods within commands.  

### Services

Services are used for reusable code
please refer to _app/services/_

### Tests

All the code in this application is tested and passing. I like using Minitest as it is easy to understand, easy to use and extend.


### Authentication

Bugged authentication can be a huge security loophole, therefore I like to keep authentication as simple as possible, 
instead of relying on huge external authentication gems like devise.

### Application

This application is kept simple as it is used to demonstrate backend code, not gems.

Ruby 2.2.2, Rails 4.2.6 and SQLite are used.

No configuration beyond _rake db:migrate;rake db:seed_ should be necessary to get up and running.

Use test@test.de / MorgenSt3rn for authentication.

Use _rake_ to run the tests.

