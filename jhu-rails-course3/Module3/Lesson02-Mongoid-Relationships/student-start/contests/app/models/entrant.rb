class Entrant
  include Mongoid::Document
  field :id, type: Integer
  field :name, type: String
  field :group, type: String
  field :secs, type: Float
  embedded_in :contest
  belongs_to :racer, validate: true

  before_create do |doc|
  	doc.name="#{doc.racer.ln}, #{doc.racer.fn}"
  end

end
