class PubAccount < ActiveRecord::Base
  has_many :stats_entries, :dependent => :destroy
  
  def class_name
    self.class.to_s.demodulize.underscore
  end
end
