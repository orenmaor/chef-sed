if defined?(ChefSpec)
  ChefSpec.define_matcher :sed

  def sed(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sed,
                                            :update,
                                            resource_name)
  end
end
