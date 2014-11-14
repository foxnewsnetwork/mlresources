I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
I18n::Backend::ActiveRecord.send :include, I18n::Backend::Flatten
I18n::Backend::ActiveRecord.send :include, I18n::Backend::Memoize
I18n::Backend::ActiveRecord.send :include, I18n::Backend::Cache
I18n.cache_store = ActiveSupport::Cache.lookup_store(:memory_store)
I18n.backend = I18n::Backend::Chain.new(I18n.backend, I18n::Backend::ActiveRecord.instance) 