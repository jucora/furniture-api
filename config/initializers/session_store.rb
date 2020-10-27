if Rails.env == "production"

    Rails.application.config.session_store :cookie_store, key: "_authentication_app", same_site: :strict, secure: true, domain: "domain"
else
    Rails.application.config.session_store :cookie_store, key: "_authentication_app", same_site: :strict 
end
