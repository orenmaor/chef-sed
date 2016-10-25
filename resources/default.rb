#
# Cookbook Name:: sed
# Resource:: replace
#
# Author:: Oren Maor (<oren.maor@sturdynetworks.com>)
#

actions :update
default_action :update

attribute :file, :kind_of => String, :name_attribute => true, :required => true
attribute :search, kind_of: String, :required => true
attribute :replace, kind_of: String, :required => true
attribute :insensitive, :kind_of => [TrueClass, FalseClass], :default => false 

def initialize(*args)
  super
  @action = :update
end
