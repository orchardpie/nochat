class ActiveRecord::Base
  class << self
    def find_by_param(param)
      find_by_id(param)
    end

    def find_by_param!(param)
      find_by_id!(param)
    end
  end
end

