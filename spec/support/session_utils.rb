def sign_out
  begin
    click "Sign out"
  rescue
  end
end

def sign_in
  user = create_user
  sign_in_as(user)
end

def sign_in_as(user)
  visit new_user_session_path
  fill_in :user_email,    with: user.email
  fill_in :user_password, with: default_user_password
  click_on "sign-in"
end

def default_user_password
  "password"
end

def default_user_email
  "user@example.com"
end

# Example usage: save_screen('not_logged_in', URI.parse(current_url).path)
def save_screen(prefix, path=nil)
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
