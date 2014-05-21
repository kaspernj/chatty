module Chatty::ApplicationHelper
  include ::SimpleFormRansackHelper
  
  def method_missing(method, *args, &block)
    return main_app.send(method, *args, &block) if main_app.respond_to?(method)
    super
  end
end
