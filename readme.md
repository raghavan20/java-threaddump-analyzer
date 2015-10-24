# Java thread dump analyzer

Helps analyzing a thread dump quickly

## Some features
  - listing thread ids
  - unique thread states
  - threads matching a state
  - thread matching id
  - threads having large stack trace
  - threads having same stack trace
  - framework to support additional versions/formats of thread dump
  - support for custom annotators to provide information on the thread dump

## Constraints
 - supports thread dumps compatible with only Oracle java 1.7_21 for the moment
 
## Technologies
 - Ruby, gem, bundle, rake, minispec

## Installation
 - Clone the git repo locally
 - bundle install
 - Build the gem, 'gem build jta.gemspec'
 - Install the built gem, 'gem install jtda-<version>.gem'
 - Run the program, 'jtda.rb --help'
 
## Usage
 -  help
```sh
$ jta.rb --help
``` 
 - list unique states
```sh
$ jta.rb -f /tmp/thread.dump -u
``` 
 - list threads by id
```sh
$ jta.rb -f /tmp/thread.dump -t 100,200
```
 - groups thread by unique thread stack
```sh
$ jta.rb -f /tmp/thread.dump -a
``` 
 
## Running tests
 - rake test
 
## License
MIT

