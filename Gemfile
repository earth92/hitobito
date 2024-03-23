# frozen_string_literal: true

#  Copyright (c) 2012-2022, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

source 'https://rubygems.org'

gem 'rails', '= 7.0.8.1'

gem 'activerecord-session_store', '>= 2.1.0'
gem 'acts-as-taggable-on'
gem 'airbrake'
gem 'awesome_nested_set'
gem 'aws-sdk-s3', require: false
gem 'bcrypt'
gem 'bleib', '~> 0.0.10'
gem 'bootsnap', require: false
gem 'cancancan', '< 3.2.0'
gem 'carrierwave'
gem 'caxlsx', '~> 3.1.0'
gem 'cmess'
gem 'commonmarker'
gem 'config'
gem 'country_select'
gem 'daemons'
gem 'dalli'
gem 'delayed_job_active_record'
gem 'delayed_job_heartbeat_plugin'
gem 'devise', '>= 4.9.0'
gem 'doorkeeper', '>= 5.4.0'
gem 'doorkeeper-i18n'
gem 'doorkeeper-openid_connect', '>= 1.7.2'
gem 'draper', '>= 4.0.0'
gem 'draper-cancancan'
gem 'epics' , '>= 2.0.0' # client for EBICS-connections to banks
gem 'faker'
gem 'faraday'
gem 'gibbon', '~> 3.4'
gem 'globalize', '>= 6.3.0'
gem 'graphiti', '>= 1.4.0'
gem 'graphiti-rails', '~> 0.1'
gem 'haml'
gem 'http_accept_language'
gem 'icalendar'
gem 'image_processing', '~> 1.12'
gem 'ledermann-rails-settings'
gem 'lograge', '>= 0.12.0'
gem 'lograge_activejob'
gem 'lograge-sql', '>= 1.2.0'
gem 'magiclabs-userstamp', require: 'userstamp'
gem 'mime-types'
gem 'mini_magick'
gem 'mysql2'
gem 'nested_form'
gem 'nokogiri', '>= 1.15.6'
gem 'oat'
gem 'paper_trail', '~> 12.0', '>= 12.0.0' # 11.1 adds Rails 6.1-support, 12 breaks for now
gem 'paranoia'
gem 'phonelib'
gem 'prawn'
gem 'prawn-markup', '>= 0.3.1'
gem 'prawn-table'
gem 'prometheus_exporter'
gem 'protective'
gem 'pry-rails'
gem 'puma'
gem 'rack-cors', '>= 2.0.0'
gem 'rails_autolink', '>= 1.1.7'
gem 'rails-i18n', '>= 7.0.1'
gem 'remotipart'
gem 'rest-client'
gem 'rotp', '>= 6.3.0'
gem 'rqrcode'
gem 'rswag', '>= 2.9.0'
gem 'rubyzip'
gem 'seed-fu'
gem 'sentry-raven'
gem 'simpleidn'
gem 'sprockets', '~> 4.0.0' # pinned to older version to avoid having an empty manifest.js
gem 'sqlite3' # required for asset generation
gem 'strip_attributes' # strip whitespace of attributes
gem 'thinking-sphinx'
gem 'truemail'
gem 'validates_by_schema'
gem 'validates_timeliness'
gem 'vcard'
gem 'wagons', '0.7.0'
gem 'webpacker', '>= 5.4.4'

# load after others because of active record inherited alias chain.
gem 'kaminari', '>= 1.2.2'

gem 'active_storage_validations' , '>= 1.0.0' # validate filesize, dimensions and content-type of uploads
gem 'active_storage_variant' # variants for Rails < 7
gem 'nochmal' # migrate into or between ActiveStorage-Backends

group :development, :test do
  gem 'better_errors', '>= 2.10.0'
  gem 'binding_of_caller'
  gem 'codez-tarantula', require: 'tarantula-rails3'
  gem 'graphiti_spec_helpers'
  gem 'parallel_tests'
  gem 'pry-byebug'
  gem 'pry-doc' , '>= 1.3.0' # provides show-source/$ in the pry-console
  gem 'rspec-rails', '~> 5.0', '>= 5.0.3'
  gem 'rswag-specs', '>= 2.9.0'
end

group :development do
  gem 'bullet'
  gem 'listen'
  gem 'redcarpet'
  gem 'request_profiler'
end

group :test do
  gem 'capybara', '>= 3.32.0'
  gem 'capybara-screenshot', '>= 1.0.25'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'headless'
  gem 'launchy'
  gem 'pdf-inspector', require: 'pdf/inspector'
  gem 'rails-controller-testing', '>= 1.0.5'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'selenium-webdriver'
  gem 'webdrivers', '>= 4.3.0'
  gem 'webmock'
end

group :console do
  gem 'awesome_print'
  gem 'hirb'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'spring-commands-rspec'
  gem 'wirble'
end

group :metrics do
  gem 'annotate'
  gem 'brakeman'
  gem 'ci_reporter_rspec'
  gem 'rails-erd'
  gem 'rubocop'
  gem 'rubocop-checkstyle_formatter'
  gem 'rubocop-rails', '>= 2.6.0'
  gem 'ruby-prof'
end

# Include the wagon gems you want attached in Wagonfile.
# Do not check Wagonfile into source control.
#
# To create a Wagonfile suitable for development, run 'rake wagon:file'
wagonfile = File.expand_path('Wagonfile', __dir__)
eval(File.read(wagonfile)) if File.exist?(wagonfile) # rubocop:disable Security/Eval
