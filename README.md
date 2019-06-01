# Here To Learn
## Empowering teachers to help students reach their fullest potential.
 Here to Learn is a Rails application that tracks vital statistics, collects student and teacher input, uses machine learning to predict test outcomes and highlights students in need of extra attention.

 The Rails application works with a Django application that has trained a machine learning model on over 5000 data points to predict test outcomes based on eating and sleeping habits in order to assist students reach their full potential.

 In addition, the Rails application works with the Surveys application which is a stand alone Sinatra application built in the spirit of Service Oriented Architecture (SOA) and stores survey information gathered from students.

### Contributing
* [Blake Enyart](https://github.com/blake-enyart) - Developed the [Machine Learning Microservice](https://github.com/blake-enyart/heretolearn_django) django app
* [Carrie Walsh](https://github.com/carriewalsh) - Developed and designed the main [Here To Learn](https://github.com/carriewalsh/HereToLearn) Ruby on Rails app
* [Jennica Stiehl](https://github.com/JennicaStiehl) - Developed and designed the [Surveys](https://github.com/JennicaStiehl/surveys) Sinatra app
* [William Peterson](https://github.com/wipegup) - Oversaw machine learning microservice development and Rails app attendance through websockets
* [Trevor Nodland](https://github.com/tnodland) - Assisted in Rails app design and dockerization

### Goals
* Assist in learning
* Assess student needs
* Auccessfully send communication between three separate apps

### Configuration
```
bundle install
 ```
### Database initialization
```
rake db:{create,migration,seed}
```
### Getting Started/Requirements/Prerequisites/Dependencies
```Ruby version: 2.4.1
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
* v1 - 5/30/2019

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
