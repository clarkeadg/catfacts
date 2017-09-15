require 'test_helper'

module Freakazoid
  class FreakazoidTest < Freakazoid::Test
    include Config
    
    def setup
      app_key :freakazoid
      agent_id AGENT_ID
      override_config(
        freakazoid: {
          block_mode: 'irreversible',
          account_name: 'bittrex',
          posting_wif: '5JrvPrQeBBvCRdjv29iDvkwn3EQYZ9jqfAHzrCyUvfbEbRkrYFC'
        }, chain_options: {
          chain: 'steem',
          url: 'https://steemd.steemit.com'
        }
      )
    end
    
    def test_backoff
      assert Freakazoid.backoff
    end
  end
end
