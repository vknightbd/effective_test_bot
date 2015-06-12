module EffectiveTestBot
  class Engine < ::Rails::Engine
    engine_name 'effective_test_bot'

    # Set up our default configuration options.
    initializer "effective_test_bot.defaults", :before => :load_config_initializers do |app|
      # Set up our defaults, as per our initializer template
      eval File.read("#{config.root}/lib/generators/templates/effective_test_bot.rb")
    end

    initializer 'effective_test_bot.test_suite' do |app|
      Rails.application.config.to_prepare do
        ActionDispatch::IntegrationTest.send(:include, EffectiveTestBotHelper)
      end
    end

  end
end
