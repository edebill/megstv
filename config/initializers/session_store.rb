# Be sure to restart your server when you modify this file.

# Be sure to restart your server when you modify this file.
CACHE = MemCache.new(:namespace => 'megstv')
CACHE.servers = ['server-1:11211', 'server-2:11211']

#Rails.application.config.session_store :mem_cache_store

Megstv::Application.config.session_store :mem_cache_store, {
  :cache => CACHE,
  :session_key => '_megstv_session',
  :secret => 'xJyrF2umJQiiRULw1oX5MLb8nf098nfqs3098fsxuwmi7XFUIO',
  :expire_after => 172800
}




#Megstv::Application.config.session_store :active_record_store, :key => '_megstv_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Megstv::Application.config.session_store :active_record_store
