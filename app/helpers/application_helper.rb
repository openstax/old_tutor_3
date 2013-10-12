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
    errors = @handler_result.errors.each do |error|
      add_local_error_alert now: true, content: error.translate
    end

    @handler_result.errors.any? ?
      js_refresh_alerts(options) : 
      js_refresh_alerts(options) + capture(&block).html_safe
  end

  def js_refresh_alerts(options={})
    options[:alerts_html_id] ||= 'local-alerts'
    options[:alerts_partial] ||= 'shared/local_alerts'
    options[:trigger] ||= 'alerts-updated'    

    "$('##{options[:alerts_html_id]}').html('#{ j(render options[:alerts_partial]) }').trigger('#{options[:trigger]}');".html_safe
  end

end
