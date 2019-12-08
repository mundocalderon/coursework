

    #Locate a sample of :number fields from the documents in the database and notice how some are strings and others are integer type.

    > Racer.collection.find(name: {:$regex=>"JONES"}).projection({_id:0, number:1}).to_a
     => [{"number"=>7}, {"number"=>"8"}]

    #Use the following query to find all :number properties of type String. We use the enum ordinal 2 for the BSON data type for String. (BSON Types)

    > Racer.collection.find(number: {:$type=>2}).count
     => 492 

    #16 is the ordinal type for a 32-bit integer.

    > Racer.collection.find(number: {:$type=>16}).count
     => 508 

    #Use the update_one operator to update only the :number field of documents with :numbers of String type with the Integer form of the String using to_i.

    > racer=Racer.collection
    > racer.find(number: {:$type=>2}).each do |r|
         racer.update_one({:_id=>r[:_id]}, {:$set=>{:number=>r[:number].to_i}})
      end

    > Racer.collection.find(number: {:$type=>2}).count
     => 0 
    > Racer.collection.find(number: {:$type=>16}).count
     => 1000 


    Use the following query to locate all documents that do not have a :gender field.

     > Racer.collection.find(gender:$nil).count
     => 508 

    Use the following query to add the :gender=>"F" to each document missing that field. This assumes we already know that each document missing a :gender is female.

    > result=Racer.collection.find(gender:$nil).update_many(:$set=>{:gender=>"F"})
    > result.modified_count
     => 508 
    > Racer.collection.find(gender:$nil).count
     => 0 




    Use the following query to show the :name fields. Notice how the first and last name of each person is combined into a single field. The later query tells us how many documents in the collection still have a :name field.

    > Racer.collection.find.projection({_id:0, name:1}).limit(3).to_a
     => [{"name"=>"ARACELY SMITH"}, {"name"=>"JOEL JOHNSON"}, {"name"=>"MARTIN JOHNSON"}] 
    > Racer.collection.find(:name=>{:$exists=>true}).count
     => 1000 

    Use the following query to locate all documents with a :name field, extract the first_name and last_name from the :name field with a regular expression, and update the document. The document will have the two new fields added and the older one removed.

    > racers=Racer.collection
    > racers.find(:name=>{:$exists=>true}).each do |r|
        matches=/(\w+) (\w+)/.match r[:name]
        first_name=matches[1]
        last_name=matches[2]
        racers.update_one({:_id=>r[:_id]}, 
                          {:$set=>{:first_name=>first_name, :last_name=>last_name}, 
                           :$unset=>{:name=>""}})
      end

    Verify all :name properties were deleted and we now have :first_name and :last_name fields.

    > racers.find(:name=>{:$exists=>false}, 
                  :first_name=>{:$exists=>true}, 
                  :last_name=>{:$exists=>true}).count
     => 1000 



    Use the following to create references to the two collections. If they do not yet exist -- they will be automatically created.

    > racers=Racer.racers_collection
    > races=Racer.races_collection

    Use the following to reset the collections back to a default state.

    > Racer.reset

    Use the following queries and algorithm to:
        locate all Races that still have a name
        upsert the Racer by attempting to locate them by name and creating a new document if not found
        create a new racer_id property in the Race set to the upserted_id of the of the Racer

    > races.find(:name=>{:$exists=>true}).count
     => 1000 
    > racers.find.count
      => 0 

    > races.find(:name=>{:$exists=>true}).each do |r| 
        result=racers.update_one({:name=>r[:name]}, {:name=>r[:name]}, {:upsert=>true})
        id=result.upserted_id
        races.update_one({:_id=>r[:_id]},{:$set=>{:racer_id=>id},:$unset=>{:name=>""}})
      end

    > races.find(:name=>{:$exists=>true}).count
     => 0 
    > racers.find.count
     => 1000 

    Use the following query to inspect both collections and perform a client "join" on the two collections. Your first document may be different than the example shown below.

    > racers.find.first
     => {"_id"=>BSON::ObjectId('563ef169e301d0dc61002e51'), "name"=>"FREDERICKA BALDWIN"}
    > pp races.find( :racer_id => racers.find.first[:_id] ).first; nil
     => {"_id"=>BSON::ObjectId('563ef169e301d0dc61002e51'), 
         "number"=>857, 
         "group"=>"20 to 20", 
         "time"=>"3594 secs", 
         "racer_id"=>BSON::ObjectId('563ef169e301d0dc61002e51')} 



    Use the following query and algorithm to:
        locate all Races with Racer names
        create a new Racer and insert the Race as the first element within an array within Racer called races
        remove the Race

    > Racer.reset
    > racers=Racer.racers_collection
    > races=Racer.races_collection
    > races.find(:name=>{:$exists=>true}).each do |r|
        result=racers.update_one({:name=>r[:name]}, 
                                 {:name=>r[:name], 
                                  :races=>[
                                     {:_id=>r[:_id],
                                      :number=>r[:number],
                                      :group=>r[:group],
                                      :time=>r[:time]}
                                      ]}, {:upsert=>true})
        races.find(:_id=>r[:_id]).delete_one
      end
      > races.find.count
       => 0 
      > racers.find.count
       => 1000 

    Use the following query to look at the structure of the document. Notice the Race is embedded within an array within the Racer.

    > pp racers.find.first; nil
    {"_id"=>BSON::ObjectId('563efb5e0878cba85bcb014a'),
     "name"=>"AMPARO WEBER",
     "races"=>
      [{"_id"=>BSON::ObjectId('563efb35e301d0dc610040e5'),
        "number"=>613,
        "group"=>"14 and under",
        "time"=>"3489 secs"}
      ]}

    Use the following query to unwind the embedded we can re-create a 1:1 relationship between the Racer and one of its Races by creating copies of the Racer for each Race in the array.

    > racers.find.aggregate([ {:$unwind=>"$races"}, {:$project=>{_id:0, name:1, races:1}} ]).first
     => {"name"=>"AMPARO WEBER", 
         "races"=>{"_id"=>BSON::ObjectId('563efb35e301d0dc610040e5'), 
                   "number"=>613, 
                   "group"=>"14 and under", 
                   "time"=>"3489 secs"}} 




