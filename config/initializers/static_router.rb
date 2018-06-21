# File: config/initializers/static_router.rb
module ActionDispatch
  module Routing
    class StaticResponder < Endpoint

      attr_accessor :path, :file_handler

      def initialize(path)
        self.path = path
        # Only if you're on Rails 5+:
        self.file_handler = ActionDispatch::FileHandler.new(
          Rails.configuration.paths['build'].first
        )
        # Only if you're on Rails 4.2:
        # self.file_handler = ActionDispatch::FileHandler.new(
        #   Rails.configuration.paths["public"].first,
        #   Rails.configuration.static_cache_control
        # )
      end

      def call(env)
        env["PATH_INFO"] = @file_handler.match?(path)
        @file_handler.call(env)
      end

      def inspect
        "static('#{path}')"
      end

    end

    class Mapper
      def static(path)
        StaticResponder.new(path)
      end
    end
  end
end