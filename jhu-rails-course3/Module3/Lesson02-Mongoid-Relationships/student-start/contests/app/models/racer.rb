class Racer
  include Mongoid::Document
  field :first_name, as: :fn, type: String
  field :last_name, as: :ln,type: String
  field :date_of_birth, as: :dob, type: Date
  embeds_one :primary_address, class_name: 'Address', as: :addressable
end
