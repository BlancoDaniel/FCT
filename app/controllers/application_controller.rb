class ApplicationController < ActionController::Base
  include Errors
  include Authentication
  include Authorization
  include Language
  include Pagy::Backend
end
