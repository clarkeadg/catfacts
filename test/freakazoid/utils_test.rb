require 'test_helper'

module Freakazoid
  class UtilsTest < Freakazoid::Test
    include Utils
    
    def setup
      app_key :freakazoid
      agent_id AGENT_ID
      override_config(
        freakazoid: {
          block_mode: 'irreversible',
          account_name: 'social',
          posting_wif: '5JrvPrQeBBvCRdjv29iDvkwn3EQYZ9jqfAHzrCyUvfbEbRkrYFC'
        }, chain_options: {
          chain: 'steem',
          url: 'https://steemd.steemit.com'
        }
      )
    end
    
    def test_random_cat_facts
      assert random_cat_fact
    end
    
    def test_name_error
      assert_raises NameError do
        assert reset_api
      end
    end
    
    def test_trace
      assert_nil trace "trace"
    end
    
    def test_debug
      assert_nil debug "debug"
    end
    
    def test_info
      assert_nil info "info"
    end
    
    def test_info_detail
      assert_nil info("info", Exception.new)
    end
    
    def test_warning
      assert_nil warning "warning"
    end
    
    def test_error
      assert_nil error "error"
    end
    
    def test_unknown_type
      assert_nil console(:BOGUS, "unknown_type")
    end
    
    def test_parse_slug
      author, permlink = parse_slug '@author/permlink'
      
      assert_equal 'author', author
      assert_equal 'permlink', permlink
    end
    
    def test_parse_slug_to_comment
      url = 'https://steemit.com/chainbb-general/@howtostartablog/the-joke-is-always-in-the-comments-8-sbd-contest#@btcvenom/re-howtostartablog-the-joke-is-always-in-the-comments-8-sbd-contest-20170624t115213474z'
      author, permlink = parse_slug url
      
      assert_equal 'btcvenom', author
      assert_equal 're-howtostartablog-the-joke-is-always-in-the-comments-8-sbd-contest-20170624t115213474z', permlink
    end
    
    def test_merge
      merge_options = {
        markup: :html,
        content_type: 'content_type',
        vote_weight_percent: 'vote_weight_percent',
        vote_type: 'vote_type',
        account_name: 'account_name',
        author: 'foo',
        body: 'body'
      }
      
      expected_merge = "<p>body</p>\n"
      assert_equal expected_merge, merge(merge_options)
    end
    
    def test_merge_markdown
      merge_options = {
        markup: :markdown,
        content_type: 'content_type',
        vote_weight_percent: 'vote_weight_percent',
        vote_type: 'vote_type',
        account_name: 'account_name',
        author: 'foo',
        body: 'body'
      }
      
      expected_merge = "body\n"
      assert_equal expected_merge, merge(merge_options)
    end
    
    def test_merge_with_from
      merge_options = {
        markup: :html,
        content_type: 'content_type',
        vote_weight_percent: 'vote_weight_percent',
        vote_type: 'vote_type',
        account_name: 'account_name',
        from: ['foo'],
        body: 'body'
      }
      
      expected_merge = "<p>body</p>\n"
      assert_equal expected_merge, merge(merge_options)
    end
    
    def test_merge_nil
      refute merge
    end
  end
end