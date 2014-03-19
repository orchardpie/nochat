RSpec::Matchers.define :respond_with_redirect_to do |path|
  match do |actual|
    response = actual.call
    response.redirect? && response.location =~ /#{path}$/
  end
end

