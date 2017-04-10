class Opening < ActiveRecord::Base
  belongs_to :port
  belongs_to :position
end
