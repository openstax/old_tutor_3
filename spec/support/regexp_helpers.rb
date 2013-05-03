# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

def regexp_case_insensitive(regexp_or_string)
  case regexp_or_string.class.to_s
  when 'Regexp'
    Regexp.new regexp_or_string.to_s, Regexp::IGNORECASE
  when 'String'
    Regexp.new Regexp.escape(regexp_or_string), Regexp::IGNORECASE
  else
    raise "cannot handle argument of type #{regexp_or_string.class}"
  end
end
