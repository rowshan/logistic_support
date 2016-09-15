class ApplicationRecord < ActiveRecord::Base
  include ApiM8::SSP::RecordMethods
  self.abstract_class = true
end
