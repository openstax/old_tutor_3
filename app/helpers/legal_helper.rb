module LegalHelper

  def copyright_text
    year_range = "2011-#{Time.now.year}".sub(/\A(\d+)-\1\z/, '\1');
    "Copyright &copy; #{year_range} #{COPYRIGHT_HOLDER}".html_safe
  end

end