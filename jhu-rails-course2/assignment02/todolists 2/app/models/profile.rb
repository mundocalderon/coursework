class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion:["male", "female"]
  validate :name_not_null, :cash_is_king

  scope :get_profiles, -> (min_year, max_year){ where(birth_year: min_year .. max_year)}

  def name_not_null
   if first_name.nil? && last_name.nil?
   	errors.add(:first_name, "Your profile must have either a first name or last name")
   end
  end

  def cash_is_king
  	if gender.eql?("male") && first_name.eql?("Sue")
  		errors.add(:first_name, "A man named Sue, no sir!")
  	end
  end

  def self.get_all_profiles(min, max)
  	where(birth_year: min..max).order(:birth_year)
  end

end
