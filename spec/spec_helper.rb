%x{
  window.requestAnimationFrame = function(callback){ callback() }
  window.setTimeout = function(callback) { callback() }
  window.clearTimeout = function() { return true }
  window.alert = function(text) { return 'alert' }
  window.confirm = function(text) { return true }
  window.prompt = function(text, value) { return value }

  window.FileReader = function(){}
  window.FileReader.prototype.readAsDataURL = function(){
    return 'data:image/gif;base64,R0lGODlhyAAiALM...DfD0QAADs='
  }

  window.throttle = function(fn){ return fn }
  window.debounce = function(fn){ return fn }
}

require 'rspec_coverage_helper'
require 'fron_ui'

require 'fron/event_mock'

RSpec.configure do |config|
  config.before do
    allow_any_instance_of(Fron::Logger).to receive(:info)
  end
end
