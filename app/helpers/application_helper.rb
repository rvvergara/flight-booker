module ApplicationHelper
  # Puts the page title in every page of the app
  def full_title(page_title)
    page_title.empty? ? "Flight Right" : "#{page_title} | Flight Right"
  end
end
