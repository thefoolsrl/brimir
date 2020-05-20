# Be sure to restart your server when you modify this file.

Rails.Application.config.session_store :redis_store, servers: ["#{ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')}/session"], secure: Rails.env != 'development'