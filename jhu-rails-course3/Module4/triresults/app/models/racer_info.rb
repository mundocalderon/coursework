class RacerInfo
  include Mongoid::Document
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address

  embedded_in :parent, polymorphic: true

  validates_presence_of :first_name, :last_name, :gender, :birth_year
  validates_inclusion_of :gender, :in => ["M", "F"], :message => "Must be M or F"
  validates_numericality_of :birth_year, :less_than => Date.today.year, :message => "Must be a year before #{Date.today.year}"

  ["city", "state"].each do |action| 
    define_method("#{action}") do
      self.residence ? self.residence.send("#{action}") : nil 
    end
    define_method("#{action}=") do |name| 
      object=self.residence ||= Address.new(nil,nil,nil) 
      object.send("#{action}=", name) 
      self.residence=object
    end 
  end

end
