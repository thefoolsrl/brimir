# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_store, servers: ["#{ENV.fetch('REDIS_URL', 'redis://localhost:6379/7')}/session"], secure: Rails.env != 'development'