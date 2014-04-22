module FullMessageErrors
  def as_json(options = {})
    super(options.merge(full_messages: true))
  end
end

ActiveModel::Errors.instance_eval { prepend FullMessageErrors }

