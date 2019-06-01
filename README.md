# Here To Learn
## Empowering teachers to help students reach their fullest potential.

### Description
 Here to Learn is a Rails application that tracks vital statistics, collects student and teacher input, uses machine learning to predict test outcomes and highlights students in need of extra attention.

 The Rails application works with a Django application that has trained a machine learning model on over 5000 data points to predict test outcomes based on eating and sleeping habits in order to assist students reach their full potential.

 In addition, the Rails application works with the Surveys application which is a stand alone Sinatra application built in the spirit of Service Oriented Architecture (SOA) and stores survey information gathered from students.

### Goals
```
-assist in learning
-assess student needs
-successfully send communication between three separate apps
```
### Configuration
```bundle install
 ```
### Database initialization
```rake db:{create,migration,seed}
```
### Getting Started/Requirements/Prerequisites/Dependencies
```Ruby version: ruby 2.4.1
```
### Locations/Where to Find the applications
#### Here To Learn
```development: localhost:3000
production: https://young-anchorage-86985.herokuapp.com
```
#### Surveys
```development: localhost:9393
production: https://aqueous-caverns-33840.herokuapp.com
```
#### Machine Learning Microservice
```development: localhost:8000
production: http://lit-fortress-28598.herokuapp.com/
```
### Versioning
```v1  5/30/2019
```
### Contributing
```https://github.com/blake-enyart/heretolearn_django
https://github.com/carriewalsh/HereToLearn
https://github.com/JennicaStiehl/surveys
```
### Testing
```
rails generate rspec:install
bundle exec rspec
```
### Tech Stack
* Javascript
 - jQuery
 - Chart JS
* Python
 - pandas/NumPy
 - scikit-learn
 - django
* Ruby
 - Sinatra
 - Ruby on Rails
 - Redis
