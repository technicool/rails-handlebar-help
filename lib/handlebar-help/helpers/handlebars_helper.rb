module HandlebarHelp

	module HandlebarsHelper
		
	def _handlebars_init
		if @_jsctx_initted_handlebars != true
			# Compile, and stick in a script tag
			jsctx = common_js_context
			jsctx.eval("var window = {}");   # For global variables like a DOM window.
			# Load handlebars - TODO: only load if not already loaded!
			jsctx.load("#{Rails.root.to_s}/app/assets/javascripts/lib/strftime.js")
			jsctx.load("#{Rails.root.to_s}/app/assets/javascripts/lib/handlebars-1.0.rc3.js")
			jsctx.load("#{Rails.root.to_s}/app/assets/javascripts/lib/big-1.0.1.min.js")
			jsctx.load("#{Rails.root.to_s}/app/assets/javascripts/handlebars/helpers.js")
			@_jsctx_initted_handlebars = true
		end
	end

	# A common javascript context for the page... to save time reinstantiating it!
	def common_js_context
		if (@jsctx.nil?)
			@jsctx = V8::Context.new
		end
		return @jsctx
	end

	# A helper that allows you to register helper functions for handlebars.
	# 
	# These functions must be included before any templates that use them
	# are created or called.
	# 
	def handlebars_helper_script(&block)
		_handlebars_init
		# the function definition
		handlebarsjs = capture(&block)
		jsctx = common_js_context
		# Include these helpers in ruby's javascript context
		jsctx.eval(handlebarsjs)
		# Load into the page via a script tag.
		return content_tag(:script, handlebarsjs )
	end
	
	# Create a <script> tag with a handlebars template. If not compiled, the 
	# script tag will have the specified ID, if compiled, the javascript variable
	# will be named whatever you pass as the id field.
	#
	# In a javascript rendered view (*.js.erb), the javascript will NOT be rendered
	# into a <script> tag and will NOT be added into the javascript context!
	def handlebars_script_template(id, compiled = true, minified = true, &block)
		_handlebars_init
		# Let's get the handlebars template text from our body
		handlebarsjs = capture(&block)
		
		# Apply a whitespace minifier to the data, unless asked not to
		handlebarsjs.gsub!(/\s+/, " ") if minified
		
		if compiled == false
			# Stick it into a script tag
			return content_tag(:script, handlebarsjs, :id => id, :type => 'text/x-handlebars-template' )
		else
			# Compile, and stick in a script tag
			jsctx = common_js_context
			jsonHandlebarsJs = ActiveSupport::JSON.encode(handlebarsjs)
			handlebarsTemplate = jsctx.eval("(function(){var source = #{jsonHandlebarsJs};return Handlebars.precompile(source);})();")
			
			if request.format == :js
				# Return just the Handlebars template for the javascript to assign to a variable
				return "Handlebars.template(#{handlebarsTemplate})".html_safe;
			else
				handlebarsTemplateLoader = "window.handlebarTmpl=window.handlebarTmpl||{};window.handlebarTmpl['#{id}'] = Handlebars.template(#{handlebarsTemplate});";
				# Load it into the shared @jsctx AND into the page... this way we can use it later also!
				jsctx.eval(handlebarsTemplateLoader)
				return content_tag(:script, (handlebarsTemplateLoader.html_safe))
			end
		end
	end
	
	# Create HTML from a previously compiled Handlebars template and insert into the page.
	# Note that the template must already have been compiled onto the page.
	def handlebars_run_compiled_template(id, context)
		_handlebars_init
		# compile the context into JSON
		compiledContext = ActiveSupport::JSON.encode(context)
		
		# We need our shared context
		jsctx = common_js_context
		return jsctx.eval("window.handlebarTmpl['#{id}'](#{compiledContext})").html_safe
	end

	# Create HTML from a previously compiled Handlebars template and insert into the page.
	# Note that the template must already have been compiled onto the page.
	def handlebars_run_compiled_template_into_element(element, id, handlebars_id, context)
		return content_tag(element, handlebars_run_compiled_template(handlebars_id, context), id: id)
	end
		
		
	end
	
end
