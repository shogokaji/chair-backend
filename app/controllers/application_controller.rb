class ApplicationController < ActionController::Base
        protect_from_forgery
        include DeviseTokenAuth::Concerns::SetUserByToken

        before_action do
                I18n.locale = :ja
        end
end
