class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  VALID_POSTAL_CODE_REGEX = /\A\d{7}\z/
end
