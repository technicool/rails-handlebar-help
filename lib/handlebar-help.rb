require "handlebar-help/version"

module Handlebar
  module Help
    class FrameworkNotFound < StandardError; end
    
	  def self.load!
		if rails?
			# TODO: Enable pure handlebars templates.
		end

		if !(rails?)
		  raise Handlebar::Help::FrameworkNotFound, "handlebar-help requires Rails > 3.1."
		end
		
		#helpers = File.expand_path(File.join("..", 'lib', 'handlebar-help', 'helpers'))
		helper do 
			require "handlebar-help/helpers/handlebars_helper"
		end
	  end
    
    def self.rails?
  	  defined?(::Rails)
  	end
  
  end
end
