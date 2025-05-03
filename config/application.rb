require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Otorepi
  class Application < Rails::Application
    config.load_defaults 7.1

    # 日本語をデフォルトにする設定
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    config.autoload_lib(ignore: %w(assets tasks))
  end
end

