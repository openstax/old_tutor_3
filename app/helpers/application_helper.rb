# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module ApplicationHelper

  def alert_tag(messages)
    attention_tag(messages, :alert)
  end

  def notice_tag(messages)
    attention_tag(messages, :notice)
  end

  def attention_tag(messages, type, classes='')
    return if messages.blank? || messages.empty?
    messages = Array.new(messages).flatten
    
    div_class = type == :alert ? "ui-state-error" : "ui-state-highlight"
    icon_class = type == :alert ? "ui-icon-alert" : "ui-icon-info"
    
    content_tag :div, :class => "ui-widget #{classes}" do
      content_tag :div, :class => "#{div_class} ui-corner-all", 
                        :style => "margin: 10px 0px; padding: 0 .7em;" do
        content_tag :p do
          content_tag(:span, "", :class => "ui-icon #{icon_class}",
                             :style => "float:left; margin-right: .3em;") +
          (type == :alert ? content_tag(:strong, "Alert: ") : "") +

          (messages.size == 1 ? 
           messages.first : 
           ("<ul>"+messages.collect{|a| "<li>"+a+"</li>"}.join("")+"</ul>").html_safe)
        end
      end
    end
  end

  def vertical_bar(options={})
    options = add_class(options, "vertical-bar")
    content_tag :span, nil, options
  end

  def add_class(options, klass)
    klasses = options.fetch(:class, "") + " vertical-bar "
    options[:class] = klasses;
    options
  end
end
