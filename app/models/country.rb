class Country < ActiveRecord::Base
   def self.dropdown_options
      return Country.find(:all, :order=>'name').collect{|c| [c.name,c.id] }
   end
end
