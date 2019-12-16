class Racer
  include Mongoid::Document
  field :first_name, as: :fn, type: String
  field :last_name, as: :ln,type: String
  field :date_of_birth, as: :dob, type: Date
  embeds_one :primary_address, class_name: 'Address', as: :addressable
  has_one :medical_record, dependent: :destroy
  #has_many :races, class_name: 'Entrant'

  validates_presence_of :first_name, :last_name

  def races
  	Contest.where(:"entrants.racer_id"=>self.id).map do |contest| 
	      contest.entrants.where(:racer_id=>self.id).first
	end
  end
end
