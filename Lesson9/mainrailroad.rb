# frozen_string_literal: true

require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_pass.rb'
require_relative 'railroad.rb'
require_relative 'module_company_name.rb'
require_relative 'module_counter.rb'
require_relative 'module_accessors'
require_relative 'module_validation'

RailRoad.new.start
