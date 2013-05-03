# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

require 'spec_helper'

def page_should_be_loaded(page_id)
  page.should have_css "[data-test-page-#{page_id}]"
end

def page_should_have_link(link_id)
  page.should have_css "a[data-test-link-#{link_id}]"
end

def page_should_have_error_alert(*patterns)
  elem = page.find "[data-test-error-alert]"
  page_match_elem_text(elem, *patterns)
end

def page_should_have_success_alert(*patterns)
  elem = page.find "[data-test-success-alert]"
  page_match_elem_text(elem, *patterns)
end

def page_should_have_info_alert(*patterns)
  elem = page.find "[data-test-info-alert]"
  page_match_elem_text(elem, *patterns)
end

def page_match_elem_text(elem, *patterns)
  patterns.each do |pattern|
    elem.text.should =~ regexp_case_insensitive(pattern)
  end
end

def page_should_have_welcome_message
  page.should have_css '[data-test-user-welcome]'
end

# Example usage: save_screen('not_logged_in', URI.parse(current_url).path)
def page_save_screen(prefix, path=nil)
  path ||= URI.parse(current_url).path
  new_path = path.clone
  new_path.gsub!(%r{/}, ":")
  Capybara::Screenshot.screen_shot_and_save_page
  dirname = Rails.root.join('tmp', 'capybara')

  Dir.foreach(dirname) do |file|
    file  = [dirname, file].join('/')

    if /\.html$/ =~ file
      File.unlink(file)
    elsif /screenshot_\d\d\d\d-\d\d-\d\d-\d\d-\d\d-\d\d\.\d\d\d\.png\z/ =~ file
      new_basename = [prefix, new_path, '01'].join('_')
      while File.exist?([dirname, '/', new_basename, '.png'].join(''))
        new_basename = new_basename.next
      end
      new_file = [dirname, '/', new_basename, '.png'].join('')
      File.rename(file, new_file)
    end
  end
end

def wait_for_browser
  page.find('div#application-footer-content')
end
