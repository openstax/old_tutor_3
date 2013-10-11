# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module ApplicationHelper

  def vertical_bar(options={})
    options = add_class(options, "vertical-bar")
    content_tag :span, nil, options
  end

  def add_class(options, klass)
    klasses = options.fetch(:class, "") + " vertical-bar "
    options[:class] = klasses;
    options
  end

  def page_heading(heading_text, options={})      
    @page_title = heading_text
    render 'shared/page_heading', page_heading: heading_text
  end

  def standard_date(datetime)
    datetime.nil? ? "" : datetime.strftime(STANDARD_DATE_FORMAT)
  end
  
  def standard_datetime(datetime)
    datetime.nil? ? "" : datetime.strftime(STANDARD_DATETIME_FORMAT)
  end
  
  def standard_time(datetime)
    datetime.nil? ? "" : datetime.strftime(STANDARD_TIME_FORMAT)
  end
  
  def standard_datetime_zone(datetime, zone)
    datetime.nil? ? "" : datetime.in_time_zone(zone).strftime(STANDARD_DATETIME_FORMAT)
  end
  
  def month_year(datetime)
    datetime.nil? ? "" : datetime.strftime("%B %Y")
  end

  def unless_errors(options={}, &block)
    options[:errors] ||= @handler_result.errors.collect{|e| e.translate}
    options[:errors_html_id] ||= 'local-alerts'
    options[:errors_partial] ||= 'shared/local_alerts'
    options[:trigger] ||= 'errors-added'

    if options[:errors].any? || flash[:alert]
      "$('##{options[:errors_html_id]}').html('#{ j(render options[:errors_partial], errors: options[:errors]) }').trigger('#{options[:trigger]}');".html_safe
    else
      ("$('##{options[:errors_html_id]}').html('');" + capture(&block)).html_safe
    end
  end
end
