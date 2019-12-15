Course3 - MongoDB, NoSQL, Mongoid

What is lazy loading?

In talking about relationships, would there ever be a case when a class  Place is embedded_in :locatable , polymorphic:false? 

MongoDB
	brew tap mongodb/brew
    brew install mongodb-community@4.2
	brew services start mongodb-community
	mongo

    the configuration file (/usr/local/etc/mongod.conf)
    the log directory path (/usr/local/var/log/mongodb)
    the default data directory path (/usr/local/var/mongodb) -> changed to /Users/admin/Projects/Coursework/jhu-rails-course3/data/db

#Connecting to cluster using Ruby Driver
client = Mongo::Client.new('mongodb+srv://admin:1234@cluster0-493fz.mongodb.net/test?retryWrites=true&w=majority')

Mongo::Logger.logger.level = ::Logger::INFO

#Connecting to cluster using Ruby Driver
client = Mongo::Client.new('mongodb://admin:1234@cluster0-shard-00-00-493fz.mongodb.net:27017,cluster0-shard-00-01-493fz.mongodb.net:27017,cluster0-shard-00-02-493fz.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin&retryWrites=true&w=majority')

#importing to cluster with mongoimport from command line
mongoimport --host Cluster0-shard-0/cluster0-shard-00-00-493fz.mongodb.net:27017,cluster0-shard-00-01-493fz.mongodb.net:27017,cluster0-shard-00-02-493fz.mongodb.net:27017 --ssl --username $MONGO_USER --password $MONGO_PW --authenticationDatabase admin  --db zips_database --collection zips --type json --file zips.json

#Connecting to cluster via Command line/Mongo Shell
mongo "mongodb+srv://cluster0-493fz.mongodb.net/test"  --username admin



Running rspec returns this error:
>/Users/admin/.rbenv/versions/2.6.5/lib/ruby/2.6.0/bundler/runtime.rb:319:in 'check_for_activated_spec!': You have already activated json 2.1.0, but your Gemfile requires json 1.8.6. Since json is a default gem, you can either remove your dependency on it or try updating to a newer version of bundler that supports json as a default gem. (Gem::LoadError)

This error happens, when you have more than one ruby/rails application, and your "global" configuration is in conflict with the current app configuration. 
Adding "bundle exec" before your command ensures using of your local gemfile.
>bundle exec rspec


