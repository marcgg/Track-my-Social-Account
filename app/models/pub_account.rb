class PubAccount < ActiveRecord::Base
  has_many :stats_entries, :dependent => :destroy
end
