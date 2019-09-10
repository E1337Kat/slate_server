# frozen_string_literal: true

DATA = YAML.load_file("#{Rails.root}/config/data.yml")[Rails.env]
