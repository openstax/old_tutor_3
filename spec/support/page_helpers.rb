require 'spec_helper'

def page_should_be_loaded(page_id)
  page.should have_css "[data-test-page-#{page_id}]"
end

def page_should_have_link(link_id)
  page.should have_css "a[data-test-link-#{link_id}]"
end

def page_should_have_notice(*patterns)
  elem = page.find "[data-test-notice]"
  patterns.each do |pattern|
    elem.should have_text pattern
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
