RSpec::Matchers.define :respond_with_status do |status|
  match do |block|
    block.call

    if Symbol === status
      if [:success, :missing, :redirect, :error].include?(status)
        response.send("#{status}?")
      else
        code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
        code == response.response_code
      end
    else
      status == response.response_code
    end
  end

  failure_message_for_should do |actual|
    "expected a #{status} response, but response was #{response.status}"
  end

  description do
    "respond with status"
  end
end

class RespondWithRedirectMatcher
  def initialize(rspec, response, target_path, &target_path_block)
    @rspec = rspec
    @response = response
    @target_path = target_path
    @target_path_block = target_path_block
  end

  def matches?(block)
    block.call
    target_path = @target_path_block.try(:call) || @target_path
    @response.should @rspec.redirect_to(target_path)
  end

  def failure_message_for_should
    "expected a redirect to #{@target_path}"
  end

  def description
    "respond with redirect"
  end
end

define_method :respond_with_redirect_to do |*target_paths, &target_path_block|
  target_path = target_paths.first
  RespondWithRedirectMatcher.new(self, response, target_path, &target_path_block)
end

RSpec::Matchers.define :respond_with_template do |template_name|
  match do |block|
    block.call
    response.should render_template(template_name)
    true
  end
end

RSpec::Matchers.define :assign do |*vars|
  match do |block|
    block.call
    vars.all? { |var| assigns(var) }
  end
end

RSpec::Matchers.define :set_flash do |type|
  chain :to do |message|
    @message = message
  end

  match do |block|
    block.call
    flash[type].should_not be_nil
    (flash[type].match(@message)).should be_true if @message
  end

  failure_message_for_should do |actual|
    message = "Expected flash[#{type}] to "
    if @message
      message += "match '#{@message}', but was '#{flash[type]}'"
    else
      message += "be set, but it was not"
    end
  end
end

