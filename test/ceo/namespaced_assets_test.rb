require 'test_helper'

describe 'namespaced assets' do
  include AcceptanceHelper

  it "should use ceo stylesheets in admin panel" do
    admin_page '/apples'

    assert page.body.match(/\/assets\/ceo\/application/)
  end

  it "should not use ceo stylesheets outside of admin panel" do
    visit '/'

    refute page.body.match(/\/assets\/ceo\/application/)
    assert page.body.match(/\/assets\/application/)
  end
end

