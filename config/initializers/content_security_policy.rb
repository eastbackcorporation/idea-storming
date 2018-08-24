# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  #   policy.default_src :self, :https
  #   policy.font_src    :self, :https, :data
  #   policy.img_src     :self, :https, :data
  #   policy.object_src  :none
  #   policy.script_src  :self, :https
  #   policy.style_src   :self, :https

  #   # Specify URI for violation reports
  #   # policy.report_uri "/csp-violation-report-endpoint"

  # If you're using Rails 5.2+ you'll need to enable unsafe-eval rule for your development environment. This can be done in the config/initializers/content_security_policy.rb with the following configuration:

  if Rails.env.development?
    policy.script_src :self, :https, :unsafe_eval, :unsafe_inline
  else
    # TODO:
    # policy.script_src :self, :https
  end
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
