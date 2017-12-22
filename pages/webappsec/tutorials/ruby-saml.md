---
title: SAML with Ruby
description: How to add Okta SAML authentication to Ruby applications
toc: true
---

# Terminology

* Identity Provider (IdP): The SAML identity provider. In our case, this will be Okta.
* Service Provider (SP): The application you are creating.
* Metadata URL: A URL that specifies the location of a metadata.xml file that defines how your application is configured for use with a particular IdP. Typically, your application will check this URL each time it is started and download the contents of the file.

# Create an app in Okta

## Create a developer account

## Add an application

The SSO endpoint for this application is:

* development: `http://localhost:3000/saml/acs`
* production: `https://DOMAIN/saml/acs`

In Okta, this URL would be specified for both `Single Sign on URL` and
`Audience URI`.

Once the identity provider is configured, copy the IdP metadata URL.


# Basic service provider

## Set environment variable

Then, set the environment variable IPD_METADATA_URL before the application is
run. For example:

In `config/development.sh`:

    export IDP_METADATA_URL="https://dev-770989.oktapreview.com/app/exk9dbq3zdHbEBp2e0h7/sso/saml/metadata"

Then, to run your application:

    source config/development.sh
    rails server

In production, you would set the environment viariable via a deployment pipeline.

## Gemfile

In `Gemfile`

```ruby
gem 'ruby-saml', '~> 1.4'
```

## Routes

in `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get 'saml/login', to: 'saml#login', as: 'login'
  post 'saml/acs',  to: 'saml#acs'
end
```

## SAML Controller

in `app/controllers/saml_controller.rb`:

```ruby
#
# A SAML service provider controller
#

class SamlController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:acs]
  skip_before_action :require_authentication
  skip_before_action :require_authorization

  #
  # GET /saml/login
  #
  # SP initiated login action. Redirects to IdP.
  #
  def login
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  #
  # POST /saml/acs
  #
  # Assertion Consumer Service URL. The endpoint that the IdP posts to.
  #
  def acs
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], :settings => saml_settings)
    reset_session
    session[:user_id] = response.nameid
    redirect_to start_url
  end

  #
  # POST /saml/logout
  #
  def logout
    reset_session
    redirect_to root_url
  end

  private

  def saml_settings
    @settings ||= begin
      if ENV['IDP_METADATA_URL'] && ENV['IDP_METADATA_URL'].present?
        OneLogin::RubySaml::IdpMetadataParser.new.parse_remote(ENV['IDP_METADATA_URL'])
      else
        raise StandardError, "The environment variable IDP_METADATA_URL is not set."
      end
    end
  end

end
```

This controller assumes you have routes for `start_url` and `root_url`. This also assumes you have a `require_authentication` and `require_authorization` before action callbacks defined. Change these as appropriate.

## Login link

Put this in a view somewhere:

```
<%= link_to "Log in", login_path, class: 'login-btn' %>
```

# Add support for groups

Lets suppose you want to give access to your application to these three groups that are defined in Okta:

* `app_developers`, with Okta group ID `0000aaaa`
* `app_admins` with Okta group ID `1111bbbb`
* `app_readers` with Okta group ID `2222cccc`

The actual group IDs in Okta look more like `00g1erqthk0Why5qd0h8`, but for the purpose of this tutorial we have simplified the IDs.

## Add groups attribute to Okta

The first step is to modify the application configuration in Okta to add a SAML property:

* Name: `groups`
* Value: `getFilteredGroups({"0000aaaa","1111bbbb", "2222cccc"}, "{group.id,group.name}", 10)`

## Configure environment

Lets suppose you want to add two simple roles to your application:

* Administration role: These users can edit everything.
* Read only role: These users can read but not edit.

For this, create the following environment variables:

ADMIN_GROUPS -- A list of SAML group IDs for users who should have full admin access to the web application.

READONLY_GROUPS -- A list of SAML group IDs for users who should have READ ONLY access to the web application.

For example, in `config/development.sh`:

```
export ADMIN_GROUPS="0000aaaa 1111bbbb"
export READONLY_GROUPS="2222cccc"
```

In this examples, `app_developers` and `app_admins` both gain the admin role, and `app_readers` gain the readonly role.

## Modify SAML controller

First, add a call to `resolve_group_role`. This will store the role and the group name in the session when the user authenticates.

```ruby
  #
  # A SAML service provider controller
  #

  class SamlController < ApplicationController

    def acs
      response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], :settings => saml_settings)
      reset_session
      session[:user_id] = response.nameid
+     session[:role], session[:group] = resolve_group_role(response)
      redirect_to start_url
    end
```

Now lets define `resolve_group_role`:

```ruby
  class SamlError < StandardError; end
  rescue_from SamlError, :with => :error

  private

  def error(exception)
    render status: 500, text: exception.to_s
  end

  def resolve_group_role(response)
    group_str = response.attributes["groups"]
    if group_str.nil?
      raise SamlError, "The SAML response must include the `groups` attribute. See README.md"
    end
    groups = parse_user_groups(group_str)
    if group = find_group(groups, ENV['ADMIN_GROUPS'])
      return [:admin, group]
    elsif group = find_group(groups, ENV['READONLY_GROUPS'])
      return [:reader, group]
    else
      raise SamlError, "You do not belong to any groups with access to this application. Your groups are #{groups.inspect}."
    end
  end

  #
  # parses the list of groups that a user is a member of, as reported by saml assertion.
  #
  # configured in okta:
  #
  #   groups => getFilteredGroups({"00gcyt4a07m0hu0pe0h7","00gcyt4j78O335Ntv0h7"}, "{group.id, group.name}", 10)
  #
  # example response.attributes["groups"]:
  #
  #   "00gcyt4a07m0hu0pe0h7,inventory_read,00gcyt4j78O335Ntv0h7,inventory_write"
  #
  # NOTE: this will fail horribly if there is a comma in the group name.
  #
  def parse_user_groups(group_str)
    groups = {}
    ids_and_names = group_str.split(',')
    while ids_and_names.any?
      id = ids_and_names.shift.strip
      name = ids_and_names.shift.strip
      groups[id] = name
    end
    return groups
  rescue
    raise SamlError, "ERROR: failed to parse `group` attrbute string from SAML. The string was: #{group_str.inspect}"
  end

  #
  # returns a group, in the form {id: group.id, name: group.name}, of the first group
  # we can find that is in both user_groups and target_groups
  #
  # user_groups: a hash of group names, indexed by group id
  # target_groups: a string of group ids, separated by commas or whitespace
  #
  def find_group(user_groups, target_groups)
    if target_groups
      target_groups.split(/[\s,]+/).each do |group_id|
        if user_groups[group_id]
          return {id: group_id, name: user_groups[group_id]}
        end
      end
    end
    return nil
  end

end
```

How would you use this? Here is a very barebones authorization code you might use:

```ruby
class ApplicationController < ActionController::Base
  NotAuthorized = Class.new(StandardError)

  before_action :require_authentication
  before_action :require_authorization

  rescue_from ApplicationController::NotAuthorized, :with => :render_unauthorized

  protected

  def render_unauthorized
    render :file => Rails.root.join('public', '422.html'), :status => 403
  end

  def current_user
    if Rails.env != "production" && ENV["AUTHENTICATION_BYPASS"]
      session[:role] = "admin"
      ENV["AUTHENTICATION_BYPASS"]
    else
      session[:user_id]
    end
  end
  helper_method :current_user

  def require_authentication
    unless current_user
      redirect_to login_url
    end
  end

  def require_authorization
    if is_admin?
      return true
    elsif is_reader? && read_only_request?
      return true
    else
      raise NotAuthorized
    end
  end

  def is_admin?
    session[:role] == "admin"
  end
  helper_method :is_admin?

  def is_reader?
    session[:role] == "reader"
  end
  helper_method :is_reader?
end
```

