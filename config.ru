require './config/environment'


if ActiveRecord::Migrator.needs_migration? #reminder to run migrations
  raise 'Migrations are pending. Run 'rake db:migrate'
end

use Rack::MethodOverride
run ApplicationController
use BooksController
use UsersController
