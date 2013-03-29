module ApplicationAccountBarHelper

  def account_bar_transparent
    content_for :account_bar_class do
      "transparent "
    end
  end
end