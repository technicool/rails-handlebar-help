# Handlebar::Help

Some helpers that work in both html and js erb files to generate handlebars templates inline. Requires V8.

This is a pre-alpha version of the code. The helpers actually work, but this project needs some more massaging into a proper gem before we can reach a stable point. Please contribute to the project by submitting pull requests!

This code was originally used in MHPOffice.com, and is donated here under Creative Commons CC BY 3.0 license.

This project is officially hosted at: https://github.com/technicool/rails-handlebar-help

## Still To Do

* Ensure that the helpers load into both .html.erb and .html.js helpers.
* Clean up the global javascript variable name
* Add configuration file for rails for the location of Javascript helper function files
* Add generator / installer for rails projects.

Please feel free to contribute or add bugs on Github.

## Installation

Add this line to your application's Gemfile:

    gem 'handlebar-help'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install handlebar-help

## Usage

You can use handlebars helpers in both JS and HTML erb's

## Javascript ERB
```erb
    var hbsTemplate = <%= handlebars_script_template do %>
    <div class="alert">
      <strong>Success!</strong> You have eaten {{mufffins}} muffins.
    </div>
    <% end %>;
    function showMuffinAlert() {
      var $hbs = $(hbsTemplate( {muffins: 5} ));
      $("#muffinCount").empty().append($hbs);
    }
```

## HTML ERB View
```erb
    <%= handlebars_script_template "hbs-template1" do %>
    <div class="alert">
      <strong>Success!</strong> You have eaten {{mufffins}} muffins.
    </div>
    <% end %>
    <span id="muffincount"></span>
    <script>
    function showMuffinAlert() {
      var $hbs = $(hbsTemplate( {muffins: 5} ));
      $("#muffinCount").empty().append($hbs);
    }
    </script>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
