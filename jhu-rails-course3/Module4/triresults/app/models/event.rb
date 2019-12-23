class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String
  embedded_in :parent, polymorphic: true, touch:true

  validates_presence_of :order, :name

  ONE_METER_IN_MILES=0.000621371
  ONE_MILE_IN_METERS=1609.344
  ONE_YARD_IN_METERS=0.9144
  ONE_YARD_IN_MILES=0.000568182

  def meters
  	case self.units
  	when "meters" then self.distance * 1
  	when "miles" then self.distance * ONE_MILE_IN_METERS
  	when "kilometers" then self.distance * 1000
  	when "yards" then self.distance * ONE_YARD_IN_METERS
  	end
  end

  def miles
  	case self.units
  	when "kilometers" then self.distance * (ONE_METER_IN_MILES*1000)
  	when "meters" then self.distance * ONE_METER_IN_MILES
  	when "miles" then self.distance * 1
  	when "yards" then self.distance * ONE_YARD_IN_MILES
  	end
  end

end
