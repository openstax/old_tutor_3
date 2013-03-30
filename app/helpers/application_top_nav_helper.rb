module ApplicationTopNavHelper

  def top_nav_about_link
    render  :partial  => "layouts/application_top_nav_link", 
            :locals   => {  :target_text            => "ABOUT",
                            :target_image           => "",
                            :target_id              => "top-nav-about-link",
                            :target_path            => "#",
                            :target_current_symbol  => :top_nav_about_current }
  end

  def top_nav_dashboard_link
    render  :partial  => "layouts/application_top_nav_link", 
            :locals   => {  :target_text            => "DASHBOARD",
                            :target_image           => "",
                            :target_id              => "top-nav-dashboard-link",
                            :target_path            => dashboard_page_path,
                            :target_current_symbol  => :top_nav_dashboard_current }
  end

  def top_nav_course_catalog_link
    render  :partial  => "layouts/application_top_nav_link", 
            :locals   => {  :target_text            => "COURSE CATALOG",
                            :target_image           => "",
                            :target_id              => "top-nav-course-catalog-link",
                            :target_path            => course_catalog_page_path,
                            :target_current_symbol  => :top_nav_course_catalog_current }
  end

  def top_nav_current_classes_link
    render  :partial  => "layouts/application_top_nav_link", 
            :locals   => {  :target_text            => "CURRENT CLASSES",
                            :target_image           => "",
                            :target_id              => "top-nav-current-classes-link",
                            :target_path            => "#",
                            :target_current_symbol  => :top_nav_current_classes_current }
  end

  def top_nav_my_tutor_link
    render  :partial  => "layouts/application_top_nav_link", 
            :locals   => {  :target_text            => "MY TUTOR",
                            :target_image           => "",
                            :target_id              => "top-nav-my-tutor-link",
                            :target_path            => "#",
                            :target_current_symbol  => :top_nav_my_tutor_current }
  end

  def top_nav_help_link
    render  :partial  => "layouts/application_top_nav_link", 
            :locals   => {  :target_text            => "HELP",
                            :target_image           => image_tag('help_icon_v4.png', :class => "help-link-icon"),
                            :target_id              => "top-nav-help-link",
                            :target_path            => "#",
                            :target_current_symbol  => :top_nav_help_current }
  end

  def top_nav_about_active
    content_for :top_nav_about_current do 
      top_nav_current_link_class
    end
  end

  def top_nav_dashboard_active
    content_for :top_nav_dashboard_current do 
      top_nav_current_link_class
    end
  end

  def top_nav_course_catalog_active
    content_for :top_nav_course_catalog_current do 
      top_nav_current_link_class
    end
  end

  def top_nav_current_classes_active
    content_for :top_nav_current_classes_current do 
      top_nav_current_link_class
    end
  end

  def top_nav_my_tutor_active
    content_for :top_nav_my_tutor_current do 
      top_nav_current_link_class
    end
  end

  def top_nav_help_active
    content_for :top_nav_help_current do 
      top_nav_current_link_class
    end
  end

  def top_nav_current_link_class
    "current "
  end

  def top_nav_home_page_background
    content_for :top_nav_class do
      "home-page "
    end
  end
end
