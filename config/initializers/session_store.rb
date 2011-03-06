require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store :dalli_store,
             :memcache_server =>  ['127.0.0.1'],
             :namespace => 'sessions',
             :key => '_megstv_sessions',
             :expire_after => 2.days



# Be sure to restart your server when you modify this file.

#Megstv::Application.config.session_store :active_record_store, :key => '_megstv_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Megstv::Application.config.session_store :active_record_store
