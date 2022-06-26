# This file is used by Rack-based servers to start the application.
# Файл используется для запуска rails приложения на web-серверах и серверов приложений, 
# которые совместимы со спецификацией rake

require_relative "config/environment"

run Rails.application
Rails.application.load_server
